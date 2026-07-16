class RoadService {
  final String id;
  final String title;
  final String description;
  final double price;
  final int points;
  final String imageAsset;
  final double rating;
  final String duration;

  const RoadService({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.points,
    required this.imageAsset,
    this.rating = 4.5,
    this.duration = '40 Min',
  });
}
