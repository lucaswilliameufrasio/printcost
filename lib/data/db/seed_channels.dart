import '../../domain/pricing/cost_calculator.dart';

/// Example marketplace fees (Brazil, Oct 2026, from public seller guides).
/// Marketplaces change them often, so they are flagged as examples and the
/// channel screen asks the user to check them.
/// Official fee pages, opened from the channel screen.
const shopeeFeesUrl = 'https://seller.shopee.com.br/edu/article/18483';
const mercadoLivreFeesUrl = 'https://www.mercadolivre.com.br/ajuda/870';

const shopeeExampleTiers = [
  FeeTier(feeBp: 2000, fixedCents: 450),
  FeeTier(minPriceCents: 8000, feeBp: 1400, fixedCents: 1600),
  FeeTier(minPriceCents: 10000, feeBp: 1400, fixedCents: 2000),
  FeeTier(minPriceCents: 20000, feeBp: 1400, fixedCents: 2600),
];

const mercadoLivreExampleTiers = [
  FeeTier(feeBp: 1400, fixedCents: 650),
  FeeTier(minPriceCents: 7900, feeBp: 1400),
];
