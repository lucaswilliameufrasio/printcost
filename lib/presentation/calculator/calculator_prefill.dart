import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/job_repository.dart';

class PrefillFilament {
  const PrefillFilament({required this.weightMg, this.filamentId, this.label});
  final int? filamentId;
  final int weightMg;

  /// Description from the source (e.g. "PLA #FFFFFF" from a .3mf).
  final String? label;
}

/// Data to load into the calculator: an existing job (edit), or values
/// imported from a sliced file / finished printer job.
class CalculatorPrefill {
  const CalculatorPrefill({
    this.job,
    this.filaments = const [],
    this.printSeconds,
    this.sourceFile,
    this.suggestedName,
    this.printerId,
  });

  final JobWithFilaments? job;
  final List<PrefillFilament> filaments;
  final int? printSeconds;
  final String? sourceFile;
  final String? suggestedName;
  final int? printerId;
}

class CalculatorPrefillNotifier extends Notifier<CalculatorPrefill?> {
  @override
  CalculatorPrefill? build() => null;

  void set(CalculatorPrefill prefill) => state = prefill;

  CalculatorPrefill? take() {
    final p = state;
    state = null;
    return p;
  }
}

final calculatorPrefillProvider =
    NotifierProvider<CalculatorPrefillNotifier, CalculatorPrefill?>(
      CalculatorPrefillNotifier.new,
    );
