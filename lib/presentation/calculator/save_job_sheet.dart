import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../domain/models/job_status.dart';
import '../../l10n/generated/app_localizations.dart';

String statusLabel(AppLocalizations l, JobStatus s) => switch (s) {
  JobStatus.quote => l.statusQuote,
  JobStatus.inProduction => l.statusInProduction,
  JobStatus.delivered => l.statusDelivered,
};

class JobMeta {
  const JobMeta({
    required this.name,
    required this.quantity,
    required this.status,
    this.customer,
    this.notes,
    this.photoPath,
  });
  final String name;
  final String? customer;
  final int quantity;
  final JobStatus status;
  final String? notes;
  final String? photoPath;
}

Future<JobMeta?> showSaveJobSheet(BuildContext context, JobMeta initial) =>
    showModalBottomSheet<JobMeta>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => _SaveJobSheet(initial: initial),
    );

class _SaveJobSheet extends StatefulWidget {
  const _SaveJobSheet({required this.initial});
  final JobMeta initial;

  @override
  State<_SaveJobSheet> createState() => _SaveJobSheetState();
}

class _SaveJobSheetState extends State<_SaveJobSheet> {
  final _form = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.initial.name);
  late final _customer = TextEditingController(text: widget.initial.customer);
  late final _qty = TextEditingController(text: '${widget.initial.quantity}');
  late final _notes = TextEditingController(text: widget.initial.notes);
  late JobStatus _status = widget.initial.status;
  late String? _photo = widget.initial.photoPath;

  @override
  void dispose() {
    for (final c in [_name, _customer, _qty, _notes]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickPhoto(ImageSource source) async {
    final picked = await ImagePicker().pickImage(
      source: source,
      maxWidth: 1600,
      imageQuality: 85,
    );
    if (picked == null) return;
    final dir = Directory(
      p.join((await getApplicationDocumentsDirectory()).path, 'photos'),
    );
    await dir.create(recursive: true);
    final dest = p.join(
      dir.path,
      '${DateTime.now().millisecondsSinceEpoch}${p.extension(picked.path)}',
    );
    await File(picked.path).copy(dest);
    setState(() => _photo = dest);
  }

  void _submit() {
    if (!_form.currentState!.validate()) return;
    String? opt(TextEditingController c) =>
        c.text.trim().isEmpty ? null : c.text.trim();
    Navigator.of(context).pop(
      JobMeta(
        name: _name.text.trim(),
        customer: opt(_customer),
        quantity: int.parse(_qty.text.trim()),
        status: _status,
        notes: opt(_notes),
        photoPath: _photo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    const gap = SizedBox(height: 12);
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 16,
      ),
      child: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l.saveJobTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              gap,
              TextFormField(
                key: const Key('save.name'),
                controller: _name,
                autofocus: widget.initial.name.isEmpty,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(labelText: l.jobName),
                validator: (v) =>
                    (v ?? '').trim().isEmpty ? l.requiredField : null,
              ),
              gap,
              TextFormField(
                controller: _customer,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(labelText: l.jobCustomer),
              ),
              gap,
              TextFormField(
                controller: _qty,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: l.jobQuantity),
                validator: (v) {
                  final n = int.tryParse((v ?? '').trim());
                  return n == null || n < 1 ? l.mustBePositive : null;
                },
              ),
              gap,
              SegmentedButton<JobStatus>(
                showSelectedIcon: false,
                segments: [
                  for (final s in JobStatus.values)
                    ButtonSegment(value: s, label: Text(statusLabel(l, s))),
                ],
                selected: {_status},
                onSelectionChanged: (v) => setState(() => _status = v.first),
              ),
              gap,
              TextFormField(
                controller: _notes,
                maxLines: 2,
                decoration: InputDecoration(labelText: l.jobNotes),
              ),
              gap,
              Row(
                children: [
                  if (_photo != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(_photo!),
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  Expanded(child: Text(l.jobPhoto)),
                  IconButton(
                    tooltip: l.takePhoto,
                    icon: const Icon(Icons.photo_camera_outlined),
                    onPressed: () => _pickPhoto(ImageSource.camera),
                  ),
                  IconButton(
                    tooltip: l.pickPhoto,
                    icon: const Icon(Icons.photo_library_outlined),
                    onPressed: () => _pickPhoto(ImageSource.gallery),
                  ),
                  if (_photo != null)
                    IconButton(
                      tooltip: l.removePhoto,
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => setState(() => _photo = null),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              FilledButton(
                key: const Key('save.confirm'),
                onPressed: _submit,
                child: Text(l.save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
