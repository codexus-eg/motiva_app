import 'package:app/features/sell_your_car/domain/entities/entities.dart';

class ListingResult {
  final bool isSuccess;
  final CarListing? listing;
  final String? errorMessage;
  final String? errorCode;

  const ListingResult._({
    required this.isSuccess,
    this.listing,
    this.errorMessage,
    this.errorCode,
  });

  factory ListingResult.success(CarListing listing) {
    return ListingResult._(isSuccess: true, listing: listing);
  }

  factory ListingResult.failure(String message, {String? code}) {
    return ListingResult._(
      isSuccess: false,
      errorMessage: message,
      errorCode: code,
    );
  }
}

class CarDataResult<T> {
  final bool isSuccess;
  final T? data;
  final String? errorMessage;

  const CarDataResult._({
    required this.isSuccess,
    this.data,
    this.errorMessage,
  });

  factory CarDataResult.success(T data) {
    return CarDataResult._(isSuccess: true, data: data);
  }

  factory CarDataResult.failure(String message) {
    return CarDataResult._(isSuccess: false, errorMessage: message);
  }
}
