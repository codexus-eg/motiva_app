import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/reviews_remote_data_source.dart';
import '../../data/models/create_review_dto.dart';
import '../../data/repositories/reviews_repository_impl.dart';
import '../../domain/entities/review.dart';
import '../../domain/repositories/reviews_repository.dart';
import '../widgets/sort_dropdown.dart';

final reviewsRemoteDataSourceProvider = Provider<ReviewsRemoteDataSource>((
  ref,
) {
  final dioClient = ref.watch(dioClientProvider);
  return ReviewsRemoteDataSourceImpl(dioClient);
});

final reviewsRepositoryProvider = Provider<ReviewsRepository>((ref) {
  final remoteDataSource = ref.watch(reviewsRemoteDataSourceProvider);
  return ReviewsRepositoryImpl(remoteDataSource);
});

class SubmitReviewNotifier extends AsyncNotifier<void> {
  @override
  void build() {
    return;
  }

  Future<void> submitReview({
    String? serviceOrderId,
    String? productOrderId,
    required String vendorId,
    required int rating,
    required String body,
  }) async {
    state = const AsyncValue.loading();
    final repository = ref.watch(reviewsRepositoryProvider);

    final dto = CreateReviewDto(
      serviceOrderId: serviceOrderId,
      productOrderId: productOrderId,
      vendorId: vendorId,
      rating: rating,
      body: body,
    );

    state = await AsyncValue.guard(() => repository.submitReview(dto));
  }
}

final submitReviewNotifierProvider =
    AsyncNotifierProvider<SubmitReviewNotifier, void>(
      () => SubmitReviewNotifier(),
    );

class ReviewsListNotifier extends StateNotifier<ReviewsListState> {
  final ReviewsRepository _repository;

  ReviewsListNotifier(this._repository) : super(ReviewsListState.initial());

  Future<void> loadReviews({
    String? vendorServiceId,
    String? productId,
    String? vendorId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _repository.getReviews(
        vendorServiceId: vendorServiceId,
        productId: productId,
        vendorId: vendorId,
        rating: state.selectedRating,
        sort: state.selectedSort.value,
        page: 1,
        limit: 10,
      );

      state = state.copyWith(
        reviews: response.data,
        totalReviews: response.total,
        averageRating: response.averageRating,
        isLoading: false,
        hasMore: response.hasMore,
        nextCursor: response.nextCursor,
        currentPage: 1,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> applyFilter(int? rating) async {
    state = state.copyWith(selectedRating: rating);
    await _refreshWithCurrentFilters();
  }

  Future<void> applySort(SortOption sort) async {
    state = state.copyWith(selectedSort: sort);
    await _refreshWithCurrentFilters();
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    try {
      final response = await _repository.getReviews(
        vendorServiceId: state.vendorServiceId,
        productId: state.productId,
        vendorId: state.vendorId,
        rating: state.selectedRating,
        sort: state.selectedSort.value,
        page: state.currentPage + 1,
        limit: 10,
        cursor: state.nextCursor,
      );

      state = state.copyWith(
        reviews: [...state.reviews, ...response.data],
        isLoading: false,
        hasMore: response.hasMore,
        nextCursor: response.nextCursor,
        currentPage: state.currentPage + 1,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> _refreshWithCurrentFilters() async {
    await loadReviews(
      vendorServiceId: state.vendorServiceId,
      productId: state.productId,
      vendorId: state.vendorId,
    );
  }

  void setContext({
    String? vendorServiceId,
    String? productId,
    String? vendorId,
  }) {
    state = state.copyWith(
      vendorServiceId: vendorServiceId,
      productId: productId,
      vendorId: vendorId,
    );
  }
}

class ReviewsListState {
  final List<Review> reviews;
  final int totalReviews;
  final double averageRating;
  final int? selectedRating;
  final SortOption selectedSort;
  final bool isLoading;
  final bool hasMore;
  final String? nextCursor;
  final int currentPage;
  final String? error;
  final String? vendorServiceId;
  final String? productId;
  final String? vendorId;

  ReviewsListState({
    required this.reviews,
    required this.totalReviews,
    required this.averageRating,
    required this.selectedRating,
    required this.selectedSort,
    required this.isLoading,
    required this.hasMore,
    this.nextCursor,
    required this.currentPage,
    this.error,
    this.vendorServiceId,
    this.productId,
    this.vendorId,
  });

  factory ReviewsListState.initial() {
    return ReviewsListState(
      reviews: [],
      totalReviews: 0,
      averageRating: 0.0,
      selectedRating: null,
      selectedSort: SortOption.mostRecent,
      isLoading: false,
      hasMore: false,
      currentPage: 1,
    );
  }

  ReviewsListState copyWith({
    List<Review>? reviews,
    int? totalReviews,
    double? averageRating,
    int? selectedRating,
    SortOption? selectedSort,
    bool? isLoading,
    bool? hasMore,
    String? nextCursor,
    int? currentPage,
    String? error,
    String? vendorServiceId,
    String? productId,
    String? vendorId,
  }) {
    return ReviewsListState(
      reviews: reviews ?? this.reviews,
      totalReviews: totalReviews ?? this.totalReviews,
      averageRating: averageRating ?? this.averageRating,
      selectedRating: selectedRating ?? this.selectedRating,
      selectedSort: selectedSort ?? this.selectedSort,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      nextCursor: nextCursor ?? this.nextCursor,
      currentPage: currentPage ?? this.currentPage,
      error: error,
      vendorServiceId: vendorServiceId ?? this.vendorServiceId,
      productId: productId ?? this.productId,
      vendorId: vendorId ?? this.vendorId,
    );
  }
}

final reviewsListNotifierProvider =
    StateNotifierProvider.family<ReviewsListNotifier, ReviewsListState, String>(
      (ref, contextKey) {
        final repository = ref.watch(reviewsRepositoryProvider);
        return ReviewsListNotifier(repository);
      },
    );
