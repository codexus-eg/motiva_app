sealed class CreateListingState {
  const CreateListingState();
}

class CreateListingInitial extends CreateListingState {
  const CreateListingInitial();
}

class CreateListingSubmitting extends CreateListingState {
  const CreateListingSubmitting();
}

class CreateListingSuccess extends CreateListingState {
  final String listingId;

  const CreateListingSuccess(this.listingId);
}

class CreateListingError extends CreateListingState {
  final String message;

  const CreateListingError(this.message);
}
