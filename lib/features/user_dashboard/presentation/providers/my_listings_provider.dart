import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../sell_your_car/domain/entities/entities.dart';
import '../../../sell_your_car/presentation/providers/good_car_form_notifier.dart';

final myListingsProvider = FutureProvider<List<CarListing>>((ref) async {
  final repository = ref.watch(carMarketplaceRepositoryProvider);
  return repository.getMyListings(page: 1, limit: 20);
});
