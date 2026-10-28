import 'package:flutter_test/flutter_test.dart';
import 'package:printcost/domain/pricing/cost_calculator.dart';
import 'package:printcost/domain/pricing/price_rounding.dart';

/// Hand-checked example (see README "Exemplo conferido à mão"):
///
/// * Filamento: rolo R$ 120,00 / 1000 g -> R$ 0,12/g; peça usa 50 g; 10% purga
///   material = 50 × 0,12 × 1,10 = R$ 6,60
/// * Impressora 150 W, 4 h, kWh R$ 0,90
///   energia = 0,15 kW × 4 h × 0,90 = R$ 0,54
/// * Máquina R$ 5.000 / 5.000 h = R$ 1,00/h + manutenção R$ 0,20/h
///   desgaste = 1,20 × 4 = R$ 4,80
/// * Pós-processamento 15 min a R$ 30/h -> R$ 7,50
/// * Embalagem R$ 2,00
///   subtotal = 6,60 + 0,54 + 4,80 + 7,50 + 2,00 = R$ 21,44
/// * Falha 5%: 21,44 × 1,05 = 22,512 -> custo R$ 22,51
/// * Margem 30% + marketplace 12% + impostos 6% = 48%
///   preço = 22,51 / 0,52 = 43,288… -> R$ 43,29
/// * Arredondado para ,90 -> R$ 43,90
///   taxa = 43,90 × 12% = 5,268 -> 5,27; impostos = 43,90 × 6% = 2,634 -> 2,63
///   lucro = 43,90 − 22,51 − 5,27 − 2,63 = R$ 13,49 (30,73% do preço)
PricingInput handCheckedInput({PriceRounding rounding = PriceRounding.none}) =>
    PricingInput(
      filaments: const [
        FilamentUsage(
          weightMg: 50000,
          rollPriceCents: 12000,
          rollWeightGrams: 1000,
        ),
      ],
      printSeconds: 4 * 3600,
      machine: const MachineProfile(
        powerWatts: 150,
        machineValueCents: 500000,
        lifespanHours: 5000,
        maintenancePerHourCents: 20,
      ),
      kwhPrice: 9000,
      postProcessMinutes: 15,
      laborHourCents: 3000,
      packagingCents: 200,
      wasteBp: 1000,
      failureBp: 500,
      marginBp: 3000,
      marketplaceFeeBp: 1200,
      taxBp: 600,
      rounding: rounding,
    );

CostBreakdown ok(PricingResult r) => switch (r) {
  PricingSuccess(:final breakdown) => breakdown,
  PricingFailure(:final error) => throw TestFailure('unexpected $error'),
};

void main() {
  group('calculatePrice – hand-checked example', () {
    test('cost components', () {
      final b = ok(calculatePrice(handCheckedInput()));
      expect(b.materialCents, 660);
      expect(b.energyCents, 54);
      expect(b.machineWearCents, 480);
      expect(b.laborCents, 750);
      expect(b.packagingCents, 200);
      expect(b.subtotalCents, 2144);
      expect(b.failureCents, 107);
      expect(b.totalCostCents, 2251);
      expect(b.unroundedPriceCents, 4329);
      expect(b.priceCents, 4329);
    });

    test('with ,90 rounding and net profit', () {
      final b = ok(
        calculatePrice(handCheckedInput(rounding: PriceRounding.endsIn90)),
      );
      expect(b.unroundedPriceCents, 4329);
      expect(b.priceCents, 4390);
      expect(b.marketplaceFeeCents, 527);
      expect(b.taxCents, 263);
      expect(b.netProfitCents, 1349);
      expect(b.netMarginBp, 3073);
    });

    test('breakdown always adds up', () {
      final b = ok(calculatePrice(handCheckedInput()));
      expect(
        b.materialCents +
            b.energyCents +
            b.machineWearCents +
            b.laborCents +
            b.packagingCents,
        b.subtotalCents,
      );
      expect(b.subtotalCents + b.failureCents, b.totalCostCents);
      expect(
        b.totalCostCents +
            b.marketplaceFeeCents +
            b.taxCents +
            b.netProfitCents,
        b.priceCents,
      );
    });
  });

  group('calculatePrice – margin + fees + taxes', () {
    PricingInput withDeductions(int margin, int fee, int tax) => PricingInput(
      filaments: const [
        FilamentUsage(
          weightMg: 10000,
          rollPriceCents: 10000,
          rollWeightGrams: 1000,
        ),
      ],
      printSeconds: 3600,
      machine: null,
      kwhPrice: 0,
      postProcessMinutes: 0,
      laborHourCents: 0,
      packagingCents: 0,
      wasteBp: 0,
      failureBp: 0,
      marginBp: margin,
      marketplaceFeeBp: fee,
      taxBp: tax,
    );

    test('exactly 100% is an error (would divide by zero)', () {
      final r = calculatePrice(withDeductions(5000, 3000, 2000));
      expect(r, isA<PricingFailure>());
      final f = r as PricingFailure;
      expect(f.error, PricingError.deductionsTooHigh);
      expect(f.deductionsBp, 10000);
    });

    test('above 100% is an error (would give negative price)', () {
      final r = calculatePrice(withDeductions(8000, 2000, 1000));
      expect((r as PricingFailure).error, PricingError.deductionsTooHigh);
      expect(r.deductionsBp, 11000);
    });

    test('99,99% still works', () {
      final b = ok(calculatePrice(withDeductions(9999, 0, 0)));
      // cost R$ 1,00 / 0,0001 = R$ 10.000,00
      expect(b.totalCostCents, 100);
      expect(b.priceCents, 1000000);
    });

    test('zero deductions: price equals cost', () {
      final b = ok(calculatePrice(withDeductions(0, 0, 0)));
      expect(b.priceCents, b.totalCostCents);
      expect(b.netProfitCents, 0);
    });
  });

  group('calculatePrice – several filaments (AMS)', () {
    test('sums each filament with its own price per gram, then waste', () {
      final b = ok(
        calculatePrice(
          const PricingInput(
            filaments: [
              // 30 g × R$ 0,10/g = 3,00
              FilamentUsage(
                weightMg: 30000,
                rollPriceCents: 10000,
                rollWeightGrams: 1000,
              ),
              // 12,5 g × (R$ 150 / 750 g = 0,20/g) = 2,50
              FilamentUsage(
                weightMg: 12500,
                rollPriceCents: 15000,
                rollWeightGrams: 750,
              ),
              // 0,333 g × R$ 0,25/g = 0,08325
              FilamentUsage(
                weightMg: 333,
                rollPriceCents: 25000,
                rollWeightGrams: 1000,
              ),
            ],
            printSeconds: 0,
            machine: null,
            kwhPrice: 0,
            postProcessMinutes: 0,
            laborHourCents: 0,
            packagingCents: 0,
            // (3,00 + 2,50 + 0,08325) × 1,20 = 6,6999 -> 6,70
            wasteBp: 2000,
            failureBp: 0,
            marginBp: 0,
            marketplaceFeeBp: 0,
            taxBp: 0,
          ),
        ),
      );
      expect(b.materialCents, 670);
    });

    test('roll weight 0 with usage is an error', () {
      final r = calculatePrice(
        const PricingInput(
          filaments: [
            FilamentUsage(
              weightMg: 1000,
              rollPriceCents: 100,
              rollWeightGrams: 0,
            ),
          ],
          printSeconds: 0,
          machine: null,
          kwhPrice: 0,
          postProcessMinutes: 0,
          laborHourCents: 0,
          packagingCents: 0,
          wasteBp: 0,
          failureBp: 0,
          marginBp: 0,
          marketplaceFeeBp: 0,
          taxBp: 0,
        ),
      );
      expect((r as PricingFailure).error, PricingError.invalidRollWeight);
    });
  });

  test('negative values are rejected', () {
    final input = handCheckedInput();
    final r = calculatePrice(
      PricingInput(
        filaments: input.filaments,
        printSeconds: input.printSeconds,
        machine: input.machine,
        kwhPrice: input.kwhPrice,
        postProcessMinutes: -1,
        laborHourCents: input.laborHourCents,
        packagingCents: input.packagingCents,
        wasteBp: input.wasteBp,
        failureBp: input.failureBp,
        marginBp: input.marginBp,
        marketplaceFeeBp: input.marketplaceFeeBp,
        taxBp: input.taxBp,
      ),
    );
    expect((r as PricingFailure).error, PricingError.negativeValue);
  });

  test('printer lifespan 0 disables depreciation but keeps maintenance', () {
    final b = ok(
      calculatePrice(
        const PricingInput(
          filaments: [],
          printSeconds: 7200,
          machine: MachineProfile(
            powerWatts: 0,
            machineValueCents: 100000,
            lifespanHours: 0,
            maintenancePerHourCents: 50,
          ),
          kwhPrice: 0,
          postProcessMinutes: 0,
          laborHourCents: 0,
          packagingCents: 0,
          wasteBp: 0,
          failureBp: 0,
          marginBp: 0,
          marketplaceFeeBp: 0,
          taxBp: 0,
        ),
      ),
    );
    expect(b.machineWearCents, 100);
  });

  group('applyPriceRounding', () {
    test('ends in ,90 always rounds up', () {
      expect(applyPriceRounding(4329, PriceRounding.endsIn90), 4390);
      expect(applyPriceRounding(4390, PriceRounding.endsIn90), 4390);
      expect(applyPriceRounding(4395, PriceRounding.endsIn90), 4490);
      expect(applyPriceRounding(5, PriceRounding.endsIn90), 90);
    });
    test('ends in ,99', () {
      expect(applyPriceRounding(1000, PriceRounding.endsIn99), 1099);
      expect(applyPriceRounding(1099, PriceRounding.endsIn99), 1099);
    });
    test('half and whole unit', () {
      expect(applyPriceRounding(1001, PriceRounding.halfUnit), 1050);
      expect(applyPriceRounding(1050, PriceRounding.halfUnit), 1050);
      expect(applyPriceRounding(1001, PriceRounding.wholeUnit), 1100);
      expect(applyPriceRounding(1100, PriceRounding.wholeUnit), 1100);
    });
    test('none and zero are untouched', () {
      expect(applyPriceRounding(1234, PriceRounding.none), 1234);
      expect(applyPriceRounding(0, PriceRounding.endsIn90), 0);
    });
  });
}
