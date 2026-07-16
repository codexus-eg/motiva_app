import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../sell_your_car/domain/entities/entities.dart';
import '../../../sell_your_car/presentation/providers/good_car_form_notifier.dart';

final listingDetailsProvider = FutureProvider.family<CarListing, String>((ref, listingId) async {
  final repository = ref.watch(carMarketplaceRepositoryProvider);
  return repository.getListing(listingId);
});
