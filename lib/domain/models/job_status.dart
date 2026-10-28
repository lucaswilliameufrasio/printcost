/// Lifecycle of a saved part/quote.
enum JobStatus {
  /// Only a quote, nothing printed yet.
  quote,

  /// Approved and being printed / post-processed.
  inProduction,

  /// Delivered to the customer.
  delivered,
}
