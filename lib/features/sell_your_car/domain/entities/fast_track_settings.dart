class FastTrackDurationOption {
  final int hours;
  final double discountPercentage;
  final double price;

  const FastTrackDurationOption({
    required this.hours,
    required this.discountPercentage,
    required this.price,
  });
}

class FastTrackSettings {
  final List<FastTrackDurationOption> options;

  const FastTrackSettings({required this.options});
}
