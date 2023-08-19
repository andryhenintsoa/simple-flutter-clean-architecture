extension DisplayableText on num{
  String get displayableText => toStringAsFixed(truncateToDouble() == this ? 0 : 2);
}