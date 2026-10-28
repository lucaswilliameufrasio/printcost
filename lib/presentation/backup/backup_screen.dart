import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/backup/backup_service.dart';
import '../../data/db/app_database.dart';
import '../../l10n/generated/app_localizations.dart';
import '../common/async_view.dart';
import '../common/share.dart';
import '../providers.dart';

Future<BackupService> _service() async =>
    BackupService(tempDir: await getTemporaryDirectory());

class BackupScreen extends ConsumerStatefulWidget {
  const BackupScreen({super.key});

  @override
  ConsumerState<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends ConsumerState<BackupScreen> {
  bool _busy = false;

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _busy = true);
    try {
      await action();
    } on BackupException catch (e) {
      if (!mounted) return;
      final l = AppLocalizations.of(context);
      showSnack(context, switch (e.problem) {
        BackupProblem.newerVersion => l.backupNewerVersion,
        _ => l.backupInvalidFile,
      });
    } on Exception catch (e) {
      if (mounted) {
        showSnack(context, AppLocalizations.of(context).unexpectedError('$e'));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _export({required bool share}) => _run(() async {
    final l = AppLocalizations.of(context);
    final service = await _service();
    final bytes = await service.export(ref.read(databaseProvider));
    final name = service.suggestedFileName(DateTime.now());
    if (share) {
      await shareBytes(
        bytes,
        fileName: name,
        mimeType: 'application/x-sqlite3',
      );
    } else {
      final uri = await FilePicker.saveFile(fileName: name, bytes: bytes);
      if (uri != null && mounted) showSnack(context, l.backupSaved);
    }
  });

  Future<void> _import() => _run(() async {
    final l = AppLocalizations.of(context);
    final file = await FilePicker.pickFile();
    if (file == null) return;
    final bytes = await file.xFile.readAsBytes();
    final service = await _service();
    final db = ref.read(databaseProvider);
    await service.validate(bytes, currentSchema: db.schemaVersion);
    if (!mounted) return;
    if (!await confirm(
      context,
      message: l.backupImportWarning,
      action: l.restore,
    )) {
      return;
    }
    await db.close();
    await service.replaceDatabaseFile(bytes, await databaseFilePath());
    ref.invalidate(databaseProvider);
    if (mounted) showSnack(context, l.backupRestored);
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.backup)),
      body: AbsorbPointer(
        absorbing: _busy,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (_busy) const LinearProgressIndicator(),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.backupExport,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(l.backupExportHelp),
                    const SizedBox(height: 4),
                    Text(
                      l.backupPhotosNote,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilledButton.icon(
                          onPressed: () => _export(share: true),
                          icon: const Icon(Icons.share_outlined),
                          label: Text(l.backupShare),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => _export(share: false),
                          icon: const Icon(Icons.save_alt),
                          label: Text(l.backupSaveToFile),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.backupImport,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(l.backupImportHelp),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: _import,
                      icon: const Icon(Icons.restore),
                      label: Text(l.backupImport),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
