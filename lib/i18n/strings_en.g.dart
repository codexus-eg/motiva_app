///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsGeneralEn general = TranslationsGeneralEn._(_root);
	late final TranslationsAuthEn auth = TranslationsAuthEn._(_root);
	late final TranslationsBookingEn booking = TranslationsBookingEn._(_root);
	late final TranslationsHomeEn home = TranslationsHomeEn._(_root);
	late final TranslationsCartEn cart = TranslationsCartEn._(_root);
	late final TranslationsCheckoutEn checkout = TranslationsCheckoutEn._(_root);
	late final TranslationsPublicServicesEn public_services = TranslationsPublicServicesEn._(_root);
	late final TranslationsPublicMarketplaceEn public_marketplace = TranslationsPublicMarketplaceEn._(_root);
	late final TranslationsServicesEn services = TranslationsServicesEn._(_root);
	late final TranslationsBuyACarEn buy_a_car = TranslationsBuyACarEn._(_root);
	late final TranslationsReviewsEn reviews = TranslationsReviewsEn._(_root);
	late final TranslationsUserDashboardEn user_dashboard = TranslationsUserDashboardEn._(_root);
	late final TranslationsBottomNavEn bottom_nav = TranslationsBottomNavEn._(_root);
	late final TranslationsSellYourCarEn sell_your_car = TranslationsSellYourCarEn._(_root);
	late final TranslationsVendorDashboardEn vendor_dashboard = TranslationsVendorDashboardEn._(_root);
	late final TranslationsVendorListingsEn vendor_listings = TranslationsVendorListingsEn._(_root);
	late final TranslationsVendorProductsEn vendor_products = TranslationsVendorProductsEn._(_root);
	late final TranslationsInventoryEn inventory = TranslationsInventoryEn._(_root);
	late final TranslationsVendorServicesEn vendor_services = TranslationsVendorServicesEn._(_root);
	late final TranslationsVendorProductAnalyticsEn vendor_product_analytics = TranslationsVendorProductAnalyticsEn._(_root);
}

// Path: general
class TranslationsGeneralEn {
	TranslationsGeneralEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Motiva App'
	String get app_name => 'Motiva App';
}

// Path: auth
class TranslationsAuthEn {
	TranslationsAuthEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsAuthLoginEn login = TranslationsAuthLoginEn._(_root);
	late final TranslationsAuthRegisterAsEn register_as = TranslationsAuthRegisterAsEn._(_root);
	late final TranslationsAuthRegisterVendorEn register_vendor = TranslationsAuthRegisterVendorEn._(_root);
	late final TranslationsAuthRegisterCustomerEn register_customer = TranslationsAuthRegisterCustomerEn._(_root);
	late final TranslationsAuthVerifyEn verify = TranslationsAuthVerifyEn._(_root);
	late final TranslationsAuthCategoryEn category = TranslationsAuthCategoryEn._(_root);
	late final TranslationsAuthSplashEn splash = TranslationsAuthSplashEn._(_root);

	/// en: 'Phone Number'
	String get phone_number => 'Phone Number';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Confirm Password'
	String get confirm_password => 'Confirm Password';

	/// en: 'CONTINUE'
	String get continue_button => 'CONTINUE';

	/// en: 'GET STARTED'
	String get get_started => 'GET STARTED';

	/// en: 'SENDING OTP...'
	String get loading => 'SENDING OTP...';

	/// en: 'Already have an account? '
	String get already_have_account => 'Already have an account? ';

	/// en: 'Login'
	String get login_button => 'Login';
}

// Path: booking
class TranslationsBookingEn {
	TranslationsBookingEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsBookingBookingScreenEn booking_screen = TranslationsBookingBookingScreenEn._(_root);
	late final TranslationsBookingOrderConfirmationEn order_confirmation = TranslationsBookingOrderConfirmationEn._(_root);
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsHomeServicesGridEn services_grid = TranslationsHomeServicesGridEn._(_root);
	late final TranslationsHomeCustomerEn customer = TranslationsHomeCustomerEn._(_root);
	late final TranslationsHomeVendorEn vendor = TranslationsHomeVendorEn._(_root);
	late final TranslationsHomeOperatorEn operator = TranslationsHomeOperatorEn._(_root);
}

// Path: cart
class TranslationsCartEn {
	TranslationsCartEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'CART'
	String get title => 'CART';

	/// en: 'Failed to load cart:'
	String get error_loading => 'Failed to load cart:';

	late final TranslationsCartEmptyEn empty = TranslationsCartEmptyEn._(_root);

	/// en: 'Delivering from'
	String get delivering_from => 'Delivering from';

	/// en: 'All Items'
	String get all_items => 'All Items';

	/// en: 'Special Request'
	String get special_request => 'Special Request';

	/// en: 'Write any special request about the order.'
	String get special_request_hint => 'Write any special request about the order.';

	/// en: 'Price'
	String get price => 'Price';

	/// en: 'items'
	String get items => 'items';

	/// en: 'Promo Code'
	String get promo_code => 'Promo Code';

	/// en: 'Total Amount'
	String get total_amount => 'Total Amount';

	/// en: 'You saved'
	String get you_saved => 'You saved';

	/// en: 'on this order'
	String get order => 'on this order';

	/// en: 'CHECKOUT'
	String get checkout_button => 'CHECKOUT';

	/// en: 'We are ready to serve you anytime'
	String get vendor_subtitle => 'We are ready to serve you anytime';
}

// Path: checkout
class TranslationsCheckoutEn {
	TranslationsCheckoutEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'CHECKOUT'
	String get title => 'CHECKOUT';

	/// en: 'Order Summary'
	String get order_summary => 'Order Summary';

	/// en: 'Subtotal'
	String get subtotal => 'Subtotal';

	/// en: 'Delivery Fee'
	String get delivery_fee => 'Delivery Fee';

	/// en: 'Voucher Discount'
	String get voucher_discount => 'Voucher Discount';

	/// en: 'Wallet Used'
	String get wallet_used => 'Wallet Used';

	/// en: 'Total'
	String get total => 'Total';

	/// en: 'Delivery Address'
	String get delivery_address => 'Delivery Address';

	/// en: 'Add New Address'
	String get add_new_address => 'Add New Address';

	/// en: 'Save Address'
	String get save_address => 'Save Address';

	/// en: 'Voucher Code'
	String get voucher_code => 'Voucher Code';

	/// en: 'Enter voucher code'
	String get enter_voucher => 'Enter voucher code';

	/// en: 'Apply'
	String get apply => 'Apply';

	/// en: 'Voucher applied successfully!'
	String get voucher_applied => 'Voucher applied successfully!';

	/// en: 'Wallet Balance'
	String get wallet_balance => 'Wallet Balance';

	/// en: 'Payment Methods'
	String get payment_methods => 'Payment Methods';

	/// en: 'PAY'
	String get pay => 'PAY';

	/// en: 'PROCESSING...'
	String get processing => 'PROCESSING...';

	/// en: 'Order Confirmed!'
	String get order_confirmed => 'Order Confirmed!';

	/// en: 'Your order has been placed successfully.'
	String get order_placed => 'Your order has been placed successfully.';

	/// en: 'Total Payment'
	String get total_payment => 'Total Payment';

	/// en: 'Order #'
	String get order_number => 'Order #';

	/// en: 'Payment Time'
	String get payment_time => 'Payment Time';

	/// en: 'Payment Method'
	String get payment_method => 'Payment Method';

	/// en: 'Items'
	String get items => 'Items';

	/// en: 'Estimated Delivery'
	String get estimated_delivery => 'Estimated Delivery';

	/// en: 'Track Order'
	String get track_order => 'Track Order';

	/// en: 'BACK HOME'
	String get back_home => 'BACK HOME';

	/// en: 'Continue shopping'
	String get continue_shopping => 'Continue shopping';

	/// en: 'Motiva Wallet'
	String get motiva_wallet => 'Motiva Wallet';

	/// en: 'Balance:'
	String get balance => 'Balance:';

	/// en: 'Please fill required fields'
	String get fill_required_fields => 'Please fill required fields';

	/// en: 'Label (e.g. Home, Work)'
	String get address_label_hint => 'Label (e.g. Home, Work)';

	/// en: 'Street *'
	String get street => 'Street *';

	/// en: 'Area *'
	String get area => 'Area *';

	/// en: 'Block *'
	String get block => 'Block *';

	/// en: 'Building'
	String get building => 'Building';

	/// en: 'Floor'
	String get floor => 'Floor';

	/// en: 'Apartment'
	String get apartment => 'Apartment';

	/// en: 'Notes'
	String get notes => 'Notes';

	/// en: 'Address'
	String get default_address_label => 'Address';

	/// en: 'Block'
	String get block_label => 'Block';

	/// en: 'Building'
	String get building_label => 'Building';

	/// en: 'Floor'
	String get floor_label => 'Floor';

	/// en: 'Apt'
	String get apartment_label => 'Apt';
}

// Path: public_services
class TranslationsPublicServicesEn {
	TranslationsPublicServicesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsPublicServicesCategoryVendorsEn category_vendors = TranslationsPublicServicesCategoryVendorsEn._(_root);
	late final TranslationsPublicServicesVendorServicesEn vendor_services = TranslationsPublicServicesVendorServicesEn._(_root);
	late final TranslationsPublicServicesServicesDetailsEn services_details = TranslationsPublicServicesServicesDetailsEn._(_root);
}

// Path: public_marketplace
class TranslationsPublicMarketplaceEn {
	TranslationsPublicMarketplaceEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsPublicMarketplaceCategoryScreenEn category_screen = TranslationsPublicMarketplaceCategoryScreenEn._(_root);
	late final TranslationsPublicMarketplaceDetailsScreenEn details_screen = TranslationsPublicMarketplaceDetailsScreenEn._(_root);
	late final TranslationsPublicMarketplaceVendorDetailsScreenEn vendor_details_screen = TranslationsPublicMarketplaceVendorDetailsScreenEn._(_root);
	late final TranslationsPublicMarketplaceSparePartsEn spare_parts = TranslationsPublicMarketplaceSparePartsEn._(_root);
}

// Path: services
class TranslationsServicesEn {
	TranslationsServicesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsServicesScreenEn screen = TranslationsServicesScreenEn._(_root);
	late final TranslationsServicesAllServicesGridEn all_services_grid = TranslationsServicesAllServicesGridEn._(_root);
}

// Path: buy_a_car
class TranslationsBuyACarEn {
	TranslationsBuyACarEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsBuyACarScreenEn screen = TranslationsBuyACarScreenEn._(_root);
	late final TranslationsBuyACarServiceSectionEn service_section = TranslationsBuyACarServiceSectionEn._(_root);
	late final TranslationsBuyACarGoodConditionScreenEn good_condition_screen = TranslationsBuyACarGoodConditionScreenEn._(_root);
	late final TranslationsBuyACarApprovedCarsScreenEn approved_cars_screen = TranslationsBuyACarApprovedCarsScreenEn._(_root);
	late final TranslationsBuyACarDamagedCarsScreenEn damaged_cars_screen = TranslationsBuyACarDamagedCarsScreenEn._(_root);
	late final TranslationsBuyACarDetailsScreenEn details_screen = TranslationsBuyACarDetailsScreenEn._(_root);
	late final TranslationsBuyACarCarChatEn car_chat = TranslationsBuyACarCarChatEn._(_root);
	late final TranslationsBuyACarListingCardEn listing_card = TranslationsBuyACarListingCardEn._(_root);
	late final TranslationsBuyACarFiltersEn filters = TranslationsBuyACarFiltersEn._(_root);
}

// Path: reviews
class TranslationsReviewsEn {
	TranslationsReviewsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Submit Review'
	String get screen_title => 'Submit Review';

	/// en: 'Rate Service'
	String get rate_service => 'Rate Service';

	/// en: 'Your Review'
	String get your_review => 'Your Review';

	/// en: 'Share your experience with this service...'
	String get review_placeholder => 'Share your experience with this service...';

	/// en: '/5000'
	String get character_count => '/5000';

	/// en: 'Submit Review'
	String get submit_review => 'Submit Review';

	/// en: 'Submitting...'
	String get submitting => 'Submitting...';

	/// en: 'Review submitted successfully!'
	String get success_message => 'Review submitted successfully!';

	/// en: 'You have already reviewed this order'
	String get error_already_reviewed => 'You have already reviewed this order';

	/// en: 'Please check your input and try again'
	String get error_validation => 'Please check your input and try again';

	/// en: 'Network error. Please try again'
	String get error_network => 'Network error. Please try again';

	late final TranslationsReviewsDisplayEn display = TranslationsReviewsDisplayEn._(_root);
}

// Path: user_dashboard
class TranslationsUserDashboardEn {
	TranslationsUserDashboardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsUserDashboardProfileEn profile = TranslationsUserDashboardProfileEn._(_root);
	late final TranslationsUserDashboardMenuEn menu = TranslationsUserDashboardMenuEn._(_root);
	late final TranslationsUserDashboardWalletEn wallet = TranslationsUserDashboardWalletEn._(_root);
	late final TranslationsUserDashboardOrdersEn orders = TranslationsUserDashboardOrdersEn._(_root);
	late final TranslationsUserDashboardActiveOrdersPreviewEn active_orders_preview = TranslationsUserDashboardActiveOrdersPreviewEn._(_root);
	late final TranslationsUserDashboardLoyaltyEn loyalty = TranslationsUserDashboardLoyaltyEn._(_root);
	late final TranslationsUserDashboardListingsEn listings = TranslationsUserDashboardListingsEn._(_root);
	late final TranslationsUserDashboardListingDetailsEn listing_details = TranslationsUserDashboardListingDetailsEn._(_root);
	late final TranslationsUserDashboardEditSpecsEn edit_specs = TranslationsUserDashboardEditSpecsEn._(_root);
	late final TranslationsUserDashboardNotificationsEn notifications = TranslationsUserDashboardNotificationsEn._(_root);
	late final TranslationsUserDashboardSettingsEn settings = TranslationsUserDashboardSettingsEn._(_root);
}

// Path: bottom_nav
class TranslationsBottomNavEn {
	TranslationsBottomNavEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsBottomNavCustomerEn customer = TranslationsBottomNavCustomerEn._(_root);
	late final TranslationsBottomNavVendorEn vendor = TranslationsBottomNavVendorEn._(_root);
	late final TranslationsBottomNavOperatorEn operator = TranslationsBottomNavOperatorEn._(_root);
}

// Path: sell_your_car
class TranslationsSellYourCarEn {
	TranslationsSellYourCarEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsSellYourCarScreensEn screens = TranslationsSellYourCarScreensEn._(_root);
	late final TranslationsSellYourCarStepsEn steps = TranslationsSellYourCarStepsEn._(_root);
	late final TranslationsSellYourCarMakeTabEn make_tab = TranslationsSellYourCarMakeTabEn._(_root);
	late final TranslationsSellYourCarModelTabEn model_tab = TranslationsSellYourCarModelTabEn._(_root);
	late final TranslationsSellYourCarTrimTabEn trim_tab = TranslationsSellYourCarTrimTabEn._(_root);
	late final TranslationsSellYourCarYearTabEn year_tab = TranslationsSellYourCarYearTabEn._(_root);
	late final TranslationsSellYourCarMileageTabEn mileage_tab = TranslationsSellYourCarMileageTabEn._(_root);
	late final TranslationsSellYourCarSellingPriceTabEn selling_price_tab = TranslationsSellYourCarSellingPriceTabEn._(_root);
	late final TranslationsSellYourCarColorsTabEn colors_tab = TranslationsSellYourCarColorsTabEn._(_root);
	late final TranslationsSellYourCarCarColorEn car_color = TranslationsSellYourCarCarColorEn._(_root);
	late final TranslationsSellYourCarImagesTabEn images_tab = TranslationsSellYourCarImagesTabEn._(_root);
	late final TranslationsSellYourCarLocationTabEn location_tab = TranslationsSellYourCarLocationTabEn._(_root);
	late final TranslationsSellYourCarInspectionReportEn inspection_report = TranslationsSellYourCarInspectionReportEn._(_root);
	late final TranslationsSellYourCarCarConditionEn car_condition = TranslationsSellYourCarCarConditionEn._(_root);
	late final TranslationsSellYourCarDescriptionEn description = TranslationsSellYourCarDescriptionEn._(_root);
	late final TranslationsSellYourCarBodyPanelTabEn body_panel_tab = TranslationsSellYourCarBodyPanelTabEn._(_root);
	late final TranslationsSellYourCarPaintConditionTabEn paint_condition_tab = TranslationsSellYourCarPaintConditionTabEn._(_root);
	late final TranslationsSellYourCarEndTabEn end_tab = TranslationsSellYourCarEndTabEn._(_root);
	late final TranslationsSellYourCarEngineTabEn engine_tab = TranslationsSellYourCarEngineTabEn._(_root);
	late final TranslationsSellYourCarTransmissionTabEn transmission_tab = TranslationsSellYourCarTransmissionTabEn._(_root);
	late final TranslationsSellYourCarAdditionalInfoEn additional_info = TranslationsSellYourCarAdditionalInfoEn._(_root);
	late final TranslationsSellYourCarServiceSectionsEn service_sections = TranslationsSellYourCarServiceSectionsEn._(_root);
	late final TranslationsSellYourCarDurationTabEn duration_tab = TranslationsSellYourCarDurationTabEn._(_root);
	late final TranslationsSellYourCarFtDurationEn ft_duration = TranslationsSellYourCarFtDurationEn._(_root);
	late final TranslationsSellYourCarDurationEn duration = TranslationsSellYourCarDurationEn._(_root);
}

// Path: vendor_dashboard
class TranslationsVendorDashboardEn {
	TranslationsVendorDashboardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsVendorDashboardProfileEn profile = TranslationsVendorDashboardProfileEn._(_root);
	late final TranslationsVendorDashboardOrdersEn orders = TranslationsVendorDashboardOrdersEn._(_root);
	late final TranslationsVendorDashboardRequestDetailsEn request_details = TranslationsVendorDashboardRequestDetailsEn._(_root);
	late final TranslationsVendorDashboardScheduleEn schedule = TranslationsVendorDashboardScheduleEn._(_root);
	late final TranslationsVendorDashboardSupportEn support = TranslationsVendorDashboardSupportEn._(_root);
	late final TranslationsVendorDashboardWalletEn wallet = TranslationsVendorDashboardWalletEn._(_root);
	late final TranslationsVendorDashboardOperatorsEn operators = TranslationsVendorDashboardOperatorsEn._(_root);
	late final TranslationsVendorDashboardAddOperatorEn add_operator = TranslationsVendorDashboardAddOperatorEn._(_root);
	late final TranslationsVendorDashboardSettingsEn settings = TranslationsVendorDashboardSettingsEn._(_root);
	late final TranslationsVendorDashboardWorkingHoursEn working_hours = TranslationsVendorDashboardWorkingHoursEn._(_root);
	late final TranslationsVendorDashboardDocumentsEn documents = TranslationsVendorDashboardDocumentsEn._(_root);
	late final TranslationsVendorDashboardBusinessLogoEn business_logo = TranslationsVendorDashboardBusinessLogoEn._(_root);
	late final TranslationsVendorDashboardCoverImageEn cover_image = TranslationsVendorDashboardCoverImageEn._(_root);
	late final TranslationsVendorDashboardServiceAreaEn service_area = TranslationsVendorDashboardServiceAreaEn._(_root);
	late final TranslationsVendorDashboardServiceCategoriesEn service_categories = TranslationsVendorDashboardServiceCategoriesEn._(_root);
	late final TranslationsVendorDashboardScheduleExceptionsEn schedule_exceptions = TranslationsVendorDashboardScheduleExceptionsEn._(_root);
	late final TranslationsVendorDashboardRecentCompletedEn recent_completed = TranslationsVendorDashboardRecentCompletedEn._(_root);
	late final TranslationsVendorDashboardTodaysScheduleEn todays_schedule = TranslationsVendorDashboardTodaysScheduleEn._(_root);
	late final TranslationsVendorDashboardRequestCardsEn request_cards = TranslationsVendorDashboardRequestCardsEn._(_root);
	late final TranslationsVendorDashboardPromoBannerEn promo_banner = TranslationsVendorDashboardPromoBannerEn._(_root);
	late final TranslationsVendorDashboardProfileMenuEn profile_menu = TranslationsVendorDashboardProfileMenuEn._(_root);
	late final TranslationsVendorDashboardUnifiedOrderCardEn unified_order_card = TranslationsVendorDashboardUnifiedOrderCardEn._(_root);
}

// Path: vendor_listings
class TranslationsVendorListingsEn {
	TranslationsVendorListingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'MY LISTINGS'
	String get screen_title => 'MY LISTINGS';

	/// en: 'Search listings...'
	String get search_hint => 'Search listings...';

	/// en: 'All'
	String get filter_all => 'All';

	/// en: 'Product'
	String get filter_product => 'Product';

	/// en: 'Service'
	String get filter_service => 'Service';

	late final TranslationsVendorListingsSnackbarEn snackbar = TranslationsVendorListingsSnackbarEn._(_root);
	late final TranslationsVendorListingsDialogEn dialog = TranslationsVendorListingsDialogEn._(_root);
	late final TranslationsVendorListingsEmptyEn empty = TranslationsVendorListingsEmptyEn._(_root);
	late final TranslationsVendorListingsErrorEn error = TranslationsVendorListingsErrorEn._(_root);
	late final TranslationsVendorListingsBottomSheetEn bottom_sheet = TranslationsVendorListingsBottomSheetEn._(_root);
	late final TranslationsVendorListingsCardEn card = TranslationsVendorListingsCardEn._(_root);
	late final TranslationsVendorListingsTooltipEn tooltip = TranslationsVendorListingsTooltipEn._(_root);
	late final TranslationsVendorListingsCategoryEn category = TranslationsVendorListingsCategoryEn._(_root);
}

// Path: vendor_products
class TranslationsVendorProductsEn {
	TranslationsVendorProductsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'MY PRODUCTS'
	String get screen_title => 'MY PRODUCTS';

	/// en: 'Search Products...'
	String get search_hint => 'Search Products...';

	/// en: 'All'
	String get filter_all => 'All';

	/// en: 'Active'
	String get filter_active => 'Active';

	/// en: 'Inactive'
	String get filter_inactive => 'Inactive';

	late final TranslationsVendorProductsEmptyEn empty = TranslationsVendorProductsEmptyEn._(_root);
	late final TranslationsVendorProductsDialogEn dialog = TranslationsVendorProductsDialogEn._(_root);
	late final TranslationsVendorProductsSnackbarEn snackbar = TranslationsVendorProductsSnackbarEn._(_root);
	late final TranslationsVendorProductsErrorEn error = TranslationsVendorProductsErrorEn._(_root);
	late final TranslationsVendorProductsCardEn card = TranslationsVendorProductsCardEn._(_root);
	late final TranslationsVendorProductsTooltipEn tooltip = TranslationsVendorProductsTooltipEn._(_root);
	late final TranslationsVendorProductsCreateProductEn create_product = TranslationsVendorProductsCreateProductEn._(_root);
}

// Path: inventory
class TranslationsInventoryEn {
	TranslationsInventoryEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'INVENTORY HISTORY'
	String get screen_title => 'INVENTORY HISTORY';

	/// en: 'All'
	String get filter_all => 'All';

	/// en: 'Stock In'
	String get filter_stock_in => 'Stock In';

	/// en: 'Stock Out'
	String get filter_stock_out => 'Stock Out';

	/// en: 'Adjustment'
	String get filter_adjustment => 'Adjustment';

	/// en: 'Refund'
	String get filter_refund => 'Refund';

	late final TranslationsInventoryEmptyEn empty = TranslationsInventoryEmptyEn._(_root);
	late final TranslationsInventoryErrorEn error = TranslationsInventoryErrorEn._(_root);
	late final TranslationsInventoryCardEn card = TranslationsInventoryCardEn._(_root);

	/// en: 'From {date}'
	String get from_date => 'From {date}';

	/// en: 'Until {date}'
	String get until_date => 'Until {date}';

	late final TranslationsInventoryTransactionTypeEn transaction_type = TranslationsInventoryTransactionTypeEn._(_root);
}

// Path: vendor_services
class TranslationsVendorServicesEn {
	TranslationsVendorServicesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsVendorServicesScreenEn screen = TranslationsVendorServicesScreenEn._(_root);
	late final TranslationsVendorServicesFilterEn filter = TranslationsVendorServicesFilterEn._(_root);
	late final TranslationsVendorServicesEmptyEn empty = TranslationsVendorServicesEmptyEn._(_root);
	late final TranslationsVendorServicesErrorEn error = TranslationsVendorServicesErrorEn._(_root);
	late final TranslationsVendorServicesCreateScreenEn create_screen = TranslationsVendorServicesCreateScreenEn._(_root);
	late final TranslationsVendorServicesSelectCategoryEn select_category = TranslationsVendorServicesSelectCategoryEn._(_root);
	late final TranslationsVendorServicesServiceCardEn service_card = TranslationsVendorServicesServiceCardEn._(_root);
	late final TranslationsVendorServicesCategorySectionEn category_section = TranslationsVendorServicesCategorySectionEn._(_root);
}

// Path: vendor_product_analytics
class TranslationsVendorProductAnalyticsEn {
	TranslationsVendorProductAnalyticsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Analytics'
	String get screen_title => 'Analytics';

	/// en: 'Stock'
	String get stock => 'Stock';

	late final TranslationsVendorProductAnalyticsMetricsEn metrics = TranslationsVendorProductAnalyticsMetricsEn._(_root);
	late final TranslationsVendorProductAnalyticsTimePeriodEn time_period = TranslationsVendorProductAnalyticsTimePeriodEn._(_root);
	late final TranslationsVendorProductAnalyticsChartsEn charts = TranslationsVendorProductAnalyticsChartsEn._(_root);
	late final TranslationsVendorProductAnalyticsEmptyEn empty = TranslationsVendorProductAnalyticsEmptyEn._(_root);
	late final TranslationsVendorProductAnalyticsErrorEn error = TranslationsVendorProductAnalyticsErrorEn._(_root);
}

// Path: auth.login
class TranslationsAuthLoginEn {
	TranslationsAuthLoginEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Login'
	String get title => 'Login';

	/// en: 'Logging in...'
	String get loading => 'Logging in...';

	/// en: 'Do not have an account? '
	String get do_not_have_account => 'Do not have an account? ';

	/// en: 'Create Account'
	String get create_account => 'Create Account';
}

// Path: auth.register_as
class TranslationsAuthRegisterAsEn {
	TranslationsAuthRegisterAsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Register As'
	String get title => 'Register As';

	/// en: 'Select User Type'
	String get select_user_type => 'Select User Type';

	/// en: 'Business Owner'
	String get business_owner => 'Business Owner';

	/// en: 'Customer'
	String get customer => 'Customer';

	/// en: 'Driver'
	String get driver => 'Driver';
}

// Path: auth.register_vendor
class TranslationsAuthRegisterVendorEn {
	TranslationsAuthRegisterVendorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Business Name'
	String get business_name => 'Business Name';

	/// en: 'Business Email'
	String get business_email => 'Business Email';

	/// en: 'Representative Name'
	String get representative_name => 'Representative Name';

	/// en: 'Commercial License No (Optional)'
	String get commercial_license => 'Commercial License No (Optional)';
}

// Path: auth.register_customer
class TranslationsAuthRegisterCustomerEn {
	TranslationsAuthRegisterCustomerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Name'
	String get name => 'Name';

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'Country'
	String get country => 'Country';

	/// en: 'Kuwait'
	String get kuwait => 'Kuwait';

	/// en: 'Saudi Arabia'
	String get saudi_arabia => 'Saudi Arabia';

	/// en: 'UAE'
	String get uae => 'UAE';

	/// en: 'City'
	String get city => 'City';

	/// en: 'Kuwait City'
	String get kuwait_city => 'Kuwait City';

	/// en: 'Al Jahra'
	String get al_jahra => 'Al Jahra';

	/// en: 'Hawalli'
	String get hawalli => 'Hawalli';
}

// Path: auth.verify
class TranslationsAuthVerifyEn {
	TranslationsAuthVerifyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'VERIFY PHONE NUMBER'
	String get title => 'VERIFY PHONE\n NUMBER';

	/// en: 'We've Sent Code To'
	String get description => 'We\'ve Sent Code To';

	/// en: 'VERIFYING...'
	String get loading => 'VERIFYING...';

	/// en: 'VERIFY'
	String get button => 'VERIFY';

	/// en: 'Resend'
	String get resend => 'Resend';

	/// en: 'Resend in'
	String get resend_in => 'Resend in';

	/// en: 'Didn't Receive Code? '
	String get did_not_receive_code => 'Didn\'t Receive Code? ';
}

// Path: auth.category
class TranslationsAuthCategoryEn {
	TranslationsAuthCategoryEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Choose Category'
	String get title => 'Choose Category';

	/// en: 'Select Category'
	String get select_category => 'Select Category';

	/// en: 'REGISTERING...'
	String get loading => 'REGISTERING...';

	late final TranslationsAuthCategoryErrorEn error = TranslationsAuthCategoryErrorEn._(_root);

	/// en: 'Registration submitted! Your account requires admin approval before you can login.'
	String get registration_success => 'Registration submitted! Your account requires admin approval before you can login.';
}

// Path: auth.splash
class TranslationsAuthSplashEn {
	TranslationsAuthSplashEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsAuthSplashVendorEn vendor = TranslationsAuthSplashVendorEn._(_root);
	late final TranslationsAuthSplashErrorEn error = TranslationsAuthSplashErrorEn._(_root);

	/// en: 'Initializing...'
	String get initializing => 'Initializing...';

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'Checking authentication...'
	String get checking_auth => 'Checking authentication...';
}

// Path: booking.booking_screen
class TranslationsBookingBookingScreenEn {
	TranslationsBookingBookingScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Book Service'
	String get title => 'Book Service';

	/// en: 'Service Details'
	String get service_details => 'Service Details';

	late final TranslationsBookingBookingScreenLocationEn location = TranslationsBookingBookingScreenLocationEn._(_root);
	late final TranslationsBookingBookingScreenSchedulingEn scheduling = TranslationsBookingBookingScreenSchedulingEn._(_root);
	late final TranslationsBookingBookingScreenOrderEn order = TranslationsBookingBookingScreenOrderEn._(_root);
	late final TranslationsBookingBookingScreenButtonEn button = TranslationsBookingBookingScreenButtonEn._(_root);
}

// Path: booking.order_confirmation
class TranslationsBookingOrderConfirmationEn {
	TranslationsBookingOrderConfirmationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Booking Submitted!'
	String get title => 'Booking Submitted!';

	/// en: 'Order:'
	String get order => 'Order:';

	late final TranslationsBookingOrderConfirmationStatusEn status = TranslationsBookingOrderConfirmationStatusEn._(_root);
	late final TranslationsBookingOrderConfirmationInfoEn info = TranslationsBookingOrderConfirmationInfoEn._(_root);
	late final TranslationsBookingOrderConfirmationButtonEn button = TranslationsBookingOrderConfirmationButtonEn._(_root);
}

// Path: home.services_grid
class TranslationsHomeServicesGridEn {
	TranslationsHomeServicesGridEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Spare Parts'
	String get spare_parts => 'Spare Parts';
}

// Path: home.customer
class TranslationsHomeCustomerEn {
	TranslationsHomeCustomerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Search Products'
	String get search => 'Search Products';

	late final TranslationsHomeCustomerActiveOrdersEn active_orders = TranslationsHomeCustomerActiveOrdersEn._(_root);
	late final TranslationsHomeCustomerPremiumBannerEn premium_banner = TranslationsHomeCustomerPremiumBannerEn._(_root);
	late final TranslationsHomeCustomerAdBannerEn ad_banner = TranslationsHomeCustomerAdBannerEn._(_root);
	late final TranslationsHomeCustomerServicesGridEn services_grid = TranslationsHomeCustomerServicesGridEn._(_root);
	late final TranslationsHomeCustomerBuySellCardEn buy_sell_card = TranslationsHomeCustomerBuySellCardEn._(_root);
	late final TranslationsHomeCustomerPromoBannerEn promo_banner = TranslationsHomeCustomerPromoBannerEn._(_root);
	late final TranslationsHomeCustomerListingEn listing = TranslationsHomeCustomerListingEn._(_root);
}

// Path: home.vendor
class TranslationsHomeVendorEn {
	TranslationsHomeVendorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsHomeVendorServicesGridEn services_grid = TranslationsHomeVendorServicesGridEn._(_root);
	late final TranslationsHomeVendorStatsEn stats = TranslationsHomeVendorStatsEn._(_root);

	/// en: 'Completed Jobs'
	String get completed_jobs => 'Completed Jobs';

	late final TranslationsHomeVendorAvailabilityCapacityEn availability_capacity = TranslationsHomeVendorAvailabilityCapacityEn._(_root);
	late final TranslationsHomeVendorActiveOrdersEn active_orders = TranslationsHomeVendorActiveOrdersEn._(_root);
	late final TranslationsHomeVendorCheckoutOrdersEn checkout_orders = TranslationsHomeVendorCheckoutOrdersEn._(_root);

	/// en: 'Profile not found'
	String get empty => 'Profile not found';

	/// en: 'Error loading data'
	String get error => 'Error loading data';
}

// Path: home.operator
class TranslationsHomeOperatorEn {
	TranslationsHomeOperatorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Incoming Requests'
	String get incoming_requests => 'Incoming Requests';

	/// en: 'Accepted Requests'
	String get accepted_requests => 'Accepted Requests';

	/// en: 'Rides History'
	String get rides_history => 'Rides History';
}

// Path: cart.empty
class TranslationsCartEmptyEn {
	TranslationsCartEmptyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your cart is empty'
	String get title => 'Your cart is empty';

	/// en: 'Browse our services and book your next appointment'
	String get subtitle => 'Browse our services and book your next appointment';

	/// en: 'Browse Services'
	String get browse_button => 'Browse Services';
}

// Path: public_services.category_vendors
class TranslationsPublicServicesCategoryVendorsEn {
	TranslationsPublicServicesCategoryVendorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Find the best services'
	String get description => 'Find the best services';

	/// en: 'Search Vendors'
	String get search => 'Search Vendors';

	/// en: 'All Vendors'
	String get all_vendors => 'All Vendors';

	/// en: 'Failed to load vendors'
	String get error_vendor => 'Failed to load vendors';

	/// en: 'No vendors found'
	String get null_vendor => 'No vendors found';

	late final TranslationsPublicServicesCategoryVendorsVendorCardEn vendor_card = TranslationsPublicServicesCategoryVendorsVendorCardEn._(_root);
}

// Path: public_services.vendor_services
class TranslationsPublicServicesVendorServicesEn {
	TranslationsPublicServicesVendorServicesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Services'
	String get services => 'Services';

	/// en: 'Reviews'
	String get reviews => 'Reviews';

	/// en: 'Most Popular'
	String get most_popular => 'Most Popular';

	/// en: 'Search Service'
	String get search => 'Search Service';

	/// en: 'Failed to load services'
	String get error_service => 'Failed to load services';

	/// en: 'No services found'
	String get null_service => 'No services found';

	/// en: 'All Services'
	String get all_services => 'All Services';

	late final TranslationsPublicServicesVendorServicesServiceCardEn service_card = TranslationsPublicServicesVendorServicesServiceCardEn._(_root);
}

// Path: public_services.services_details
class TranslationsPublicServicesServicesDetailsEn {
	TranslationsPublicServicesServicesDetailsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'About this services'
	String get title => 'About this services';

	/// en: 'min'
	String get min => 'min';

	late final TranslationsPublicServicesServicesDetailsDescriptionEn description = TranslationsPublicServicesServicesDetailsDescriptionEn._(_root);

	/// en: 'Service Details'
	String get service_details => 'Service Details';

	/// en: 'Service Provider'
	String get provider => 'Service Provider';

	/// en: 'Services'
	String get services => 'Services';

	/// en: 'Reviews'
	String get reviews => 'Reviews';

	late final TranslationsPublicServicesServicesDetailsWorkingHoursEn working_hours = TranslationsPublicServicesServicesDetailsWorkingHoursEn._(_root);
	late final TranslationsPublicServicesServicesDetailsDaysEn days = TranslationsPublicServicesServicesDetailsDaysEn._(_root);
	late final TranslationsPublicServicesServicesDetailsButtonEn button = TranslationsPublicServicesServicesDetailsButtonEn._(_root);
}

// Path: public_marketplace.category_screen
class TranslationsPublicMarketplaceCategoryScreenEn {
	TranslationsPublicMarketplaceCategoryScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Accessories'
	String get title_accessories => 'Accessories';

	/// en: 'Spare Parts'
	String get title_spare_parts => 'Spare Parts';

	/// en: 'Find the best services'
	String get subtitle => 'Find the best services';

	/// en: 'Search Vendor'
	String get search_hint => 'Search Vendor';

	/// en: 'All Supplies'
	String get all_supplies => 'All Supplies';

	/// en: 'No vendors match your search'
	String get no_vendors_match_search => 'No vendors match your search';

	/// en: 'No vendors found'
	String get no_vendors_found => 'No vendors found';

	/// en: 'accessories'
	String get label_accessories => 'accessories';

	/// en: 'spare parts'
	String get label_spare_parts => 'spare parts';

	/// en: 'Verified'
	String get verified => 'Verified';

	/// en: 'Failed to load vendors'
	String get error_loading => 'Failed to load vendors';
}

// Path: public_marketplace.details_screen
class TranslationsPublicMarketplaceDetailsScreenEn {
	TranslationsPublicMarketplaceDetailsScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'About This Service'
	String get app_bar_title => 'About This Service';

	/// en: 'Product not found'
	String get product_not_found => 'Product not found';

	/// en: 'Description'
	String get description => 'Description';

	/// en: 'No description available.'
	String get no_description => 'No description available.';

	/// en: 'Quantity'
	String get quantity => 'Quantity';

	/// en: 'added to cart'
	String get added_to_cart => 'added to cart';

	/// en: 'ADD TO CART'
	String get add_to_cart_button => 'ADD TO CART';

	/// en: 'Reviews'
	String get reviews => 'Reviews';

	/// en: 'Load More Reviews'
	String get load_more_reviews => 'Load More Reviews';

	/// en: 'Similar Products'
	String get similar_products => 'Similar Products';

	/// en: 'Months Ago'
	String get months_ago => 'Months Ago';
}

// Path: public_marketplace.vendor_details_screen
class TranslationsPublicMarketplaceVendorDetailsScreenEn {
	TranslationsPublicMarketplaceVendorDetailsScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Search Service'
	String get search_hint => 'Search Service';

	/// en: 'Most Popular'
	String get most_popular => 'Most Popular';

	/// en: 'All Services'
	String get all_services => 'All Services';

	/// en: 'Reviews'
	String get reviews => 'Reviews';

	/// en: 'No services found'
	String get no_services_found => 'No services found';

	/// en: 'Professional service'
	String get professional_service => 'Professional service';

	/// en: 'Add to Cart'
	String get add_to_cart => 'Add to Cart';

	/// en: 'services'
	String get services => 'services';

	/// en: 'reviews'
	String get reviews_label => 'reviews';
}

// Path: public_marketplace.spare_parts
class TranslationsPublicMarketplaceSparePartsEn {
	TranslationsPublicMarketplaceSparePartsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Spare Parts'
	String get title => 'Spare Parts';

	late final TranslationsPublicMarketplaceSparePartsDetailsScreenEn details_screen = TranslationsPublicMarketplaceSparePartsDetailsScreenEn._(_root);
	late final TranslationsPublicMarketplaceSparePartsCategoryScreenEn category_screen = TranslationsPublicMarketplaceSparePartsCategoryScreenEn._(_root);
	late final TranslationsPublicMarketplaceSparePartsFilterSheetEn filter_sheet = TranslationsPublicMarketplaceSparePartsFilterSheetEn._(_root);
}

// Path: services.screen
class TranslationsServicesScreenEn {
	TranslationsServicesScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All Services'
	String get title => 'All Services';

	/// en: 'Search Services'
	String get search_hint => 'Search Services';
}

// Path: services.all_services_grid
class TranslationsServicesAllServicesGridEn {
	TranslationsServicesAllServicesGridEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsServicesAllServicesGridErrorEn error = TranslationsServicesAllServicesGridErrorEn._(_root);
	late final TranslationsServicesAllServicesGridEmptyEn empty = TranslationsServicesAllServicesGridEmptyEn._(_root);
	late final TranslationsServicesAllServicesGridStaticEn static = TranslationsServicesAllServicesGridStaticEn._(_root);
}

// Path: buy_a_car.screen
class TranslationsBuyACarScreenEn {
	TranslationsBuyACarScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'BUY A CARS'
	String get title => 'BUY A CARS';

	/// en: 'We have offers waiting for you'
	String get subtitle => 'We have offers waiting for you';
}

// Path: buy_a_car.service_section
class TranslationsBuyACarServiceSectionEn {
	TranslationsBuyACarServiceSectionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Good Condition Cars'
	String get good_condition_cars => 'Good Condition Cars';

	/// en: 'Damaged Cars'
	String get damaged_cars => 'Damaged Cars';

	/// en: 'Approved Cars'
	String get approved_cars => 'Approved Cars';

	/// en: 'Browse through our wide selection of cars in great condition.'
	String get good_condition_description => 'Browse through our wide selection of cars in great condition.';

	/// en: 'Find damaged cars for spare parts or repair projects.'
	String get damaged_cars_description => 'Find damaged cars for spare parts or repair projects.';

	/// en: 'Shop certified and approved cars with full inspection reports.'
	String get approved_cars_description => 'Shop certified and approved cars with full inspection reports.';
}

// Path: buy_a_car.good_condition_screen
class TranslationsBuyACarGoodConditionScreenEn {
	TranslationsBuyACarGoodConditionScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Explore Cars'
	String get title => 'Explore Cars';

	/// en: 'Search cars by make, model...'
	String get search_hint => 'Search cars by make, model...';

	/// en: 'All Cars'
	String get all_cars => 'All Cars';

	/// en: 'No cars found matching'
	String get no_cars_found => 'No cars found matching';

	/// en: 'No cars available'
	String get no_cars_available => 'No cars available';

	/// en: 'Failed to load cars'
	String get failed_to_load => 'Failed to load cars';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: buy_a_car.approved_cars_screen
class TranslationsBuyACarApprovedCarsScreenEn {
	TranslationsBuyACarApprovedCarsScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Approved Cars'
	String get title => 'Approved Cars';

	/// en: 'Search approved cars...'
	String get search_hint => 'Search approved cars...';

	/// en: 'All Approved Cars'
	String get all_approved_cars => 'All Approved Cars';

	/// en: 'No cars found matching'
	String get no_cars_found => 'No cars found matching';

	/// en: 'No approved cars available'
	String get no_approved_cars_available => 'No approved cars available';

	/// en: 'Failed to load cars'
	String get failed_to_load => 'Failed to load cars';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: buy_a_car.damaged_cars_screen
class TranslationsBuyACarDamagedCarsScreenEn {
	TranslationsBuyACarDamagedCarsScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Damaged Cars'
	String get title => 'Damaged Cars';

	/// en: 'Search damaged cars...'
	String get search_hint => 'Search damaged cars...';

	/// en: 'All Damaged Cars'
	String get all_damaged_cars => 'All Damaged Cars';

	/// en: 'No cars found matching'
	String get no_cars_found => 'No cars found matching';

	/// en: 'No damaged cars available'
	String get no_damaged_cars_available => 'No damaged cars available';

	/// en: 'Failed to load cars'
	String get failed_to_load => 'Failed to load cars';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: buy_a_car.details_screen
class TranslationsBuyACarDetailsScreenEn {
	TranslationsBuyACarDetailsScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'About This Car'
	String get about_this_car => 'About This Car';

	/// en: 'Failed to load listing'
	String get failed_to_load_listing => 'Failed to load listing';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Price on Request'
	String get price_on_request => 'Price on Request';

	/// en: 'Car Details'
	String get car_details => 'Car Details';

	/// en: 'Location not specified'
	String get location_not_specified => 'Location not specified';

	/// en: 'Featured'
	String get featured => 'Featured';

	/// en: 'Inspected'
	String get inspected => 'Inspected';

	/// en: 'View Details'
	String get view_details => 'View Details';

	late final TranslationsBuyACarDetailsScreenInspectionReportEn inspection_report = TranslationsBuyACarDetailsScreenInspectionReportEn._(_root);

	/// en: 'Specifications'
	String get specifications => 'Specifications';

	late final TranslationsBuyACarDetailsScreenSpecLabelsEn spec_labels = TranslationsBuyACarDetailsScreenSpecLabelsEn._(_root);

	/// en: 'N/A'
	String get na => 'N/A';

	/// en: 'Description'
	String get description => 'Description';

	/// en: 'No description available.'
	String get no_description => 'No description available.';

	/// en: 'Location'
	String get location => 'Location';

	/// en: 'CALL NOW'
	String get call_now => 'CALL NOW';

	/// en: 'Chat'
	String get chat => 'Chat';

	late final TranslationsBuyACarDetailsScreenConditionEn condition = TranslationsBuyACarDetailsScreenConditionEn._(_root);

	/// en: 'Could not open inspection report'
	String get error_open_report => 'Could not open inspection report';
}

// Path: buy_a_car.car_chat
class TranslationsBuyACarCarChatEn {
	TranslationsBuyACarCarChatEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Toyota land cruiser 300'
	String get title => 'Toyota land cruiser 300';

	/// en: 'This message relates to:'
	String get this_message_relates_to => 'This message relates to:';

	/// en: 'Buy a Car'
	String get buy_a_car => 'Buy a Car';

	/// en: 'InspectionReport.pdf'
	String get inspection_report_pdf => 'InspectionReport.pdf';

	/// en: '487 KB'
	String get size_kb => '487 KB';

	/// en: 'Download'
	String get download => 'Download';

	/// en: 'Please have a look at this inspection report.'
	String get inspection_report_message => 'Please have a look at this inspection report.';

	/// en: 'R'
	String get sender_initial => 'R';

	/// en: 'Prime Car care'
	String get sender_name => 'Prime Car care';

	/// en: 'You'
	String get you => 'You';

	/// en: 'Type a message'
	String get type_message => 'Type a message';
}

// Path: buy_a_car.listing_card
class TranslationsBuyACarListingCardEn {
	TranslationsBuyACarListingCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Featured'
	String get featured => 'Featured';

	/// en: 'Inspected'
	String get inspected => 'Inspected';

	/// en: 'Not Inspected'
	String get not_inspected => 'Not Inspected';
}

// Path: buy_a_car.filters
class TranslationsBuyACarFiltersEn {
	TranslationsBuyACarFiltersEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Clear All'
	String get clear_all => 'Clear All';

	/// en: 'Make'
	String get make => 'Make';

	/// en: 'Model'
	String get model => 'Model';

	/// en: 'Trim'
	String get trim => 'Trim';

	/// en: 'Year'
	String get year => 'Year';

	/// en: 'Mileage'
	String get mileage => 'Mileage';

	/// en: 'Transmission'
	String get transmission => 'Transmission';

	/// en: 'Automatic'
	String get automatic => 'Automatic';

	/// en: 'Manual'
	String get manual => 'Manual';

	/// en: 'Search makes...'
	String get search_makes => 'Search makes...';

	/// en: 'No makes found'
	String get no_makes_found => 'No makes found';

	/// en: 'Failed to load makes'
	String get failed_to_load_makes => 'Failed to load makes';

	/// en: 'Please select a make first'
	String get select_make_first => 'Please select a make first';

	/// en: 'Search models...'
	String get search_models => 'Search models...';

	/// en: 'No models found'
	String get no_models_found => 'No models found';

	/// en: 'Failed to load models'
	String get failed_to_load_models => 'Failed to load models';

	/// en: 'Please select a model first'
	String get select_model_first => 'Please select a model first';

	/// en: 'Search trims...'
	String get search_trims => 'Search trims...';

	/// en: 'No trims available'
	String get no_trims_available => 'No trims available';

	/// en: 'No trims found'
	String get no_trims_found => 'No trims found';

	/// en: 'Failed to load trims'
	String get failed_to_load_trims => 'Failed to load trims';

	/// en: 'From Year'
	String get from_year => 'From Year';

	/// en: 'To Year'
	String get to_year => 'To Year';

	/// en: 'Select year'
	String get select_year => 'Select year';

	/// en: 'Any'
	String get any => 'Any';

	/// en: 'Failed to load years'
	String get failed_to_load_years => 'Failed to load years';

	/// en: 'Any'
	String get mileage_any => 'Any';

	/// en: 'Under 50,000 km'
	String get under_50k => 'Under 50,000 km';

	/// en: '50,000 - 100,000 km'
	String get range_50k_100k => '50,000 - 100,000 km';

	/// en: '100,000 - 150,000 km'
	String get range_100k_150k => '100,000 - 150,000 km';

	/// en: '150,000+ km'
	String get over_150k => '150,000+ km';
}

// Path: reviews.display
class TranslationsReviewsDisplayEn {
	TranslationsReviewsDisplayEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Reviews'
	String get title => 'Reviews';

	/// en: 'Review'
	String get review => 'Review';

	/// en: 'All'
	String get filter_all => 'All';

	/// en: '5★'
	String get filter_5_stars => '5★';

	/// en: '4★'
	String get filter_4_stars => '4★';

	/// en: '3★'
	String get filter_3_stars => '3★';

	/// en: '2★'
	String get filter_2_stars => '2★';

	/// en: '1★'
	String get filter_1_star => '1★';

	/// en: 'Most Recent'
	String get sort_most_recent => 'Most Recent';

	/// en: 'Highest'
	String get sort_highest => 'Highest';

	/// en: 'Lowest'
	String get sort_lowest => 'Lowest';

	/// en: 'Verified'
	String get verified_badge => 'Verified';

	/// en: 'No reviews yet'
	String get empty_state_title => 'No reviews yet';

	/// en: 'Be the first to leave a review!'
	String get empty_state_message => 'Be the first to leave a review!';

	/// en: 'Load More'
	String get load_more => 'Load More';
}

// Path: user_dashboard.profile
class TranslationsUserDashboardProfileEn {
	TranslationsUserDashboardProfileEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Hi {name}!'
	String get greeting => 'Hi {name}!';

	/// en: 'Guest'
	String get guest => 'Guest';

	/// en: 'G'
	String get guest_initial => 'G';

	/// en: 'Kuwait'
	String get location => 'Kuwait';
}

// Path: user_dashboard.menu
class TranslationsUserDashboardMenuEn {
	TranslationsUserDashboardMenuEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Wallet'
	String get wallet => 'Wallet';

	/// en: 'Orders'
	String get orders => 'Orders';

	/// en: 'Listings'
	String get listings => 'Listings';

	/// en: 'Loyalty Program'
	String get loyalty_program => 'Loyalty Program';
}

// Path: user_dashboard.wallet
class TranslationsUserDashboardWalletEn {
	TranslationsUserDashboardWalletEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Motiva Wallet'
	String get screen_title => 'Motiva Wallet';

	/// en: 'All data is encrypted'
	String get encrypted => 'All data is encrypted';

	/// en: 'Total (KWD):'
	String get total => 'Total (KWD):';

	/// en: 'use it now'
	String get use_now => 'use it now';

	/// en: 'History'
	String get history => 'History';

	/// en: 'Use Reward Balance'
	String get use_reward_balance => 'Use Reward Balance';

	/// en: 'Coming Soon'
	String get coming_soon => 'Coming Soon';

	/// en: 'Wallet balance can be used for payments — coming soon!'
	String get coming_soon_message => 'Wallet balance can be used for payments — coming soon!';

	/// en: 'No transactions yet'
	String get no_transactions => 'No transactions yet';

	/// en: 'Failed to load wallet data'
	String get error_loading => 'Failed to load wallet data';

	/// en: 'Available Balance'
	String get available_balance => 'Available Balance';

	/// en: 'Failed to load balance'
	String get failed_to_load_balance => 'Failed to load balance';

	/// en: 'Credit'
	String get credit => 'Credit';

	/// en: 'Debit'
	String get debit => 'Debit';

	/// en: 'Balance Available'
	String get balance_available => 'Balance Available';

	/// en: 'Retry'
	String get retry => 'Retry';

	late final TranslationsUserDashboardWalletReferenceTypesEn reference_types = TranslationsUserDashboardWalletReferenceTypesEn._(_root);
	late final TranslationsUserDashboardWalletTransactionDetailsEn transaction_details = TranslationsUserDashboardWalletTransactionDetailsEn._(_root);
	late final TranslationsUserDashboardWalletRewardCardsEn reward_cards = TranslationsUserDashboardWalletRewardCardsEn._(_root);
	late final TranslationsUserDashboardWalletTransactionEn transaction = TranslationsUserDashboardWalletTransactionEn._(_root);
	late final TranslationsUserDashboardWalletMonthsEn months = TranslationsUserDashboardWalletMonthsEn._(_root);
	late final TranslationsUserDashboardWalletDetailLabelsEn detail_labels = TranslationsUserDashboardWalletDetailLabelsEn._(_root);
}

// Path: user_dashboard.orders
class TranslationsUserDashboardOrdersEn {
	TranslationsUserDashboardOrdersEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Orders'
	String get screen_title => 'Orders';

	/// en: 'Search orders...'
	String get search_hint => 'Search orders...';

	/// en: 'All'
	String get filter_all => 'All';

	/// en: 'Service'
	String get filter_service => 'Service';

	/// en: 'Product'
	String get filter_product => 'Product';

	/// en: 'All'
	String get tab_all => 'All';

	/// en: 'Active'
	String get tab_active => 'Active';

	/// en: 'Completed'
	String get tab_completed => 'Completed';

	/// en: 'Service details available in full view'
	String get service_details => 'Service details available in full view';

	late final TranslationsUserDashboardOrdersEmptyEn empty = TranslationsUserDashboardOrdersEmptyEn._(_root);
	late final TranslationsUserDashboardOrdersErrorEn error = TranslationsUserDashboardOrdersErrorEn._(_root);
	late final TranslationsUserDashboardOrdersCardEn card = TranslationsUserDashboardOrdersCardEn._(_root);
	late final TranslationsUserDashboardOrdersStatusEn status = TranslationsUserDashboardOrdersStatusEn._(_root);
	late final TranslationsUserDashboardOrdersDetailsEn details = TranslationsUserDashboardOrdersDetailsEn._(_root);
}

// Path: user_dashboard.active_orders_preview
class TranslationsUserDashboardActiveOrdersPreviewEn {
	TranslationsUserDashboardActiveOrdersPreviewEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No Active Requests'
	String get empty_title => 'No Active Requests';

	/// en: 'Your active service requests will appear here.'
	String get empty_subtitle => 'Your active service requests will appear here.';

	/// en: 'My Active Requests'
	String get section_title => 'My Active Requests';

	/// en: 'View All'
	String get view_all => 'View All';

	/// en: 'Unknown Service'
	String get unknown_service => 'Unknown Service';

	/// en: 'Unknown Vendor'
	String get unknown_vendor => 'Unknown Vendor';

	late final TranslationsUserDashboardActiveOrdersPreviewTimeAgoEn time_ago = TranslationsUserDashboardActiveOrdersPreviewTimeAgoEn._(_root);
}

// Path: user_dashboard.loyalty
class TranslationsUserDashboardLoyaltyEn {
	TranslationsUserDashboardLoyaltyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Loyalty Program'
	String get screen_title => 'Loyalty Program';

	/// en: 'Points Balance'
	String get points_balance => 'Points Balance';

	/// en: 'Points'
	String get points => 'Points';

	/// en: 'Progress to Reward'
	String get progress_to_reward => 'Progress to Reward';

	/// en: '{current} of {total} points to next reward'
	String get of_points_to_reward => '{current} of {total} points to next reward';

	/// en: 'Redeem Points'
	String get redeem_points => 'Redeem Points';

	/// en: 'Transactions'
	String get transactions => 'Transactions';

	/// en: 'Earn'
	String get earn => 'Earn';

	/// en: 'Redeem'
	String get redeem => 'Redeem';

	/// en: 'Expire'
	String get expire => 'Expire';

	/// en: 'Adjust'
	String get adjust => 'Adjust';

	/// en: 'No Transactions Yet'
	String get empty_title => 'No Transactions Yet';

	/// en: 'Your loyalty transactions will appear here.'
	String get empty_subtitle => 'Your loyalty transactions will appear here.';

	/// en: 'Failed to Load'
	String get error_title => 'Failed to Load';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: user_dashboard.listings
class TranslationsUserDashboardListingsEn {
	TranslationsUserDashboardListingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Listings'
	String get screen_title => 'Listings';

	/// en: 'Search Listed car'
	String get search_hint => 'Search Listed car';

	late final TranslationsUserDashboardListingsErrorEn error = TranslationsUserDashboardListingsErrorEn._(_root);
	late final TranslationsUserDashboardListingsEmptyEn empty = TranslationsUserDashboardListingsEmptyEn._(_root);
	late final TranslationsUserDashboardListingsCardEn card = TranslationsUserDashboardListingsCardEn._(_root);
}

// Path: user_dashboard.listing_details
class TranslationsUserDashboardListingDetailsEn {
	TranslationsUserDashboardListingDetailsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'About This Car'
	String get screen_title => 'About This Car';

	/// en: 'Featured'
	String get featured => 'Featured';

	/// en: 'Price on request'
	String get price_on_request => 'Price on request';

	/// en: 'Inspected'
	String get inspected => 'Inspected';

	/// en: 'Not Inspected'
	String get not_inspected => 'Not Inspected';

	/// en: 'View Details'
	String get view_details => 'View Details';

	/// en: 'Unknown location'
	String get unknown_location => 'Unknown location';

	late final TranslationsUserDashboardListingDetailsTimeAgoEn time_ago = TranslationsUserDashboardListingDetailsTimeAgoEn._(_root);
	late final TranslationsUserDashboardListingDetailsInspectionEn inspection = TranslationsUserDashboardListingDetailsInspectionEn._(_root);
	late final TranslationsUserDashboardListingDetailsSpecificationsEn specifications = TranslationsUserDashboardListingDetailsSpecificationsEn._(_root);
	late final TranslationsUserDashboardListingDetailsDescriptionEn description = TranslationsUserDashboardListingDetailsDescriptionEn._(_root);

	/// en: 'Save'
	String get save_button => 'Save';
}

// Path: user_dashboard.edit_specs
class TranslationsUserDashboardEditSpecsEn {
	TranslationsUserDashboardEditSpecsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Edit Specifications'
	String get screen_title => 'Edit Specifications';

	late final TranslationsUserDashboardEditSpecsStepsEn steps = TranslationsUserDashboardEditSpecsStepsEn._(_root);

	/// en: 'Saving...'
	String get save_button_loading => 'Saving...';

	/// en: 'Save Changes'
	String get save_button => 'Save Changes';

	late final TranslationsUserDashboardEditSpecsValidationEn validation = TranslationsUserDashboardEditSpecsValidationEn._(_root);
}

// Path: user_dashboard.notifications
class TranslationsUserDashboardNotificationsEn {
	TranslationsUserDashboardNotificationsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'NOTIFICATIONS'
	String get screen_title => 'NOTIFICATIONS';

	/// en: 'Read All'
	String get read_all => 'Read All';

	/// en: 'All'
	String get tab_all => 'All';

	/// en: 'Orders'
	String get tab_orders => 'Orders';

	/// en: 'Offers'
	String get tab_offers => 'Offers';

	/// en: 'System'
	String get tab_system => 'System';

	late final TranslationsUserDashboardNotificationsEmptyEn empty = TranslationsUserDashboardNotificationsEmptyEn._(_root);
}

// Path: user_dashboard.settings
class TranslationsUserDashboardSettingsEn {
	TranslationsUserDashboardSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'SETTINGS'
	String get screen_title => 'SETTINGS';

	/// en: 'Search settings'
	String get search_hint => 'Search settings';

	/// en: 'No settings found'
	String get not_found => 'No settings found';

	late final TranslationsUserDashboardSettingsMenuEn menu = TranslationsUserDashboardSettingsMenuEn._(_root);
	late final TranslationsUserDashboardSettingsDeleteAccountConfirmEn delete_account_confirm = TranslationsUserDashboardSettingsDeleteAccountConfirmEn._(_root);
	late final TranslationsUserDashboardSettingsAccountInfoEn account_info = TranslationsUserDashboardSettingsAccountInfoEn._(_root);
	late final TranslationsUserDashboardSettingsChangeEmailEn change_email = TranslationsUserDashboardSettingsChangeEmailEn._(_root);
	late final TranslationsUserDashboardSettingsChangePasswordEn change_password = TranslationsUserDashboardSettingsChangePasswordEn._(_root);
	late final TranslationsUserDashboardSettingsLanguageEn language = TranslationsUserDashboardSettingsLanguageEn._(_root);
	late final TranslationsUserDashboardSettingsAppModeEn app_mode = TranslationsUserDashboardSettingsAppModeEn._(_root);
	late final TranslationsUserDashboardSettingsCountryEn country = TranslationsUserDashboardSettingsCountryEn._(_root);
	late final TranslationsUserDashboardSettingsSavedAddressesEn saved_addresses = TranslationsUserDashboardSettingsSavedAddressesEn._(_root);
	late final TranslationsUserDashboardSettingsNotificationPreferencesEn notification_preferences = TranslationsUserDashboardSettingsNotificationPreferencesEn._(_root);
	late final TranslationsUserDashboardSettingsVerifyEmailOtpEn verify_email_otp = TranslationsUserDashboardSettingsVerifyEmailOtpEn._(_root);
	late final TranslationsUserDashboardSettingsEditAddressEn edit_address = TranslationsUserDashboardSettingsEditAddressEn._(_root);
	late final TranslationsUserDashboardSettingsAddressTileEn address_tile = TranslationsUserDashboardSettingsAddressTileEn._(_root);
}

// Path: bottom_nav.customer
class TranslationsBottomNavCustomerEn {
	TranslationsBottomNavCustomerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Services'
	String get services => 'Services';

	/// en: 'Offers'
	String get offers => 'Offers';

	/// en: 'Cart'
	String get cart => 'Cart';

	/// en: 'Profile'
	String get profile => 'Profile';
}

// Path: bottom_nav.vendor
class TranslationsBottomNavVendorEn {
	TranslationsBottomNavVendorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Listings'
	String get listings => 'Listings';

	/// en: 'Orders'
	String get orders => 'Orders';

	/// en: 'Operator'
	String get operator => 'Operator';

	/// en: 'Profile'
	String get profile => 'Profile';
}

// Path: bottom_nav.operator
class TranslationsBottomNavOperatorEn {
	TranslationsBottomNavOperatorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Orders'
	String get orders => 'Orders';

	/// en: 'Profile'
	String get profile => 'Profile';
}

// Path: sell_your_car.screens
class TranslationsSellYourCarScreensEn {
	TranslationsSellYourCarScreensEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsSellYourCarScreensConditionCarEn condition_car = TranslationsSellYourCarScreensConditionCarEn._(_root);
	late final TranslationsSellYourCarScreensSellACarEn sell_a_car = TranslationsSellYourCarScreensSellACarEn._(_root);
	late final TranslationsSellYourCarScreensSellOrBuyCarEn sell_or_buy_car = TranslationsSellYourCarScreensSellOrBuyCarEn._(_root);
	late final TranslationsSellYourCarScreensFastTrackConditionEn fast_track_condition = TranslationsSellYourCarScreensFastTrackConditionEn._(_root);
	late final TranslationsSellYourCarScreensFastTrackSaleEn fast_track_sale = TranslationsSellYourCarScreensFastTrackSaleEn._(_root);
	late final TranslationsSellYourCarScreensOpenAnAuctionEn open_an_auction = TranslationsSellYourCarScreensOpenAnAuctionEn._(_root);
	late final TranslationsSellYourCarScreensCarDetailsEn car_details = TranslationsSellYourCarScreensCarDetailsEn._(_root);
	late final TranslationsSellYourCarScreensSuccessDialogEn success_dialog = TranslationsSellYourCarScreensSuccessDialogEn._(_root);
	late final TranslationsSellYourCarScreensRequestReceivedDialogEn request_received_dialog = TranslationsSellYourCarScreensRequestReceivedDialogEn._(_root);
	late final TranslationsSellYourCarScreensErrorDialogEn error_dialog = TranslationsSellYourCarScreensErrorDialogEn._(_root);
}

// Path: sell_your_car.steps
class TranslationsSellYourCarStepsEn {
	TranslationsSellYourCarStepsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Make'
	String get make => 'Make';

	/// en: 'Model'
	String get model => 'Model';

	/// en: 'Trim'
	String get trim => 'Trim';

	/// en: 'Year'
	String get year => 'Year';

	/// en: 'Mileage'
	String get mileage => 'Mileage';

	/// en: 'Selling Price'
	String get selling_price => 'Selling Price';

	/// en: 'Car Specs'
	String get car_specs => 'Car Specs';

	/// en: 'Car Condition'
	String get car_condition => 'Car Condition';

	/// en: 'Colors'
	String get colors => 'Colors';

	/// en: 'Images'
	String get images => 'Images';

	/// en: 'Location'
	String get location => 'Location';

	/// en: 'Additional Information'
	String get additional_info => 'Additional Information';

	/// en: 'Duration'
	String get duration => 'Duration';

	/// en: 'Color'
	String get color => 'Color';

	/// en: 'Image'
	String get image => 'Image';
}

// Path: sell_your_car.make_tab
class TranslationsSellYourCarMakeTabEn {
	TranslationsSellYourCarMakeTabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select Your car make'
	String get title => 'Select Your car make';

	/// en: 'Search Car Make'
	String get search_hint => 'Search Car Make';

	/// en: 'No makes available'
	String get no_available => 'No makes available';

	/// en: 'No makes found'
	String get no_found => 'No makes found';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: sell_your_car.model_tab
class TranslationsSellYourCarModelTabEn {
	TranslationsSellYourCarModelTabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select Your car model'
	String get title => 'Select Your car model';

	/// en: 'Search Car Model'
	String get search_hint => 'Search Car Model';

	/// en: 'Please select a make first'
	String get select_make_first => 'Please select a make first';

	/// en: 'No models available'
	String get no_available => 'No models available';

	/// en: 'No models found'
	String get no_found => 'No models found';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: sell_your_car.trim_tab
class TranslationsSellYourCarTrimTabEn {
	TranslationsSellYourCarTrimTabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select Your car Trim'
	String get title => 'Select Your car Trim';

	/// en: 'Search Car Trim'
	String get search_hint => 'Search Car Trim';

	/// en: 'Please select a model first'
	String get select_model_first => 'Please select a model first';

	/// en: 'No trims available'
	String get no_available => 'No trims available';

	/// en: 'No trims found'
	String get no_found => 'No trims found';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: sell_your_car.year_tab
class TranslationsSellYourCarYearTabEn {
	TranslationsSellYourCarYearTabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Enter Model Year'
	String get title => 'Enter Model Year';

	/// en: 'Please enter a year between 1900 and {year}'
	String get error => 'Please enter a year between 1900 and {year}';
}

// Path: sell_your_car.mileage_tab
class TranslationsSellYourCarMileageTabEn {
	TranslationsSellYourCarMileageTabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Enter Mileage'
	String get title => 'Enter Mileage';

	/// en: 'KM'
	String get unit => 'KM';

	/// en: 'CONTINUE'
	String get kContinue => 'CONTINUE';
}

// Path: sell_your_car.selling_price_tab
class TranslationsSellYourCarSellingPriceTabEn {
	TranslationsSellYourCarSellingPriceTabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Enter Selling Price'
	String get title => 'Enter Selling Price';

	/// en: 'KWD'
	String get unit => 'KWD';

	/// en: 'CONTINUE'
	String get kContinue => 'CONTINUE';
}

// Path: sell_your_car.colors_tab
class TranslationsSellYourCarColorsTabEn {
	TranslationsSellYourCarColorsTabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select your car colors'
	String get title => 'Select your car colors';

	/// en: 'Select your exterior color'
	String get exterior_title => 'Select your exterior color';

	/// en: 'Select your Interior Color'
	String get interior_title => 'Select your Interior Color';

	/// en: 'View More'
	String get view_more => 'View More';

	/// en: 'CONTINUE'
	String get kContinue => 'CONTINUE';
}

// Path: sell_your_car.car_color
class TranslationsSellYourCarCarColorEn {
	TranslationsSellYourCarCarColorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'White'
	String get white => 'White';

	/// en: 'Black'
	String get black => 'Black';

	/// en: 'Orange'
	String get orange => 'Orange';

	/// en: 'Blue'
	String get blue => 'Blue';

	/// en: 'Red'
	String get red => 'Red';

	/// en: 'Green'
	String get green => 'Green';

	/// en: 'Purple'
	String get purple => 'Purple';

	/// en: 'Yellow'
	String get yellow => 'Yellow';

	/// en: 'Aqua'
	String get aqua => 'Aqua';

	/// en: 'Snow'
	String get snow => 'Snow';

	/// en: 'Beige'
	String get beige => 'Beige';

	/// en: 'DimGray'
	String get dim_gray => 'DimGray';
}

// Path: sell_your_car.images_tab
class TranslationsSellYourCarImagesTabEn {
	TranslationsSellYourCarImagesTabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Upload Car Images'
	String get car_images_title => 'Upload Car Images';

	/// en: 'Add photos of your car (exterior, interior, engine)'
	String get car_images_hint => 'Add photos of your car (exterior, interior, engine)';

	/// en: 'Upload Damage Images'
	String get damage_images_title => 'Upload Damage Images';

	/// en: 'Add photos showing damage areas'
	String get damage_images_hint => 'Add photos showing damage areas';

	/// en: 'Camera'
	String get camera => 'Camera';

	/// en: 'Gallery'
	String get gallery => 'Gallery';

	/// en: 'Add Photo'
	String get add_photo => 'Add Photo';

	/// en: 'Select Image Source'
	String get select_source => 'Select Image Source';

	/// en: 'Uploading images...'
	String get uploading => 'Uploading images...';

	/// en: 'SKIP'
	String get skip => 'SKIP';

	/// en: 'CONTINUE'
	String get kContinue => 'CONTINUE';

	/// en: 'Car'
	String get car_label => 'Car';

	/// en: 'Damage'
	String get damage_label => 'Damage';

	/// en: 'Image {number}'
	String get image_label => 'Image {number}';
}

// Path: sell_your_car.location_tab
class TranslationsSellYourCarLocationTabEn {
	TranslationsSellYourCarLocationTabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Pick Your Location'
	String get pick_location => 'Pick Your Location';

	/// en: 'Select Location'
	String get select_location_title => 'Select Location';

	/// en: 'Select'
	String get select => 'Select';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Country'
	String get country => 'Country';

	/// en: 'City'
	String get city => 'City';

	/// en: 'continue'
	String get kContinue => 'continue';

	/// en: 'Failed to open location picker'
	String get failed_picker => 'Failed to open location picker';
}

// Path: sell_your_car.inspection_report
class TranslationsSellYourCarInspectionReportEn {
	TranslationsSellYourCarInspectionReportEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Do you have recent inspection report?'
	String get title => 'Do you have recent inspection report?';

	/// en: 'Browse '
	String get browse => 'Browse ';

	/// en: 'your File'
	String get your_file => 'your File';

	/// en: 'Max 10 MB files are allowed'
	String get max_size => 'Max 10 MB files are allowed';

	/// en: 'PDF, JPG, PNG'
	String get file_types => 'PDF, JPG, PNG';

	/// en: 'Uploaded successfully'
	String get uploaded_success => 'Uploaded successfully';

	/// en: 'No, I don't have'
	String get no_report => 'No, I don\'t have';

	/// en: 'Do you want us to inspect your car?'
	String get inspect_question => 'Do you want us to inspect your car?';

	/// en: 'Get your car professionally inspected for peace of mind. Add this service for a thorough check to ensure it's in top condition.'
	String get inspect_description => 'Get your car professionally inspected for peace of mind. Add this service for a thorough check to ensure it\'s in top condition.';

	/// en: 'KD 20 + 3 Stars'
	String get inspect_price => 'KD 20   + 3 Stars';

	/// en: 'Enter Inspection Report URL'
	String get dialog_title => 'Enter Inspection Report URL';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'UPLOAD'
	String get upload => 'UPLOAD';

	/// en: 'CONTINUE'
	String get kContinue => 'CONTINUE';

	/// en: 'Uploading file...'
	String get uploading => 'Uploading file...';

	/// en: 'File size must be less than 10MB'
	String get file_size_error => 'File size must be less than 10MB';

	/// en: 'Error picking file: {error}'
	String get pick_error => 'Error picking file: {error}';

	/// en: 'Failed to upload file. Please try again.'
	String get upload_error => 'Failed to upload file. Please try again.';

	/// en: 'Error uploading file: {error}'
	String get upload_error_generic => 'Error uploading file: {error}';
}

// Path: sell_your_car.car_condition
class TranslationsSellYourCarCarConditionEn {
	TranslationsSellYourCarCarConditionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Are there any chassis issues?'
	String get chassis_title => 'Are there any chassis issues?';

	/// en: 'Are there any mechanical issues in the car?'
	String get mechanical_title => 'Are there any mechanical issues in the car?';

	/// en: 'Are there any warning lights on?'
	String get warning_lights_title => 'Are there any warning lights on?';

	/// en: 'What is the condition of the tires?'
	String get tires_title => 'What is the condition of the tires?';

	/// en: 'New'
	String get tires_new => 'New';

	/// en: 'Good'
	String get tires_good => 'Good';

	/// en: 'Needs Change'
	String get tires_needs_change => 'Needs Change';

	/// en: 'Does the car run and drive?'
	String get runs_drives_title => 'Does the car run and drive?';

	/// en: 'Yes, it runs and drives'
	String get runs_drives_yes => 'Yes, it runs and drives';

	/// en: 'No, it does not run/drive'
	String get runs_drives_no => 'No, it does not run/drive';

	/// en: 'Yes'
	String get yes => 'Yes';

	/// en: 'No'
	String get no => 'No';

	/// en: 'I don't know'
	String get dont_know => 'I don\'t know';

	/// en: 'Continue'
	String get kContinue => 'Continue';
}

// Path: sell_your_car.description
class TranslationsSellYourCarDescriptionEn {
	TranslationsSellYourCarDescriptionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Description'
	String get title => 'Description';

	/// en: 'Write any extra details about your Car.'
	String get hint => 'Write any extra details about your Car.';
}

// Path: sell_your_car.body_panel_tab
class TranslationsSellYourCarBodyPanelTabEn {
	TranslationsSellYourCarBodyPanelTabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Are there any minor defects or damages to the body panels?'
	String get title => 'Are there any minor defects or damages to the body panels?';

	/// en: 'Yes'
	String get yes => 'Yes';

	/// en: 'No'
	String get no => 'No';

	/// en: 'I don't know'
	String get dont_know => 'I don\'t know';

	/// en: 'Continue'
	String get kContinue => 'Continue';
}

// Path: sell_your_car.paint_condition_tab
class TranslationsSellYourCarPaintConditionTabEn {
	TranslationsSellYourCarPaintConditionTabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'What is the paint condition?'
	String get title => 'What is the paint condition?';

	/// en: 'CONTINUE'
	String get kContinue => 'CONTINUE';
}

// Path: sell_your_car.end_tab
class TranslationsSellYourCarEndTabEn {
	TranslationsSellYourCarEndTabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'PROCEED WITH PAYMENT'
	String get proceed_payment => 'PROCEED WITH PAYMENT';
}

// Path: sell_your_car.engine_tab
class TranslationsSellYourCarEngineTabEn {
	TranslationsSellYourCarEngineTabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select Your Car Engine'
	String get title => 'Select Your Car Engine';

	/// en: 'Other'
	String get other => 'Other';
}

// Path: sell_your_car.transmission_tab
class TranslationsSellYourCarTransmissionTabEn {
	TranslationsSellYourCarTransmissionTabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select Your Car Transmission'
	String get title => 'Select Your Car Transmission';

	/// en: 'Manual'
	String get manual => 'Manual';

	/// en: 'Automatic'
	String get automatic => 'Automatic';

	/// en: 'Continue'
	String get kContinue => 'Continue';
}

// Path: sell_your_car.additional_info
class TranslationsSellYourCarAdditionalInfoEn {
	TranslationsSellYourCarAdditionalInfoEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select your car features'
	String get features_title => 'Select your car features';

	/// en: 'Feature your car'
	String get feature_your_car => 'Feature your car';

	/// en: 'Featuring your car will allow more people see it and will be sold quickly.'
	String get feature_description => 'Featuring your car will allow more people see it and will be sold quickly.';

	/// en: '1 week'
	String get one_week => '1 week';

	/// en: '2 weeks'
	String get two_weeks => '2 weeks';

	/// en: '1 month'
	String get one_month => '1 month';

	/// en: 'Total Price : '
	String get total_price => 'Total Price : ';

	/// en: 'SAVING...'
	String get saving => 'SAVING...';

	/// en: 'SUBMIT LISTING'
	String get submit_listing => 'SUBMIT LISTING';

	/// en: 'Listing Created Successfully!'
	String get listing_created => 'Listing Created Successfully!';

	/// en: 'Your car listing has been saved. Listing ID: {id}'
	String get listing_saved => 'Your car listing has been saved.\nListing ID: {id}';

	/// en: 'Done'
	String get done => 'Done';
}

// Path: sell_your_car.service_sections
class TranslationsSellYourCarServiceSectionsEn {
	TranslationsSellYourCarServiceSectionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All Services'
	String get all_services => 'All Services';

	/// en: 'Sell your Car'
	String get sell_your_car => 'Sell your Car';

	/// en: 'Sell a Car'
	String get sell_a_car => 'Sell a Car';

	/// en: 'Buy a Car'
	String get buy_a_car => 'Buy a Car';

	/// en: 'Good Condition Car'
	String get good_condition_car => 'Good Condition Car';

	/// en: 'Damaged Car'
	String get damaged_car => 'Damaged Car';

	/// en: 'Open an Auction'
	String get open_an_auction => 'Open an Auction';

	/// en: 'Fast Track Car Sale'
	String get fast_track_car_sale => 'Fast Track Car Sale';

	/// en: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor tempor'
	String get lorem_description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor tempor';
}

// Path: sell_your_car.duration_tab
class TranslationsSellYourCarDurationTabEn {
	TranslationsSellYourCarDurationTabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Choose Duration of auction'
	String get title => 'Choose Duration of auction';

	/// en: 'Auction should start from'
	String get auction_start => 'Auction should start from';

	/// en: 'Starting Price'
	String get starting_price => 'Starting Price';

	/// en: 'Feature your auction'
	String get feature_auction => 'Feature your auction';

	/// en: 'Feature Your Auction to Maximize Visibility and Competitive Bidding!'
	String get feature_description => 'Feature Your Auction to Maximize Visibility and Competitive Bidding!';

	/// en: 'Total price : '
	String get total_price => 'Total price : ';

	/// en: '3 days'
	String get days_3 => '3 days';

	/// en: '5 days'
	String get days_5 => '5 days';

	/// en: '7 days'
	String get days_7 => '7 days';

	/// en: 'CONTINUE'
	String get kContinue => 'CONTINUE';

	/// en: 'PROCEED WITH PAYMENT'
	String get proceed_payment => 'PROCEED WITH PAYMENT';
}

// Path: sell_your_car.ft_duration
class TranslationsSellYourCarFtDurationEn {
	TranslationsSellYourCarFtDurationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Choose when do you want to have your cash?'
	String get title => 'Choose when do you want to have your cash?';

	/// en: 'within {hours} hours - {discount}% lower than market price'
	String get hours_label => 'within {hours} hours - {discount}% lower than market price';

	/// en: 'Using default options - backend unavailable'
	String get fallback_tooltip => 'Using default options - backend unavailable';

	/// en: 'Failed to load duration options'
	String get failed_load => 'Failed to load duration options';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'SUBMIT REQUEST'
	String get submit_request => 'SUBMIT REQUEST';

	/// en: 'Total Price : '
	String get total_price => 'Total Price : ';
}

// Path: sell_your_car.duration
class TranslationsSellYourCarDurationEn {
	TranslationsSellYourCarDurationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Auction Duration'
	String get title => 'Auction Duration';

	/// en: '1 Day'
	String get one_day => '1 Day';

	/// en: '3 Days'
	String get three_days => '3 Days';

	/// en: '7 Days'
	String get seven_days => '7 Days';

	/// en: 'CONTINUE'
	String get kContinue => 'CONTINUE';
}

// Path: vendor_dashboard.profile
class TranslationsVendorDashboardProfileEn {
	TranslationsVendorDashboardProfileEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Profile Not Found'
	String get not_found_title => 'Profile Not Found';

	/// en: 'Your vendor profile has not been set up yet. Please contact support to complete your registration.'
	String get not_found_description => 'Your vendor profile has not been set up yet. Please contact support to complete your registration.';

	/// en: 'Error Loading Profile'
	String get error_loading_title => 'Error Loading Profile';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Verified'
	String get verified => 'Verified';

	/// en: 'reviews'
	String get reviews => 'reviews';

	/// en: 'Vendor Profile'
	String get vendor_profile => 'Vendor Profile';

	/// en: 'Profile not set up'
	String get profile_not_set_up => 'Profile not set up';

	/// en: 'Unable to load profile'
	String get unable_to_load_profile => 'Unable to load profile';
}

// Path: vendor_dashboard.orders
class TranslationsVendorDashboardOrdersEn {
	TranslationsVendorDashboardOrdersEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All Orders'
	String get screen_title => 'All Orders';

	/// en: 'Orders'
	String get tab_title => 'Orders';

	/// en: 'Manage your business'
	String get tab_subtitle => 'Manage your business';

	/// en: '{count} orders'
	String get live_badge => '{count} orders';

	/// en: 'Search orders...'
	String get search_hint => 'Search orders...';

	/// en: 'All'
	String get filter_all => 'All';

	/// en: 'Services'
	String get filter_services => 'Services';

	/// en: 'Products'
	String get filter_products => 'Products';

	/// en: 'All'
	String get tab_all => 'All';

	/// en: 'New'
	String get tab_new => 'New';

	/// en: 'Processing'
	String get tab_processing => 'Processing';

	/// en: 'Completed'
	String get tab_completed => 'Completed';

	/// en: 'No Results Found'
	String get empty_search_title => 'No Results Found';

	/// en: 'Try adjusting your search terms.'
	String get empty_search_subtitle => 'Try adjusting your search terms.';

	/// en: 'No {tabName} Orders'
	String get empty_tab => 'No {tabName} Orders';

	/// en: 'Orders will appear here once available.'
	String get empty_tab_subtitle => 'Orders will appear here once available.';

	/// en: 'Error Loading Orders'
	String get error_loading => 'Error Loading Orders';
}

// Path: vendor_dashboard.request_details
class TranslationsVendorDashboardRequestDetailsEn {
	TranslationsVendorDashboardRequestDetailsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'ORDER DETAILS'
	String get screen_title => 'ORDER DETAILS';

	/// en: 'Order accepted successfully'
	String get order_accepted => 'Order accepted successfully';

	/// en: 'Failed to accept order: {error}'
	String get accept_failed => 'Failed to accept order: {error}';

	/// en: 'Status updated: On the way'
	String get status_on_the_way => 'Status updated: On the way';

	/// en: 'Status updated: Arrived at location'
	String get status_arrived => 'Status updated: Arrived at location';

	/// en: 'Service started'
	String get service_started => 'Service started';

	/// en: 'Failed: {error}'
	String get action_failed => 'Failed: {error}';

	/// en: 'Error: {error}'
	String get error => 'Error: {error}';

	/// en: 'Service'
	String get service_fallback => 'Service';

	/// en: 'Order Ref'
	String get order_ref => 'Order Ref';

	/// en: 'Amount'
	String get amount => 'Amount';

	/// en: 'Created'
	String get created => 'Created';

	/// en: 'Scheduled'
	String get scheduled => 'Scheduled';

	/// en: 'Route'
	String get route => 'Route';

	/// en: 'Location'
	String get location => 'Location';

	/// en: 'Pickup'
	String get pickup => 'Pickup';

	/// en: 'Dropoff'
	String get dropoff => 'Dropoff';

	/// en: 'Address'
	String get address => 'Address';

	/// en: 'No address provided'
	String get no_address => 'No address provided';

	/// en: 'Open in Maps'
	String get open_in_maps => 'Open in Maps';

	/// en: 'Order Details'
	String get order_details => 'Order Details';

	/// en: 'Base Amount'
	String get base_amount => 'Base Amount';

	/// en: 'Total'
	String get total => 'Total';

	/// en: 'Service Specifications'
	String get service_specifications => 'Service Specifications';

	/// en: 'Customer Information'
	String get customer_information => 'Customer Information';

	/// en: 'Attributes'
	String get attributes => 'Attributes';

	/// en: 'Customer'
	String get customer => 'Customer';

	/// en: 'Rejection Reason'
	String get rejection_reason => 'Rejection Reason';

	/// en: 'No reason provided'
	String get no_reason => 'No reason provided';

	/// en: 'Cancellation Details'
	String get cancellation_details => 'Cancellation Details';

	/// en: 'Reason: {reason}'
	String get cancellation_reason_label => 'Reason: {reason}';

	/// en: 'Penalty Fee: {fee} KWD'
	String get penalty_fee => 'Penalty Fee: {fee} KWD';

	/// en: 'Documents'
	String get documents => 'Documents';

	/// en: 'Document'
	String get document_fallback => 'Document';

	/// en: 'Reject'
	String get reject => 'Reject';

	/// en: 'Accept'
	String get accept => 'Accept';

	/// en: 'Assign Operator'
	String get assign_operator => 'Assign Operator';

	/// en: 'Start Travel'
	String get start_travel => 'Start Travel';

	/// en: 'Mark Arrived'
	String get mark_arrived => 'Mark Arrived';

	/// en: 'Start Service'
	String get start_service => 'Start Service';

	/// en: 'Complete'
	String get complete => 'Complete';
}

// Path: vendor_dashboard.schedule
class TranslationsVendorDashboardScheduleEn {
	TranslationsVendorDashboardScheduleEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Schedule'
	String get screen_title => 'Schedule';

	/// en: 'Error loading orders'
	String get error_loading => 'Error loading orders';

	/// en: 'No appointments'
	String get no_appointments => 'No appointments';

	/// en: 'No scheduled orders for {date}'
	String get no_scheduled_for_date => 'No scheduled orders for {date}';

	/// en: 'appointment'
	String get appointment_singular => 'appointment';

	/// en: 'appointments'
	String get appointment_plural => 'appointments';

	/// en: 'Service'
	String get service_fallback => 'Service';

	/// en: 'Customer'
	String get customer_fallback => 'Customer';

	/// en: 'Pending'
	String get status_pending => 'Pending';

	/// en: 'Accepted'
	String get status_accepted => 'Accepted';

	/// en: 'En Route'
	String get status_en_route => 'En Route';

	/// en: 'Arrived'
	String get status_arrived => 'Arrived';

	/// en: 'Active'
	String get status_active => 'Active';

	/// en: 'Done'
	String get status_done => 'Done';

	/// en: 'Cancelled'
	String get status_cancelled => 'Cancelled';

	/// en: 'Unknown'
	String get status_unknown => 'Unknown';
}

// Path: vendor_dashboard.support
class TranslationsVendorDashboardSupportEn {
	TranslationsVendorDashboardSupportEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Support'
	String get screen_title => 'Support';

	/// en: 'FAQ's'
	String get faq_title => 'FAQ\'s';

	/// en: 'CONTACT US'
	String get contact_us => 'CONTACT US';

	/// en: 'Reach out to us through live chat or email for quick assistance.'
	String get contact_description => 'Reach out to us through live chat or email for quick assistance.';

	/// en: 'Email US'
	String get email_us => 'Email US';

	/// en: 'CHAT'
	String get chat => 'CHAT';

	/// en: 'or'
	String get or => 'or';

	/// en: 'SUBMIT A TICKET'
	String get submit_ticket => 'SUBMIT A TICKET';

	/// en: '1. How can I register as a vendor?'
	String get faq_1_question => '1. How can I register as a vendor?';

	/// en: 'To register, click on the "Vendor Sign-Up" option, complete the registration form with your business details, and submit the required documents for verification.'
	String get faq_1_answer => 'To register, click on the "Vendor Sign-Up" option, complete the registration form with your business details, and submit the required documents for verification.';

	/// en: '2. Is there a fee for listing my services?'
	String get faq_2_question => '2. Is there a fee for listing my services?';

	/// en: '3. How will I receive payments?'
	String get faq_3_question => '3. How will I receive payments?';

	/// en: '4. Can I edit my service listings?'
	String get faq_4_question => '4. Can I edit my service listings?';

	/// en: '5. How do I contact customer support?'
	String get faq_5_question => '5. How do I contact customer support?';
}

// Path: vendor_dashboard.wallet
class TranslationsVendorDashboardWalletEn {
	TranslationsVendorDashboardWalletEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Motiva Wallet'
	String get screen_title => 'Motiva Wallet';

	/// en: 'Total (KWD):'
	String get total_label => 'Total (KWD):';

	/// en: 'withDrew'
	String get withdraw => 'withDrew';

	late final TranslationsVendorDashboardWalletTabsEn tabs = TranslationsVendorDashboardWalletTabsEn._(_root);

	/// en: 'Completed Jobs'
	String get completed_jobs => 'Completed Jobs';

	/// en: 'History'
	String get history => 'History';

	late final TranslationsVendorDashboardWalletStatsEn stats = TranslationsVendorDashboardWalletStatsEn._(_root);
	late final TranslationsVendorDashboardWalletHistoryStatusEn history_status = TranslationsVendorDashboardWalletHistoryStatusEn._(_root);

	/// en: 'Id: {id}'
	String get id_label => 'Id: {id}';

	late final TranslationsVendorDashboardWalletPayoutRequestEn payout_request = TranslationsVendorDashboardWalletPayoutRequestEn._(_root);

	/// en: 'Wallet balance can be used for payments — coming soon!'
	String get coming_soon_message => 'Wallet balance can be used for payments — coming soon!';

	/// en: 'No transactions yet'
	String get no_transactions => 'No transactions yet';

	/// en: 'Failed to load wallet data'
	String get error_loading => 'Failed to load wallet data';

	/// en: 'Retry'
	String get retry => 'Retry';

	late final TranslationsVendorDashboardWalletPayoutStatusEn payout_status = TranslationsVendorDashboardWalletPayoutStatusEn._(_root);

	/// en: 'Payout Request'
	String get payout_request_card_title => 'Payout Request';

	/// en: 'Available Balance'
	String get available_balance => 'Available Balance';

	/// en: 'Failed to load balance'
	String get failed_to_load_balance => 'Failed to load balance';

	/// en: 'SUBMITTING...'
	String get submitting => 'SUBMITTING...';

	late final TranslationsVendorDashboardWalletMonthsEn months = TranslationsVendorDashboardWalletMonthsEn._(_root);
	late final TranslationsVendorDashboardWalletReferenceTypesEn reference_types = TranslationsVendorDashboardWalletReferenceTypesEn._(_root);
}

// Path: vendor_dashboard.operators
class TranslationsVendorDashboardOperatorsEn {
	TranslationsVendorDashboardOperatorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Operators'
	String get screen_title => 'Operators';

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'Inactive'
	String get inactive => 'Inactive';

	/// en: 'No Operators Yet'
	String get empty_title => 'No Operators Yet';

	/// en: 'Add your first operator to get started'
	String get empty_subtitle => 'Add your first operator to get started';

	/// en: 'Error Loading Operators'
	String get error_loading => 'Error Loading Operators';

	/// en: 'Add New Operator'
	String get add_new => 'Add New Operator';
}

// Path: vendor_dashboard.add_operator
class TranslationsVendorDashboardAddOperatorEn {
	TranslationsVendorDashboardAddOperatorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add New Operator'
	String get screen_title => 'Add New Operator';

	/// en: 'Operator added successfully'
	String get success => 'Operator added successfully';

	/// en: 'This email is already registered'
	String get email_exists => 'This email is already registered';

	/// en: 'This phone number is already registered'
	String get phone_exists => 'This phone number is already registered';

	/// en: 'Failed to add operator'
	String get failed => 'Failed to add operator';

	/// en: 'Operator Information'
	String get section_title => 'Operator Information';

	/// en: 'Full Name'
	String get full_name => 'Full Name';

	/// en: 'Please enter the operator name'
	String get name_error => 'Please enter the operator name';

	/// en: 'Phone Number'
	String get phone_number => 'Phone Number';

	/// en: 'Please enter the operator phone number'
	String get phone_error => 'Please enter the operator phone number';

	/// en: 'Email Address'
	String get email_address => 'Email Address';

	/// en: 'Please enter the operator email'
	String get email_error => 'Please enter the operator email';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Please enter a password'
	String get password_error => 'Please enter a password';

	/// en: 'Password must be at least 8 characters'
	String get password_min_error => 'Password must be at least 8 characters';

	/// en: 'loading'
	String get loading => 'loading';

	/// en: 'Add Operator'
	String get add_operator_button => 'Add Operator';
}

// Path: vendor_dashboard.settings
class TranslationsVendorDashboardSettingsEn {
	TranslationsVendorDashboardSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'SETTINGS'
	String get screen_title => 'SETTINGS';

	/// en: 'Search settings'
	String get search_hint => 'Search settings';

	/// en: 'No settings found'
	String get not_found => 'No settings found';

	late final TranslationsVendorDashboardSettingsMenuEn menu = TranslationsVendorDashboardSettingsMenuEn._(_root);
	late final TranslationsVendorDashboardSettingsDeleteAccountConfirmEn delete_account_confirm = TranslationsVendorDashboardSettingsDeleteAccountConfirmEn._(_root);
}

// Path: vendor_dashboard.working_hours
class TranslationsVendorDashboardWorkingHoursEn {
	TranslationsVendorDashboardWorkingHoursEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Working hours'
	String get screen_title => 'Working hours';

	/// en: 'Schedule Exceptions'
	String get schedule_exceptions => 'Schedule Exceptions';

	/// en: 'Starting Hour'
	String get starting_hour => 'Starting Hour';

	/// en: 'Closing Hour'
	String get closing_hour => 'Closing Hour';

	/// en: 'Off days'
	String get off_days => 'Off days';

	/// en: 'Saving...'
	String get saving => 'Saving...';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Working hours updated successfully'
	String get update_success => 'Working hours updated successfully';

	/// en: 'Failed to update working hours'
	String get update_failed => 'Failed to update working hours';

	/// en: 'Select Off Days'
	String get select_off_days => 'Select Off Days';

	/// en: 'Done'
	String get done => 'Done';

	/// en: 'Error: {error}'
	String get error => 'Error: {error}';
}

// Path: vendor_dashboard.documents
class TranslationsVendorDashboardDocumentsEn {
	TranslationsVendorDashboardDocumentsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Documents'
	String get screen_title => 'Documents';

	/// en: 'Commercial License'
	String get commercial_license => 'Commercial License';

	/// en: 'Civil Id'
	String get civil_id => 'Civil Id';

	/// en: 'Upload Successful'
	String get upload_success => 'Upload Successful';

	/// en: 'Re-uploads require admin approval.'
	String get re_upload_note => 'Re-uploads require admin approval.';

	/// en: 'Browse'
	String get browse => 'Browse';

	/// en: 'your File'
	String get your_file => 'your File';

	/// en: 'Max 10 MB files are allowed'
	String get max_size => 'Max 10 MB files are allowed';
}

// Path: vendor_dashboard.business_logo
class TranslationsVendorDashboardBusinessLogoEn {
	TranslationsVendorDashboardBusinessLogoEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Business logo'
	String get screen_title => 'Business logo';

	/// en: 'General Upload Instructions'
	String get instructions_title => 'General Upload Instructions';

	/// en: 'When uploading your logo, ensure it meets the recommended dimensions of 500x500 pixels or larger for optimal quality. Use PNG or JPEG formats with a maximum file size of 2 MB. For PNG files, a transparent background is ideal, while JPEG files should have a plain backdrop. Make sure the logo is clear and free from pixelation to maintain a professional appearance.'
	String get instructions_text => 'When uploading your logo, ensure it meets the recommended dimensions of 500x500 pixels or larger for optimal quality.\nUse PNG or JPEG formats with a maximum file size of 2 MB.\nFor PNG files, a transparent background is ideal, while JPEG files should have a plain backdrop.\nMake sure the logo is clear and free from pixelation to maintain a professional appearance.';

	/// en: 'Logo updated successfully'
	String get logo_updated => 'Logo updated successfully';
}

// Path: vendor_dashboard.cover_image
class TranslationsVendorDashboardCoverImageEn {
	TranslationsVendorDashboardCoverImageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cover Image'
	String get screen_title => 'Cover Image';

	/// en: 'Cover image updated successfully'
	String get updated_success => 'Cover image updated successfully';

	/// en: 'Cover Image Guidelines'
	String get guidelines_title => 'Cover Image Guidelines';

	/// en: 'Your cover image is displayed at the top of your vendor page. Recommended dimensions: 1200 x 400 pixels or larger. Use PNG or JPEG formats with a maximum file size of 10 MB. Tips: • Use a high-quality image that represents your business • Avoid text-heavy images as they may be hard to read on mobile • Make sure the image is not pixelated or blurry'
	String get guidelines_text => 'Your cover image is displayed at the top of your vendor page.\n\nRecommended dimensions: 1200 x 400 pixels or larger.\nUse PNG or JPEG formats with a maximum file size of 10 MB.\n\nTips:\n• Use a high-quality image that represents your business\n• Avoid text-heavy images as they may be hard to read on mobile\n• Make sure the image is not pixelated or blurry';
}

// Path: vendor_dashboard.service_area
class TranslationsVendorDashboardServiceAreaEn {
	TranslationsVendorDashboardServiceAreaEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cities of Service'
	String get screen_title => 'Cities of Service';

	/// en: 'Search City'
	String get search_hint => 'Search City';
}

// Path: vendor_dashboard.service_categories
class TranslationsVendorDashboardServiceCategoriesEn {
	TranslationsVendorDashboardServiceCategoriesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Service Categories'
	String get screen_title => 'Service Categories';

	/// en: 'add new'
	String get add_new => 'add new';

	/// en: 'Oil Filters'
	String get oil_filters => 'Oil Filters';

	/// en: 'Fix my Car'
	String get fix_my_car => 'Fix my Car';

	/// en: 'Car Batteries'
	String get car_batteries => 'Car Batteries';
}

// Path: vendor_dashboard.schedule_exceptions
class TranslationsVendorDashboardScheduleExceptionsEn {
	TranslationsVendorDashboardScheduleExceptionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Schedule Exceptions'
	String get screen_title => 'Schedule Exceptions';

	/// en: 'Failed to load schedule exceptions'
	String get load_failed => 'Failed to load schedule exceptions';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'No schedule exceptions'
	String get empty_title => 'No schedule exceptions';

	/// en: 'Add exceptions for holidays or special days'
	String get empty_subtitle => 'Add exceptions for holidays or special days';

	/// en: 'Add Exception'
	String get add_button => 'Add Exception';

	/// en: 'Delete exception'
	String get delete_tooltip => 'Delete exception';

	/// en: 'Fully Closed'
	String get fully_closed => 'Fully Closed';

	/// en: 'Modified Hours'
	String get modified_hours => 'Modified Hours';

	/// en: 'Hours: {start} - {end}'
	String get hours_label => 'Hours: {start} - {end}';

	/// en: 'Reason: {reason}'
	String get reason_label => 'Reason: {reason}';

	/// en: 'Delete Exception'
	String get delete_dialog_title => 'Delete Exception';

	/// en: 'Are you sure you want to delete this schedule exception?'
	String get delete_dialog_message => 'Are you sure you want to delete this schedule exception?';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Exception deleted successfully'
	String get delete_success => 'Exception deleted successfully';

	/// en: 'Failed to delete exception'
	String get delete_failed => 'Failed to delete exception';

	/// en: 'Add Schedule Exception'
	String get add_dialog_title => 'Add Schedule Exception';

	/// en: 'Date'
	String get date_label => 'Date';

	/// en: 'Fully Closed'
	String get fully_closed_switch => 'Fully Closed';

	/// en: 'Start Time'
	String get start_time => 'Start Time';

	/// en: 'Select'
	String get select_time => 'Select';

	/// en: 'End Time'
	String get end_time => 'End Time';

	/// en: 'Reason (optional)'
	String get reason_optional => 'Reason (optional)';

	/// en: 'Please select start and end times'
	String get select_times_error => 'Please select start and end times';

	/// en: 'Exception added successfully'
	String get add_success => 'Exception added successfully';

	/// en: 'Failed to add exception'
	String get add_failed => 'Failed to add exception';

	/// en: 'Add'
	String get add_button_dialog => 'Add';

	/// en: 'Error: {error}'
	String get error => 'Error: {error}';
}

// Path: vendor_dashboard.recent_completed
class TranslationsVendorDashboardRecentCompletedEn {
	TranslationsVendorDashboardRecentCompletedEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Recent Completed'
	String get title => 'Recent Completed';

	/// en: 'See all'
	String get see_all => 'See all';

	/// en: 'No completed orders yet'
	String get empty => 'No completed orders yet';

	/// en: 'Service'
	String get service_fallback => 'Service';

	/// en: 'Customer'
	String get customer_fallback => 'Customer';
}

// Path: vendor_dashboard.todays_schedule
class TranslationsVendorDashboardTodaysScheduleEn {
	TranslationsVendorDashboardTodaysScheduleEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Today's Schedule'
	String get title => 'Today\'s Schedule';

	/// en: 'View Calendar'
	String get view_calendar => 'View Calendar';

	/// en: 'View Full Calendar'
	String get view_full_calendar => 'View Full Calendar';

	/// en: 'No appointments today'
	String get empty => 'No appointments today';

	/// en: 'ASAP'
	String get asap => 'ASAP';

	/// en: 'Service'
	String get service_fallback => 'Service';
}

// Path: vendor_dashboard.request_cards
class TranslationsVendorDashboardRequestCardsEn {
	TranslationsVendorDashboardRequestCardsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Order Ref'
	String get order_ref => 'Order Ref';

	/// en: 'Amount'
	String get amount => 'Amount';

	/// en: 'Completed'
	String get completed => 'Completed';

	/// en: 'Time'
	String get time => 'Time';

	/// en: 'Status'
	String get status => 'Status';

	/// en: 'VIEW DETAILS'
	String get view_details => 'VIEW DETAILS';

	/// en: 'View Details'
	String get view_details_normal => 'View Details';

	/// en: 'Proceed'
	String get proceed => 'Proceed';

	/// en: 'Service'
	String get service_fallback => 'Service';

	/// en: 'Customer'
	String get customer_fallback => 'Customer';
}

// Path: vendor_dashboard.promo_banner
class TranslationsVendorDashboardPromoBannerEn {
	TranslationsVendorDashboardPromoBannerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Save upTo KD 5'
	String get title => 'Save upTo KD 5';

	/// en: 'Limited time offer on specific services'
	String get description => 'Limited time offer on specific\nservices';
}

// Path: vendor_dashboard.profile_menu
class TranslationsVendorDashboardProfileMenuEn {
	TranslationsVendorDashboardProfileMenuEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All Orders'
	String get all_orders => 'All Orders';

	/// en: 'My Listings'
	String get my_listings => 'My Listings';

	/// en: 'Inventory History'
	String get inventory_history => 'Inventory History';

	/// en: 'Wallet'
	String get wallet => 'Wallet';

	/// en: 'FAQs'
	String get faqs => 'FAQs';
}

// Path: vendor_dashboard.unified_order_card
class TranslationsVendorDashboardUnifiedOrderCardEn {
	TranslationsVendorDashboardUnifiedOrderCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Service Order'
	String get service_order => 'Service Order';

	/// en: 'Product Order'
	String get product_order => 'Product Order';

	/// en: 'Service'
	String get service_fallback => 'Service';

	/// en: 'Customer'
	String get customer_fallback => 'Customer';

	/// en: 'item'
	String get item_singular => 'item';

	/// en: 'items'
	String get item_plural => 'items';

	/// en: 'Reference'
	String get reference => 'Reference';

	/// en: 'Amount'
	String get amount => 'Amount';

	/// en: 'Time'
	String get time => 'Time';

	/// en: 'Status'
	String get status => 'Status';

	/// en: 'Date'
	String get date => 'Date';
}

// Path: vendor_listings.snackbar
class TranslationsVendorListingsSnackbarEn {
	TranslationsVendorListingsSnackbarEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Product deactivated'
	String get product_deactivated => 'Product deactivated';

	/// en: 'Product activated'
	String get product_activated => 'Product activated';

	/// en: 'Failed to update product status'
	String get update_status_failed => 'Failed to update product status';

	/// en: 'Product deleted successfully'
	String get product_deleted => 'Product deleted successfully';

	/// en: 'Failed to delete product'
	String get delete_failed => 'Failed to delete product';

	/// en: 'Service archived successfully'
	String get service_archived => 'Service archived successfully';

	/// en: 'Failed to archive service'
	String get archive_failed => 'Failed to archive service';

	/// en: 'Service restored successfully'
	String get service_restored => 'Service restored successfully';

	/// en: 'Failed to restore service'
	String get restore_failed => 'Failed to restore service';
}

// Path: vendor_listings.dialog
class TranslationsVendorListingsDialogEn {
	TranslationsVendorListingsDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Delete Product'
	String get delete_product_title => 'Delete Product';

	/// en: 'Are you sure you want to delete "{name}"? This action cannot be undone.'
	String get delete_product_message => 'Are you sure you want to delete "{name}"? This action cannot be undone.';

	/// en: 'Delete'
	String get delete_confirm => 'Delete';

	/// en: 'Archive Service'
	String get archive_service_title => 'Archive Service';

	/// en: 'Are you sure you want to archive "{name}"? It will be hidden from customers.'
	String get archive_service_message => 'Are you sure you want to archive "{name}"? It will be hidden from customers.';

	/// en: 'Archive'
	String get archive_confirm => 'Archive';
}

// Path: vendor_listings.empty
class TranslationsVendorListingsEmptyEn {
	TranslationsVendorListingsEmptyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No Results Found'
	String get no_results => 'No Results Found';

	/// en: 'No Products Yet'
	String get no_products => 'No Products Yet';

	/// en: 'No Services Yet'
	String get no_services => 'No Services Yet';

	/// en: 'No Listings Yet'
	String get no_listings => 'No Listings Yet';

	/// en: 'Try adjusting your search terms.'
	String get adjust_search => 'Try adjusting your search terms.';

	/// en: 'Create your first product to start selling.'
	String get create_product_prompt => 'Create your first product to start selling.';

	/// en: 'Create your first service to start receiving orders.'
	String get create_service_prompt => 'Create your first service to start receiving orders.';

	/// en: 'Create your first listing to start receiving orders.'
	String get create_listing_prompt => 'Create your first listing to start receiving orders.';

	/// en: 'Create Listing'
	String get create_listing_button => 'Create Listing';
}

// Path: vendor_listings.error
class TranslationsVendorListingsErrorEn {
	TranslationsVendorListingsErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error Loading Listings'
	String get title => 'Error Loading Listings';

	/// en: 'Something went wrong. Please try again.'
	String get message => 'Something went wrong. Please try again.';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: vendor_listings.bottom_sheet
class TranslationsVendorListingsBottomSheetEn {
	TranslationsVendorListingsBottomSheetEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Create New'
	String get title => 'Create New';

	/// en: 'Product'
	String get product_label => 'Product';

	/// en: 'Add a new product to your catalog'
	String get product_description => 'Add a new product to your catalog';

	/// en: 'Service'
	String get service_label => 'Service';

	/// en: 'Add a new service offering'
	String get service_description => 'Add a new service offering';
}

// Path: vendor_listings.card
class TranslationsVendorListingsCardEn {
	TranslationsVendorListingsCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Product'
	String get type_product => 'Product';

	/// en: 'Service'
	String get type_service => 'Service';

	/// en: 'Stock: {count}'
	String get stock_label => 'Stock: {count}';

	/// en: 'Active'
	String get status_active => 'Active';

	/// en: 'Inactive'
	String get status_inactive => 'Inactive';

	/// en: 'Archived'
	String get status_archived => 'Archived';

	/// en: ' KWD'
	String get currency_suffix => ' KWD';
}

// Path: vendor_listings.tooltip
class TranslationsVendorListingsTooltipEn {
	TranslationsVendorListingsTooltipEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Activate'
	String get activate => 'Activate';

	/// en: 'Deactivate'
	String get deactivate => 'Deactivate';

	/// en: 'Archive'
	String get archive => 'Archive';

	/// en: 'Restore'
	String get restore => 'Restore';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Delete'
	String get delete => 'Delete';
}

// Path: vendor_listings.category
class TranslationsVendorListingsCategoryEn {
	TranslationsVendorListingsCategoryEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'active'
	String get active => 'active';

	/// en: 'inactive'
	String get inactive => 'inactive';

	/// en: 'Services'
	String get services_fallback => 'Services';

	/// en: 'Products'
	String get products_fallback => 'Products';
}

// Path: vendor_products.empty
class TranslationsVendorProductsEmptyEn {
	TranslationsVendorProductsEmptyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No Results Found'
	String get no_results => 'No Results Found';

	/// en: 'No Products Yet'
	String get no_products => 'No Products Yet';

	/// en: 'No Inactive Products'
	String get no_inactive_products => 'No Inactive Products';

	/// en: 'Inactive products will appear here.'
	String get inactive_subtitle => 'Inactive products will appear here.';

	/// en: 'Try adjusting your search terms.'
	String get adjust_search => 'Try adjusting your search terms.';

	/// en: 'Create your first product to start selling.'
	String get create_product_prompt => 'Create your first product to start selling.';

	/// en: 'Create Product'
	String get create_product_button => 'Create Product';
}

// Path: vendor_products.dialog
class TranslationsVendorProductsDialogEn {
	TranslationsVendorProductsDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Delete Product'
	String get delete_title => 'Delete Product';

	/// en: 'Are you sure you want to delete "{name}"? This action cannot be undone.'
	String get delete_message => 'Are you sure you want to delete "{name}"? This action cannot be undone.';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Delete'
	String get delete => 'Delete';
}

// Path: vendor_products.snackbar
class TranslationsVendorProductsSnackbarEn {
	TranslationsVendorProductsSnackbarEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Product deleted successfully'
	String get product_deleted => 'Product deleted successfully';

	/// en: 'Failed to delete product'
	String get delete_failed => 'Failed to delete product';

	/// en: 'Product deactivated'
	String get product_deactivated => 'Product deactivated';

	/// en: 'Product activated'
	String get product_activated => 'Product activated';

	/// en: 'Failed to update product status'
	String get update_status_failed => 'Failed to update product status';
}

// Path: vendor_products.error
class TranslationsVendorProductsErrorEn {
	TranslationsVendorProductsErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error Loading Products'
	String get title => 'Error Loading Products';

	/// en: 'Something went wrong. Please try again.'
	String get message => 'Something went wrong. Please try again.';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: vendor_products.card
class TranslationsVendorProductsCardEn {
	TranslationsVendorProductsCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Inactive'
	String get inactive => 'Inactive';

	/// en: 'Stock: {count}'
	String get stock_label => 'Stock: {count}';

	/// en: 'Accessory'
	String get type_accessory => 'Accessory';

	/// en: 'Spare Part'
	String get type_spare_part => 'Spare Part';
}

// Path: vendor_products.tooltip
class TranslationsVendorProductsTooltipEn {
	TranslationsVendorProductsTooltipEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Activate'
	String get activate => 'Activate';

	/// en: 'Deactivate'
	String get deactivate => 'Deactivate';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Delete'
	String get delete => 'Delete';
}

// Path: vendor_products.create_product
class TranslationsVendorProductsCreateProductEn {
	TranslationsVendorProductsCreateProductEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'New Product'
	String get app_bar_new => 'New Product';

	/// en: 'Edit Product'
	String get app_bar_edit => 'Edit Product';

	/// en: 'Product Name'
	String get field_name_label => 'Product Name';

	/// en: 'e.g., Brake Pads'
	String get field_name_hint => 'e.g., Brake Pads';

	/// en: 'Description (Optional)'
	String get field_description_label => 'Description (Optional)';

	/// en: 'Describe your product'
	String get field_description_hint => 'Describe your product';

	/// en: 'Price (KWD)'
	String get field_price_label => 'Price (KWD)';

	/// en: '0.00'
	String get field_price_hint => '0.00';

	/// en: 'Stock Quantity'
	String get field_stock_label => 'Stock Quantity';

	/// en: '10'
	String get field_stock_hint => '10';

	/// en: 'Product Type'
	String get product_type_label => 'Product Type';

	/// en: 'Accessory'
	String get product_type_accessory => 'Accessory';

	/// en: 'Spare Part'
	String get product_type_spare_part => 'Spare Part';

	/// en: 'Product Images'
	String get images_title => 'Product Images';

	/// en: 'Upload images to showcase your product'
	String get images_subtitle => 'Upload images to showcase your product';

	/// en: 'Add'
	String get add_image_button => 'Add';

	/// en: 'Create Product'
	String get button_create => 'Create Product';

	/// en: 'Save Changes'
	String get button_save => 'Save Changes';

	/// en: 'Product created successfully'
	String get snackbar_created => 'Product created successfully';

	/// en: 'Product updated successfully'
	String get snackbar_updated => 'Product updated successfully';

	/// en: 'Failed to create product. Please check your inputs and try again.'
	String get snackbar_create_failed => 'Failed to create product. Please check your inputs and try again.';

	/// en: 'Failed to update product. Please check your inputs and try again.'
	String get snackbar_update_failed => 'Failed to update product. Please check your inputs and try again.';

	/// en: '{field} is required'
	String get validation_required => '{field} is required';

	/// en: 'Enter a valid {field}'
	String get validation_valid_number => 'Enter a valid {field}';

	/// en: 'Spare Part Specifications'
	String get spare_part_section_title => 'Spare Part Specifications';

	/// en: 'Part Number'
	String get part_number_label => 'Part Number';

	/// en: 'Brand'
	String get brand_label => 'Brand';

	/// en: 'Warranty (months)'
	String get warranty_label => 'Warranty (months)';

	/// en: 'Compatibility'
	String get compatibility_label => 'Compatibility';

	/// en: 'No compatibility entries'
	String get compatibility_empty => 'No compatibility entries';

	/// en: 'Make'
	String get compatibility_make => 'Make';

	/// en: 'Model'
	String get compatibility_model => 'Model';

	/// en: 'Year from'
	String get compatibility_year_from => 'Year from';

	/// en: 'Year to'
	String get compatibility_year_to => 'Year to';

	/// en: 'Add'
	String get compatibility_add => 'Add';
}

// Path: inventory.empty
class TranslationsInventoryEmptyEn {
	TranslationsInventoryEmptyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No Transactions Found'
	String get title => 'No Transactions Found';

	/// en: 'Try adjusting your filters.'
	String get filtered_subtitle => 'Try adjusting your filters.';

	/// en: 'Inventory transactions will appear here.'
	String get subtitle => 'Inventory transactions will appear here.';
}

// Path: inventory.error
class TranslationsInventoryErrorEn {
	TranslationsInventoryErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error Loading Transactions'
	String get title => 'Error Loading Transactions';

	/// en: 'Something went wrong. Please try again.'
	String get message => 'Something went wrong. Please try again.';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: inventory.card
class TranslationsInventoryCardEn {
	TranslationsInventoryCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Before:'
	String get before => 'Before:';

	/// en: 'After:'
	String get after => 'After:';

	/// en: 'Reason:'
	String get reason => 'Reason:';
}

// Path: inventory.transaction_type
class TranslationsInventoryTransactionTypeEn {
	TranslationsInventoryTransactionTypeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Stock Out'
	String get sale => 'Stock Out';

	/// en: 'Stock In'
	String get restock => 'Stock In';

	/// en: 'Adjustment'
	String get adjustment => 'Adjustment';

	/// en: 'Refund'
	String get refund => 'Refund';
}

// Path: vendor_services.screen
class TranslationsVendorServicesScreenEn {
	TranslationsVendorServicesScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'MY SERVICES'
	String get title => 'MY SERVICES';

	/// en: 'Search Services... '
	String get search_hint => 'Search Services... ';
}

// Path: vendor_services.filter
class TranslationsVendorServicesFilterEn {
	TranslationsVendorServicesFilterEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All'
	String get all => 'All';

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'Archived'
	String get archived => 'Archived';
}

// Path: vendor_services.empty
class TranslationsVendorServicesEmptyEn {
	TranslationsVendorServicesEmptyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsVendorServicesEmptySearchEn search = TranslationsVendorServicesEmptySearchEn._(_root);
	late final TranslationsVendorServicesEmptyArchivedEn archived = TranslationsVendorServicesEmptyArchivedEn._(_root);
	late final TranslationsVendorServicesEmptyNoServicesEn no_services = TranslationsVendorServicesEmptyNoServicesEn._(_root);
}

// Path: vendor_services.error
class TranslationsVendorServicesErrorEn {
	TranslationsVendorServicesErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error Loading Services'
	String get title => 'Error Loading Services';

	/// en: 'Something went wrong. Please try again.'
	String get subtitle => 'Something went wrong. Please try again.';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: vendor_services.create_screen
class TranslationsVendorServicesCreateScreenEn {
	TranslationsVendorServicesCreateScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsVendorServicesCreateScreenAppBarEn app_bar = TranslationsVendorServicesCreateScreenAppBarEn._(_root);
	late final TranslationsVendorServicesCreateScreenFormEn form = TranslationsVendorServicesCreateScreenFormEn._(_root);
	late final TranslationsVendorServicesCreateScreenImageUploadEn image_upload = TranslationsVendorServicesCreateScreenImageUploadEn._(_root);
	late final TranslationsVendorServicesCreateScreenAttributesEn attributes = TranslationsVendorServicesCreateScreenAttributesEn._(_root);
	late final TranslationsVendorServicesCreateScreenCustomerQuestionsEn customer_questions = TranslationsVendorServicesCreateScreenCustomerQuestionsEn._(_root);
	late final TranslationsVendorServicesCreateScreenButtonEn button = TranslationsVendorServicesCreateScreenButtonEn._(_root);
	late final TranslationsVendorServicesCreateScreenSnackbarEn snackbar = TranslationsVendorServicesCreateScreenSnackbarEn._(_root);
	late final TranslationsVendorServicesCreateScreenDialogEn dialog = TranslationsVendorServicesCreateScreenDialogEn._(_root);
	late final TranslationsVendorServicesCreateScreenErrorEn error = TranslationsVendorServicesCreateScreenErrorEn._(_root);
}

// Path: vendor_services.select_category
class TranslationsVendorServicesSelectCategoryEn {
	TranslationsVendorServicesSelectCategoryEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'SELECT CATEGORY'
	String get title => 'SELECT CATEGORY';

	/// en: 'Search categories...'
	String get search_hint => 'Search categories...';

	late final TranslationsVendorServicesSelectCategoryEmptyEn empty = TranslationsVendorServicesSelectCategoryEmptyEn._(_root);
	late final TranslationsVendorServicesSelectCategorySearchEmptyEn search_empty = TranslationsVendorServicesSelectCategorySearchEmptyEn._(_root);
	late final TranslationsVendorServicesSelectCategoryErrorEn error = TranslationsVendorServicesSelectCategoryErrorEn._(_root);
}

// Path: vendor_services.service_card
class TranslationsVendorServicesServiceCardEn {
	TranslationsVendorServicesServiceCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Archived'
	String get archived_badge => 'Archived';

	/// en: '{price} KWD'
	String get price_format => '{price} KWD';

	/// en: '{radius} km'
	String get radius_format => '{radius} km';

	late final TranslationsVendorServicesServiceCardTooltipEn tooltip = TranslationsVendorServicesServiceCardTooltipEn._(_root);
	late final TranslationsVendorServicesServiceCardActionEn action = TranslationsVendorServicesServiceCardActionEn._(_root);
}

// Path: vendor_services.category_section
class TranslationsVendorServicesCategorySectionEn {
	TranslationsVendorServicesCategorySectionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Services'
	String get fallback_name => 'Services';

	/// en: '{active} active'
	String get status => '{active} active';

	/// en: '{active} active • {archived} archived'
	String get status_with_archived => '{active} active • {archived} archived';

	late final TranslationsVendorServicesCategorySectionDialogEn dialog = TranslationsVendorServicesCategorySectionDialogEn._(_root);
	late final TranslationsVendorServicesCategorySectionSnackbarEn snackbar = TranslationsVendorServicesCategorySectionSnackbarEn._(_root);
}

// Path: vendor_product_analytics.metrics
class TranslationsVendorProductAnalyticsMetricsEn {
	TranslationsVendorProductAnalyticsMetricsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Total Views'
	String get total_views => 'Total Views';

	/// en: 'Conversion'
	String get conversion => 'Conversion';

	/// en: 'Total Orders'
	String get total_orders => 'Total Orders';
}

// Path: vendor_product_analytics.time_period
class TranslationsVendorProductAnalyticsTimePeriodEn {
	TranslationsVendorProductAnalyticsTimePeriodEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '7D'
	String get k7d => '7D';

	/// en: '30D'
	String get k30d => '30D';

	/// en: '90D'
	String get k90d => '90D';
}

// Path: vendor_product_analytics.charts
class TranslationsVendorProductAnalyticsChartsEn {
	TranslationsVendorProductAnalyticsChartsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Revenue Over Time'
	String get revenue_over_time => 'Revenue Over Time';

	/// en: 'Top Products'
	String get top_products => 'Top Products';

	/// en: '{count} sales'
	String get sales => '{count} sales';
}

// Path: vendor_product_analytics.empty
class TranslationsVendorProductAnalyticsEmptyEn {
	TranslationsVendorProductAnalyticsEmptyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No revenue data available'
	String get no_revenue_data => 'No revenue data available';

	/// en: 'No product sales data available'
	String get no_product_sales_data => 'No product sales data available';
}

// Path: vendor_product_analytics.error
class TranslationsVendorProductAnalyticsErrorEn {
	TranslationsVendorProductAnalyticsErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error Loading Analytics'
	String get title => 'Error Loading Analytics';

	/// en: 'Something went wrong. Please try again.'
	String get message => 'Something went wrong. Please try again.';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: auth.category.error
class TranslationsAuthCategoryErrorEn {
	TranslationsAuthCategoryErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Please select a category'
	String get null_category => 'Please select a category';

	/// en: 'No categories available'
	String get no_categories => 'No categories available';

	/// en: 'Failed to load categories'
	String get failed_to_load => 'Failed to load categories';

	/// en: 'Retry'
	String get button => 'Retry';

	/// en: 'Registration failed. Please try again.'
	String get registration_failed => 'Registration failed. Please try again.';
}

// Path: auth.splash.vendor
class TranslationsAuthSplashVendorEn {
	TranslationsAuthSplashVendorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Verifying profile...'
	String get title => 'Verifying profile...';

	/// en: 'Vendor profile verification failed'
	String get login_error => 'Vendor profile verification failed';

	/// en: 'Your vendor profile is incomplete or was not found. Please contact support or complete your registration to continue.'
	String get logout_error => 'Your vendor profile is incomplete or was not found.\nPlease contact support or complete your registration to continue.';
}

// Path: auth.splash.error
class TranslationsAuthSplashErrorEn {
	TranslationsAuthSplashErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Auth error in splash'
	String get splash_failed => 'Auth error in splash';

	/// en: 'Authentication failed. Please login again.'
	String get auth_failed => 'Authentication failed. Please login again.';
}

// Path: booking.booking_screen.location
class TranslationsBookingBookingScreenLocationEn {
	TranslationsBookingBookingScreenLocationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Service Location'
	String get title => 'Service Location';

	/// en: 'Selected'
	String get selected => 'Selected';

	/// en: 'Tap to select'
	String get tap_to_select => 'Tap to select';

	/// en: 'Tap to select location on map'
	String get tap_to_select_location => 'Tap to select location on map';

	/// en: 'pick'
	String get pick => 'pick';

	/// en: 'pick location'
	String get pick_location => 'pick location';

	/// en: 'Additional address details (optional)'
	String get additional_details => 'Additional address details (optional)';

	/// en: 'Pickup Location'
	String get pickup => 'Pickup Location';

	/// en: 'Drop off Location'
	String get drop_off => 'Drop off Location';

	/// en: 'Location Selected'
	String get location_selected => 'Location Selected';

	/// en: 'selected successfully'
	String get success => 'selected successfully';

	/// en: 'Location selected successfully'
	String get success_location => 'Location selected successfully';

	/// en: 'Please select your location'
	String get null_location => 'Please select your location';

	/// en: 'Please select pickup location'
	String get null_pickup => 'Please select pickup location';

	/// en: 'Please select drop off location'
	String get null_drop_off => 'Please select drop off location';
}

// Path: booking.booking_screen.scheduling
class TranslationsBookingBookingScreenSchedulingEn {
	TranslationsBookingBookingScreenSchedulingEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Schedule'
	String get title => 'Schedule';

	/// en: 'Choose Date'
	String get date => 'Choose Date';

	/// en: 'Jan'
	String get jan => 'Jan';

	/// en: 'Feb'
	String get feb => 'Feb';

	/// en: 'Mar'
	String get mar => 'Mar';

	/// en: 'Apr'
	String get apr => 'Apr';

	/// en: 'May'
	String get may => 'May';

	/// en: 'Jun'
	String get jun => 'Jun';

	/// en: 'Jul'
	String get jul => 'Jul';

	/// en: 'Aug'
	String get aug => 'Aug';

	/// en: 'Sep'
	String get sep => 'Sep';

	/// en: 'Oct'
	String get oct => 'Oct';

	/// en: 'Nov'
	String get nov => 'Nov';

	/// en: 'Dec'
	String get dec => 'Dec';

	/// en: 'Available Time'
	String get time => 'Available Time';

	/// en: 'Clear'
	String get clear => 'Clear';

	/// en: 'No available time slots for this date. Please select another date.'
	String get null_time => 'No available time slots for this date. Please select another date.';

	/// en: 'Please select time slot'
	String get select_time => 'Please select time slot';

	/// en: 'No Time Slot Available'
	String get error_time => 'No Time Slot Available';

	/// en: 'Next available'
	String get next_available => 'Next available';

	/// en: 'Select This Day'
	String get select_next_available => 'Select This Day';
}

// Path: booking.booking_screen.order
class TranslationsBookingBookingScreenOrderEn {
	TranslationsBookingBookingScreenOrderEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Order Summary'
	String get title => 'Order Summary';

	/// en: 'Base Amount'
	String get base_amount => 'Base Amount';

	/// en: 'Final amount will be confirmed by vendor'
	String get description => 'Final amount will be confirmed by vendor';
}

// Path: booking.booking_screen.button
class TranslationsBookingBookingScreenButtonEn {
	TranslationsBookingBookingScreenButtonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Confirm Booking'
	String get title => 'Confirm Booking';

	/// en: 'Please select your location to continue'
	String get error_location => 'Please select your location to continue';

	/// en: 'Please select pickup location'
	String get error_pickup => 'Please select pickup location';

	/// en: 'Please select drop off location'
	String get error_drop_off => 'Please select drop off location';
}

// Path: booking.order_confirmation.status
class TranslationsBookingOrderConfirmationStatusEn {
	TranslationsBookingOrderConfirmationStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Booking Confirmed'
	String get title => 'Booking Confirmed';

	/// en: 'Your booking has been auto-accepted and confirmed successfully.'
	String get description => 'Your booking has been auto-accepted and confirmed successfully.';
}

// Path: booking.order_confirmation.info
class TranslationsBookingOrderConfirmationInfoEn {
	TranslationsBookingOrderConfirmationInfoEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Service'
	String get service => 'Service';

	/// en: 'Vendor'
	String get vendor => 'Vendor';

	/// en: 'Base Amount'
	String get base_amount => 'Base Amount';

	/// en: 'Scheduled'
	String get scheduled => 'Scheduled';

	/// en: 'Location'
	String get location => 'Location';
}

// Path: booking.order_confirmation.button
class TranslationsBookingOrderConfirmationButtonEn {
	TranslationsBookingOrderConfirmationButtonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Back to Home'
	String get primary => 'Back to Home';

	/// en: 'Go to My Requests'
	String get secondary => 'Go to My Requests';
}

// Path: home.customer.active_orders
class TranslationsHomeCustomerActiveOrdersEn {
	TranslationsHomeCustomerActiveOrdersEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsHomeCustomerActiveOrdersEmptyEn empty = TranslationsHomeCustomerActiveOrdersEmptyEn._(_root);
	late final TranslationsHomeCustomerActiveOrdersOrderEn order = TranslationsHomeCustomerActiveOrdersOrderEn._(_root);
}

// Path: home.customer.premium_banner
class TranslationsHomeCustomerPremiumBannerEn {
	TranslationsHomeCustomerPremiumBannerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Upgrade to Premium for Exclusive Benefits!'
	String get title => 'Upgrade to Premium\nfor Exclusive\nBenefits!';

	/// en: 'Upgrade Now'
	String get button => 'Upgrade Now';
}

// Path: home.customer.ad_banner
class TranslationsHomeCustomerAdBannerEn {
	TranslationsHomeCustomerAdBannerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Road Assistance at 10% Off - Book Now!'
	String get title => 'Road Assistance\n at 10% Off - Book Now!';
}

// Path: home.customer.services_grid
class TranslationsHomeCustomerServicesGridEn {
	TranslationsHomeCustomerServicesGridEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Available Services'
	String get title => 'Available Services';

	/// en: 'View All'
	String get view_all => 'View All';

	/// en: 'Failed to load service categories'
	String get error_category => 'Failed to load service categories';

	late final TranslationsHomeCustomerServicesGridErrorEn error = TranslationsHomeCustomerServicesGridErrorEn._(_root);
	late final TranslationsHomeCustomerServicesGridEmptyEn empty = TranslationsHomeCustomerServicesGridEmptyEn._(_root);
}

// Path: home.customer.buy_sell_card
class TranslationsHomeCustomerBuySellCardEn {
	TranslationsHomeCustomerBuySellCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Buy a Car'
	String get buy => 'Buy a Car';

	/// en: 'Sell Your Car'
	String get sell => 'Sell Your Car';

	/// en: 'Tap here'
	String get tap => 'Tap here';
}

// Path: home.customer.promo_banner
class TranslationsHomeCustomerPromoBannerEn {
	TranslationsHomeCustomerPromoBannerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Save upTo KD 5'
	String get title => 'Save upTo KD 5';

	/// en: 'Limited time offer on specific services'
	String get description => 'Limited time offer on specific\nservices';
}

// Path: home.customer.listing
class TranslationsHomeCustomerListingEn {
	TranslationsHomeCustomerListingEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Popular Today'
	String get popular_today => 'Popular Today';

	/// en: 'Top Vendors'
	String get top_vendors => 'Top Vendors';

	/// en: 'New Vendors'
	String get new_vendors => 'New Vendors';
}

// Path: home.vendor.services_grid
class TranslationsHomeVendorServicesGridEn {
	TranslationsHomeVendorServicesGridEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Messages'
	String get messages => 'Messages';

	/// en: 'Support'
	String get support => 'Support';

	/// en: 'Requests'
	String get requests => 'Requests';

	/// en: 'Orders'
	String get orders => 'Orders';

	/// en: 'Add Services'
	String get add_services => 'Add Services';

	/// en: 'Current Services'
	String get current_services => 'Current Services';
}

// Path: home.vendor.stats
class TranslationsHomeVendorStatsEn {
	TranslationsHomeVendorStatsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Today'
	String get today => 'Today';

	/// en: 'Weekly'
	String get weekly => 'Weekly';

	/// en: 'Monthly'
	String get monthly => 'Monthly';

	/// en: 'This Week'
	String get this_weekly => 'This Week';

	/// en: 'This Month'
	String get this_monthly => 'This Month';

	late final TranslationsHomeVendorStatsStatsCardEn stats_card = TranslationsHomeVendorStatsStatsCardEn._(_root);
}

// Path: home.vendor.availability_capacity
class TranslationsHomeVendorAvailabilityCapacityEn {
	TranslationsHomeVendorAvailabilityCapacityEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Availability & Capacity'
	String get title => 'Availability & Capacity';

	late final TranslationsHomeVendorAvailabilityCapacityAvailabilityEn availability = TranslationsHomeVendorAvailabilityCapacityAvailabilityEn._(_root);
	late final TranslationsHomeVendorAvailabilityCapacityStatusEn status = TranslationsHomeVendorAvailabilityCapacityStatusEn._(_root);
	late final TranslationsHomeVendorAvailabilityCapacityCapacityEn capacity = TranslationsHomeVendorAvailabilityCapacityCapacityEn._(_root);
}

// Path: home.vendor.active_orders
class TranslationsHomeVendorActiveOrdersEn {
	TranslationsHomeVendorActiveOrdersEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Active Orders'
	String get title => 'Active Orders';

	/// en: 'All'
	String get all => 'All';

	/// en: 'En Route'
	String get en_route => 'En Route';

	/// en: 'Arrived'
	String get arrived => 'Arrived';

	/// en: 'In Progress'
	String get in_progress => 'In Progress';

	/// en: 'No orders'
	String get empty => 'No orders';

	/// en: 'Service'
	String get service => 'Service';

	/// en: 'Customer'
	String get customer => 'Customer';

	/// en: 'ASAP'
	String get asap => 'ASAP';
}

// Path: home.vendor.checkout_orders
class TranslationsHomeVendorCheckoutOrdersEn {
	TranslationsHomeVendorCheckoutOrdersEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Product Orders'
	String get title => 'Product Orders';

	/// en: 'All'
	String get all => 'All';

	/// en: 'Pending'
	String get pending => 'Pending';

	/// en: 'Processing'
	String get processing => 'Processing';

	/// en: 'Confirmed'
	String get confirmed => 'Confirmed';

	/// en: 'Shipped'
	String get shipped => 'Shipped';

	/// en: 'No product orders'
	String get empty => 'No product orders';

	/// en: 'Order #'
	String get order_number => 'Order #';

	/// en: 'items'
	String get items_count => 'items';

	/// en: 'item'
	String get item => 'item';

	/// en: 'Payment: COD'
	String get payment_method => 'Payment: COD';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Mark Shipped'
	String get ship => 'Mark Shipped';

	/// en: 'Mark Delivered'
	String get deliver => 'Mark Delivered';

	/// en: 'Product Order'
	String get product_order => 'Product Order';

	/// en: 'Placed'
	String get placed => 'Placed';

	/// en: 'Total'
	String get total => 'Total';

	/// en: 'Status Timeline'
	String get status_timeline => 'Status Timeline';

	late final TranslationsHomeVendorCheckoutOrdersTimelineEn timeline = TranslationsHomeVendorCheckoutOrdersTimelineEn._(_root);
	late final TranslationsHomeVendorCheckoutOrdersStatusEn status = TranslationsHomeVendorCheckoutOrdersStatusEn._(_root);

	/// en: 'Customer'
	String get customer => 'Customer';

	/// en: 'Order Items'
	String get order_items => 'Order Items';

	/// en: 'Delivery'
	String get delivery => 'Delivery';

	/// en: 'Delivery Address'
	String get delivery_address => 'Delivery Address';

	/// en: 'No address provided'
	String get no_address_provided => 'No address provided';

	/// en: 'Payment'
	String get payment => 'Payment';

	/// en: 'Status'
	String get payment_status => 'Status';

	/// en: 'Paid'
	String get payment_paid => 'Paid';

	/// en: 'Pending'
	String get payment_pending => 'Pending';

	/// en: 'Order Info'
	String get order_info => 'Order Info';

	/// en: 'Order ID'
	String get order_id => 'Order ID';

	/// en: 'Placed on'
	String get placed_on => 'Placed on';

	/// en: 'Last updated'
	String get last_updated => 'Last updated';

	/// en: 'Est. delivery'
	String get est_delivery => 'Est. delivery';

	/// en: 'Cancellation'
	String get cancellation => 'Cancellation';

	/// en: 'Cancellation Reason'
	String get cancellation_reason => 'Cancellation Reason';

	/// en: 'No reason provided'
	String get no_reason_provided => 'No reason provided';

	/// en: 'Loading order...'
	String get loading_order => 'Loading order...';

	/// en: 'Failed to Load'
	String get failed_to_load => 'Failed to Load';

	/// en: 'Try Again'
	String get try_again => 'Try Again';

	/// en: 'Mark Shipped'
	String get mark_shipped => 'Mark Shipped';

	/// en: 'Delivered'
	String get mark_delivered => 'Delivered';

	/// en: 'Order shipped!'
	String get order_shipped_success => 'Order shipped!';

	/// en: 'Order delivered!'
	String get order_delivered_success => 'Order delivered!';

	/// en: 'Failed'
	String get failed => 'Failed';

	/// en: 'Not specified'
	String get not_specified => 'Not specified';

	/// en: 'Cash on Delivery'
	String get cash_on_delivery => 'Cash on Delivery';

	/// en: 'Credit/Debit Card'
	String get credit_debit_card => 'Credit/Debit Card';
}

// Path: public_services.category_vendors.vendor_card
class TranslationsPublicServicesCategoryVendorsVendorCardEn {
	TranslationsPublicServicesCategoryVendorsVendorCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'services available'
	String get sub_title => 'services available';

	/// en: 'verified'
	String get badge_title => 'verified';
}

// Path: public_services.vendor_services.service_card
class TranslationsPublicServicesVendorServicesServiceCardEn {
	TranslationsPublicServicesVendorServicesServiceCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Professional Service'
	String get description => 'Professional Service';

	/// en: 'View Details'
	String get button => 'View Details';
}

// Path: public_services.services_details.description
class TranslationsPublicServicesServicesDetailsDescriptionEn {
	TranslationsPublicServicesServicesDetailsDescriptionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Description'
	String get title => 'Description';

	/// en: 'Professional Service From'
	String get dec => 'Professional Service From';
}

// Path: public_services.services_details.working_hours
class TranslationsPublicServicesServicesDetailsWorkingHoursEn {
	TranslationsPublicServicesServicesDetailsWorkingHoursEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Working Hours'
	String get title => 'Working Hours';

	/// en: 'Closed'
	String get closed => 'Closed';

	/// en: 'Open'
	String get open => 'Open';
}

// Path: public_services.services_details.days
class TranslationsPublicServicesServicesDetailsDaysEn {
	TranslationsPublicServicesServicesDetailsDaysEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Monday'
	String get Monday => 'Monday';

	/// en: 'Tuesday'
	String get Tuesday => 'Tuesday';

	/// en: 'Wednesday'
	String get Wednesday => 'Wednesday';

	/// en: 'Thursday'
	String get Thursday => 'Thursday';

	/// en: 'Friday'
	String get Friday => 'Friday';

	/// en: 'Saturday'
	String get Saturday => 'Saturday';

	/// en: 'Sunday'
	String get Sunday => 'Sunday';
}

// Path: public_services.services_details.button
class TranslationsPublicServicesServicesDetailsButtonEn {
	TranslationsPublicServicesServicesDetailsButtonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'REQUEST NOW'
	String get title => 'REQUEST NOW';

	/// en: 'Loading service details...'
	String get null_service => 'Loading service details...';

	/// en: 'This service requires a quotation. Please contact the vendor directly.'
	String get error_service => 'This service requires a quotation. Please contact the vendor directly.';
}

// Path: public_marketplace.spare_parts.details_screen
class TranslationsPublicMarketplaceSparePartsDetailsScreenEn {
	TranslationsPublicMarketplaceSparePartsDetailsScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Specifications'
	String get specifications => 'Specifications';

	/// en: 'Brand'
	String get brand => 'Brand';

	/// en: 'Part Number'
	String get part_number => 'Part Number';

	/// en: 'Warranty'
	String get warranty => 'Warranty';

	/// en: '{months} mo warranty'
	String get warranty_months_suffix => '{months} mo warranty';

	/// en: 'Compatibility'
	String get compatibility => 'Compatibility';

	/// en: 'No compatibility info'
	String get compatibility_empty => 'No compatibility info';

	/// en: '—'
	String get no_value => '—';
}

// Path: public_marketplace.spare_parts.category_screen
class TranslationsPublicMarketplaceSparePartsCategoryScreenEn {
	TranslationsPublicMarketplaceSparePartsCategoryScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Spare Parts'
	String get title => 'Spare Parts';

	/// en: 'Filter spare parts'
	String get filter_button_tooltip => 'Filter spare parts';

	/// en: 'Make: {value}'
	String get chip_make => 'Make: {value}';

	/// en: 'Model: {value}'
	String get chip_model => 'Model: {value}';

	/// en: 'Year {value}+'
	String get chip_year_from => 'Year {value}+';

	/// en: 'to {value}'
	String get chip_year_to => 'to {value}';

	/// en: 'Brand: {value}'
	String get chip_brand => 'Brand: {value}';

	/// en: 'Min: {value}'
	String get chip_min_price => 'Min: {value}';

	/// en: 'Max: {value}'
	String get chip_max_price => 'Max: {value}';

	/// en: 'Clear all'
	String get chip_clear_all => 'Clear all';
}

// Path: public_marketplace.spare_parts.filter_sheet
class TranslationsPublicMarketplaceSparePartsFilterSheetEn {
	TranslationsPublicMarketplaceSparePartsFilterSheetEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Filter Spare Parts'
	String get title => 'Filter Spare Parts';

	/// en: 'Make'
	String get make_label => 'Make';

	/// en: 'Model'
	String get model_label => 'Model';

	/// en: 'Year from'
	String get year_from_label => 'Year from';

	/// en: 'Year to'
	String get year_to_label => 'Year to';

	/// en: 'Brand'
	String get brand_label => 'Brand';

	/// en: 'Min price (KWD)'
	String get min_price_label => 'Min price (KWD)';

	/// en: 'Max price (KWD)'
	String get max_price_label => 'Max price (KWD)';

	/// en: 'Apply'
	String get apply => 'Apply';

	/// en: 'Reset'
	String get reset => 'Reset';

	/// en: 'Cancel'
	String get cancel => 'Cancel';
}

// Path: services.all_services_grid.error
class TranslationsServicesAllServicesGridErrorEn {
	TranslationsServicesAllServicesGridErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Failed to load services'
	String get title => 'Failed to load services';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: services.all_services_grid.empty
class TranslationsServicesAllServicesGridEmptyEn {
	TranslationsServicesAllServicesGridEmptyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No services found for your search'
	String get title => 'No services found for your search';
}

// Path: services.all_services_grid.static
class TranslationsServicesAllServicesGridStaticEn {
	TranslationsServicesAllServicesGridStaticEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Buy a Car'
	String get buy_a_car => 'Buy a Car';

	/// en: 'Sell your Car'
	String get sell_your_car => 'Sell your Car';

	/// en: 'Car Accessories'
	String get car_accessories => 'Car Accessories';

	/// en: 'Spare Parts'
	String get spare_parts => 'Spare Parts';
}

// Path: buy_a_car.details_screen.inspection_report
class TranslationsBuyACarDetailsScreenInspectionReportEn {
	TranslationsBuyACarDetailsScreenInspectionReportEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Inspection Report'
	String get title => 'Inspection Report';

	/// en: 'Download and view the inspection report of this car.'
	String get description => 'Download and view the\n inspection report of this car.';

	/// en: 'View Inspection Report'
	String get view_report => 'View Inspection Report';
}

// Path: buy_a_car.details_screen.spec_labels
class TranslationsBuyACarDetailsScreenSpecLabelsEn {
	TranslationsBuyACarDetailsScreenSpecLabelsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Make'
	String get make => 'Make';

	/// en: 'Model'
	String get model => 'Model';

	/// en: 'Trim'
	String get trim => 'Trim';

	/// en: 'Year'
	String get year => 'Year';

	/// en: 'Mileage'
	String get mileage => 'Mileage';

	/// en: 'Transmission'
	String get transmission => 'Transmission';

	/// en: 'Engine'
	String get engine => 'Engine';

	/// en: 'Color'
	String get color => 'Color';
}

// Path: buy_a_car.details_screen.condition
class TranslationsBuyACarDetailsScreenConditionEn {
	TranslationsBuyACarDetailsScreenConditionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Excellent'
	String get excellent => 'Excellent';

	/// en: 'Good'
	String get good => 'Good';

	/// en: 'Fair'
	String get fair => 'Fair';

	/// en: 'Poor'
	String get poor => 'Poor';

	/// en: 'Damaged'
	String get damaged => 'Damaged';
}

// Path: user_dashboard.wallet.reference_types
class TranslationsUserDashboardWalletReferenceTypesEn {
	TranslationsUserDashboardWalletReferenceTypesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Order Payment'
	String get order => 'Order Payment';

	/// en: 'Refund'
	String get refund => 'Refund';

	/// en: 'Voucher Redemption'
	String get voucher => 'Voucher Redemption';

	/// en: 'Adjustment'
	String get adjustment => 'Adjustment';

	/// en: 'Admin Credit'
	String get admin => 'Admin Credit';

	/// en: 'Payout Hold'
	String get payout_hold => 'Payout Hold';

	/// en: 'Payout Released'
	String get payout_release => 'Payout Released';

	/// en: 'Product Order'
	String get product_order => 'Product Order';
}

// Path: user_dashboard.wallet.transaction_details
class TranslationsUserDashboardWalletTransactionDetailsEn {
	TranslationsUserDashboardWalletTransactionDetailsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Description'
	String get description => 'Description';

	/// en: 'Reference ID'
	String get reference_id => 'Reference ID';

	/// en: 'Type'
	String get type => 'Type';

	/// en: 'Date'
	String get date => 'Date';
}

// Path: user_dashboard.wallet.reward_cards
class TranslationsUserDashboardWalletRewardCardsEn {
	TranslationsUserDashboardWalletRewardCardsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Buy a Car'
	String get buy_a_car => 'Buy a Car';

	/// en: 'Car Accessories'
	String get car_accessories => 'Car Accessories';

	/// en: 'Spare Parts'
	String get spare_parts => 'Spare Parts';
}

// Path: user_dashboard.wallet.transaction
class TranslationsUserDashboardWalletTransactionEn {
	TranslationsUserDashboardWalletTransactionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Compensation'
	String get compensation => 'Compensation';

	/// en: 'Used'
	String get used => 'Used';
}

// Path: user_dashboard.wallet.months
class TranslationsUserDashboardWalletMonthsEn {
	TranslationsUserDashboardWalletMonthsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Jan'
	String get jan => 'Jan';

	/// en: 'Feb'
	String get feb => 'Feb';

	/// en: 'Mar'
	String get mar => 'Mar';

	/// en: 'Apr'
	String get apr => 'Apr';

	/// en: 'May'
	String get may => 'May';

	/// en: 'Jun'
	String get jun => 'Jun';

	/// en: 'Jul'
	String get jul => 'Jul';

	/// en: 'Aug'
	String get aug => 'Aug';

	/// en: 'Sep'
	String get sep => 'Sep';

	/// en: 'Oct'
	String get oct => 'Oct';

	/// en: 'Nov'
	String get nov => 'Nov';

	/// en: 'Dec'
	String get dec => 'Dec';
}

// Path: user_dashboard.wallet.detail_labels
class TranslationsUserDashboardWalletDetailLabelsEn {
	TranslationsUserDashboardWalletDetailLabelsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Service type'
	String get service_type => 'Service type';

	/// en: 'Vendor Name'
	String get vendor_name => 'Vendor Name';

	/// en: 'Liters'
	String get liters => 'Liters';

	/// en: 'Order Id'
	String get order_id => 'Order Id';

	/// en: 'Status'
	String get status => 'Status';
}

// Path: user_dashboard.orders.empty
class TranslationsUserDashboardOrdersEmptyEn {
	TranslationsUserDashboardOrdersEmptyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No Results Found'
	String get no_results => 'No Results Found';

	/// en: 'No {tabName} Orders'
	String get no_tab_orders => 'No {tabName} Orders';

	/// en: 'Try adjusting your search terms.'
	String get adjust_search => 'Try adjusting your search terms.';

	/// en: 'Orders will appear here once available.'
	String get orders_appear_here => 'Orders will appear here once available.';
}

// Path: user_dashboard.orders.error
class TranslationsUserDashboardOrdersErrorEn {
	TranslationsUserDashboardOrdersErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error Loading Orders'
	String get title => 'Error Loading Orders';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: user_dashboard.orders.card
class TranslationsUserDashboardOrdersCardEn {
	TranslationsUserDashboardOrdersCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Service Order'
	String get service_order => 'Service Order';

	/// en: 'Product Order'
	String get product_order => 'Product Order';

	/// en: 'Service'
	String get fallback_service => 'Service';

	/// en: 'Vendor'
	String get fallback_vendor => 'Vendor';

	/// en: 'item'
	String get item => 'item';

	/// en: 'items'
	String get items => 'items';

	/// en: 'Reference'
	String get reference => 'Reference';

	/// en: 'Amount'
	String get amount => 'Amount';

	/// en: 'Time'
	String get time => 'Time';

	/// en: 'Order ID'
	String get order_id => 'Order ID';

	/// en: 'Date'
	String get date => 'Date';

	/// en: 'Delivery Address'
	String get delivery_address => 'Delivery Address';

	/// en: 'Order Summary'
	String get order_summary => 'Order Summary';

	/// en: 'Download Receipt'
	String get download_receipt => 'Download Receipt';

	/// en: 'Subtotal'
	String get subtotal => 'Subtotal';

	/// en: 'Total'
	String get total => 'Total';

	/// en: 'Payment Method'
	String get payment_method => 'Payment Method';

	/// en: 'Failed to load details: {error}'
	String get failed_details => 'Failed to load details: {error}';

	/// en: '+ {count} more'
	String get more_items => '+ {count} more';

	/// en: 'View Details'
	String get view_details => 'View Details';

	/// en: 'ADD REVIEW'
	String get add_review => 'ADD REVIEW';
}

// Path: user_dashboard.orders.status
class TranslationsUserDashboardOrdersStatusEn {
	TranslationsUserDashboardOrdersStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Pending'
	String get pending => 'Pending';

	/// en: 'Accepted'
	String get accepted => 'Accepted';

	/// en: 'On the Way'
	String get on_the_way => 'On the Way';

	/// en: 'Arrived'
	String get arrived => 'Arrived';

	/// en: 'In Progress'
	String get in_progress => 'In Progress';

	/// en: 'Completed'
	String get completed => 'Completed';

	/// en: 'Rejected'
	String get rejected => 'Rejected';

	/// en: 'Cancelled'
	String get cancelled => 'Cancelled';

	/// en: 'Processing'
	String get processing => 'Processing';

	/// en: 'Confirmed'
	String get confirmed => 'Confirmed';

	/// en: 'Shipped'
	String get shipped => 'Shipped';

	/// en: 'Delivered'
	String get delivered => 'Delivered';
}

// Path: user_dashboard.orders.details
class TranslationsUserDashboardOrdersDetailsEn {
	TranslationsUserDashboardOrdersDetailsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Request Details'
	String get screen_title => 'Request Details';

	/// en: 'Service Specifications'
	String get service_specifications => 'Service Specifications';

	/// en: 'Your Details'
	String get your_details => 'Your Details';

	/// en: 'Failed to load order'
	String get failed_to_load => 'Failed to load order';

	/// en: 'Unknown Service'
	String get unknown_service => 'Unknown Service';

	/// en: 'Unknown Vendor'
	String get unknown_vendor => 'Unknown Vendor';

	/// en: 'Order Information'
	String get order_information => 'Order Information';

	/// en: 'Order Reference'
	String get order_reference => 'Order Reference';

	/// en: 'Service'
	String get service => 'Service';

	/// en: 'Vendor'
	String get vendor => 'Vendor';

	/// en: 'Base Amount'
	String get base_amount => 'Base Amount';

	/// en: 'Total Amount'
	String get total_amount => 'Total Amount';

	/// en: 'Scheduled Date & Time'
	String get scheduled_date_time => 'Scheduled Date & Time';

	/// en: 'Date'
	String get date => 'Date';

	/// en: 'Time'
	String get time => 'Time';

	/// en: 'Service Location'
	String get service_location => 'Service Location';

	/// en: 'Open in Maps'
	String get open_in_maps => 'Open in Maps';

	/// en: 'Timeline'
	String get timeline => 'Timeline';

	/// en: 'Order Placed'
	String get order_placed => 'Order Placed';

	/// en: 'Vendor Accepted'
	String get vendor_accepted => 'Vendor Accepted';

	/// en: 'Service Completed'
	String get service_completed => 'Service Completed';

	/// en: 'Order Cancelled'
	String get order_cancelled => 'Order Cancelled';

	/// en: 'Documents'
	String get documents => 'Documents';

	/// en: 'Document'
	String get document => 'Document';

	/// en: 'Rejection Reason'
	String get rejection_reason => 'Rejection Reason';

	/// en: 'Cancellation Reason'
	String get cancellation_reason => 'Cancellation Reason';

	/// en: 'Call Vendor'
	String get call_vendor => 'Call Vendor';

	/// en: 'Write Review'
	String get write_review => 'Write Review';

	/// en: 'Book Again'
	String get book_again => 'Book Again';

	/// en: 'Vendor phone number is not available'
	String get phone_not_available => 'Vendor phone number is not available';

	/// en: 'Could not launch phone dialer'
	String get could_not_launch_dialer => 'Could not launch phone dialer';

	/// en: 'Review feature coming soon'
	String get review_coming_soon => 'Review feature coming soon';

	/// en: 'Order Details'
	String get screen_title_product => 'Order Details';

	/// en: 'Order Date'
	String get order_date => 'Order Date';

	/// en: 'Order Items'
	String get order_items => 'Order Items';

	/// en: 'Qty: {qty}'
	String get quantity_label => 'Qty: {qty}';

	/// en: 'Payment Summary'
	String get payment_summary => 'Payment Summary';

	/// en: 'Order Updated'
	String get order_updated => 'Order Updated';
}

// Path: user_dashboard.active_orders_preview.time_ago
class TranslationsUserDashboardActiveOrdersPreviewTimeAgoEn {
	TranslationsUserDashboardActiveOrdersPreviewTimeAgoEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Just now'
	String get just_now => 'Just now';

	/// en: '{n}m ago'
	String get minutes_ago => '{n}m ago';

	/// en: '{n}h ago'
	String get hours_ago => '{n}h ago';

	/// en: '{n}d ago'
	String get days_ago => '{n}d ago';
}

// Path: user_dashboard.listings.error
class TranslationsUserDashboardListingsErrorEn {
	TranslationsUserDashboardListingsErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Failed to load listings'
	String get failed_to_load => 'Failed to load listings';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: user_dashboard.listings.empty
class TranslationsUserDashboardListingsEmptyEn {
	TranslationsUserDashboardListingsEmptyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No listings found'
	String get no_results => 'No listings found';

	/// en: 'No listings yet'
	String get no_listings_yet => 'No listings yet';

	/// en: 'No listings match.'
	String get no_match => 'No listings match.';

	/// en: 'Your car listings will appear here'
	String get appear_here => 'Your car listings will appear here';
}

// Path: user_dashboard.listings.card
class TranslationsUserDashboardListingsCardEn {
	TranslationsUserDashboardListingsCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Featured'
	String get featured => 'Featured';

	/// en: 'Inspected'
	String get inspected => 'Inspected';

	/// en: 'Not Inspected'
	String get not_inspected => 'Not Inspected';
}

// Path: user_dashboard.listing_details.time_ago
class TranslationsUserDashboardListingDetailsTimeAgoEn {
	TranslationsUserDashboardListingDetailsTimeAgoEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Just now'
	String get just_now => 'Just now';

	/// en: '{n} minutes ago'
	String get minutes_ago => '{n} minutes ago';

	/// en: '{n} hours ago'
	String get hours_ago => '{n} hours ago';

	/// en: '{n} days ago'
	String get days_ago => '{n} days ago';

	/// en: '{n} months ago'
	String get months_ago => '{n} months ago';
}

// Path: user_dashboard.listing_details.inspection
class TranslationsUserDashboardListingDetailsInspectionEn {
	TranslationsUserDashboardListingDetailsInspectionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Inspection Report'
	String get title => 'Inspection Report';

	/// en: 'Download and view the inspection report of this car.'
	String get has_report_desc => 'Download and view the\n inspection report of this car.';

	/// en: 'No inspection report available for this car.'
	String get no_report_desc => 'No inspection report\n available for this car.';

	/// en: 'View Inspection Report'
	String get view_report => 'View Inspection Report';
}

// Path: user_dashboard.listing_details.specifications
class TranslationsUserDashboardListingDetailsSpecificationsEn {
	TranslationsUserDashboardListingDetailsSpecificationsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Specifications'
	String get title => 'Specifications';

	/// en: 'Edit'
	String get edit => 'Edit';

	late final TranslationsUserDashboardListingDetailsSpecificationsLabelsEn labels = TranslationsUserDashboardListingDetailsSpecificationsLabelsEn._(_root);

	/// en: 'N/A'
	String get na => 'N/A';
}

// Path: user_dashboard.listing_details.description
class TranslationsUserDashboardListingDetailsDescriptionEn {
	TranslationsUserDashboardListingDetailsDescriptionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Description'
	String get title => 'Description';

	/// en: 'No description available.'
	String get no_description => 'No description available.';

	/// en: 'Edit Description'
	String get edit_dialog_title => 'Edit Description';

	/// en: 'Enter new description...'
	String get edit_dialog_hint => 'Enter new description...';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Save'
	String get save => 'Save';
}

// Path: user_dashboard.edit_specs.steps
class TranslationsUserDashboardEditSpecsStepsEn {
	TranslationsUserDashboardEditSpecsStepsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Make'
	String get make => 'Make';

	/// en: 'Model'
	String get model => 'Model';

	/// en: 'Trim'
	String get trim => 'Trim';

	/// en: 'Year'
	String get year => 'Year';

	/// en: 'Mileage'
	String get mileage => 'Mileage';

	/// en: 'Transmission'
	String get transmission => 'Transmission';

	/// en: 'Color'
	String get color => 'Color';
}

// Path: user_dashboard.edit_specs.validation
class TranslationsUserDashboardEditSpecsValidationEn {
	TranslationsUserDashboardEditSpecsValidationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Please complete all fields'
	String get complete_all_fields => 'Please complete all fields';
}

// Path: user_dashboard.notifications.empty
class TranslationsUserDashboardNotificationsEmptyEn {
	TranslationsUserDashboardNotificationsEmptyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All Caught Up!'
	String get title => 'All Caught Up!';

	/// en: 'No new notifications to display.'
	String get subtitle => 'No new notifications to display.';
}

// Path: user_dashboard.settings.menu
class TranslationsUserDashboardSettingsMenuEn {
	TranslationsUserDashboardSettingsMenuEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Account Info'
	String get account_info => 'Account Info';

	/// en: 'Saved Addresses'
	String get saved_addresses => 'Saved Addresses';

	/// en: 'Change Email'
	String get change_email => 'Change Email';

	/// en: 'Change Password'
	String get change_password => 'Change Password';

	/// en: 'Country'
	String get country => 'Country';

	/// en: 'Notifications'
	String get notifications => 'Notifications';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'App Mode'
	String get app_mode => 'App Mode';

	/// en: 'Logout'
	String get logout => 'Logout';

	/// en: 'Delete Account'
	String get delete_account => 'Delete Account';
}

// Path: user_dashboard.settings.delete_account_confirm
class TranslationsUserDashboardSettingsDeleteAccountConfirmEn {
	TranslationsUserDashboardSettingsDeleteAccountConfirmEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Delete Account?'
	String get title => 'Delete Account?';

	/// en: 'Are you sure you want to delete your account? This action is permanent and cannot be undone.'
	String get message => 'Are you sure you want to delete your account? This action is permanent and cannot be undone.';

	/// en: 'Delete'
	String get confirm => 'Delete';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Failed to delete account. Please try again.'
	String get error => 'Failed to delete account. Please try again.';
}

// Path: user_dashboard.settings.account_info
class TranslationsUserDashboardSettingsAccountInfoEn {
	TranslationsUserDashboardSettingsAccountInfoEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Account Info'
	String get screen_title => 'Account Info';

	/// en: 'Edit'
	String get edit => 'Edit';

	late final TranslationsUserDashboardSettingsAccountInfoFieldsEn fields = TranslationsUserDashboardSettingsAccountInfoFieldsEn._(_root);
	late final TranslationsUserDashboardSettingsAccountInfoGenderEn gender = TranslationsUserDashboardSettingsAccountInfoGenderEn._(_root);
	late final TranslationsUserDashboardSettingsAccountInfoPreferencesEn preferences = TranslationsUserDashboardSettingsAccountInfoPreferencesEn._(_root);

	/// en: 'DELETE ACCOUNT'
	String get delete_account => 'DELETE ACCOUNT';
}

// Path: user_dashboard.settings.change_email
class TranslationsUserDashboardSettingsChangeEmailEn {
	TranslationsUserDashboardSettingsChangeEmailEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Change Email'
	String get screen_title => 'Change Email';

	/// en: 'New Email Address'
	String get field_hint => 'New Email Address';

	/// en: 'Please enter a valid email address'
	String get validation_error => 'Please enter a valid email address';

	/// en: 'CONFIRMING...'
	String get confirm_button_loading => 'CONFIRMING...';

	/// en: 'Confirm'
	String get confirm_button => 'Confirm';

	/// en: 'Email updated successfully'
	String get success => 'Email updated successfully';

	/// en: 'Failed to update email. Please try again.'
	String get error => 'Failed to update email. Please try again.';
}

// Path: user_dashboard.settings.change_password
class TranslationsUserDashboardSettingsChangePasswordEn {
	TranslationsUserDashboardSettingsChangePasswordEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Change Password'
	String get screen_title => 'Change Password';

	late final TranslationsUserDashboardSettingsChangePasswordFieldsEn fields = TranslationsUserDashboardSettingsChangePasswordFieldsEn._(_root);
	late final TranslationsUserDashboardSettingsChangePasswordValidationEn validation = TranslationsUserDashboardSettingsChangePasswordValidationEn._(_root);

	/// en: 'CHANGING...'
	String get button_loading => 'CHANGING...';

	/// en: 'Change Password'
	String get button => 'Change Password';

	/// en: 'Password change success.'
	String get success => 'Password change success.';

	/// en: 'Failed to change password. Please try again.'
	String get error => 'Failed to change password. Please try again.';
}

// Path: user_dashboard.settings.language
class TranslationsUserDashboardSettingsLanguageEn {
	TranslationsUserDashboardSettingsLanguageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Language'
	String get title => 'Language';

	/// en: 'English'
	String get english => 'English';

	/// en: 'Arabic'
	String get arabic => 'Arabic';
}

// Path: user_dashboard.settings.app_mode
class TranslationsUserDashboardSettingsAppModeEn {
	TranslationsUserDashboardSettingsAppModeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'App Mode'
	String get title => 'App Mode';

	/// en: 'Dark'
	String get dark => 'Dark';

	/// en: 'Light'
	String get light => 'Light';
}

// Path: user_dashboard.settings.country
class TranslationsUserDashboardSettingsCountryEn {
	TranslationsUserDashboardSettingsCountryEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Country'
	String get title => 'Country';

	/// en: 'Kuwait'
	String get kuwait => 'Kuwait';

	/// en: 'Bahrain'
	String get bahrain => 'Bahrain';

	/// en: 'UAE'
	String get uae => 'UAE';

	/// en: 'Oman'
	String get oman => 'Oman';

	/// en: 'Qatar'
	String get qatar => 'Qatar';

	/// en: 'Saudi Arabia'
	String get saudi_arabia => 'Saudi Arabia';
}

// Path: user_dashboard.settings.saved_addresses
class TranslationsUserDashboardSettingsSavedAddressesEn {
	TranslationsUserDashboardSettingsSavedAddressesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Addresses'
	String get screen_title => 'Addresses';

	/// en: 'Add'
	String get add_button => 'Add';

	/// en: 'No saved addresses'
	String get empty_title => 'No saved addresses';

	/// en: 'Add New Address'
	String get add_new_button => 'Add New Address';
}

// Path: user_dashboard.settings.notification_preferences
class TranslationsUserDashboardSettingsNotificationPreferencesEn {
	TranslationsUserDashboardSettingsNotificationPreferencesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'NOTIFICATION PREFERENCES'
	String get screen_title => 'NOTIFICATION PREFERENCES';

	/// en: 'Order updates'
	String get order_updates => 'Order updates';

	/// en: 'Promotions'
	String get promotions => 'Promotions';
}

// Path: user_dashboard.settings.verify_email_otp
class TranslationsUserDashboardSettingsVerifyEmailOtpEn {
	TranslationsUserDashboardSettingsVerifyEmailOtpEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'VERIFY EMAIL'
	String get title => 'VERIFY EMAIL';

	/// en: 'We've sent a code to '
	String get sent_code => 'We\'ve sent a code to ';

	/// en: 'Please enter the complete OTP code'
	String get otp_error => 'Please enter the complete OTP code';

	/// en: 'VERIFYING...'
	String get verify_button_loading => 'VERIFYING...';

	/// en: 'VERIFY'
	String get verify_button => 'VERIFY';

	/// en: 'Email updated successfully'
	String get success => 'Email updated successfully';

	/// en: 'Failed to update email. Please try again.'
	String get error => 'Failed to update email. Please try again.';

	/// en: 'OTP sent successfully'
	String get otp_sent => 'OTP sent successfully';

	late final TranslationsUserDashboardSettingsVerifyEmailOtpResendEn resend = TranslationsUserDashboardSettingsVerifyEmailOtpResendEn._(_root);
}

// Path: user_dashboard.settings.edit_address
class TranslationsUserDashboardSettingsEditAddressEn {
	TranslationsUserDashboardSettingsEditAddressEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Edit Address'
	String get edit_title => 'Edit Address';

	/// en: 'Add Address'
	String get add_title => 'Add Address';

	/// en: 'Delete'
	String get delete => 'Delete';

	late final TranslationsUserDashboardSettingsEditAddressDeleteDialogEn delete_dialog = TranslationsUserDashboardSettingsEditAddressDeleteDialogEn._(_root);
	late final TranslationsUserDashboardSettingsEditAddressValidationEn validation = TranslationsUserDashboardSettingsEditAddressValidationEn._(_root);
	late final TranslationsUserDashboardSettingsEditAddressAreaEn area = TranslationsUserDashboardSettingsEditAddressAreaEn._(_root);
	late final TranslationsUserDashboardSettingsEditAddressPropertyTypesEn property_types = TranslationsUserDashboardSettingsEditAddressPropertyTypesEn._(_root);
	late final TranslationsUserDashboardSettingsEditAddressFieldsEn fields = TranslationsUserDashboardSettingsEditAddressFieldsEn._(_root);

	/// en: 'SAVE ADDRESS'
	String get save_button => 'SAVE ADDRESS';

	/// en: 'Address'
	String get default_label => 'Address';
}

// Path: user_dashboard.settings.address_tile
class TranslationsUserDashboardSettingsAddressTileEn {
	TranslationsUserDashboardSettingsAddressTileEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Block {n}'
	String get block => 'Block {n}';

	/// en: 'Building {n}'
	String get building => 'Building {n}';

	/// en: 'Apt {n}'
	String get apt => 'Apt {n}';

	/// en: 'Mobile Number: {n}'
	String get mobile_number => 'Mobile Number: {n}';
}

// Path: sell_your_car.screens.condition_car
class TranslationsSellYourCarScreensConditionCarEn {
	TranslationsSellYourCarScreensConditionCarEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'SELL Your CARS'
	String get title => 'SELL Your CARS';

	/// en: 'We have offers waiting for you'
	String get subtitle => 'We have offers waiting for you';
}

// Path: sell_your_car.screens.sell_a_car
class TranslationsSellYourCarScreensSellACarEn {
	TranslationsSellYourCarScreensSellACarEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'SELL A CAR'
	String get title => 'SELL A CAR';

	/// en: 'We have offers waiting for you'
	String get subtitle => 'We have offers waiting for you';
}

// Path: sell_your_car.screens.sell_or_buy_car
class TranslationsSellYourCarScreensSellOrBuyCarEn {
	TranslationsSellYourCarScreensSellOrBuyCarEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'SELL OR BUY YOUR CARS'
	String get title => 'SELL OR BUY YOUR CARS';

	/// en: 'Buy and Sell Your Car Quickly and Conveniently'
	String get subtitle => 'Buy and Sell Your Car Quickly and Conveniently';
}

// Path: sell_your_car.screens.fast_track_condition
class TranslationsSellYourCarScreensFastTrackConditionEn {
	TranslationsSellYourCarScreensFastTrackConditionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Fast Track Car Sale'
	String get title => 'Fast Track Car Sale';

	/// en: 'We have offers waiting for you'
	String get subtitle => 'We have offers waiting for you';
}

// Path: sell_your_car.screens.fast_track_sale
class TranslationsSellYourCarScreensFastTrackSaleEn {
	TranslationsSellYourCarScreensFastTrackSaleEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'FAST TRACK CAR SALE'
	String get title => 'FAST TRACK CAR SALE';

	/// en: 'We have offers waiting for you'
	String get subtitle => 'We have offers waiting for you';

	/// en: 'Description'
	String get description_title => 'Description';

	/// en: 'Fast Track Car Sale is designed for those who need to sell their car quickly and efficiently. By listing at a discounted price, your car can be sold within 15 hours. Once you approve the offer, our team will handle the process, ensuring a smooth and hassle-free transaction. A representative will contact you to finalize the sale after your approval.'
	String get description => 'Fast Track Car Sale is designed for those who need to sell their car quickly and efficiently. By listing at a discounted price, your car can be sold within 15 hours. Once you approve the offer, our team will handle the process, ensuring a smooth and hassle-free transaction. A representative will contact you to finalize the sale after your approval.';

	/// en: 'Terms and Conditions'
	String get terms_title => 'Terms and Conditions';

	/// en: 'By using our car listing services, you agree to the following terms and conditions:'
	String get terms_intro => 'By using our car listing services, you agree to the following terms and conditions:';

	/// en: 'Cars listed under Fast Track Sale must be priced 30% lower than the lowest market value.'
	String get bullet_1 => 'Cars listed under Fast Track Sale must be priced 30% lower than the lowest market value.';

	/// en: 'Listing fees are non-refundable.'
	String get bullet_2 => 'Listing fees are non-refundable.';

	/// en: 'Transactions are subject to a 5% fee for both the buyer and seller.'
	String get bullet_3 => 'Transactions are subject to a 5% fee for both the buyer and seller.';

	/// en: 'The seller must approve the offer and terms before proceeding.'
	String get bullet_4 => 'The seller must approve the offer and terms before proceeding.';

	/// en: 'Listings and offers are valid only after Motiva's approval.'
	String get bullet_5 => 'Listings and offers are valid only after Motiva\'s approval.';

	/// en: 'Yes, I approve the Motiva's terms and conditions of fast track car sale.'
	String get approve_checkbox => 'Yes, I approve the Motiva\'s terms and conditions of fast track car sale.';

	/// en: 'CONTINUE'
	String get kContinue => 'CONTINUE';
}

// Path: sell_your_car.screens.open_an_auction
class TranslationsSellYourCarScreensOpenAnAuctionEn {
	TranslationsSellYourCarScreensOpenAnAuctionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'OPEN AN AUCTION'
	String get title => 'OPEN AN AUCTION';

	/// en: 'Sell Fast Through Auction'
	String get subtitle => 'Sell Fast Through Auction';

	/// en: 'Description'
	String get description_title => 'Description';

	/// en: 'List your car for sale with ease using our platform. Choose from Normal, Auction, or Fast Track options to find buyers quickly and securely. Opt for add-ons like an inspection report to boost your listing credibility. Fast Track ensures a guaranteed sale within 15 hours at 30% below the lowest market price.'
	String get description => 'List your car for sale with ease using our platform. Choose from Normal, Auction, or Fast Track options to find buyers quickly and securely. Opt for add-ons like an inspection report to boost your listing credibility. Fast Track ensures a guaranteed sale within 15 hours at 30% below the lowest market price.';

	/// en: 'Terms and Conditions'
	String get terms_title => 'Terms and Conditions';

	/// en: 'By using our car listing services, you agree to the following terms and conditions:'
	String get terms_intro => 'By using our car listing services, you agree to the following terms and conditions:';

	/// en: 'All car details must be accurate and up-to-date.'
	String get bullet_1 => 'All car details must be accurate and up-to-date.';

	/// en: 'Listing fees are non-refundable and vary by service type.'
	String get bullet_2 => 'Listing fees are non-refundable and vary by service type.';

	/// en: 'Fast Track Sales require a 30% discount on the lowest market price.'
	String get bullet_3 => 'Fast Track Sales require a 30% discount on the lowest market price.';

	/// en: 'A 5% transaction fee applies to both seller and buyer on successful sales.'
	String get bullet_4 => 'A 5% transaction fee applies to both seller and buyer on successful sales.';

	/// en: 'Inspection reports must be valid and accurate.'
	String get bullet_5 => 'Inspection reports must be valid and accurate.';

	/// en: 'Yes, I approve the Motiva's terms and conditions of opening an auction.'
	String get approve_checkbox => 'Yes, I approve the Motiva\'s terms and conditions of opening an auction.';

	/// en: 'CONTINUE'
	String get kContinue => 'CONTINUE';
}

// Path: sell_your_car.screens.car_details
class TranslationsSellYourCarScreensCarDetailsEn {
	TranslationsSellYourCarScreensCarDetailsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Car Details'
	String get title => 'Car Details';

	/// en: 'Submitting your listing...'
	String get submitting_listing => 'Submitting your listing...';

	/// en: 'Submitting your request...'
	String get submitting_request => 'Submitting your request...';
}

// Path: sell_your_car.screens.success_dialog
class TranslationsSellYourCarScreensSuccessDialogEn {
	TranslationsSellYourCarScreensSuccessDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Success!'
	String get title => 'Success!';

	/// en: 'Your damaged car listing has been submitted successfully.'
	String get damaged_car_message => 'Your damaged car listing has been submitted successfully.';

	/// en: 'Listing Created Successfully!'
	String get listing_created => 'Listing Created Successfully!';

	/// en: 'Your car listing has been saved.'
	String get listing_saved => 'Your car listing has been saved.';

	/// en: 'OK'
	String get ok => 'OK';

	/// en: 'Done'
	String get done => 'Done';
}

// Path: sell_your_car.screens.request_received_dialog
class TranslationsSellYourCarScreensRequestReceivedDialogEn {
	TranslationsSellYourCarScreensRequestReceivedDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Request Received!'
	String get title => 'Request Received!';

	/// en: 'Request sent to Motiva admins — we will contact you with an offer'
	String get message => 'Request sent to Motiva admins — we will contact you with an offer';
}

// Path: sell_your_car.screens.error_dialog
class TranslationsSellYourCarScreensErrorDialogEn {
	TranslationsSellYourCarScreensErrorDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error'
	String get title => 'Error';
}

// Path: vendor_dashboard.wallet.tabs
class TranslationsVendorDashboardWalletTabsEn {
	TranslationsVendorDashboardWalletTabsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Daily'
	String get daily => 'Daily';

	/// en: 'Weekly'
	String get weekly => 'Weekly';

	/// en: 'Monthly'
	String get monthly => 'Monthly';
}

// Path: vendor_dashboard.wallet.stats
class TranslationsVendorDashboardWalletStatsEn {
	TranslationsVendorDashboardWalletStatsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Total Sales'
	String get total_sales => 'Total Sales';

	/// en: 'Total Earnings'
	String get total_earnings => 'Total Earnings';

	/// en: 'Average Rating'
	String get average_rating => 'Average Rating';

	/// en: 'Cancellation Rate'
	String get cancellation_rate => 'Cancellation Rate';
}

// Path: vendor_dashboard.wallet.history_status
class TranslationsVendorDashboardWalletHistoryStatusEn {
	TranslationsVendorDashboardWalletHistoryStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Under Progress'
	String get in_progress => 'Under Progress';

	/// en: 'Rejected'
	String get rejected => 'Rejected';
}

// Path: vendor_dashboard.wallet.payout_request
class TranslationsVendorDashboardWalletPayoutRequestEn {
	TranslationsVendorDashboardWalletPayoutRequestEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Withdraw Funds'
	String get title => 'Withdraw Funds';

	/// en: 'Amount (KWD)'
	String get amount_label => 'Amount (KWD)';

	/// en: 'Enter amount to withdraw'
	String get amount_hint => 'Enter amount to withdraw';

	/// en: 'Bank Details'
	String get bank_details => 'Bank Details';

	/// en: 'Bank Name'
	String get bank_name => 'Bank Name';

	/// en: 'Account Number'
	String get account_number => 'Account Number';

	/// en: 'Account Holder'
	String get account_holder => 'Account Holder';

	/// en: 'Kuwait Code'
	String get kuwait_code => 'Kuwait Code';

	/// en: 'Update Bank Details'
	String get update_bank_details => 'Update Bank Details';

	/// en: 'Submit Payout Request'
	String get submit => 'Submit Payout Request';

	/// en: 'Insufficient wallet balance'
	String get insufficient_balance => 'Insufficient wallet balance';

	/// en: 'Please enter a valid amount'
	String get invalid_amount => 'Please enter a valid amount';

	/// en: 'Payout request submitted successfully'
	String get success => 'Payout request submitted successfully';

	/// en: 'Failed to submit payout request'
	String get error => 'Failed to submit payout request';

	/// en: 'No bank details found. Please add bank details first.'
	String get no_bank_details => 'No bank details found. Please add bank details first.';
}

// Path: vendor_dashboard.wallet.payout_status
class TranslationsVendorDashboardWalletPayoutStatusEn {
	TranslationsVendorDashboardWalletPayoutStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Pending'
	String get pending => 'Pending';

	/// en: 'Processed'
	String get processed => 'Processed';

	/// en: 'Rejected'
	String get rejected => 'Rejected';
}

// Path: vendor_dashboard.wallet.months
class TranslationsVendorDashboardWalletMonthsEn {
	TranslationsVendorDashboardWalletMonthsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Jan'
	String get jan => 'Jan';

	/// en: 'Feb'
	String get feb => 'Feb';

	/// en: 'Mar'
	String get mar => 'Mar';

	/// en: 'Apr'
	String get apr => 'Apr';

	/// en: 'May'
	String get may => 'May';

	/// en: 'Jun'
	String get jun => 'Jun';

	/// en: 'Jul'
	String get jul => 'Jul';

	/// en: 'Aug'
	String get aug => 'Aug';

	/// en: 'Sep'
	String get sep => 'Sep';

	/// en: 'Oct'
	String get oct => 'Oct';

	/// en: 'Nov'
	String get nov => 'Nov';

	/// en: 'Dec'
	String get dec => 'Dec';
}

// Path: vendor_dashboard.wallet.reference_types
class TranslationsVendorDashboardWalletReferenceTypesEn {
	TranslationsVendorDashboardWalletReferenceTypesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Order Payment'
	String get order => 'Order Payment';

	/// en: 'Refund'
	String get refund => 'Refund';

	/// en: 'Voucher Redemption'
	String get voucher => 'Voucher Redemption';

	/// en: 'Adjustment'
	String get adjustment => 'Adjustment';

	/// en: 'Admin Credit'
	String get admin => 'Admin Credit';

	/// en: 'Payout Hold'
	String get payout_hold => 'Payout Hold';

	/// en: 'Payout Released'
	String get payout_release => 'Payout Released';

	/// en: 'Product Order'
	String get product_order => 'Product Order';
}

// Path: vendor_dashboard.settings.menu
class TranslationsVendorDashboardSettingsMenuEn {
	TranslationsVendorDashboardSettingsMenuEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Uploaded Documents'
	String get uploaded_documents => 'Uploaded Documents';

	/// en: 'Service Area'
	String get service_area => 'Service Area';

	/// en: 'Business Logo'
	String get business_logo => 'Business Logo';

	/// en: 'Cover Image'
	String get cover_image => 'Cover Image';

	/// en: 'Working Hours'
	String get working_hours => 'Working Hours';

	/// en: 'Notifications'
	String get notifications => 'Notifications';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'App Mode'
	String get app_mode => 'App Mode';

	/// en: 'Logout'
	String get logout => 'Logout';

	/// en: 'Delete Account'
	String get delete_account => 'Delete Account';
}

// Path: vendor_dashboard.settings.delete_account_confirm
class TranslationsVendorDashboardSettingsDeleteAccountConfirmEn {
	TranslationsVendorDashboardSettingsDeleteAccountConfirmEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Delete Account?'
	String get title => 'Delete Account?';

	/// en: 'Are you sure you want to delete your account? This action is permanent and cannot be undone.'
	String get message => 'Are you sure you want to delete your account? This action is permanent and cannot be undone.';

	/// en: 'Delete'
	String get confirm => 'Delete';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Failed to delete account. Please try again.'
	String get error => 'Failed to delete account. Please try again.';
}

// Path: vendor_services.empty.search
class TranslationsVendorServicesEmptySearchEn {
	TranslationsVendorServicesEmptySearchEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No Results Found'
	String get title => 'No Results Found';

	/// en: 'Try adjusting your search terms.'
	String get subtitle => 'Try adjusting your search terms.';
}

// Path: vendor_services.empty.archived
class TranslationsVendorServicesEmptyArchivedEn {
	TranslationsVendorServicesEmptyArchivedEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No Archived Services'
	String get title => 'No Archived Services';

	/// en: 'Archived services will appear here.'
	String get subtitle => 'Archived services will appear here.';
}

// Path: vendor_services.empty.no_services
class TranslationsVendorServicesEmptyNoServicesEn {
	TranslationsVendorServicesEmptyNoServicesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No Services Yet'
	String get title => 'No Services Yet';

	/// en: 'Create your first service to start receiving orders.'
	String get subtitle => 'Create your first service to start receiving orders.';

	/// en: 'Create Service'
	String get action => 'Create Service';
}

// Path: vendor_services.create_screen.app_bar
class TranslationsVendorServicesCreateScreenAppBarEn {
	TranslationsVendorServicesCreateScreenAppBarEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'New Service'
	String get new_title => 'New Service';

	/// en: 'Edit Service'
	String get edit => 'Edit Service';
}

// Path: vendor_services.create_screen.form
class TranslationsVendorServicesCreateScreenFormEn {
	TranslationsVendorServicesCreateScreenFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsVendorServicesCreateScreenFormServiceNameEn service_name = TranslationsVendorServicesCreateScreenFormServiceNameEn._(_root);
	late final TranslationsVendorServicesCreateScreenFormDescriptionEn description = TranslationsVendorServicesCreateScreenFormDescriptionEn._(_root);
	late final TranslationsVendorServicesCreateScreenFormBasePriceEn base_price = TranslationsVendorServicesCreateScreenFormBasePriceEn._(_root);
	late final TranslationsVendorServicesCreateScreenFormRadiusEn radius = TranslationsVendorServicesCreateScreenFormRadiusEn._(_root);
}

// Path: vendor_services.create_screen.image_upload
class TranslationsVendorServicesCreateScreenImageUploadEn {
	TranslationsVendorServicesCreateScreenImageUploadEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Service Image'
	String get title => 'Service Image';

	/// en: 'Upload an image to showcase your service'
	String get subtitle => 'Upload an image to showcase your service';

	/// en: 'Uploading...'
	String get uploading => 'Uploading...';

	/// en: 'Change Image'
	String get change => 'Change Image';

	/// en: 'Tap to upload service image'
	String get placeholder_title => 'Tap to upload service image';

	/// en: 'Recommended: 800x600 pixels'
	String get placeholder_subtitle => 'Recommended: 800x600 pixels';
}

// Path: vendor_services.create_screen.attributes
class TranslationsVendorServicesCreateScreenAttributesEn {
	TranslationsVendorServicesCreateScreenAttributesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Service Attributes'
	String get title => 'Service Attributes';

	/// en: 'Required'
	String get required_badge => 'Required';

	/// en: 'Fill in the details specific to this service type'
	String get subtitle => 'Fill in the details specific to this service type';

	/// en: 'Enter {field}'
	String get hint => 'Enter {field}';
}

// Path: vendor_services.create_screen.customer_questions
class TranslationsVendorServicesCreateScreenCustomerQuestionsEn {
	TranslationsVendorServicesCreateScreenCustomerQuestionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Customer Questions'
	String get title => 'Customer Questions';

	/// en: 'Define questions customers must answer when booking this service.'
	String get subtitle => 'Define questions customers must answer when booking this service.';

	/// en: 'Add Customer Question'
	String get add_button => 'Add Customer Question';

	/// en: ' *'
	String get required_suffix => ' *';
}

// Path: vendor_services.create_screen.button
class TranslationsVendorServicesCreateScreenButtonEn {
	TranslationsVendorServicesCreateScreenButtonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Save Changes'
	String get save => 'Save Changes';

	/// en: 'Create Service'
	String get create => 'Create Service';

	/// en: 'Restore Service'
	String get restore => 'Restore Service';
}

// Path: vendor_services.create_screen.snackbar
class TranslationsVendorServicesCreateScreenSnackbarEn {
	TranslationsVendorServicesCreateScreenSnackbarEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Service created successfully'
	String get create_success => 'Service created successfully';

	/// en: 'Service updated successfully'
	String get update_success => 'Service updated successfully';

	/// en: 'Failed to create service. Please check your inputs and try again.'
	String get create_failed => 'Failed to create service. Please check your inputs and try again.';

	/// en: 'Failed to update service. Please check your inputs and try again.'
	String get update_failed => 'Failed to update service. Please check your inputs and try again.';

	/// en: 'Service archived successfully'
	String get archive_success => 'Service archived successfully';

	/// en: 'Failed to archive service'
	String get archive_failed => 'Failed to archive service';

	/// en: 'Service restored successfully'
	String get restore_success => 'Service restored successfully';

	/// en: 'Failed to restore service'
	String get restore_failed => 'Failed to restore service';

	/// en: 'Customer question added'
	String get question_added => 'Customer question added';
}

// Path: vendor_services.create_screen.dialog
class TranslationsVendorServicesCreateScreenDialogEn {
	TranslationsVendorServicesCreateScreenDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Archive Service'
	String get archive_title => 'Archive Service';

	/// en: 'Are you sure you want to archive "{name}"? It will be hidden from customers.'
	String get archive_message => 'Are you sure you want to archive "{name}"? It will be hidden from customers.';

	/// en: 'Archive'
	String get archive_confirm => 'Archive';

	/// en: 'Add Customer Question'
	String get add_question_title => 'Add Customer Question';

	/// en: 'Label'
	String get label => 'Label';

	/// en: 'e.g., Vehicle Photo'
	String get label_hint => 'e.g., Vehicle Photo';

	/// en: 'Type'
	String get type => 'Type';

	/// en: 'Required'
	String get required => 'Required';

	/// en: 'Options (comma-separated)'
	String get options_label => 'Options (comma-separated)';

	/// en: 'e.g., comprehensive, third_party, theft_fire'
	String get options_hint => 'e.g., comprehensive, third_party, theft_fire';

	/// en: 'Min'
	String get min => 'Min';

	/// en: 'Max'
	String get max => 'Max';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Add'
	String get add => 'Add';
}

// Path: vendor_services.create_screen.error
class TranslationsVendorServicesCreateScreenErrorEn {
	TranslationsVendorServicesCreateScreenErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No service category available. Please contact support.'
	String get no_category => 'No service category available. Please contact support.';

	/// en: 'Failed to load category schema'
	String get load_category => 'Failed to load category schema';
}

// Path: vendor_services.select_category.empty
class TranslationsVendorServicesSelectCategoryEmptyEn {
	TranslationsVendorServicesSelectCategoryEmptyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No Categories Available'
	String get title => 'No Categories Available';

	/// en: 'Service categories have not been configured yet. Please contact support.'
	String get subtitle => 'Service categories have not been configured yet. Please contact support.';
}

// Path: vendor_services.select_category.search_empty
class TranslationsVendorServicesSelectCategorySearchEmptyEn {
	TranslationsVendorServicesSelectCategorySearchEmptyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No Categories Found'
	String get title => 'No Categories Found';

	/// en: 'Try a different search term.'
	String get subtitle => 'Try a different search term.';
}

// Path: vendor_services.select_category.error
class TranslationsVendorServicesSelectCategoryErrorEn {
	TranslationsVendorServicesSelectCategoryErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Failed to Load Categories'
	String get title => 'Failed to Load Categories';

	/// en: 'Something went wrong. Please try again.'
	String get subtitle => 'Something went wrong. Please try again.';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: vendor_services.service_card.tooltip
class TranslationsVendorServicesServiceCardTooltipEn {
	TranslationsVendorServicesServiceCardTooltipEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Archive'
	String get archive => 'Archive';
}

// Path: vendor_services.service_card.action
class TranslationsVendorServicesServiceCardActionEn {
	TranslationsVendorServicesServiceCardActionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Restore'
	String get restore => 'Restore';
}

// Path: vendor_services.category_section.dialog
class TranslationsVendorServicesCategorySectionDialogEn {
	TranslationsVendorServicesCategorySectionDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Archive Service'
	String get archive_title => 'Archive Service';

	/// en: 'Are you sure you want to archive "{name}"? It will be hidden from customers.'
	String get archive_message => 'Are you sure you want to archive "{name}"? It will be hidden from customers.';

	/// en: 'Archive'
	String get archive_confirm => 'Archive';

	/// en: 'Restore Service'
	String get restore_title => 'Restore Service';

	/// en: 'Restore "{name}"? It will be visible to customers again.'
	String get restore_message => 'Restore "{name}"? It will be visible to customers again.';

	/// en: 'Restore'
	String get restore_confirm => 'Restore';
}

// Path: vendor_services.category_section.snackbar
class TranslationsVendorServicesCategorySectionSnackbarEn {
	TranslationsVendorServicesCategorySectionSnackbarEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Service archived successfully'
	String get archive_success => 'Service archived successfully';

	/// en: 'Failed to archive service'
	String get archive_failed => 'Failed to archive service';

	/// en: 'Service restored successfully'
	String get restore_success => 'Service restored successfully';

	/// en: 'Failed to restore service'
	String get restore_failed => 'Failed to restore service';
}

// Path: home.customer.active_orders.empty
class TranslationsHomeCustomerActiveOrdersEmptyEn {
	TranslationsHomeCustomerActiveOrdersEmptyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No Active Orders'
	String get title => 'No Active Orders';

	/// en: 'Your active orders will appear here'
	String get description => 'Your active orders will appear here';
}

// Path: home.customer.active_orders.order
class TranslationsHomeCustomerActiveOrdersOrderEn {
	TranslationsHomeCustomerActiveOrdersOrderEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Active Orders'
	String get title => 'Active Orders';

	/// en: 'more orders'
	String get more_orders => 'more orders';

	/// en: 'View All Orders'
	String get view_all => 'View All Orders';

	late final TranslationsHomeCustomerActiveOrdersOrderOrderCardEn order_card = TranslationsHomeCustomerActiveOrdersOrderOrderCardEn._(_root);
}

// Path: home.customer.services_grid.error
class TranslationsHomeCustomerServicesGridErrorEn {
	TranslationsHomeCustomerServicesGridErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Failed to load services'
	String get title => 'Failed to load services';

	/// en: 'Retry'
	String get retry => 'Retry';
}

// Path: home.customer.services_grid.empty
class TranslationsHomeCustomerServicesGridEmptyEn {
	TranslationsHomeCustomerServicesGridEmptyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No services available'
	String get title => 'No services available';

	/// en: 'Refresh'
	String get refresh => 'Refresh';
}

// Path: home.vendor.stats.stats_card
class TranslationsHomeVendorStatsStatsCardEn {
	TranslationsHomeVendorStatsStatsCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Statistics'
	String get title => 'Statistics';

	/// en: 'Earnings'
	String get earnings => 'Earnings';

	/// en: 'Orders'
	String get orders => 'Orders';

	/// en: 'Rating'
	String get rating => 'Rating';

	/// en: 'Sales'
	String get sales => 'Sales';
}

// Path: home.vendor.availability_capacity.availability
class TranslationsHomeVendorAvailabilityCapacityAvailabilityEn {
	TranslationsHomeVendorAvailabilityCapacityAvailabilityEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Accepting New Orders'
	String get title => 'Accepting New Orders';

	/// en: 'Available'
	String get available => 'Available';

	/// en: 'Not Available'
	String get not_available => 'Not Available';
}

// Path: home.vendor.availability_capacity.status
class TranslationsHomeVendorAvailabilityCapacityStatusEn {
	TranslationsHomeVendorAvailabilityCapacityStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Vendor Status'
	String get title => 'Vendor Status';

	/// en: 'Open'
	String get open => 'Open';

	/// en: 'Busy'
	String get busy => 'Busy';
}

// Path: home.vendor.availability_capacity.capacity
class TranslationsHomeVendorAvailabilityCapacityCapacityEn {
	TranslationsHomeVendorAvailabilityCapacityCapacityEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Order Capacity'
	String get title => 'Order Capacity';

	/// en: 'Max concurrent orders'
	String get description => 'Max concurrent orders';
}

// Path: home.vendor.checkout_orders.timeline
class TranslationsHomeVendorCheckoutOrdersTimelineEn {
	TranslationsHomeVendorCheckoutOrdersTimelineEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Pending'
	String get pending => 'Pending';

	/// en: 'Received'
	String get pending_sublabel => 'Received';

	/// en: 'Processing'
	String get processing => 'Processing';

	/// en: 'Preparing'
	String get processing_sublabel => 'Preparing';

	/// en: 'Shipped'
	String get shipped => 'Shipped';

	/// en: 'En Route'
	String get shipped_sublabel => 'En Route';

	/// en: 'Delivered'
	String get delivered => 'Delivered';

	/// en: 'Done'
	String get delivered_sublabel => 'Done';
}

// Path: home.vendor.checkout_orders.status
class TranslationsHomeVendorCheckoutOrdersStatusEn {
	TranslationsHomeVendorCheckoutOrdersStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Pending'
	String get pending => 'Pending';

	/// en: 'Processing'
	String get processing => 'Processing';

	/// en: 'Confirmed'
	String get confirmed => 'Confirmed';

	/// en: 'Shipped'
	String get shipped => 'Shipped';

	/// en: 'Delivered'
	String get delivered => 'Delivered';

	/// en: 'Cancelled'
	String get cancelled => 'Cancelled';
}

// Path: user_dashboard.listing_details.specifications.labels
class TranslationsUserDashboardListingDetailsSpecificationsLabelsEn {
	TranslationsUserDashboardListingDetailsSpecificationsLabelsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Make'
	String get make => 'Make';

	/// en: 'Model'
	String get model => 'Model';

	/// en: 'Trim'
	String get trim => 'Trim';

	/// en: 'Year'
	String get year => 'Year';

	/// en: 'Mileage'
	String get mileage => 'Mileage';

	/// en: 'Transmission'
	String get transmission => 'Transmission';

	/// en: 'Engine'
	String get engine => 'Engine';

	/// en: 'Color'
	String get color => 'Color';
}

// Path: user_dashboard.settings.account_info.fields
class TranslationsUserDashboardSettingsAccountInfoFieldsEn {
	TranslationsUserDashboardSettingsAccountInfoFieldsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'First Name'
	String get first_name => 'First Name';

	/// en: 'Last Name'
	String get last_name => 'Last Name';

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'Date of birth'
	String get date_of_birth => 'Date of birth';

	/// en: 'Phone Number'
	String get phone_number => 'Phone Number';
}

// Path: user_dashboard.settings.account_info.gender
class TranslationsUserDashboardSettingsAccountInfoGenderEn {
	TranslationsUserDashboardSettingsAccountInfoGenderEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Gender'
	String get title => 'Gender';

	/// en: 'Male'
	String get male => 'Male';

	/// en: 'Female'
	String get female => 'Female';
}

// Path: user_dashboard.settings.account_info.preferences
class TranslationsUserDashboardSettingsAccountInfoPreferencesEn {
	TranslationsUserDashboardSettingsAccountInfoPreferencesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Yes, I want to receive offers and discounts'
	String get receive_offers => 'Yes, I want to receive offers and discounts';

	/// en: 'Subscribe to Newsletter'
	String get newsletter => 'Subscribe to Newsletter';
}

// Path: user_dashboard.settings.change_password.fields
class TranslationsUserDashboardSettingsChangePasswordFieldsEn {
	TranslationsUserDashboardSettingsChangePasswordFieldsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Current Password'
	String get current_password => 'Current Password';

	/// en: 'New Password'
	String get new_password => 'New Password';

	/// en: 'Confirm New Password'
	String get confirm_password => 'Confirm New Password';
}

// Path: user_dashboard.settings.change_password.validation
class TranslationsUserDashboardSettingsChangePasswordValidationEn {
	TranslationsUserDashboardSettingsChangePasswordValidationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Current password is required'
	String get current_required => 'Current password is required';

	/// en: 'Password must be at least 8 characters'
	String get min_length => 'Password must be at least 8 characters';

	/// en: 'Passwords do not match'
	String get match => 'Passwords do not match';
}

// Path: user_dashboard.settings.verify_email_otp.resend
class TranslationsUserDashboardSettingsVerifyEmailOtpResendEn {
	TranslationsUserDashboardSettingsVerifyEmailOtpResendEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Didn't Receive Code? '
	String get did_not_receive => 'Didn\'t Receive Code? ';

	/// en: 'Resend in {time}'
	String get resend_in => 'Resend in {time}';

	/// en: 'Resend'
	String get resend_button => 'Resend';
}

// Path: user_dashboard.settings.edit_address.delete_dialog
class TranslationsUserDashboardSettingsEditAddressDeleteDialogEn {
	TranslationsUserDashboardSettingsEditAddressDeleteDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Delete Address'
	String get title => 'Delete Address';

	/// en: 'Are you sure you want to delete this address?'
	String get description => 'Are you sure you want to delete this address?';

	/// en: 'YES'
	String get yes => 'YES';

	/// en: 'no'
	String get no => 'no';
}

// Path: user_dashboard.settings.edit_address.validation
class TranslationsUserDashboardSettingsEditAddressValidationEn {
	TranslationsUserDashboardSettingsEditAddressValidationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Please fill required fields'
	String get required_fields => 'Please fill required fields';
}

// Path: user_dashboard.settings.edit_address.area
class TranslationsUserDashboardSettingsEditAddressAreaEn {
	TranslationsUserDashboardSettingsEditAddressAreaEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Area'
	String get label => 'Area';

	/// en: 'Tap Change to set area'
	String get hint => 'Tap Change to set area';

	/// en: 'Change'
	String get change_button => 'Change';

	/// en: 'Area'
	String get dialog_title => 'Area';

	/// en: 'Enter area'
	String get dialog_hint => 'Enter area';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'OK'
	String get ok => 'OK';
}

// Path: user_dashboard.settings.edit_address.property_types
class TranslationsUserDashboardSettingsEditAddressPropertyTypesEn {
	TranslationsUserDashboardSettingsEditAddressPropertyTypesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Apartment'
	String get apartment => 'Apartment';

	/// en: 'House'
	String get house => 'House';

	/// en: 'Office'
	String get office => 'Office';
}

// Path: user_dashboard.settings.edit_address.fields
class TranslationsUserDashboardSettingsEditAddressFieldsEn {
	TranslationsUserDashboardSettingsEditAddressFieldsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Address Title'
	String get address_title => 'Address Title';

	/// en: 'Building Name'
	String get building_name => 'Building Name';

	/// en: 'Apt. Number'
	String get apt_number => 'Apt. Number';

	/// en: 'Street'
	String get street => 'Street';

	/// en: 'Block'
	String get block => 'Block';

	/// en: 'Avenue (optional)'
	String get avenue_optional => 'Avenue (optional)';

	/// en: 'Additional Directions (optional)'
	String get directions_optional => 'Additional Directions (optional)';

	/// en: 'Phone Number'
	String get phone_number => 'Phone Number';

	/// en: 'Address Label (optional)'
	String get address_label_optional => 'Address Label (optional)';
}

// Path: vendor_services.create_screen.form.service_name
class TranslationsVendorServicesCreateScreenFormServiceNameEn {
	TranslationsVendorServicesCreateScreenFormServiceNameEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Service Name'
	String get label => 'Service Name';

	/// en: 'e.g., Premium Car Wash'
	String get hint => 'e.g., Premium Car Wash';

	/// en: '{field} is required'
	String get required => '{field} is required';
}

// Path: vendor_services.create_screen.form.description
class TranslationsVendorServicesCreateScreenFormDescriptionEn {
	TranslationsVendorServicesCreateScreenFormDescriptionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Description (Optional)'
	String get label => 'Description (Optional)';

	/// en: 'Describe your service'
	String get hint => 'Describe your service';
}

// Path: vendor_services.create_screen.form.base_price
class TranslationsVendorServicesCreateScreenFormBasePriceEn {
	TranslationsVendorServicesCreateScreenFormBasePriceEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Base Price (KWD)'
	String get label => 'Base Price (KWD)';

	/// en: '0.00'
	String get hint => '0.00';
}

// Path: vendor_services.create_screen.form.radius
class TranslationsVendorServicesCreateScreenFormRadiusEn {
	TranslationsVendorServicesCreateScreenFormRadiusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Service Radius (km)'
	String get label => 'Service Radius (km)';

	/// en: '20'
	String get hint => '20';
}

// Path: home.customer.active_orders.order.order_card
class TranslationsHomeCustomerActiveOrdersOrderOrderCardEn {
	TranslationsHomeCustomerActiveOrdersOrderOrderCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Service'
	String get service => 'Service';

	/// en: 'Scheduled'
	String get scheduled => 'Scheduled';

	/// en: 'ASAP'
	String get asap => 'ASAP';

	late final TranslationsHomeCustomerActiveOrdersOrderOrderCardStatusEn status = TranslationsHomeCustomerActiveOrdersOrderOrderCardStatusEn._(_root);
}

// Path: home.customer.active_orders.order.order_card.status
class TranslationsHomeCustomerActiveOrdersOrderOrderCardStatusEn {
	TranslationsHomeCustomerActiveOrdersOrderOrderCardStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Pending'
	String get pending => 'Pending';

	/// en: 'Accepted'
	String get accepted => 'Accepted';

	/// en: 'En Route'
	String get en_route => 'En Route';

	/// en: 'Arrived'
	String get arrived => 'Arrived';

	/// en: 'Active'
	String get active => 'Active';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'general.app_name' => 'Motiva App',
			'auth.login.title' => 'Login',
			'auth.login.loading' => 'Logging in...',
			'auth.login.do_not_have_account' => 'Do not have an account? ',
			'auth.login.create_account' => 'Create Account',
			'auth.register_as.title' => 'Register As',
			'auth.register_as.select_user_type' => 'Select User Type',
			'auth.register_as.business_owner' => 'Business Owner',
			'auth.register_as.customer' => 'Customer',
			'auth.register_as.driver' => 'Driver',
			'auth.register_vendor.business_name' => 'Business Name',
			'auth.register_vendor.business_email' => 'Business Email',
			'auth.register_vendor.representative_name' => 'Representative Name',
			'auth.register_vendor.commercial_license' => 'Commercial License No (Optional)',
			'auth.register_customer.name' => 'Name',
			'auth.register_customer.email' => 'Email',
			'auth.register_customer.country' => 'Country',
			'auth.register_customer.kuwait' => 'Kuwait',
			'auth.register_customer.saudi_arabia' => 'Saudi Arabia',
			'auth.register_customer.uae' => 'UAE',
			'auth.register_customer.city' => 'City',
			'auth.register_customer.kuwait_city' => 'Kuwait City',
			'auth.register_customer.al_jahra' => 'Al Jahra',
			'auth.register_customer.hawalli' => 'Hawalli',
			'auth.verify.title' => 'VERIFY PHONE\n NUMBER',
			'auth.verify.description' => 'We\'ve Sent Code To',
			'auth.verify.loading' => 'VERIFYING...',
			'auth.verify.button' => 'VERIFY',
			'auth.verify.resend' => 'Resend',
			'auth.verify.resend_in' => 'Resend in',
			'auth.verify.did_not_receive_code' => 'Didn\'t Receive Code? ',
			'auth.category.title' => 'Choose Category',
			'auth.category.select_category' => 'Select Category',
			'auth.category.loading' => 'REGISTERING...',
			'auth.category.error.null_category' => 'Please select a category',
			'auth.category.error.no_categories' => 'No categories available',
			'auth.category.error.failed_to_load' => 'Failed to load categories',
			'auth.category.error.button' => 'Retry',
			'auth.category.error.registration_failed' => 'Registration failed. Please try again.',
			'auth.category.registration_success' => 'Registration submitted! Your account requires admin approval before you can login.',
			'auth.splash.vendor.title' => 'Verifying profile...',
			'auth.splash.vendor.login_error' => 'Vendor profile verification failed',
			'auth.splash.vendor.logout_error' => 'Your vendor profile is incomplete or was not found.\nPlease contact support or complete your registration to continue.',
			'auth.splash.error.splash_failed' => 'Auth error in splash',
			'auth.splash.error.auth_failed' => 'Authentication failed. Please login again.',
			'auth.splash.initializing' => 'Initializing...',
			'auth.splash.loading' => 'Loading...',
			'auth.splash.checking_auth' => 'Checking authentication...',
			'auth.phone_number' => 'Phone Number',
			'auth.password' => 'Password',
			'auth.confirm_password' => 'Confirm Password',
			'auth.continue_button' => 'CONTINUE',
			'auth.get_started' => 'GET STARTED',
			'auth.loading' => 'SENDING OTP...',
			'auth.already_have_account' => 'Already have an account? ',
			'auth.login_button' => 'Login',
			'booking.booking_screen.title' => 'Book Service',
			'booking.booking_screen.service_details' => 'Service Details',
			'booking.booking_screen.location.title' => 'Service Location',
			'booking.booking_screen.location.selected' => 'Selected',
			'booking.booking_screen.location.tap_to_select' => 'Tap to select',
			'booking.booking_screen.location.tap_to_select_location' => 'Tap to select location on map',
			'booking.booking_screen.location.pick' => 'pick',
			'booking.booking_screen.location.pick_location' => 'pick location',
			'booking.booking_screen.location.additional_details' => 'Additional address details (optional)',
			'booking.booking_screen.location.pickup' => 'Pickup Location',
			'booking.booking_screen.location.drop_off' => 'Drop off Location',
			'booking.booking_screen.location.location_selected' => 'Location Selected',
			'booking.booking_screen.location.success' => 'selected successfully',
			'booking.booking_screen.location.success_location' => 'Location selected successfully',
			'booking.booking_screen.location.null_location' => 'Please select your location',
			'booking.booking_screen.location.null_pickup' => 'Please select pickup location',
			'booking.booking_screen.location.null_drop_off' => 'Please select drop off location',
			'booking.booking_screen.scheduling.title' => 'Schedule',
			'booking.booking_screen.scheduling.date' => 'Choose Date',
			'booking.booking_screen.scheduling.jan' => 'Jan',
			'booking.booking_screen.scheduling.feb' => 'Feb',
			'booking.booking_screen.scheduling.mar' => 'Mar',
			'booking.booking_screen.scheduling.apr' => 'Apr',
			'booking.booking_screen.scheduling.may' => 'May',
			'booking.booking_screen.scheduling.jun' => 'Jun',
			'booking.booking_screen.scheduling.jul' => 'Jul',
			'booking.booking_screen.scheduling.aug' => 'Aug',
			'booking.booking_screen.scheduling.sep' => 'Sep',
			'booking.booking_screen.scheduling.oct' => 'Oct',
			'booking.booking_screen.scheduling.nov' => 'Nov',
			'booking.booking_screen.scheduling.dec' => 'Dec',
			'booking.booking_screen.scheduling.time' => 'Available Time',
			'booking.booking_screen.scheduling.clear' => 'Clear',
			'booking.booking_screen.scheduling.null_time' => 'No available time slots for this date. Please select another date.',
			'booking.booking_screen.scheduling.select_time' => 'Please select time slot',
			'booking.booking_screen.scheduling.error_time' => 'No Time Slot Available',
			'booking.booking_screen.scheduling.next_available' => 'Next available',
			'booking.booking_screen.scheduling.select_next_available' => 'Select This Day',
			'booking.booking_screen.order.title' => 'Order Summary',
			'booking.booking_screen.order.base_amount' => 'Base Amount',
			'booking.booking_screen.order.description' => 'Final amount will be confirmed by vendor',
			'booking.booking_screen.button.title' => 'Confirm Booking',
			'booking.booking_screen.button.error_location' => 'Please select your location to continue',
			'booking.booking_screen.button.error_pickup' => 'Please select pickup location',
			'booking.booking_screen.button.error_drop_off' => 'Please select drop off location',
			'booking.order_confirmation.title' => 'Booking Submitted!',
			'booking.order_confirmation.order' => 'Order:',
			'booking.order_confirmation.status.title' => 'Booking Confirmed',
			'booking.order_confirmation.status.description' => 'Your booking has been auto-accepted and confirmed successfully.',
			'booking.order_confirmation.info.service' => 'Service',
			'booking.order_confirmation.info.vendor' => 'Vendor',
			'booking.order_confirmation.info.base_amount' => 'Base Amount',
			'booking.order_confirmation.info.scheduled' => 'Scheduled',
			'booking.order_confirmation.info.location' => 'Location',
			'booking.order_confirmation.button.primary' => 'Back to Home',
			'booking.order_confirmation.button.secondary' => 'Go to My Requests',
			'home.services_grid.spare_parts' => 'Spare Parts',
			'home.customer.search' => 'Search Products',
			'home.customer.active_orders.empty.title' => 'No Active Orders',
			'home.customer.active_orders.empty.description' => 'Your active orders will appear here',
			'home.customer.active_orders.order.title' => 'Active Orders',
			'home.customer.active_orders.order.more_orders' => 'more orders',
			'home.customer.active_orders.order.view_all' => 'View All Orders',
			'home.customer.active_orders.order.order_card.service' => 'Service',
			'home.customer.active_orders.order.order_card.scheduled' => 'Scheduled',
			'home.customer.active_orders.order.order_card.asap' => 'ASAP',
			'home.customer.active_orders.order.order_card.status.pending' => 'Pending',
			'home.customer.active_orders.order.order_card.status.accepted' => 'Accepted',
			'home.customer.active_orders.order.order_card.status.en_route' => 'En Route',
			'home.customer.active_orders.order.order_card.status.arrived' => 'Arrived',
			'home.customer.active_orders.order.order_card.status.active' => 'Active',
			'home.customer.premium_banner.title' => 'Upgrade to Premium\nfor Exclusive\nBenefits!',
			'home.customer.premium_banner.button' => 'Upgrade Now',
			'home.customer.ad_banner.title' => 'Road Assistance\n at 10% Off - Book Now!',
			'home.customer.services_grid.title' => 'Available Services',
			'home.customer.services_grid.view_all' => 'View All',
			'home.customer.services_grid.error_category' => 'Failed to load service categories',
			'home.customer.services_grid.error.title' => 'Failed to load services',
			'home.customer.services_grid.error.retry' => 'Retry',
			'home.customer.services_grid.empty.title' => 'No services available',
			'home.customer.services_grid.empty.refresh' => 'Refresh',
			'home.customer.buy_sell_card.buy' => 'Buy a Car',
			'home.customer.buy_sell_card.sell' => 'Sell Your Car',
			'home.customer.buy_sell_card.tap' => 'Tap here',
			'home.customer.promo_banner.title' => 'Save upTo KD 5',
			'home.customer.promo_banner.description' => 'Limited time offer on specific\nservices',
			'home.customer.listing.popular_today' => 'Popular Today',
			'home.customer.listing.top_vendors' => 'Top Vendors',
			'home.customer.listing.new_vendors' => 'New Vendors',
			'home.vendor.services_grid.messages' => 'Messages',
			'home.vendor.services_grid.support' => 'Support',
			'home.vendor.services_grid.requests' => 'Requests',
			'home.vendor.services_grid.orders' => 'Orders',
			'home.vendor.services_grid.add_services' => 'Add Services',
			'home.vendor.services_grid.current_services' => 'Current Services',
			'home.vendor.stats.today' => 'Today',
			'home.vendor.stats.weekly' => 'Weekly',
			'home.vendor.stats.monthly' => 'Monthly',
			'home.vendor.stats.this_weekly' => 'This Week',
			'home.vendor.stats.this_monthly' => 'This Month',
			'home.vendor.stats.stats_card.title' => 'Statistics',
			'home.vendor.stats.stats_card.earnings' => 'Earnings',
			'home.vendor.stats.stats_card.orders' => 'Orders',
			'home.vendor.stats.stats_card.rating' => 'Rating',
			'home.vendor.stats.stats_card.sales' => 'Sales',
			'home.vendor.completed_jobs' => 'Completed Jobs',
			'home.vendor.availability_capacity.title' => 'Availability & Capacity',
			'home.vendor.availability_capacity.availability.title' => 'Accepting New Orders',
			'home.vendor.availability_capacity.availability.available' => 'Available',
			'home.vendor.availability_capacity.availability.not_available' => 'Not Available',
			'home.vendor.availability_capacity.status.title' => 'Vendor Status',
			'home.vendor.availability_capacity.status.open' => 'Open',
			'home.vendor.availability_capacity.status.busy' => 'Busy',
			'home.vendor.availability_capacity.capacity.title' => 'Order Capacity',
			'home.vendor.availability_capacity.capacity.description' => 'Max concurrent orders',
			'home.vendor.active_orders.title' => 'Active Orders',
			'home.vendor.active_orders.all' => 'All',
			'home.vendor.active_orders.en_route' => 'En Route',
			'home.vendor.active_orders.arrived' => 'Arrived',
			'home.vendor.active_orders.in_progress' => 'In Progress',
			'home.vendor.active_orders.empty' => 'No orders',
			'home.vendor.active_orders.service' => 'Service',
			'home.vendor.active_orders.customer' => 'Customer',
			'home.vendor.active_orders.asap' => 'ASAP',
			'home.vendor.checkout_orders.title' => 'Product Orders',
			'home.vendor.checkout_orders.all' => 'All',
			'home.vendor.checkout_orders.pending' => 'Pending',
			'home.vendor.checkout_orders.processing' => 'Processing',
			'home.vendor.checkout_orders.confirmed' => 'Confirmed',
			'home.vendor.checkout_orders.shipped' => 'Shipped',
			'home.vendor.checkout_orders.empty' => 'No product orders',
			'home.vendor.checkout_orders.order_number' => 'Order #',
			'home.vendor.checkout_orders.items_count' => 'items',
			'home.vendor.checkout_orders.item' => 'item',
			'home.vendor.checkout_orders.payment_method' => 'Payment: COD',
			'home.vendor.checkout_orders.cancel' => 'Cancel',
			'home.vendor.checkout_orders.ship' => 'Mark Shipped',
			'home.vendor.checkout_orders.deliver' => 'Mark Delivered',
			'home.vendor.checkout_orders.product_order' => 'Product Order',
			'home.vendor.checkout_orders.placed' => 'Placed',
			'home.vendor.checkout_orders.total' => 'Total',
			'home.vendor.checkout_orders.status_timeline' => 'Status Timeline',
			'home.vendor.checkout_orders.timeline.pending' => 'Pending',
			'home.vendor.checkout_orders.timeline.pending_sublabel' => 'Received',
			'home.vendor.checkout_orders.timeline.processing' => 'Processing',
			'home.vendor.checkout_orders.timeline.processing_sublabel' => 'Preparing',
			'home.vendor.checkout_orders.timeline.shipped' => 'Shipped',
			'home.vendor.checkout_orders.timeline.shipped_sublabel' => 'En Route',
			'home.vendor.checkout_orders.timeline.delivered' => 'Delivered',
			'home.vendor.checkout_orders.timeline.delivered_sublabel' => 'Done',
			'home.vendor.checkout_orders.status.pending' => 'Pending',
			'home.vendor.checkout_orders.status.processing' => 'Processing',
			'home.vendor.checkout_orders.status.confirmed' => 'Confirmed',
			'home.vendor.checkout_orders.status.shipped' => 'Shipped',
			'home.vendor.checkout_orders.status.delivered' => 'Delivered',
			'home.vendor.checkout_orders.status.cancelled' => 'Cancelled',
			'home.vendor.checkout_orders.customer' => 'Customer',
			'home.vendor.checkout_orders.order_items' => 'Order Items',
			'home.vendor.checkout_orders.delivery' => 'Delivery',
			'home.vendor.checkout_orders.delivery_address' => 'Delivery Address',
			'home.vendor.checkout_orders.no_address_provided' => 'No address provided',
			'home.vendor.checkout_orders.payment' => 'Payment',
			'home.vendor.checkout_orders.payment_status' => 'Status',
			'home.vendor.checkout_orders.payment_paid' => 'Paid',
			'home.vendor.checkout_orders.payment_pending' => 'Pending',
			'home.vendor.checkout_orders.order_info' => 'Order Info',
			'home.vendor.checkout_orders.order_id' => 'Order ID',
			'home.vendor.checkout_orders.placed_on' => 'Placed on',
			'home.vendor.checkout_orders.last_updated' => 'Last updated',
			'home.vendor.checkout_orders.est_delivery' => 'Est. delivery',
			'home.vendor.checkout_orders.cancellation' => 'Cancellation',
			'home.vendor.checkout_orders.cancellation_reason' => 'Cancellation Reason',
			'home.vendor.checkout_orders.no_reason_provided' => 'No reason provided',
			'home.vendor.checkout_orders.loading_order' => 'Loading order...',
			'home.vendor.checkout_orders.failed_to_load' => 'Failed to Load',
			'home.vendor.checkout_orders.try_again' => 'Try Again',
			'home.vendor.checkout_orders.mark_shipped' => 'Mark Shipped',
			'home.vendor.checkout_orders.mark_delivered' => 'Delivered',
			'home.vendor.checkout_orders.order_shipped_success' => 'Order shipped!',
			'home.vendor.checkout_orders.order_delivered_success' => 'Order delivered!',
			'home.vendor.checkout_orders.failed' => 'Failed',
			'home.vendor.checkout_orders.not_specified' => 'Not specified',
			'home.vendor.checkout_orders.cash_on_delivery' => 'Cash on Delivery',
			'home.vendor.checkout_orders.credit_debit_card' => 'Credit/Debit Card',
			'home.vendor.empty' => 'Profile not found',
			'home.vendor.error' => 'Error loading data',
			'home.operator.incoming_requests' => 'Incoming Requests',
			'home.operator.accepted_requests' => 'Accepted Requests',
			'home.operator.rides_history' => 'Rides History',
			'cart.title' => 'CART',
			'cart.error_loading' => 'Failed to load cart:',
			'cart.empty.title' => 'Your cart is empty',
			'cart.empty.subtitle' => 'Browse our services and book your next appointment',
			'cart.empty.browse_button' => 'Browse Services',
			'cart.delivering_from' => 'Delivering from',
			'cart.all_items' => 'All Items',
			'cart.special_request' => 'Special Request',
			'cart.special_request_hint' => 'Write any special request about the order.',
			'cart.price' => 'Price',
			'cart.items' => 'items',
			'cart.promo_code' => 'Promo Code',
			'cart.total_amount' => 'Total Amount',
			'cart.you_saved' => 'You saved',
			'cart.order' => 'on this order',
			'cart.checkout_button' => 'CHECKOUT',
			'cart.vendor_subtitle' => 'We are ready to serve you anytime',
			'checkout.title' => 'CHECKOUT',
			'checkout.order_summary' => 'Order Summary',
			'checkout.subtotal' => 'Subtotal',
			'checkout.delivery_fee' => 'Delivery Fee',
			'checkout.voucher_discount' => 'Voucher Discount',
			'checkout.wallet_used' => 'Wallet Used',
			'checkout.total' => 'Total',
			'checkout.delivery_address' => 'Delivery Address',
			'checkout.add_new_address' => 'Add New Address',
			'checkout.save_address' => 'Save Address',
			'checkout.voucher_code' => 'Voucher Code',
			'checkout.enter_voucher' => 'Enter voucher code',
			'checkout.apply' => 'Apply',
			'checkout.voucher_applied' => 'Voucher applied successfully!',
			'checkout.wallet_balance' => 'Wallet Balance',
			'checkout.payment_methods' => 'Payment Methods',
			'checkout.pay' => 'PAY',
			'checkout.processing' => 'PROCESSING...',
			'checkout.order_confirmed' => 'Order Confirmed!',
			'checkout.order_placed' => 'Your order has been placed successfully.',
			'checkout.total_payment' => 'Total Payment',
			'checkout.order_number' => 'Order #',
			'checkout.payment_time' => 'Payment Time',
			'checkout.payment_method' => 'Payment Method',
			'checkout.items' => 'Items',
			'checkout.estimated_delivery' => 'Estimated Delivery',
			'checkout.track_order' => 'Track Order',
			'checkout.back_home' => 'BACK HOME',
			'checkout.continue_shopping' => 'Continue shopping',
			'checkout.motiva_wallet' => 'Motiva Wallet',
			'checkout.balance' => 'Balance:',
			'checkout.fill_required_fields' => 'Please fill required fields',
			'checkout.address_label_hint' => 'Label (e.g. Home, Work)',
			'checkout.street' => 'Street *',
			'checkout.area' => 'Area *',
			'checkout.block' => 'Block *',
			'checkout.building' => 'Building',
			'checkout.floor' => 'Floor',
			'checkout.apartment' => 'Apartment',
			'checkout.notes' => 'Notes',
			'checkout.default_address_label' => 'Address',
			'checkout.block_label' => 'Block',
			'checkout.building_label' => 'Building',
			'checkout.floor_label' => 'Floor',
			'checkout.apartment_label' => 'Apt',
			'public_services.category_vendors.description' => 'Find the best services',
			'public_services.category_vendors.search' => 'Search Vendors',
			'public_services.category_vendors.all_vendors' => 'All Vendors',
			'public_services.category_vendors.error_vendor' => 'Failed to load vendors',
			'public_services.category_vendors.null_vendor' => 'No vendors found',
			'public_services.category_vendors.vendor_card.sub_title' => 'services available',
			'public_services.category_vendors.vendor_card.badge_title' => 'verified',
			'public_services.vendor_services.services' => 'Services',
			'public_services.vendor_services.reviews' => 'Reviews',
			'public_services.vendor_services.most_popular' => 'Most Popular',
			'public_services.vendor_services.search' => 'Search Service',
			'public_services.vendor_services.error_service' => 'Failed to load services',
			'public_services.vendor_services.null_service' => 'No services found',
			'public_services.vendor_services.all_services' => 'All Services',
			'public_services.vendor_services.service_card.description' => 'Professional Service',
			'public_services.vendor_services.service_card.button' => 'View Details',
			'public_services.services_details.title' => 'About this services',
			'public_services.services_details.min' => 'min',
			'public_services.services_details.description.title' => 'Description',
			'public_services.services_details.description.dec' => 'Professional Service From',
			'public_services.services_details.service_details' => 'Service Details',
			'public_services.services_details.provider' => 'Service Provider',
			'public_services.services_details.services' => 'Services',
			'public_services.services_details.reviews' => 'Reviews',
			'public_services.services_details.working_hours.title' => 'Working Hours',
			'public_services.services_details.working_hours.closed' => 'Closed',
			'public_services.services_details.working_hours.open' => 'Open',
			'public_services.services_details.days.Monday' => 'Monday',
			'public_services.services_details.days.Tuesday' => 'Tuesday',
			'public_services.services_details.days.Wednesday' => 'Wednesday',
			'public_services.services_details.days.Thursday' => 'Thursday',
			'public_services.services_details.days.Friday' => 'Friday',
			'public_services.services_details.days.Saturday' => 'Saturday',
			'public_services.services_details.days.Sunday' => 'Sunday',
			'public_services.services_details.button.title' => 'REQUEST NOW',
			'public_services.services_details.button.null_service' => 'Loading service details...',
			'public_services.services_details.button.error_service' => 'This service requires a quotation. Please contact the vendor directly.',
			'public_marketplace.category_screen.title_accessories' => 'Accessories',
			'public_marketplace.category_screen.title_spare_parts' => 'Spare Parts',
			'public_marketplace.category_screen.subtitle' => 'Find the best services',
			'public_marketplace.category_screen.search_hint' => 'Search Vendor',
			'public_marketplace.category_screen.all_supplies' => 'All Supplies',
			'public_marketplace.category_screen.no_vendors_match_search' => 'No vendors match your search',
			'public_marketplace.category_screen.no_vendors_found' => 'No vendors found',
			'public_marketplace.category_screen.label_accessories' => 'accessories',
			'public_marketplace.category_screen.label_spare_parts' => 'spare parts',
			'public_marketplace.category_screen.verified' => 'Verified',
			'public_marketplace.category_screen.error_loading' => 'Failed to load vendors',
			'public_marketplace.details_screen.app_bar_title' => 'About This Service',
			'public_marketplace.details_screen.product_not_found' => 'Product not found',
			'public_marketplace.details_screen.description' => 'Description',
			'public_marketplace.details_screen.no_description' => 'No description available.',
			'public_marketplace.details_screen.quantity' => 'Quantity',
			'public_marketplace.details_screen.added_to_cart' => 'added to cart',
			'public_marketplace.details_screen.add_to_cart_button' => 'ADD TO CART',
			'public_marketplace.details_screen.reviews' => 'Reviews',
			'public_marketplace.details_screen.load_more_reviews' => 'Load More Reviews',
			'public_marketplace.details_screen.similar_products' => 'Similar Products',
			'public_marketplace.details_screen.months_ago' => 'Months Ago',
			'public_marketplace.vendor_details_screen.search_hint' => 'Search Service',
			'public_marketplace.vendor_details_screen.most_popular' => 'Most Popular',
			'public_marketplace.vendor_details_screen.all_services' => 'All Services',
			'public_marketplace.vendor_details_screen.reviews' => 'Reviews',
			'public_marketplace.vendor_details_screen.no_services_found' => 'No services found',
			'public_marketplace.vendor_details_screen.professional_service' => 'Professional service',
			'public_marketplace.vendor_details_screen.add_to_cart' => 'Add to Cart',
			'public_marketplace.vendor_details_screen.services' => 'services',
			'public_marketplace.vendor_details_screen.reviews_label' => 'reviews',
			'public_marketplace.spare_parts.title' => 'Spare Parts',
			'public_marketplace.spare_parts.details_screen.specifications' => 'Specifications',
			'public_marketplace.spare_parts.details_screen.brand' => 'Brand',
			'public_marketplace.spare_parts.details_screen.part_number' => 'Part Number',
			'public_marketplace.spare_parts.details_screen.warranty' => 'Warranty',
			'public_marketplace.spare_parts.details_screen.warranty_months_suffix' => '{months} mo warranty',
			'public_marketplace.spare_parts.details_screen.compatibility' => 'Compatibility',
			'public_marketplace.spare_parts.details_screen.compatibility_empty' => 'No compatibility info',
			'public_marketplace.spare_parts.details_screen.no_value' => '—',
			'public_marketplace.spare_parts.category_screen.title' => 'Spare Parts',
			'public_marketplace.spare_parts.category_screen.filter_button_tooltip' => 'Filter spare parts',
			'public_marketplace.spare_parts.category_screen.chip_make' => 'Make: {value}',
			'public_marketplace.spare_parts.category_screen.chip_model' => 'Model: {value}',
			'public_marketplace.spare_parts.category_screen.chip_year_from' => 'Year {value}+',
			'public_marketplace.spare_parts.category_screen.chip_year_to' => 'to {value}',
			'public_marketplace.spare_parts.category_screen.chip_brand' => 'Brand: {value}',
			'public_marketplace.spare_parts.category_screen.chip_min_price' => 'Min: {value}',
			'public_marketplace.spare_parts.category_screen.chip_max_price' => 'Max: {value}',
			'public_marketplace.spare_parts.category_screen.chip_clear_all' => 'Clear all',
			'public_marketplace.spare_parts.filter_sheet.title' => 'Filter Spare Parts',
			'public_marketplace.spare_parts.filter_sheet.make_label' => 'Make',
			'public_marketplace.spare_parts.filter_sheet.model_label' => 'Model',
			'public_marketplace.spare_parts.filter_sheet.year_from_label' => 'Year from',
			'public_marketplace.spare_parts.filter_sheet.year_to_label' => 'Year to',
			'public_marketplace.spare_parts.filter_sheet.brand_label' => 'Brand',
			'public_marketplace.spare_parts.filter_sheet.min_price_label' => 'Min price (KWD)',
			'public_marketplace.spare_parts.filter_sheet.max_price_label' => 'Max price (KWD)',
			'public_marketplace.spare_parts.filter_sheet.apply' => 'Apply',
			'public_marketplace.spare_parts.filter_sheet.reset' => 'Reset',
			'public_marketplace.spare_parts.filter_sheet.cancel' => 'Cancel',
			'services.screen.title' => 'All Services',
			'services.screen.search_hint' => 'Search Services',
			'services.all_services_grid.error.title' => 'Failed to load services',
			'services.all_services_grid.error.retry' => 'Retry',
			'services.all_services_grid.empty.title' => 'No services found for your search',
			'services.all_services_grid.static.buy_a_car' => 'Buy a Car',
			'services.all_services_grid.static.sell_your_car' => 'Sell your Car',
			'services.all_services_grid.static.car_accessories' => 'Car Accessories',
			'services.all_services_grid.static.spare_parts' => 'Spare Parts',
			'buy_a_car.screen.title' => 'BUY A CARS',
			'buy_a_car.screen.subtitle' => 'We have offers waiting for you',
			'buy_a_car.service_section.good_condition_cars' => 'Good Condition Cars',
			'buy_a_car.service_section.damaged_cars' => 'Damaged Cars',
			'buy_a_car.service_section.approved_cars' => 'Approved Cars',
			'buy_a_car.service_section.good_condition_description' => 'Browse through our wide selection of cars in great condition.',
			'buy_a_car.service_section.damaged_cars_description' => 'Find damaged cars for spare parts or repair projects.',
			'buy_a_car.service_section.approved_cars_description' => 'Shop certified and approved cars with full inspection reports.',
			'buy_a_car.good_condition_screen.title' => 'Explore Cars',
			'buy_a_car.good_condition_screen.search_hint' => 'Search cars by make, model...',
			'buy_a_car.good_condition_screen.all_cars' => 'All Cars',
			'buy_a_car.good_condition_screen.no_cars_found' => 'No cars found matching',
			'buy_a_car.good_condition_screen.no_cars_available' => 'No cars available',
			'buy_a_car.good_condition_screen.failed_to_load' => 'Failed to load cars',
			'buy_a_car.good_condition_screen.retry' => 'Retry',
			'buy_a_car.approved_cars_screen.title' => 'Approved Cars',
			'buy_a_car.approved_cars_screen.search_hint' => 'Search approved cars...',
			'buy_a_car.approved_cars_screen.all_approved_cars' => 'All Approved Cars',
			'buy_a_car.approved_cars_screen.no_cars_found' => 'No cars found matching',
			'buy_a_car.approved_cars_screen.no_approved_cars_available' => 'No approved cars available',
			'buy_a_car.approved_cars_screen.failed_to_load' => 'Failed to load cars',
			'buy_a_car.approved_cars_screen.retry' => 'Retry',
			'buy_a_car.damaged_cars_screen.title' => 'Damaged Cars',
			'buy_a_car.damaged_cars_screen.search_hint' => 'Search damaged cars...',
			'buy_a_car.damaged_cars_screen.all_damaged_cars' => 'All Damaged Cars',
			'buy_a_car.damaged_cars_screen.no_cars_found' => 'No cars found matching',
			'buy_a_car.damaged_cars_screen.no_damaged_cars_available' => 'No damaged cars available',
			'buy_a_car.damaged_cars_screen.failed_to_load' => 'Failed to load cars',
			'buy_a_car.damaged_cars_screen.retry' => 'Retry',
			'buy_a_car.details_screen.about_this_car' => 'About This Car',
			'buy_a_car.details_screen.failed_to_load_listing' => 'Failed to load listing',
			'buy_a_car.details_screen.retry' => 'Retry',
			'buy_a_car.details_screen.price_on_request' => 'Price on Request',
			'buy_a_car.details_screen.car_details' => 'Car Details',
			'buy_a_car.details_screen.location_not_specified' => 'Location not specified',
			'buy_a_car.details_screen.featured' => 'Featured',
			'buy_a_car.details_screen.inspected' => 'Inspected',
			'buy_a_car.details_screen.view_details' => 'View Details',
			'buy_a_car.details_screen.inspection_report.title' => 'Inspection Report',
			'buy_a_car.details_screen.inspection_report.description' => 'Download and view the\n inspection report of this car.',
			'buy_a_car.details_screen.inspection_report.view_report' => 'View Inspection Report',
			'buy_a_car.details_screen.specifications' => 'Specifications',
			'buy_a_car.details_screen.spec_labels.make' => 'Make',
			'buy_a_car.details_screen.spec_labels.model' => 'Model',
			'buy_a_car.details_screen.spec_labels.trim' => 'Trim',
			'buy_a_car.details_screen.spec_labels.year' => 'Year',
			'buy_a_car.details_screen.spec_labels.mileage' => 'Mileage',
			'buy_a_car.details_screen.spec_labels.transmission' => 'Transmission',
			'buy_a_car.details_screen.spec_labels.engine' => 'Engine',
			'buy_a_car.details_screen.spec_labels.color' => 'Color',
			'buy_a_car.details_screen.na' => 'N/A',
			'buy_a_car.details_screen.description' => 'Description',
			'buy_a_car.details_screen.no_description' => 'No description available.',
			'buy_a_car.details_screen.location' => 'Location',
			'buy_a_car.details_screen.call_now' => 'CALL NOW',
			'buy_a_car.details_screen.chat' => 'Chat',
			'buy_a_car.details_screen.condition.excellent' => 'Excellent',
			'buy_a_car.details_screen.condition.good' => 'Good',
			'buy_a_car.details_screen.condition.fair' => 'Fair',
			'buy_a_car.details_screen.condition.poor' => 'Poor',
			'buy_a_car.details_screen.condition.damaged' => 'Damaged',
			'buy_a_car.details_screen.error_open_report' => 'Could not open inspection report',
			'buy_a_car.car_chat.title' => 'Toyota land cruiser 300',
			'buy_a_car.car_chat.this_message_relates_to' => 'This message relates to:',
			'buy_a_car.car_chat.buy_a_car' => 'Buy a Car',
			'buy_a_car.car_chat.inspection_report_pdf' => 'InspectionReport.pdf',
			'buy_a_car.car_chat.size_kb' => '487 KB',
			'buy_a_car.car_chat.download' => 'Download',
			'buy_a_car.car_chat.inspection_report_message' => 'Please have a look at this inspection report.',
			'buy_a_car.car_chat.sender_initial' => 'R',
			'buy_a_car.car_chat.sender_name' => 'Prime Car care',
			'buy_a_car.car_chat.you' => 'You',
			'buy_a_car.car_chat.type_message' => 'Type a message',
			'buy_a_car.listing_card.featured' => 'Featured',
			'buy_a_car.listing_card.inspected' => 'Inspected',
			'buy_a_car.listing_card.not_inspected' => 'Not Inspected',
			'buy_a_car.filters.clear_all' => 'Clear All',
			'buy_a_car.filters.make' => 'Make',
			'buy_a_car.filters.model' => 'Model',
			'buy_a_car.filters.trim' => 'Trim',
			'buy_a_car.filters.year' => 'Year',
			'buy_a_car.filters.mileage' => 'Mileage',
			'buy_a_car.filters.transmission' => 'Transmission',
			'buy_a_car.filters.automatic' => 'Automatic',
			'buy_a_car.filters.manual' => 'Manual',
			'buy_a_car.filters.search_makes' => 'Search makes...',
			'buy_a_car.filters.no_makes_found' => 'No makes found',
			'buy_a_car.filters.failed_to_load_makes' => 'Failed to load makes',
			'buy_a_car.filters.select_make_first' => 'Please select a make first',
			'buy_a_car.filters.search_models' => 'Search models...',
			'buy_a_car.filters.no_models_found' => 'No models found',
			'buy_a_car.filters.failed_to_load_models' => 'Failed to load models',
			'buy_a_car.filters.select_model_first' => 'Please select a model first',
			'buy_a_car.filters.search_trims' => 'Search trims...',
			'buy_a_car.filters.no_trims_available' => 'No trims available',
			'buy_a_car.filters.no_trims_found' => 'No trims found',
			'buy_a_car.filters.failed_to_load_trims' => 'Failed to load trims',
			'buy_a_car.filters.from_year' => 'From Year',
			_ => null,
		} ?? switch (path) {
			'buy_a_car.filters.to_year' => 'To Year',
			'buy_a_car.filters.select_year' => 'Select year',
			'buy_a_car.filters.any' => 'Any',
			'buy_a_car.filters.failed_to_load_years' => 'Failed to load years',
			'buy_a_car.filters.mileage_any' => 'Any',
			'buy_a_car.filters.under_50k' => 'Under 50,000 km',
			'buy_a_car.filters.range_50k_100k' => '50,000 - 100,000 km',
			'buy_a_car.filters.range_100k_150k' => '100,000 - 150,000 km',
			'buy_a_car.filters.over_150k' => '150,000+ km',
			'reviews.screen_title' => 'Submit Review',
			'reviews.rate_service' => 'Rate Service',
			'reviews.your_review' => 'Your Review',
			'reviews.review_placeholder' => 'Share your experience with this service...',
			'reviews.character_count' => '/5000',
			'reviews.submit_review' => 'Submit Review',
			'reviews.submitting' => 'Submitting...',
			'reviews.success_message' => 'Review submitted successfully!',
			'reviews.error_already_reviewed' => 'You have already reviewed this order',
			'reviews.error_validation' => 'Please check your input and try again',
			'reviews.error_network' => 'Network error. Please try again',
			'reviews.display.title' => 'Reviews',
			'reviews.display.review' => 'Review',
			'reviews.display.filter_all' => 'All',
			'reviews.display.filter_5_stars' => '5★',
			'reviews.display.filter_4_stars' => '4★',
			'reviews.display.filter_3_stars' => '3★',
			'reviews.display.filter_2_stars' => '2★',
			'reviews.display.filter_1_star' => '1★',
			'reviews.display.sort_most_recent' => 'Most Recent',
			'reviews.display.sort_highest' => 'Highest',
			'reviews.display.sort_lowest' => 'Lowest',
			'reviews.display.verified_badge' => 'Verified',
			'reviews.display.empty_state_title' => 'No reviews yet',
			'reviews.display.empty_state_message' => 'Be the first to leave a review!',
			'reviews.display.load_more' => 'Load More',
			'user_dashboard.profile.greeting' => 'Hi {name}!',
			'user_dashboard.profile.guest' => 'Guest',
			'user_dashboard.profile.guest_initial' => 'G',
			'user_dashboard.profile.location' => 'Kuwait',
			'user_dashboard.menu.wallet' => 'Wallet',
			'user_dashboard.menu.orders' => 'Orders',
			'user_dashboard.menu.listings' => 'Listings',
			'user_dashboard.menu.loyalty_program' => 'Loyalty Program',
			'user_dashboard.wallet.screen_title' => 'Motiva Wallet',
			'user_dashboard.wallet.encrypted' => 'All data is encrypted',
			'user_dashboard.wallet.total' => 'Total (KWD):',
			'user_dashboard.wallet.use_now' => 'use it now',
			'user_dashboard.wallet.history' => 'History',
			'user_dashboard.wallet.use_reward_balance' => 'Use Reward Balance',
			'user_dashboard.wallet.coming_soon' => 'Coming Soon',
			'user_dashboard.wallet.coming_soon_message' => 'Wallet balance can be used for payments — coming soon!',
			'user_dashboard.wallet.no_transactions' => 'No transactions yet',
			'user_dashboard.wallet.error_loading' => 'Failed to load wallet data',
			'user_dashboard.wallet.available_balance' => 'Available Balance',
			'user_dashboard.wallet.failed_to_load_balance' => 'Failed to load balance',
			'user_dashboard.wallet.credit' => 'Credit',
			'user_dashboard.wallet.debit' => 'Debit',
			'user_dashboard.wallet.balance_available' => 'Balance Available',
			'user_dashboard.wallet.retry' => 'Retry',
			'user_dashboard.wallet.reference_types.order' => 'Order Payment',
			'user_dashboard.wallet.reference_types.refund' => 'Refund',
			'user_dashboard.wallet.reference_types.voucher' => 'Voucher Redemption',
			'user_dashboard.wallet.reference_types.adjustment' => 'Adjustment',
			'user_dashboard.wallet.reference_types.admin' => 'Admin Credit',
			'user_dashboard.wallet.reference_types.payout_hold' => 'Payout Hold',
			'user_dashboard.wallet.reference_types.payout_release' => 'Payout Released',
			'user_dashboard.wallet.reference_types.product_order' => 'Product Order',
			'user_dashboard.wallet.transaction_details.description' => 'Description',
			'user_dashboard.wallet.transaction_details.reference_id' => 'Reference ID',
			'user_dashboard.wallet.transaction_details.type' => 'Type',
			'user_dashboard.wallet.transaction_details.date' => 'Date',
			'user_dashboard.wallet.reward_cards.buy_a_car' => 'Buy a Car',
			'user_dashboard.wallet.reward_cards.car_accessories' => 'Car Accessories',
			'user_dashboard.wallet.reward_cards.spare_parts' => 'Spare Parts',
			'user_dashboard.wallet.transaction.compensation' => 'Compensation',
			'user_dashboard.wallet.transaction.used' => 'Used',
			'user_dashboard.wallet.months.jan' => 'Jan',
			'user_dashboard.wallet.months.feb' => 'Feb',
			'user_dashboard.wallet.months.mar' => 'Mar',
			'user_dashboard.wallet.months.apr' => 'Apr',
			'user_dashboard.wallet.months.may' => 'May',
			'user_dashboard.wallet.months.jun' => 'Jun',
			'user_dashboard.wallet.months.jul' => 'Jul',
			'user_dashboard.wallet.months.aug' => 'Aug',
			'user_dashboard.wallet.months.sep' => 'Sep',
			'user_dashboard.wallet.months.oct' => 'Oct',
			'user_dashboard.wallet.months.nov' => 'Nov',
			'user_dashboard.wallet.months.dec' => 'Dec',
			'user_dashboard.wallet.detail_labels.service_type' => 'Service type',
			'user_dashboard.wallet.detail_labels.vendor_name' => 'Vendor Name',
			'user_dashboard.wallet.detail_labels.liters' => 'Liters',
			'user_dashboard.wallet.detail_labels.order_id' => 'Order Id',
			'user_dashboard.wallet.detail_labels.status' => 'Status',
			'user_dashboard.orders.screen_title' => 'Orders',
			'user_dashboard.orders.search_hint' => 'Search orders...',
			'user_dashboard.orders.filter_all' => 'All',
			'user_dashboard.orders.filter_service' => 'Service',
			'user_dashboard.orders.filter_product' => 'Product',
			'user_dashboard.orders.tab_all' => 'All',
			'user_dashboard.orders.tab_active' => 'Active',
			'user_dashboard.orders.tab_completed' => 'Completed',
			'user_dashboard.orders.service_details' => 'Service details available in full view',
			'user_dashboard.orders.empty.no_results' => 'No Results Found',
			'user_dashboard.orders.empty.no_tab_orders' => 'No {tabName} Orders',
			'user_dashboard.orders.empty.adjust_search' => 'Try adjusting your search terms.',
			'user_dashboard.orders.empty.orders_appear_here' => 'Orders will appear here once available.',
			'user_dashboard.orders.error.title' => 'Error Loading Orders',
			'user_dashboard.orders.error.retry' => 'Retry',
			'user_dashboard.orders.card.service_order' => 'Service Order',
			'user_dashboard.orders.card.product_order' => 'Product Order',
			'user_dashboard.orders.card.fallback_service' => 'Service',
			'user_dashboard.orders.card.fallback_vendor' => 'Vendor',
			'user_dashboard.orders.card.item' => 'item',
			'user_dashboard.orders.card.items' => 'items',
			'user_dashboard.orders.card.reference' => 'Reference',
			'user_dashboard.orders.card.amount' => 'Amount',
			'user_dashboard.orders.card.time' => 'Time',
			'user_dashboard.orders.card.order_id' => 'Order ID',
			'user_dashboard.orders.card.date' => 'Date',
			'user_dashboard.orders.card.delivery_address' => 'Delivery Address',
			'user_dashboard.orders.card.order_summary' => 'Order Summary',
			'user_dashboard.orders.card.download_receipt' => 'Download Receipt',
			'user_dashboard.orders.card.subtotal' => 'Subtotal',
			'user_dashboard.orders.card.total' => 'Total',
			'user_dashboard.orders.card.payment_method' => 'Payment Method',
			'user_dashboard.orders.card.failed_details' => 'Failed to load details: {error}',
			'user_dashboard.orders.card.more_items' => '+ {count} more',
			'user_dashboard.orders.card.view_details' => 'View Details',
			'user_dashboard.orders.card.add_review' => 'ADD REVIEW',
			'user_dashboard.orders.status.pending' => 'Pending',
			'user_dashboard.orders.status.accepted' => 'Accepted',
			'user_dashboard.orders.status.on_the_way' => 'On the Way',
			'user_dashboard.orders.status.arrived' => 'Arrived',
			'user_dashboard.orders.status.in_progress' => 'In Progress',
			'user_dashboard.orders.status.completed' => 'Completed',
			'user_dashboard.orders.status.rejected' => 'Rejected',
			'user_dashboard.orders.status.cancelled' => 'Cancelled',
			'user_dashboard.orders.status.processing' => 'Processing',
			'user_dashboard.orders.status.confirmed' => 'Confirmed',
			'user_dashboard.orders.status.shipped' => 'Shipped',
			'user_dashboard.orders.status.delivered' => 'Delivered',
			'user_dashboard.orders.details.screen_title' => 'Request Details',
			'user_dashboard.orders.details.service_specifications' => 'Service Specifications',
			'user_dashboard.orders.details.your_details' => 'Your Details',
			'user_dashboard.orders.details.failed_to_load' => 'Failed to load order',
			'user_dashboard.orders.details.unknown_service' => 'Unknown Service',
			'user_dashboard.orders.details.unknown_vendor' => 'Unknown Vendor',
			'user_dashboard.orders.details.order_information' => 'Order Information',
			'user_dashboard.orders.details.order_reference' => 'Order Reference',
			'user_dashboard.orders.details.service' => 'Service',
			'user_dashboard.orders.details.vendor' => 'Vendor',
			'user_dashboard.orders.details.base_amount' => 'Base Amount',
			'user_dashboard.orders.details.total_amount' => 'Total Amount',
			'user_dashboard.orders.details.scheduled_date_time' => 'Scheduled Date & Time',
			'user_dashboard.orders.details.date' => 'Date',
			'user_dashboard.orders.details.time' => 'Time',
			'user_dashboard.orders.details.service_location' => 'Service Location',
			'user_dashboard.orders.details.open_in_maps' => 'Open in Maps',
			'user_dashboard.orders.details.timeline' => 'Timeline',
			'user_dashboard.orders.details.order_placed' => 'Order Placed',
			'user_dashboard.orders.details.vendor_accepted' => 'Vendor Accepted',
			'user_dashboard.orders.details.service_completed' => 'Service Completed',
			'user_dashboard.orders.details.order_cancelled' => 'Order Cancelled',
			'user_dashboard.orders.details.documents' => 'Documents',
			'user_dashboard.orders.details.document' => 'Document',
			'user_dashboard.orders.details.rejection_reason' => 'Rejection Reason',
			'user_dashboard.orders.details.cancellation_reason' => 'Cancellation Reason',
			'user_dashboard.orders.details.call_vendor' => 'Call Vendor',
			'user_dashboard.orders.details.write_review' => 'Write Review',
			'user_dashboard.orders.details.book_again' => 'Book Again',
			'user_dashboard.orders.details.phone_not_available' => 'Vendor phone number is not available',
			'user_dashboard.orders.details.could_not_launch_dialer' => 'Could not launch phone dialer',
			'user_dashboard.orders.details.review_coming_soon' => 'Review feature coming soon',
			'user_dashboard.orders.details.screen_title_product' => 'Order Details',
			'user_dashboard.orders.details.order_date' => 'Order Date',
			'user_dashboard.orders.details.order_items' => 'Order Items',
			'user_dashboard.orders.details.quantity_label' => 'Qty: {qty}',
			'user_dashboard.orders.details.payment_summary' => 'Payment Summary',
			'user_dashboard.orders.details.order_updated' => 'Order Updated',
			'user_dashboard.active_orders_preview.empty_title' => 'No Active Requests',
			'user_dashboard.active_orders_preview.empty_subtitle' => 'Your active service requests will appear here.',
			'user_dashboard.active_orders_preview.section_title' => 'My Active Requests',
			'user_dashboard.active_orders_preview.view_all' => 'View All',
			'user_dashboard.active_orders_preview.unknown_service' => 'Unknown Service',
			'user_dashboard.active_orders_preview.unknown_vendor' => 'Unknown Vendor',
			'user_dashboard.active_orders_preview.time_ago.just_now' => 'Just now',
			'user_dashboard.active_orders_preview.time_ago.minutes_ago' => '{n}m ago',
			'user_dashboard.active_orders_preview.time_ago.hours_ago' => '{n}h ago',
			'user_dashboard.active_orders_preview.time_ago.days_ago' => '{n}d ago',
			'user_dashboard.loyalty.screen_title' => 'Loyalty Program',
			'user_dashboard.loyalty.points_balance' => 'Points Balance',
			'user_dashboard.loyalty.points' => 'Points',
			'user_dashboard.loyalty.progress_to_reward' => 'Progress to Reward',
			'user_dashboard.loyalty.of_points_to_reward' => '{current} of {total} points to next reward',
			'user_dashboard.loyalty.redeem_points' => 'Redeem Points',
			'user_dashboard.loyalty.transactions' => 'Transactions',
			'user_dashboard.loyalty.earn' => 'Earn',
			'user_dashboard.loyalty.redeem' => 'Redeem',
			'user_dashboard.loyalty.expire' => 'Expire',
			'user_dashboard.loyalty.adjust' => 'Adjust',
			'user_dashboard.loyalty.empty_title' => 'No Transactions Yet',
			'user_dashboard.loyalty.empty_subtitle' => 'Your loyalty transactions will appear here.',
			'user_dashboard.loyalty.error_title' => 'Failed to Load',
			'user_dashboard.loyalty.retry' => 'Retry',
			'user_dashboard.listings.screen_title' => 'Listings',
			'user_dashboard.listings.search_hint' => 'Search Listed car',
			'user_dashboard.listings.error.failed_to_load' => 'Failed to load listings',
			'user_dashboard.listings.error.retry' => 'Retry',
			'user_dashboard.listings.empty.no_results' => 'No listings found',
			'user_dashboard.listings.empty.no_listings_yet' => 'No listings yet',
			'user_dashboard.listings.empty.no_match' => 'No listings match.',
			'user_dashboard.listings.empty.appear_here' => 'Your car listings will appear here',
			'user_dashboard.listings.card.featured' => 'Featured',
			'user_dashboard.listings.card.inspected' => 'Inspected',
			'user_dashboard.listings.card.not_inspected' => 'Not Inspected',
			'user_dashboard.listing_details.screen_title' => 'About This Car',
			'user_dashboard.listing_details.featured' => 'Featured',
			'user_dashboard.listing_details.price_on_request' => 'Price on request',
			'user_dashboard.listing_details.inspected' => 'Inspected',
			'user_dashboard.listing_details.not_inspected' => 'Not Inspected',
			'user_dashboard.listing_details.view_details' => 'View Details',
			'user_dashboard.listing_details.unknown_location' => 'Unknown location',
			'user_dashboard.listing_details.time_ago.just_now' => 'Just now',
			'user_dashboard.listing_details.time_ago.minutes_ago' => '{n} minutes ago',
			'user_dashboard.listing_details.time_ago.hours_ago' => '{n} hours ago',
			'user_dashboard.listing_details.time_ago.days_ago' => '{n} days ago',
			'user_dashboard.listing_details.time_ago.months_ago' => '{n} months ago',
			'user_dashboard.listing_details.inspection.title' => 'Inspection Report',
			'user_dashboard.listing_details.inspection.has_report_desc' => 'Download and view the\n inspection report of this car.',
			'user_dashboard.listing_details.inspection.no_report_desc' => 'No inspection report\n available for this car.',
			'user_dashboard.listing_details.inspection.view_report' => 'View Inspection Report',
			'user_dashboard.listing_details.specifications.title' => 'Specifications',
			'user_dashboard.listing_details.specifications.edit' => 'Edit',
			'user_dashboard.listing_details.specifications.labels.make' => 'Make',
			'user_dashboard.listing_details.specifications.labels.model' => 'Model',
			'user_dashboard.listing_details.specifications.labels.trim' => 'Trim',
			'user_dashboard.listing_details.specifications.labels.year' => 'Year',
			'user_dashboard.listing_details.specifications.labels.mileage' => 'Mileage',
			'user_dashboard.listing_details.specifications.labels.transmission' => 'Transmission',
			'user_dashboard.listing_details.specifications.labels.engine' => 'Engine',
			'user_dashboard.listing_details.specifications.labels.color' => 'Color',
			'user_dashboard.listing_details.specifications.na' => 'N/A',
			'user_dashboard.listing_details.description.title' => 'Description',
			'user_dashboard.listing_details.description.no_description' => 'No description available.',
			'user_dashboard.listing_details.description.edit_dialog_title' => 'Edit Description',
			'user_dashboard.listing_details.description.edit_dialog_hint' => 'Enter new description...',
			'user_dashboard.listing_details.description.cancel' => 'Cancel',
			'user_dashboard.listing_details.description.save' => 'Save',
			'user_dashboard.listing_details.save_button' => 'Save',
			'user_dashboard.edit_specs.screen_title' => 'Edit Specifications',
			'user_dashboard.edit_specs.steps.make' => 'Make',
			'user_dashboard.edit_specs.steps.model' => 'Model',
			'user_dashboard.edit_specs.steps.trim' => 'Trim',
			'user_dashboard.edit_specs.steps.year' => 'Year',
			'user_dashboard.edit_specs.steps.mileage' => 'Mileage',
			'user_dashboard.edit_specs.steps.transmission' => 'Transmission',
			'user_dashboard.edit_specs.steps.color' => 'Color',
			'user_dashboard.edit_specs.save_button_loading' => 'Saving...',
			'user_dashboard.edit_specs.save_button' => 'Save Changes',
			'user_dashboard.edit_specs.validation.complete_all_fields' => 'Please complete all fields',
			'user_dashboard.notifications.screen_title' => 'NOTIFICATIONS',
			'user_dashboard.notifications.read_all' => 'Read All',
			'user_dashboard.notifications.tab_all' => 'All',
			'user_dashboard.notifications.tab_orders' => 'Orders',
			'user_dashboard.notifications.tab_offers' => 'Offers',
			'user_dashboard.notifications.tab_system' => 'System',
			'user_dashboard.notifications.empty.title' => 'All Caught Up!',
			'user_dashboard.notifications.empty.subtitle' => 'No new notifications to display.',
			'user_dashboard.settings.screen_title' => 'SETTINGS',
			'user_dashboard.settings.search_hint' => 'Search settings',
			'user_dashboard.settings.not_found' => 'No settings found',
			'user_dashboard.settings.menu.account_info' => 'Account Info',
			'user_dashboard.settings.menu.saved_addresses' => 'Saved Addresses',
			'user_dashboard.settings.menu.change_email' => 'Change Email',
			'user_dashboard.settings.menu.change_password' => 'Change Password',
			'user_dashboard.settings.menu.country' => 'Country',
			'user_dashboard.settings.menu.notifications' => 'Notifications',
			'user_dashboard.settings.menu.language' => 'Language',
			'user_dashboard.settings.menu.app_mode' => 'App Mode',
			'user_dashboard.settings.menu.logout' => 'Logout',
			'user_dashboard.settings.menu.delete_account' => 'Delete Account',
			'user_dashboard.settings.delete_account_confirm.title' => 'Delete Account?',
			'user_dashboard.settings.delete_account_confirm.message' => 'Are you sure you want to delete your account? This action is permanent and cannot be undone.',
			'user_dashboard.settings.delete_account_confirm.confirm' => 'Delete',
			'user_dashboard.settings.delete_account_confirm.cancel' => 'Cancel',
			'user_dashboard.settings.delete_account_confirm.error' => 'Failed to delete account. Please try again.',
			'user_dashboard.settings.account_info.screen_title' => 'Account Info',
			'user_dashboard.settings.account_info.edit' => 'Edit',
			'user_dashboard.settings.account_info.fields.first_name' => 'First Name',
			'user_dashboard.settings.account_info.fields.last_name' => 'Last Name',
			'user_dashboard.settings.account_info.fields.email' => 'Email',
			'user_dashboard.settings.account_info.fields.date_of_birth' => 'Date of birth',
			'user_dashboard.settings.account_info.fields.phone_number' => 'Phone Number',
			'user_dashboard.settings.account_info.gender.title' => 'Gender',
			'user_dashboard.settings.account_info.gender.male' => 'Male',
			'user_dashboard.settings.account_info.gender.female' => 'Female',
			'user_dashboard.settings.account_info.preferences.receive_offers' => 'Yes, I want to receive offers and discounts',
			'user_dashboard.settings.account_info.preferences.newsletter' => 'Subscribe to Newsletter',
			'user_dashboard.settings.account_info.delete_account' => 'DELETE ACCOUNT',
			'user_dashboard.settings.change_email.screen_title' => 'Change Email',
			'user_dashboard.settings.change_email.field_hint' => 'New Email Address',
			'user_dashboard.settings.change_email.validation_error' => 'Please enter a valid email address',
			'user_dashboard.settings.change_email.confirm_button_loading' => 'CONFIRMING...',
			'user_dashboard.settings.change_email.confirm_button' => 'Confirm',
			'user_dashboard.settings.change_email.success' => 'Email updated successfully',
			'user_dashboard.settings.change_email.error' => 'Failed to update email. Please try again.',
			'user_dashboard.settings.change_password.screen_title' => 'Change Password',
			'user_dashboard.settings.change_password.fields.current_password' => 'Current Password',
			'user_dashboard.settings.change_password.fields.new_password' => 'New Password',
			'user_dashboard.settings.change_password.fields.confirm_password' => 'Confirm New Password',
			'user_dashboard.settings.change_password.validation.current_required' => 'Current password is required',
			'user_dashboard.settings.change_password.validation.min_length' => 'Password must be at least 8 characters',
			'user_dashboard.settings.change_password.validation.match' => 'Passwords do not match',
			'user_dashboard.settings.change_password.button_loading' => 'CHANGING...',
			'user_dashboard.settings.change_password.button' => 'Change Password',
			'user_dashboard.settings.change_password.success' => 'Password change success.',
			'user_dashboard.settings.change_password.error' => 'Failed to change password. Please try again.',
			'user_dashboard.settings.language.title' => 'Language',
			'user_dashboard.settings.language.english' => 'English',
			'user_dashboard.settings.language.arabic' => 'Arabic',
			'user_dashboard.settings.app_mode.title' => 'App Mode',
			'user_dashboard.settings.app_mode.dark' => 'Dark',
			'user_dashboard.settings.app_mode.light' => 'Light',
			'user_dashboard.settings.country.title' => 'Country',
			'user_dashboard.settings.country.kuwait' => 'Kuwait',
			'user_dashboard.settings.country.bahrain' => 'Bahrain',
			'user_dashboard.settings.country.uae' => 'UAE',
			'user_dashboard.settings.country.oman' => 'Oman',
			'user_dashboard.settings.country.qatar' => 'Qatar',
			'user_dashboard.settings.country.saudi_arabia' => 'Saudi Arabia',
			'user_dashboard.settings.saved_addresses.screen_title' => 'Addresses',
			'user_dashboard.settings.saved_addresses.add_button' => 'Add',
			'user_dashboard.settings.saved_addresses.empty_title' => 'No saved addresses',
			'user_dashboard.settings.saved_addresses.add_new_button' => 'Add New Address',
			'user_dashboard.settings.notification_preferences.screen_title' => 'NOTIFICATION PREFERENCES',
			'user_dashboard.settings.notification_preferences.order_updates' => 'Order updates',
			'user_dashboard.settings.notification_preferences.promotions' => 'Promotions',
			'user_dashboard.settings.verify_email_otp.title' => 'VERIFY EMAIL',
			'user_dashboard.settings.verify_email_otp.sent_code' => 'We\'ve sent a code to ',
			'user_dashboard.settings.verify_email_otp.otp_error' => 'Please enter the complete OTP code',
			'user_dashboard.settings.verify_email_otp.verify_button_loading' => 'VERIFYING...',
			'user_dashboard.settings.verify_email_otp.verify_button' => 'VERIFY',
			'user_dashboard.settings.verify_email_otp.success' => 'Email updated successfully',
			'user_dashboard.settings.verify_email_otp.error' => 'Failed to update email. Please try again.',
			'user_dashboard.settings.verify_email_otp.otp_sent' => 'OTP sent successfully',
			'user_dashboard.settings.verify_email_otp.resend.did_not_receive' => 'Didn\'t Receive Code? ',
			'user_dashboard.settings.verify_email_otp.resend.resend_in' => 'Resend in {time}',
			'user_dashboard.settings.verify_email_otp.resend.resend_button' => 'Resend',
			'user_dashboard.settings.edit_address.edit_title' => 'Edit Address',
			'user_dashboard.settings.edit_address.add_title' => 'Add Address',
			'user_dashboard.settings.edit_address.delete' => 'Delete',
			'user_dashboard.settings.edit_address.delete_dialog.title' => 'Delete Address',
			'user_dashboard.settings.edit_address.delete_dialog.description' => 'Are you sure you want to delete this address?',
			'user_dashboard.settings.edit_address.delete_dialog.yes' => 'YES',
			'user_dashboard.settings.edit_address.delete_dialog.no' => 'no',
			'user_dashboard.settings.edit_address.validation.required_fields' => 'Please fill required fields',
			'user_dashboard.settings.edit_address.area.label' => 'Area',
			'user_dashboard.settings.edit_address.area.hint' => 'Tap Change to set area',
			'user_dashboard.settings.edit_address.area.change_button' => 'Change',
			'user_dashboard.settings.edit_address.area.dialog_title' => 'Area',
			'user_dashboard.settings.edit_address.area.dialog_hint' => 'Enter area',
			'user_dashboard.settings.edit_address.area.cancel' => 'Cancel',
			'user_dashboard.settings.edit_address.area.ok' => 'OK',
			'user_dashboard.settings.edit_address.property_types.apartment' => 'Apartment',
			'user_dashboard.settings.edit_address.property_types.house' => 'House',
			'user_dashboard.settings.edit_address.property_types.office' => 'Office',
			'user_dashboard.settings.edit_address.fields.address_title' => 'Address Title',
			'user_dashboard.settings.edit_address.fields.building_name' => 'Building Name',
			'user_dashboard.settings.edit_address.fields.apt_number' => 'Apt. Number',
			'user_dashboard.settings.edit_address.fields.street' => 'Street',
			'user_dashboard.settings.edit_address.fields.block' => 'Block',
			'user_dashboard.settings.edit_address.fields.avenue_optional' => 'Avenue (optional)',
			'user_dashboard.settings.edit_address.fields.directions_optional' => 'Additional Directions (optional)',
			'user_dashboard.settings.edit_address.fields.phone_number' => 'Phone Number',
			'user_dashboard.settings.edit_address.fields.address_label_optional' => 'Address Label (optional)',
			'user_dashboard.settings.edit_address.save_button' => 'SAVE ADDRESS',
			'user_dashboard.settings.edit_address.default_label' => 'Address',
			'user_dashboard.settings.address_tile.block' => 'Block {n}',
			'user_dashboard.settings.address_tile.building' => 'Building {n}',
			'user_dashboard.settings.address_tile.apt' => 'Apt {n}',
			'user_dashboard.settings.address_tile.mobile_number' => 'Mobile Number: {n}',
			'bottom_nav.customer.home' => 'Home',
			'bottom_nav.customer.services' => 'Services',
			'bottom_nav.customer.offers' => 'Offers',
			'bottom_nav.customer.cart' => 'Cart',
			'bottom_nav.customer.profile' => 'Profile',
			'bottom_nav.vendor.home' => 'Home',
			'bottom_nav.vendor.listings' => 'Listings',
			'bottom_nav.vendor.orders' => 'Orders',
			'bottom_nav.vendor.operator' => 'Operator',
			'bottom_nav.vendor.profile' => 'Profile',
			'bottom_nav.operator.home' => 'Home',
			'bottom_nav.operator.orders' => 'Orders',
			'bottom_nav.operator.profile' => 'Profile',
			'sell_your_car.screens.condition_car.title' => 'SELL Your CARS',
			'sell_your_car.screens.condition_car.subtitle' => 'We have offers waiting for you',
			'sell_your_car.screens.sell_a_car.title' => 'SELL A CAR',
			'sell_your_car.screens.sell_a_car.subtitle' => 'We have offers waiting for you',
			'sell_your_car.screens.sell_or_buy_car.title' => 'SELL OR BUY YOUR CARS',
			'sell_your_car.screens.sell_or_buy_car.subtitle' => 'Buy and Sell Your Car Quickly and Conveniently',
			'sell_your_car.screens.fast_track_condition.title' => 'Fast Track Car Sale',
			'sell_your_car.screens.fast_track_condition.subtitle' => 'We have offers waiting for you',
			'sell_your_car.screens.fast_track_sale.title' => 'FAST TRACK CAR SALE',
			'sell_your_car.screens.fast_track_sale.subtitle' => 'We have offers waiting for you',
			'sell_your_car.screens.fast_track_sale.description_title' => 'Description',
			'sell_your_car.screens.fast_track_sale.description' => 'Fast Track Car Sale is designed for those who need to sell their car quickly and efficiently. By listing at a discounted price, your car can be sold within 15 hours. Once you approve the offer, our team will handle the process, ensuring a smooth and hassle-free transaction. A representative will contact you to finalize the sale after your approval.',
			'sell_your_car.screens.fast_track_sale.terms_title' => 'Terms and Conditions',
			'sell_your_car.screens.fast_track_sale.terms_intro' => 'By using our car listing services, you agree to the following terms and conditions:',
			'sell_your_car.screens.fast_track_sale.bullet_1' => 'Cars listed under Fast Track Sale must be priced 30% lower than the lowest market value.',
			'sell_your_car.screens.fast_track_sale.bullet_2' => 'Listing fees are non-refundable.',
			'sell_your_car.screens.fast_track_sale.bullet_3' => 'Transactions are subject to a 5% fee for both the buyer and seller.',
			'sell_your_car.screens.fast_track_sale.bullet_4' => 'The seller must approve the offer and terms before proceeding.',
			'sell_your_car.screens.fast_track_sale.bullet_5' => 'Listings and offers are valid only after Motiva\'s approval.',
			'sell_your_car.screens.fast_track_sale.approve_checkbox' => 'Yes, I approve the Motiva\'s terms and conditions of fast track car sale.',
			'sell_your_car.screens.fast_track_sale.kContinue' => 'CONTINUE',
			'sell_your_car.screens.open_an_auction.title' => 'OPEN AN AUCTION',
			'sell_your_car.screens.open_an_auction.subtitle' => 'Sell Fast Through Auction',
			'sell_your_car.screens.open_an_auction.description_title' => 'Description',
			'sell_your_car.screens.open_an_auction.description' => 'List your car for sale with ease using our platform. Choose from Normal, Auction, or Fast Track options to find buyers quickly and securely. Opt for add-ons like an inspection report to boost your listing credibility. Fast Track ensures a guaranteed sale within 15 hours at 30% below the lowest market price.',
			'sell_your_car.screens.open_an_auction.terms_title' => 'Terms and Conditions',
			'sell_your_car.screens.open_an_auction.terms_intro' => 'By using our car listing services, you agree to the following terms and conditions:',
			'sell_your_car.screens.open_an_auction.bullet_1' => 'All car details must be accurate and up-to-date.',
			'sell_your_car.screens.open_an_auction.bullet_2' => 'Listing fees are non-refundable and vary by service type.',
			'sell_your_car.screens.open_an_auction.bullet_3' => 'Fast Track Sales require a 30% discount on the lowest market price.',
			'sell_your_car.screens.open_an_auction.bullet_4' => 'A 5% transaction fee applies to both seller and buyer on successful sales.',
			'sell_your_car.screens.open_an_auction.bullet_5' => 'Inspection reports must be valid and accurate.',
			'sell_your_car.screens.open_an_auction.approve_checkbox' => 'Yes, I approve the Motiva\'s terms and conditions of opening an auction.',
			'sell_your_car.screens.open_an_auction.kContinue' => 'CONTINUE',
			'sell_your_car.screens.car_details.title' => 'Car Details',
			'sell_your_car.screens.car_details.submitting_listing' => 'Submitting your listing...',
			'sell_your_car.screens.car_details.submitting_request' => 'Submitting your request...',
			'sell_your_car.screens.success_dialog.title' => 'Success!',
			'sell_your_car.screens.success_dialog.damaged_car_message' => 'Your damaged car listing has been submitted successfully.',
			'sell_your_car.screens.success_dialog.listing_created' => 'Listing Created Successfully!',
			'sell_your_car.screens.success_dialog.listing_saved' => 'Your car listing has been saved.',
			'sell_your_car.screens.success_dialog.ok' => 'OK',
			'sell_your_car.screens.success_dialog.done' => 'Done',
			'sell_your_car.screens.request_received_dialog.title' => 'Request Received!',
			'sell_your_car.screens.request_received_dialog.message' => 'Request sent to Motiva admins — we will contact you with an offer',
			'sell_your_car.screens.error_dialog.title' => 'Error',
			'sell_your_car.steps.make' => 'Make',
			'sell_your_car.steps.model' => 'Model',
			'sell_your_car.steps.trim' => 'Trim',
			'sell_your_car.steps.year' => 'Year',
			'sell_your_car.steps.mileage' => 'Mileage',
			'sell_your_car.steps.selling_price' => 'Selling Price',
			'sell_your_car.steps.car_specs' => 'Car Specs',
			'sell_your_car.steps.car_condition' => 'Car Condition',
			'sell_your_car.steps.colors' => 'Colors',
			'sell_your_car.steps.images' => 'Images',
			'sell_your_car.steps.location' => 'Location',
			'sell_your_car.steps.additional_info' => 'Additional Information',
			'sell_your_car.steps.duration' => 'Duration',
			'sell_your_car.steps.color' => 'Color',
			'sell_your_car.steps.image' => 'Image',
			'sell_your_car.make_tab.title' => 'Select Your car make',
			'sell_your_car.make_tab.search_hint' => 'Search Car Make',
			'sell_your_car.make_tab.no_available' => 'No makes available',
			'sell_your_car.make_tab.no_found' => 'No makes found',
			'sell_your_car.make_tab.retry' => 'Retry',
			'sell_your_car.model_tab.title' => 'Select Your car model',
			'sell_your_car.model_tab.search_hint' => 'Search Car Model',
			'sell_your_car.model_tab.select_make_first' => 'Please select a make first',
			'sell_your_car.model_tab.no_available' => 'No models available',
			'sell_your_car.model_tab.no_found' => 'No models found',
			'sell_your_car.model_tab.retry' => 'Retry',
			'sell_your_car.trim_tab.title' => 'Select Your car Trim',
			'sell_your_car.trim_tab.search_hint' => 'Search Car Trim',
			'sell_your_car.trim_tab.select_model_first' => 'Please select a model first',
			'sell_your_car.trim_tab.no_available' => 'No trims available',
			'sell_your_car.trim_tab.no_found' => 'No trims found',
			'sell_your_car.trim_tab.retry' => 'Retry',
			'sell_your_car.year_tab.title' => 'Enter Model Year',
			'sell_your_car.year_tab.error' => 'Please enter a year between 1900 and {year}',
			'sell_your_car.mileage_tab.title' => 'Enter Mileage',
			'sell_your_car.mileage_tab.unit' => 'KM',
			'sell_your_car.mileage_tab.kContinue' => 'CONTINUE',
			'sell_your_car.selling_price_tab.title' => 'Enter Selling Price',
			'sell_your_car.selling_price_tab.unit' => 'KWD',
			'sell_your_car.selling_price_tab.kContinue' => 'CONTINUE',
			'sell_your_car.colors_tab.title' => 'Select your car colors',
			'sell_your_car.colors_tab.exterior_title' => 'Select your exterior color',
			'sell_your_car.colors_tab.interior_title' => 'Select your Interior Color',
			'sell_your_car.colors_tab.view_more' => 'View More',
			'sell_your_car.colors_tab.kContinue' => 'CONTINUE',
			'sell_your_car.car_color.white' => 'White',
			'sell_your_car.car_color.black' => 'Black',
			'sell_your_car.car_color.orange' => 'Orange',
			'sell_your_car.car_color.blue' => 'Blue',
			'sell_your_car.car_color.red' => 'Red',
			'sell_your_car.car_color.green' => 'Green',
			'sell_your_car.car_color.purple' => 'Purple',
			'sell_your_car.car_color.yellow' => 'Yellow',
			'sell_your_car.car_color.aqua' => 'Aqua',
			'sell_your_car.car_color.snow' => 'Snow',
			'sell_your_car.car_color.beige' => 'Beige',
			'sell_your_car.car_color.dim_gray' => 'DimGray',
			'sell_your_car.images_tab.car_images_title' => 'Upload Car Images',
			'sell_your_car.images_tab.car_images_hint' => 'Add photos of your car (exterior, interior, engine)',
			'sell_your_car.images_tab.damage_images_title' => 'Upload Damage Images',
			'sell_your_car.images_tab.damage_images_hint' => 'Add photos showing damage areas',
			'sell_your_car.images_tab.camera' => 'Camera',
			'sell_your_car.images_tab.gallery' => 'Gallery',
			'sell_your_car.images_tab.add_photo' => 'Add Photo',
			'sell_your_car.images_tab.select_source' => 'Select Image Source',
			'sell_your_car.images_tab.uploading' => 'Uploading images...',
			'sell_your_car.images_tab.skip' => 'SKIP',
			'sell_your_car.images_tab.kContinue' => 'CONTINUE',
			'sell_your_car.images_tab.car_label' => 'Car',
			'sell_your_car.images_tab.damage_label' => 'Damage',
			'sell_your_car.images_tab.image_label' => 'Image {number}',
			'sell_your_car.location_tab.pick_location' => 'Pick Your Location',
			_ => null,
		} ?? switch (path) {
			'sell_your_car.location_tab.select_location_title' => 'Select Location',
			'sell_your_car.location_tab.select' => 'Select',
			'sell_your_car.location_tab.cancel' => 'Cancel',
			'sell_your_car.location_tab.country' => 'Country',
			'sell_your_car.location_tab.city' => 'City',
			'sell_your_car.location_tab.kContinue' => 'continue',
			'sell_your_car.location_tab.failed_picker' => 'Failed to open location picker',
			'sell_your_car.inspection_report.title' => 'Do you have recent inspection report?',
			'sell_your_car.inspection_report.browse' => 'Browse ',
			'sell_your_car.inspection_report.your_file' => 'your File',
			'sell_your_car.inspection_report.max_size' => 'Max 10 MB files are allowed',
			'sell_your_car.inspection_report.file_types' => 'PDF, JPG, PNG',
			'sell_your_car.inspection_report.uploaded_success' => 'Uploaded successfully',
			'sell_your_car.inspection_report.no_report' => 'No, I don\'t have',
			'sell_your_car.inspection_report.inspect_question' => 'Do you want us to inspect your car?',
			'sell_your_car.inspection_report.inspect_description' => 'Get your car professionally inspected for peace of mind. Add this service for a thorough check to ensure it\'s in top condition.',
			'sell_your_car.inspection_report.inspect_price' => 'KD 20   + 3 Stars',
			'sell_your_car.inspection_report.dialog_title' => 'Enter Inspection Report URL',
			'sell_your_car.inspection_report.cancel' => 'Cancel',
			'sell_your_car.inspection_report.upload' => 'UPLOAD',
			'sell_your_car.inspection_report.kContinue' => 'CONTINUE',
			'sell_your_car.inspection_report.uploading' => 'Uploading file...',
			'sell_your_car.inspection_report.file_size_error' => 'File size must be less than 10MB',
			'sell_your_car.inspection_report.pick_error' => 'Error picking file: {error}',
			'sell_your_car.inspection_report.upload_error' => 'Failed to upload file. Please try again.',
			'sell_your_car.inspection_report.upload_error_generic' => 'Error uploading file: {error}',
			'sell_your_car.car_condition.chassis_title' => 'Are there any chassis issues?',
			'sell_your_car.car_condition.mechanical_title' => 'Are there any mechanical issues in the car?',
			'sell_your_car.car_condition.warning_lights_title' => 'Are there any warning lights on?',
			'sell_your_car.car_condition.tires_title' => 'What is the condition of the tires?',
			'sell_your_car.car_condition.tires_new' => 'New',
			'sell_your_car.car_condition.tires_good' => 'Good',
			'sell_your_car.car_condition.tires_needs_change' => 'Needs Change',
			'sell_your_car.car_condition.runs_drives_title' => 'Does the car run and drive?',
			'sell_your_car.car_condition.runs_drives_yes' => 'Yes, it runs and drives',
			'sell_your_car.car_condition.runs_drives_no' => 'No, it does not run/drive',
			'sell_your_car.car_condition.yes' => 'Yes',
			'sell_your_car.car_condition.no' => 'No',
			'sell_your_car.car_condition.dont_know' => 'I don\'t know',
			'sell_your_car.car_condition.kContinue' => 'Continue',
			'sell_your_car.description.title' => 'Description',
			'sell_your_car.description.hint' => 'Write any extra details about your Car.',
			'sell_your_car.body_panel_tab.title' => 'Are there any minor defects or damages to the body panels?',
			'sell_your_car.body_panel_tab.yes' => 'Yes',
			'sell_your_car.body_panel_tab.no' => 'No',
			'sell_your_car.body_panel_tab.dont_know' => 'I don\'t know',
			'sell_your_car.body_panel_tab.kContinue' => 'Continue',
			'sell_your_car.paint_condition_tab.title' => 'What is the paint condition?',
			'sell_your_car.paint_condition_tab.kContinue' => 'CONTINUE',
			'sell_your_car.end_tab.proceed_payment' => 'PROCEED WITH PAYMENT',
			'sell_your_car.engine_tab.title' => 'Select Your Car Engine',
			'sell_your_car.engine_tab.other' => 'Other',
			'sell_your_car.transmission_tab.title' => 'Select Your Car Transmission',
			'sell_your_car.transmission_tab.manual' => 'Manual',
			'sell_your_car.transmission_tab.automatic' => 'Automatic',
			'sell_your_car.transmission_tab.kContinue' => 'Continue',
			'sell_your_car.additional_info.features_title' => 'Select your car features',
			'sell_your_car.additional_info.feature_your_car' => 'Feature your car',
			'sell_your_car.additional_info.feature_description' => 'Featuring your car will allow more people see it and will be sold quickly.',
			'sell_your_car.additional_info.one_week' => '1 week',
			'sell_your_car.additional_info.two_weeks' => '2 weeks',
			'sell_your_car.additional_info.one_month' => '1 month',
			'sell_your_car.additional_info.total_price' => 'Total Price : ',
			'sell_your_car.additional_info.saving' => 'SAVING...',
			'sell_your_car.additional_info.submit_listing' => 'SUBMIT LISTING',
			'sell_your_car.additional_info.listing_created' => 'Listing Created Successfully!',
			'sell_your_car.additional_info.listing_saved' => 'Your car listing has been saved.\nListing ID: {id}',
			'sell_your_car.additional_info.done' => 'Done',
			'sell_your_car.service_sections.all_services' => 'All Services',
			'sell_your_car.service_sections.sell_your_car' => 'Sell your Car',
			'sell_your_car.service_sections.sell_a_car' => 'Sell a Car',
			'sell_your_car.service_sections.buy_a_car' => 'Buy a Car',
			'sell_your_car.service_sections.good_condition_car' => 'Good Condition Car',
			'sell_your_car.service_sections.damaged_car' => 'Damaged Car',
			'sell_your_car.service_sections.open_an_auction' => 'Open an Auction',
			'sell_your_car.service_sections.fast_track_car_sale' => 'Fast Track Car Sale',
			'sell_your_car.service_sections.lorem_description' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor tempor',
			'sell_your_car.duration_tab.title' => 'Choose Duration of auction',
			'sell_your_car.duration_tab.auction_start' => 'Auction should start from',
			'sell_your_car.duration_tab.starting_price' => 'Starting Price',
			'sell_your_car.duration_tab.feature_auction' => 'Feature your auction',
			'sell_your_car.duration_tab.feature_description' => 'Feature Your Auction to Maximize Visibility and Competitive Bidding!',
			'sell_your_car.duration_tab.total_price' => 'Total price : ',
			'sell_your_car.duration_tab.days_3' => '3 days',
			'sell_your_car.duration_tab.days_5' => '5 days',
			'sell_your_car.duration_tab.days_7' => '7 days',
			'sell_your_car.duration_tab.kContinue' => 'CONTINUE',
			'sell_your_car.duration_tab.proceed_payment' => 'PROCEED WITH PAYMENT',
			'sell_your_car.ft_duration.title' => 'Choose when do you want to have your cash?',
			'sell_your_car.ft_duration.hours_label' => 'within {hours} hours - {discount}% lower than market price',
			'sell_your_car.ft_duration.fallback_tooltip' => 'Using default options - backend unavailable',
			'sell_your_car.ft_duration.failed_load' => 'Failed to load duration options',
			'sell_your_car.ft_duration.retry' => 'Retry',
			'sell_your_car.ft_duration.submit_request' => 'SUBMIT REQUEST',
			'sell_your_car.ft_duration.total_price' => 'Total Price : ',
			'sell_your_car.duration.title' => 'Auction Duration',
			'sell_your_car.duration.one_day' => '1 Day',
			'sell_your_car.duration.three_days' => '3 Days',
			'sell_your_car.duration.seven_days' => '7 Days',
			'sell_your_car.duration.kContinue' => 'CONTINUE',
			'vendor_dashboard.profile.not_found_title' => 'Profile Not Found',
			'vendor_dashboard.profile.not_found_description' => 'Your vendor profile has not been set up yet. Please contact support to complete your registration.',
			'vendor_dashboard.profile.error_loading_title' => 'Error Loading Profile',
			'vendor_dashboard.profile.retry' => 'Retry',
			'vendor_dashboard.profile.verified' => 'Verified',
			'vendor_dashboard.profile.reviews' => 'reviews',
			'vendor_dashboard.profile.vendor_profile' => 'Vendor Profile',
			'vendor_dashboard.profile.profile_not_set_up' => 'Profile not set up',
			'vendor_dashboard.profile.unable_to_load_profile' => 'Unable to load profile',
			'vendor_dashboard.orders.screen_title' => 'All Orders',
			'vendor_dashboard.orders.tab_title' => 'Orders',
			'vendor_dashboard.orders.tab_subtitle' => 'Manage your business',
			'vendor_dashboard.orders.live_badge' => '{count} orders',
			'vendor_dashboard.orders.search_hint' => 'Search orders...',
			'vendor_dashboard.orders.filter_all' => 'All',
			'vendor_dashboard.orders.filter_services' => 'Services',
			'vendor_dashboard.orders.filter_products' => 'Products',
			'vendor_dashboard.orders.tab_all' => 'All',
			'vendor_dashboard.orders.tab_new' => 'New',
			'vendor_dashboard.orders.tab_processing' => 'Processing',
			'vendor_dashboard.orders.tab_completed' => 'Completed',
			'vendor_dashboard.orders.empty_search_title' => 'No Results Found',
			'vendor_dashboard.orders.empty_search_subtitle' => 'Try adjusting your search terms.',
			'vendor_dashboard.orders.empty_tab' => 'No {tabName} Orders',
			'vendor_dashboard.orders.empty_tab_subtitle' => 'Orders will appear here once available.',
			'vendor_dashboard.orders.error_loading' => 'Error Loading Orders',
			'vendor_dashboard.request_details.screen_title' => 'ORDER DETAILS',
			'vendor_dashboard.request_details.order_accepted' => 'Order accepted successfully',
			'vendor_dashboard.request_details.accept_failed' => 'Failed to accept order: {error}',
			'vendor_dashboard.request_details.status_on_the_way' => 'Status updated: On the way',
			'vendor_dashboard.request_details.status_arrived' => 'Status updated: Arrived at location',
			'vendor_dashboard.request_details.service_started' => 'Service started',
			'vendor_dashboard.request_details.action_failed' => 'Failed: {error}',
			'vendor_dashboard.request_details.error' => 'Error: {error}',
			'vendor_dashboard.request_details.service_fallback' => 'Service',
			'vendor_dashboard.request_details.order_ref' => 'Order Ref',
			'vendor_dashboard.request_details.amount' => 'Amount',
			'vendor_dashboard.request_details.created' => 'Created',
			'vendor_dashboard.request_details.scheduled' => 'Scheduled',
			'vendor_dashboard.request_details.route' => 'Route',
			'vendor_dashboard.request_details.location' => 'Location',
			'vendor_dashboard.request_details.pickup' => 'Pickup',
			'vendor_dashboard.request_details.dropoff' => 'Dropoff',
			'vendor_dashboard.request_details.address' => 'Address',
			'vendor_dashboard.request_details.no_address' => 'No address provided',
			'vendor_dashboard.request_details.open_in_maps' => 'Open in Maps',
			'vendor_dashboard.request_details.order_details' => 'Order Details',
			'vendor_dashboard.request_details.base_amount' => 'Base Amount',
			'vendor_dashboard.request_details.total' => 'Total',
			'vendor_dashboard.request_details.service_specifications' => 'Service Specifications',
			'vendor_dashboard.request_details.customer_information' => 'Customer Information',
			'vendor_dashboard.request_details.attributes' => 'Attributes',
			'vendor_dashboard.request_details.customer' => 'Customer',
			'vendor_dashboard.request_details.rejection_reason' => 'Rejection Reason',
			'vendor_dashboard.request_details.no_reason' => 'No reason provided',
			'vendor_dashboard.request_details.cancellation_details' => 'Cancellation Details',
			'vendor_dashboard.request_details.cancellation_reason_label' => 'Reason: {reason}',
			'vendor_dashboard.request_details.penalty_fee' => 'Penalty Fee: {fee} KWD',
			'vendor_dashboard.request_details.documents' => 'Documents',
			'vendor_dashboard.request_details.document_fallback' => 'Document',
			'vendor_dashboard.request_details.reject' => 'Reject',
			'vendor_dashboard.request_details.accept' => 'Accept',
			'vendor_dashboard.request_details.assign_operator' => 'Assign Operator',
			'vendor_dashboard.request_details.start_travel' => 'Start Travel',
			'vendor_dashboard.request_details.mark_arrived' => 'Mark Arrived',
			'vendor_dashboard.request_details.start_service' => 'Start Service',
			'vendor_dashboard.request_details.complete' => 'Complete',
			'vendor_dashboard.schedule.screen_title' => 'Schedule',
			'vendor_dashboard.schedule.error_loading' => 'Error loading orders',
			'vendor_dashboard.schedule.no_appointments' => 'No appointments',
			'vendor_dashboard.schedule.no_scheduled_for_date' => 'No scheduled orders for {date}',
			'vendor_dashboard.schedule.appointment_singular' => 'appointment',
			'vendor_dashboard.schedule.appointment_plural' => 'appointments',
			'vendor_dashboard.schedule.service_fallback' => 'Service',
			'vendor_dashboard.schedule.customer_fallback' => 'Customer',
			'vendor_dashboard.schedule.status_pending' => 'Pending',
			'vendor_dashboard.schedule.status_accepted' => 'Accepted',
			'vendor_dashboard.schedule.status_en_route' => 'En Route',
			'vendor_dashboard.schedule.status_arrived' => 'Arrived',
			'vendor_dashboard.schedule.status_active' => 'Active',
			'vendor_dashboard.schedule.status_done' => 'Done',
			'vendor_dashboard.schedule.status_cancelled' => 'Cancelled',
			'vendor_dashboard.schedule.status_unknown' => 'Unknown',
			'vendor_dashboard.support.screen_title' => 'Support',
			'vendor_dashboard.support.faq_title' => 'FAQ\'s',
			'vendor_dashboard.support.contact_us' => 'CONTACT US',
			'vendor_dashboard.support.contact_description' => 'Reach out to us through live chat or email for quick assistance.',
			'vendor_dashboard.support.email_us' => 'Email US',
			'vendor_dashboard.support.chat' => 'CHAT',
			'vendor_dashboard.support.or' => 'or',
			'vendor_dashboard.support.submit_ticket' => 'SUBMIT A TICKET',
			'vendor_dashboard.support.faq_1_question' => '1. How can I register as a vendor?',
			'vendor_dashboard.support.faq_1_answer' => 'To register, click on the "Vendor Sign-Up" option, complete the registration form with your business details, and submit the required documents for verification.',
			'vendor_dashboard.support.faq_2_question' => '2. Is there a fee for listing my services?',
			'vendor_dashboard.support.faq_3_question' => '3. How will I receive payments?',
			'vendor_dashboard.support.faq_4_question' => '4. Can I edit my service listings?',
			'vendor_dashboard.support.faq_5_question' => '5. How do I contact customer support?',
			'vendor_dashboard.wallet.screen_title' => 'Motiva Wallet',
			'vendor_dashboard.wallet.total_label' => 'Total (KWD):',
			'vendor_dashboard.wallet.withdraw' => 'withDrew',
			'vendor_dashboard.wallet.tabs.daily' => 'Daily',
			'vendor_dashboard.wallet.tabs.weekly' => 'Weekly',
			'vendor_dashboard.wallet.tabs.monthly' => 'Monthly',
			'vendor_dashboard.wallet.completed_jobs' => 'Completed Jobs',
			'vendor_dashboard.wallet.history' => 'History',
			'vendor_dashboard.wallet.stats.total_sales' => 'Total Sales',
			'vendor_dashboard.wallet.stats.total_earnings' => 'Total Earnings',
			'vendor_dashboard.wallet.stats.average_rating' => 'Average Rating',
			'vendor_dashboard.wallet.stats.cancellation_rate' => 'Cancellation Rate',
			'vendor_dashboard.wallet.history_status.in_progress' => 'Under Progress',
			'vendor_dashboard.wallet.history_status.rejected' => 'Rejected',
			'vendor_dashboard.wallet.id_label' => 'Id: {id}',
			'vendor_dashboard.wallet.payout_request.title' => 'Withdraw Funds',
			'vendor_dashboard.wallet.payout_request.amount_label' => 'Amount (KWD)',
			'vendor_dashboard.wallet.payout_request.amount_hint' => 'Enter amount to withdraw',
			'vendor_dashboard.wallet.payout_request.bank_details' => 'Bank Details',
			'vendor_dashboard.wallet.payout_request.bank_name' => 'Bank Name',
			'vendor_dashboard.wallet.payout_request.account_number' => 'Account Number',
			'vendor_dashboard.wallet.payout_request.account_holder' => 'Account Holder',
			'vendor_dashboard.wallet.payout_request.kuwait_code' => 'Kuwait Code',
			'vendor_dashboard.wallet.payout_request.update_bank_details' => 'Update Bank Details',
			'vendor_dashboard.wallet.payout_request.submit' => 'Submit Payout Request',
			'vendor_dashboard.wallet.payout_request.insufficient_balance' => 'Insufficient wallet balance',
			'vendor_dashboard.wallet.payout_request.invalid_amount' => 'Please enter a valid amount',
			'vendor_dashboard.wallet.payout_request.success' => 'Payout request submitted successfully',
			'vendor_dashboard.wallet.payout_request.error' => 'Failed to submit payout request',
			'vendor_dashboard.wallet.payout_request.no_bank_details' => 'No bank details found. Please add bank details first.',
			'vendor_dashboard.wallet.coming_soon_message' => 'Wallet balance can be used for payments — coming soon!',
			'vendor_dashboard.wallet.no_transactions' => 'No transactions yet',
			'vendor_dashboard.wallet.error_loading' => 'Failed to load wallet data',
			'vendor_dashboard.wallet.retry' => 'Retry',
			'vendor_dashboard.wallet.payout_status.pending' => 'Pending',
			'vendor_dashboard.wallet.payout_status.processed' => 'Processed',
			'vendor_dashboard.wallet.payout_status.rejected' => 'Rejected',
			'vendor_dashboard.wallet.payout_request_card_title' => 'Payout Request',
			'vendor_dashboard.wallet.available_balance' => 'Available Balance',
			'vendor_dashboard.wallet.failed_to_load_balance' => 'Failed to load balance',
			'vendor_dashboard.wallet.submitting' => 'SUBMITTING...',
			'vendor_dashboard.wallet.months.jan' => 'Jan',
			'vendor_dashboard.wallet.months.feb' => 'Feb',
			'vendor_dashboard.wallet.months.mar' => 'Mar',
			'vendor_dashboard.wallet.months.apr' => 'Apr',
			'vendor_dashboard.wallet.months.may' => 'May',
			'vendor_dashboard.wallet.months.jun' => 'Jun',
			'vendor_dashboard.wallet.months.jul' => 'Jul',
			'vendor_dashboard.wallet.months.aug' => 'Aug',
			'vendor_dashboard.wallet.months.sep' => 'Sep',
			'vendor_dashboard.wallet.months.oct' => 'Oct',
			'vendor_dashboard.wallet.months.nov' => 'Nov',
			'vendor_dashboard.wallet.months.dec' => 'Dec',
			'vendor_dashboard.wallet.reference_types.order' => 'Order Payment',
			'vendor_dashboard.wallet.reference_types.refund' => 'Refund',
			'vendor_dashboard.wallet.reference_types.voucher' => 'Voucher Redemption',
			'vendor_dashboard.wallet.reference_types.adjustment' => 'Adjustment',
			'vendor_dashboard.wallet.reference_types.admin' => 'Admin Credit',
			'vendor_dashboard.wallet.reference_types.payout_hold' => 'Payout Hold',
			'vendor_dashboard.wallet.reference_types.payout_release' => 'Payout Released',
			'vendor_dashboard.wallet.reference_types.product_order' => 'Product Order',
			'vendor_dashboard.operators.screen_title' => 'Operators',
			'vendor_dashboard.operators.active' => 'Active',
			'vendor_dashboard.operators.inactive' => 'Inactive',
			'vendor_dashboard.operators.empty_title' => 'No Operators Yet',
			'vendor_dashboard.operators.empty_subtitle' => 'Add your first operator to get started',
			'vendor_dashboard.operators.error_loading' => 'Error Loading Operators',
			'vendor_dashboard.operators.add_new' => 'Add New Operator',
			'vendor_dashboard.add_operator.screen_title' => 'Add New Operator',
			'vendor_dashboard.add_operator.success' => 'Operator added successfully',
			'vendor_dashboard.add_operator.email_exists' => 'This email is already registered',
			'vendor_dashboard.add_operator.phone_exists' => 'This phone number is already registered',
			'vendor_dashboard.add_operator.failed' => 'Failed to add operator',
			'vendor_dashboard.add_operator.section_title' => 'Operator Information',
			'vendor_dashboard.add_operator.full_name' => 'Full Name',
			'vendor_dashboard.add_operator.name_error' => 'Please enter the operator name',
			'vendor_dashboard.add_operator.phone_number' => 'Phone Number',
			'vendor_dashboard.add_operator.phone_error' => 'Please enter the operator phone number',
			'vendor_dashboard.add_operator.email_address' => 'Email Address',
			'vendor_dashboard.add_operator.email_error' => 'Please enter the operator email',
			'vendor_dashboard.add_operator.password' => 'Password',
			'vendor_dashboard.add_operator.password_error' => 'Please enter a password',
			'vendor_dashboard.add_operator.password_min_error' => 'Password must be at least 8 characters',
			'vendor_dashboard.add_operator.loading' => 'loading',
			'vendor_dashboard.add_operator.add_operator_button' => 'Add Operator',
			'vendor_dashboard.settings.screen_title' => 'SETTINGS',
			'vendor_dashboard.settings.search_hint' => 'Search settings',
			'vendor_dashboard.settings.not_found' => 'No settings found',
			'vendor_dashboard.settings.menu.uploaded_documents' => 'Uploaded Documents',
			'vendor_dashboard.settings.menu.service_area' => 'Service Area',
			'vendor_dashboard.settings.menu.business_logo' => 'Business Logo',
			'vendor_dashboard.settings.menu.cover_image' => 'Cover Image',
			'vendor_dashboard.settings.menu.working_hours' => 'Working Hours',
			'vendor_dashboard.settings.menu.notifications' => 'Notifications',
			'vendor_dashboard.settings.menu.language' => 'Language',
			'vendor_dashboard.settings.menu.app_mode' => 'App Mode',
			'vendor_dashboard.settings.menu.logout' => 'Logout',
			'vendor_dashboard.settings.menu.delete_account' => 'Delete Account',
			'vendor_dashboard.settings.delete_account_confirm.title' => 'Delete Account?',
			'vendor_dashboard.settings.delete_account_confirm.message' => 'Are you sure you want to delete your account? This action is permanent and cannot be undone.',
			'vendor_dashboard.settings.delete_account_confirm.confirm' => 'Delete',
			'vendor_dashboard.settings.delete_account_confirm.cancel' => 'Cancel',
			'vendor_dashboard.settings.delete_account_confirm.error' => 'Failed to delete account. Please try again.',
			'vendor_dashboard.working_hours.screen_title' => 'Working hours',
			'vendor_dashboard.working_hours.schedule_exceptions' => 'Schedule Exceptions',
			'vendor_dashboard.working_hours.starting_hour' => 'Starting Hour',
			'vendor_dashboard.working_hours.closing_hour' => 'Closing Hour',
			'vendor_dashboard.working_hours.off_days' => 'Off days',
			'vendor_dashboard.working_hours.saving' => 'Saving...',
			'vendor_dashboard.working_hours.save' => 'Save',
			'vendor_dashboard.working_hours.update_success' => 'Working hours updated successfully',
			'vendor_dashboard.working_hours.update_failed' => 'Failed to update working hours',
			'vendor_dashboard.working_hours.select_off_days' => 'Select Off Days',
			'vendor_dashboard.working_hours.done' => 'Done',
			'vendor_dashboard.working_hours.error' => 'Error: {error}',
			'vendor_dashboard.documents.screen_title' => 'Documents',
			'vendor_dashboard.documents.commercial_license' => 'Commercial License',
			'vendor_dashboard.documents.civil_id' => 'Civil Id',
			'vendor_dashboard.documents.upload_success' => 'Upload Successful',
			'vendor_dashboard.documents.re_upload_note' => 'Re-uploads require admin approval.',
			'vendor_dashboard.documents.browse' => 'Browse',
			'vendor_dashboard.documents.your_file' => 'your File',
			'vendor_dashboard.documents.max_size' => 'Max 10 MB files are allowed',
			'vendor_dashboard.business_logo.screen_title' => 'Business logo',
			'vendor_dashboard.business_logo.instructions_title' => 'General Upload Instructions',
			'vendor_dashboard.business_logo.instructions_text' => 'When uploading your logo, ensure it meets the recommended dimensions of 500x500 pixels or larger for optimal quality.\nUse PNG or JPEG formats with a maximum file size of 2 MB.\nFor PNG files, a transparent background is ideal, while JPEG files should have a plain backdrop.\nMake sure the logo is clear and free from pixelation to maintain a professional appearance.',
			'vendor_dashboard.business_logo.logo_updated' => 'Logo updated successfully',
			'vendor_dashboard.cover_image.screen_title' => 'Cover Image',
			'vendor_dashboard.cover_image.updated_success' => 'Cover image updated successfully',
			'vendor_dashboard.cover_image.guidelines_title' => 'Cover Image Guidelines',
			'vendor_dashboard.cover_image.guidelines_text' => 'Your cover image is displayed at the top of your vendor page.\n\nRecommended dimensions: 1200 x 400 pixels or larger.\nUse PNG or JPEG formats with a maximum file size of 10 MB.\n\nTips:\n• Use a high-quality image that represents your business\n• Avoid text-heavy images as they may be hard to read on mobile\n• Make sure the image is not pixelated or blurry',
			'vendor_dashboard.service_area.screen_title' => 'Cities of Service',
			'vendor_dashboard.service_area.search_hint' => 'Search City',
			'vendor_dashboard.service_categories.screen_title' => 'Service Categories',
			'vendor_dashboard.service_categories.add_new' => 'add new',
			'vendor_dashboard.service_categories.oil_filters' => 'Oil Filters',
			'vendor_dashboard.service_categories.fix_my_car' => 'Fix my Car',
			'vendor_dashboard.service_categories.car_batteries' => 'Car Batteries',
			'vendor_dashboard.schedule_exceptions.screen_title' => 'Schedule Exceptions',
			'vendor_dashboard.schedule_exceptions.load_failed' => 'Failed to load schedule exceptions',
			'vendor_dashboard.schedule_exceptions.retry' => 'Retry',
			'vendor_dashboard.schedule_exceptions.empty_title' => 'No schedule exceptions',
			'vendor_dashboard.schedule_exceptions.empty_subtitle' => 'Add exceptions for holidays or special days',
			'vendor_dashboard.schedule_exceptions.add_button' => 'Add Exception',
			'vendor_dashboard.schedule_exceptions.delete_tooltip' => 'Delete exception',
			'vendor_dashboard.schedule_exceptions.fully_closed' => 'Fully Closed',
			'vendor_dashboard.schedule_exceptions.modified_hours' => 'Modified Hours',
			'vendor_dashboard.schedule_exceptions.hours_label' => 'Hours: {start} - {end}',
			'vendor_dashboard.schedule_exceptions.reason_label' => 'Reason: {reason}',
			'vendor_dashboard.schedule_exceptions.delete_dialog_title' => 'Delete Exception',
			'vendor_dashboard.schedule_exceptions.delete_dialog_message' => 'Are you sure you want to delete this schedule exception?',
			'vendor_dashboard.schedule_exceptions.cancel' => 'Cancel',
			'vendor_dashboard.schedule_exceptions.delete' => 'Delete',
			'vendor_dashboard.schedule_exceptions.delete_success' => 'Exception deleted successfully',
			'vendor_dashboard.schedule_exceptions.delete_failed' => 'Failed to delete exception',
			'vendor_dashboard.schedule_exceptions.add_dialog_title' => 'Add Schedule Exception',
			'vendor_dashboard.schedule_exceptions.date_label' => 'Date',
			'vendor_dashboard.schedule_exceptions.fully_closed_switch' => 'Fully Closed',
			'vendor_dashboard.schedule_exceptions.start_time' => 'Start Time',
			'vendor_dashboard.schedule_exceptions.select_time' => 'Select',
			'vendor_dashboard.schedule_exceptions.end_time' => 'End Time',
			'vendor_dashboard.schedule_exceptions.reason_optional' => 'Reason (optional)',
			'vendor_dashboard.schedule_exceptions.select_times_error' => 'Please select start and end times',
			'vendor_dashboard.schedule_exceptions.add_success' => 'Exception added successfully',
			'vendor_dashboard.schedule_exceptions.add_failed' => 'Failed to add exception',
			'vendor_dashboard.schedule_exceptions.add_button_dialog' => 'Add',
			'vendor_dashboard.schedule_exceptions.error' => 'Error: {error}',
			'vendor_dashboard.recent_completed.title' => 'Recent Completed',
			'vendor_dashboard.recent_completed.see_all' => 'See all',
			'vendor_dashboard.recent_completed.empty' => 'No completed orders yet',
			'vendor_dashboard.recent_completed.service_fallback' => 'Service',
			'vendor_dashboard.recent_completed.customer_fallback' => 'Customer',
			'vendor_dashboard.todays_schedule.title' => 'Today\'s Schedule',
			'vendor_dashboard.todays_schedule.view_calendar' => 'View Calendar',
			'vendor_dashboard.todays_schedule.view_full_calendar' => 'View Full Calendar',
			'vendor_dashboard.todays_schedule.empty' => 'No appointments today',
			'vendor_dashboard.todays_schedule.asap' => 'ASAP',
			'vendor_dashboard.todays_schedule.service_fallback' => 'Service',
			'vendor_dashboard.request_cards.order_ref' => 'Order Ref',
			'vendor_dashboard.request_cards.amount' => 'Amount',
			'vendor_dashboard.request_cards.completed' => 'Completed',
			'vendor_dashboard.request_cards.time' => 'Time',
			'vendor_dashboard.request_cards.status' => 'Status',
			'vendor_dashboard.request_cards.view_details' => 'VIEW DETAILS',
			'vendor_dashboard.request_cards.view_details_normal' => 'View Details',
			'vendor_dashboard.request_cards.proceed' => 'Proceed',
			'vendor_dashboard.request_cards.service_fallback' => 'Service',
			'vendor_dashboard.request_cards.customer_fallback' => 'Customer',
			'vendor_dashboard.promo_banner.title' => 'Save upTo KD 5',
			'vendor_dashboard.promo_banner.description' => 'Limited time offer on specific\nservices',
			'vendor_dashboard.profile_menu.all_orders' => 'All Orders',
			'vendor_dashboard.profile_menu.my_listings' => 'My Listings',
			'vendor_dashboard.profile_menu.inventory_history' => 'Inventory History',
			'vendor_dashboard.profile_menu.wallet' => 'Wallet',
			'vendor_dashboard.profile_menu.faqs' => 'FAQs',
			'vendor_dashboard.unified_order_card.service_order' => 'Service Order',
			'vendor_dashboard.unified_order_card.product_order' => 'Product Order',
			'vendor_dashboard.unified_order_card.service_fallback' => 'Service',
			'vendor_dashboard.unified_order_card.customer_fallback' => 'Customer',
			'vendor_dashboard.unified_order_card.item_singular' => 'item',
			'vendor_dashboard.unified_order_card.item_plural' => 'items',
			'vendor_dashboard.unified_order_card.reference' => 'Reference',
			'vendor_dashboard.unified_order_card.amount' => 'Amount',
			'vendor_dashboard.unified_order_card.time' => 'Time',
			'vendor_dashboard.unified_order_card.status' => 'Status',
			'vendor_dashboard.unified_order_card.date' => 'Date',
			'vendor_listings.screen_title' => 'MY LISTINGS',
			'vendor_listings.search_hint' => 'Search listings...',
			'vendor_listings.filter_all' => 'All',
			'vendor_listings.filter_product' => 'Product',
			'vendor_listings.filter_service' => 'Service',
			'vendor_listings.snackbar.product_deactivated' => 'Product deactivated',
			'vendor_listings.snackbar.product_activated' => 'Product activated',
			'vendor_listings.snackbar.update_status_failed' => 'Failed to update product status',
			'vendor_listings.snackbar.product_deleted' => 'Product deleted successfully',
			'vendor_listings.snackbar.delete_failed' => 'Failed to delete product',
			'vendor_listings.snackbar.service_archived' => 'Service archived successfully',
			'vendor_listings.snackbar.archive_failed' => 'Failed to archive service',
			'vendor_listings.snackbar.service_restored' => 'Service restored successfully',
			'vendor_listings.snackbar.restore_failed' => 'Failed to restore service',
			'vendor_listings.dialog.delete_product_title' => 'Delete Product',
			'vendor_listings.dialog.delete_product_message' => 'Are you sure you want to delete "{name}"? This action cannot be undone.',
			'vendor_listings.dialog.delete_confirm' => 'Delete',
			'vendor_listings.dialog.archive_service_title' => 'Archive Service',
			'vendor_listings.dialog.archive_service_message' => 'Are you sure you want to archive "{name}"? It will be hidden from customers.',
			'vendor_listings.dialog.archive_confirm' => 'Archive',
			'vendor_listings.empty.no_results' => 'No Results Found',
			'vendor_listings.empty.no_products' => 'No Products Yet',
			'vendor_listings.empty.no_services' => 'No Services Yet',
			'vendor_listings.empty.no_listings' => 'No Listings Yet',
			'vendor_listings.empty.adjust_search' => 'Try adjusting your search terms.',
			'vendor_listings.empty.create_product_prompt' => 'Create your first product to start selling.',
			'vendor_listings.empty.create_service_prompt' => 'Create your first service to start receiving orders.',
			'vendor_listings.empty.create_listing_prompt' => 'Create your first listing to start receiving orders.',
			'vendor_listings.empty.create_listing_button' => 'Create Listing',
			'vendor_listings.error.title' => 'Error Loading Listings',
			'vendor_listings.error.message' => 'Something went wrong. Please try again.',
			'vendor_listings.error.retry' => 'Retry',
			'vendor_listings.bottom_sheet.title' => 'Create New',
			'vendor_listings.bottom_sheet.product_label' => 'Product',
			'vendor_listings.bottom_sheet.product_description' => 'Add a new product to your catalog',
			'vendor_listings.bottom_sheet.service_label' => 'Service',
			'vendor_listings.bottom_sheet.service_description' => 'Add a new service offering',
			'vendor_listings.card.type_product' => 'Product',
			'vendor_listings.card.type_service' => 'Service',
			'vendor_listings.card.stock_label' => 'Stock: {count}',
			'vendor_listings.card.status_active' => 'Active',
			'vendor_listings.card.status_inactive' => 'Inactive',
			'vendor_listings.card.status_archived' => 'Archived',
			'vendor_listings.card.currency_suffix' => ' KWD',
			'vendor_listings.tooltip.activate' => 'Activate',
			'vendor_listings.tooltip.deactivate' => 'Deactivate',
			'vendor_listings.tooltip.archive' => 'Archive',
			'vendor_listings.tooltip.restore' => 'Restore',
			'vendor_listings.tooltip.edit' => 'Edit',
			'vendor_listings.tooltip.delete' => 'Delete',
			'vendor_listings.category.active' => 'active',
			'vendor_listings.category.inactive' => 'inactive',
			'vendor_listings.category.services_fallback' => 'Services',
			'vendor_listings.category.products_fallback' => 'Products',
			'vendor_products.screen_title' => 'MY PRODUCTS',
			'vendor_products.search_hint' => 'Search Products...',
			'vendor_products.filter_all' => 'All',
			'vendor_products.filter_active' => 'Active',
			'vendor_products.filter_inactive' => 'Inactive',
			'vendor_products.empty.no_results' => 'No Results Found',
			'vendor_products.empty.no_products' => 'No Products Yet',
			'vendor_products.empty.no_inactive_products' => 'No Inactive Products',
			'vendor_products.empty.inactive_subtitle' => 'Inactive products will appear here.',
			'vendor_products.empty.adjust_search' => 'Try adjusting your search terms.',
			'vendor_products.empty.create_product_prompt' => 'Create your first product to start selling.',
			'vendor_products.empty.create_product_button' => 'Create Product',
			'vendor_products.dialog.delete_title' => 'Delete Product',
			'vendor_products.dialog.delete_message' => 'Are you sure you want to delete "{name}"? This action cannot be undone.',
			'vendor_products.dialog.cancel' => 'Cancel',
			'vendor_products.dialog.delete' => 'Delete',
			'vendor_products.snackbar.product_deleted' => 'Product deleted successfully',
			'vendor_products.snackbar.delete_failed' => 'Failed to delete product',
			'vendor_products.snackbar.product_deactivated' => 'Product deactivated',
			'vendor_products.snackbar.product_activated' => 'Product activated',
			'vendor_products.snackbar.update_status_failed' => 'Failed to update product status',
			'vendor_products.error.title' => 'Error Loading Products',
			'vendor_products.error.message' => 'Something went wrong. Please try again.',
			'vendor_products.error.retry' => 'Retry',
			'vendor_products.card.inactive' => 'Inactive',
			'vendor_products.card.stock_label' => 'Stock: {count}',
			'vendor_products.card.type_accessory' => 'Accessory',
			'vendor_products.card.type_spare_part' => 'Spare Part',
			'vendor_products.tooltip.activate' => 'Activate',
			'vendor_products.tooltip.deactivate' => 'Deactivate',
			'vendor_products.tooltip.edit' => 'Edit',
			'vendor_products.tooltip.delete' => 'Delete',
			'vendor_products.create_product.app_bar_new' => 'New Product',
			'vendor_products.create_product.app_bar_edit' => 'Edit Product',
			'vendor_products.create_product.field_name_label' => 'Product Name',
			'vendor_products.create_product.field_name_hint' => 'e.g., Brake Pads',
			'vendor_products.create_product.field_description_label' => 'Description (Optional)',
			'vendor_products.create_product.field_description_hint' => 'Describe your product',
			'vendor_products.create_product.field_price_label' => 'Price (KWD)',
			'vendor_products.create_product.field_price_hint' => '0.00',
			'vendor_products.create_product.field_stock_label' => 'Stock Quantity',
			'vendor_products.create_product.field_stock_hint' => '10',
			'vendor_products.create_product.product_type_label' => 'Product Type',
			'vendor_products.create_product.product_type_accessory' => 'Accessory',
			'vendor_products.create_product.product_type_spare_part' => 'Spare Part',
			'vendor_products.create_product.images_title' => 'Product Images',
			'vendor_products.create_product.images_subtitle' => 'Upload images to showcase your product',
			'vendor_products.create_product.add_image_button' => 'Add',
			'vendor_products.create_product.button_create' => 'Create Product',
			'vendor_products.create_product.button_save' => 'Save Changes',
			'vendor_products.create_product.snackbar_created' => 'Product created successfully',
			'vendor_products.create_product.snackbar_updated' => 'Product updated successfully',
			'vendor_products.create_product.snackbar_create_failed' => 'Failed to create product. Please check your inputs and try again.',
			'vendor_products.create_product.snackbar_update_failed' => 'Failed to update product. Please check your inputs and try again.',
			'vendor_products.create_product.validation_required' => '{field} is required',
			_ => null,
		} ?? switch (path) {
			'vendor_products.create_product.validation_valid_number' => 'Enter a valid {field}',
			'vendor_products.create_product.spare_part_section_title' => 'Spare Part Specifications',
			'vendor_products.create_product.part_number_label' => 'Part Number',
			'vendor_products.create_product.brand_label' => 'Brand',
			'vendor_products.create_product.warranty_label' => 'Warranty (months)',
			'vendor_products.create_product.compatibility_label' => 'Compatibility',
			'vendor_products.create_product.compatibility_empty' => 'No compatibility entries',
			'vendor_products.create_product.compatibility_make' => 'Make',
			'vendor_products.create_product.compatibility_model' => 'Model',
			'vendor_products.create_product.compatibility_year_from' => 'Year from',
			'vendor_products.create_product.compatibility_year_to' => 'Year to',
			'vendor_products.create_product.compatibility_add' => 'Add',
			'inventory.screen_title' => 'INVENTORY HISTORY',
			'inventory.filter_all' => 'All',
			'inventory.filter_stock_in' => 'Stock In',
			'inventory.filter_stock_out' => 'Stock Out',
			'inventory.filter_adjustment' => 'Adjustment',
			'inventory.filter_refund' => 'Refund',
			'inventory.empty.title' => 'No Transactions Found',
			'inventory.empty.filtered_subtitle' => 'Try adjusting your filters.',
			'inventory.empty.subtitle' => 'Inventory transactions will appear here.',
			'inventory.error.title' => 'Error Loading Transactions',
			'inventory.error.message' => 'Something went wrong. Please try again.',
			'inventory.error.retry' => 'Retry',
			'inventory.card.before' => 'Before:',
			'inventory.card.after' => 'After:',
			'inventory.card.reason' => 'Reason:',
			'inventory.from_date' => 'From {date}',
			'inventory.until_date' => 'Until {date}',
			'inventory.transaction_type.sale' => 'Stock Out',
			'inventory.transaction_type.restock' => 'Stock In',
			'inventory.transaction_type.adjustment' => 'Adjustment',
			'inventory.transaction_type.refund' => 'Refund',
			'vendor_services.screen.title' => 'MY SERVICES',
			'vendor_services.screen.search_hint' => 'Search Services... ',
			'vendor_services.filter.all' => 'All',
			'vendor_services.filter.active' => 'Active',
			'vendor_services.filter.archived' => 'Archived',
			'vendor_services.empty.search.title' => 'No Results Found',
			'vendor_services.empty.search.subtitle' => 'Try adjusting your search terms.',
			'vendor_services.empty.archived.title' => 'No Archived Services',
			'vendor_services.empty.archived.subtitle' => 'Archived services will appear here.',
			'vendor_services.empty.no_services.title' => 'No Services Yet',
			'vendor_services.empty.no_services.subtitle' => 'Create your first service to start receiving orders.',
			'vendor_services.empty.no_services.action' => 'Create Service',
			'vendor_services.error.title' => 'Error Loading Services',
			'vendor_services.error.subtitle' => 'Something went wrong. Please try again.',
			'vendor_services.error.retry' => 'Retry',
			'vendor_services.create_screen.app_bar.new_title' => 'New Service',
			'vendor_services.create_screen.app_bar.edit' => 'Edit Service',
			'vendor_services.create_screen.form.service_name.label' => 'Service Name',
			'vendor_services.create_screen.form.service_name.hint' => 'e.g., Premium Car Wash',
			'vendor_services.create_screen.form.service_name.required' => '{field} is required',
			'vendor_services.create_screen.form.description.label' => 'Description (Optional)',
			'vendor_services.create_screen.form.description.hint' => 'Describe your service',
			'vendor_services.create_screen.form.base_price.label' => 'Base Price (KWD)',
			'vendor_services.create_screen.form.base_price.hint' => '0.00',
			'vendor_services.create_screen.form.radius.label' => 'Service Radius (km)',
			'vendor_services.create_screen.form.radius.hint' => '20',
			'vendor_services.create_screen.image_upload.title' => 'Service Image',
			'vendor_services.create_screen.image_upload.subtitle' => 'Upload an image to showcase your service',
			'vendor_services.create_screen.image_upload.uploading' => 'Uploading...',
			'vendor_services.create_screen.image_upload.change' => 'Change Image',
			'vendor_services.create_screen.image_upload.placeholder_title' => 'Tap to upload service image',
			'vendor_services.create_screen.image_upload.placeholder_subtitle' => 'Recommended: 800x600 pixels',
			'vendor_services.create_screen.attributes.title' => 'Service Attributes',
			'vendor_services.create_screen.attributes.required_badge' => 'Required',
			'vendor_services.create_screen.attributes.subtitle' => 'Fill in the details specific to this service type',
			'vendor_services.create_screen.attributes.hint' => 'Enter {field}',
			'vendor_services.create_screen.customer_questions.title' => 'Customer Questions',
			'vendor_services.create_screen.customer_questions.subtitle' => 'Define questions customers must answer when booking this service.',
			'vendor_services.create_screen.customer_questions.add_button' => 'Add Customer Question',
			'vendor_services.create_screen.customer_questions.required_suffix' => ' *',
			'vendor_services.create_screen.button.save' => 'Save Changes',
			'vendor_services.create_screen.button.create' => 'Create Service',
			'vendor_services.create_screen.button.restore' => 'Restore Service',
			'vendor_services.create_screen.snackbar.create_success' => 'Service created successfully',
			'vendor_services.create_screen.snackbar.update_success' => 'Service updated successfully',
			'vendor_services.create_screen.snackbar.create_failed' => 'Failed to create service. Please check your inputs and try again.',
			'vendor_services.create_screen.snackbar.update_failed' => 'Failed to update service. Please check your inputs and try again.',
			'vendor_services.create_screen.snackbar.archive_success' => 'Service archived successfully',
			'vendor_services.create_screen.snackbar.archive_failed' => 'Failed to archive service',
			'vendor_services.create_screen.snackbar.restore_success' => 'Service restored successfully',
			'vendor_services.create_screen.snackbar.restore_failed' => 'Failed to restore service',
			'vendor_services.create_screen.snackbar.question_added' => 'Customer question added',
			'vendor_services.create_screen.dialog.archive_title' => 'Archive Service',
			'vendor_services.create_screen.dialog.archive_message' => 'Are you sure you want to archive "{name}"? It will be hidden from customers.',
			'vendor_services.create_screen.dialog.archive_confirm' => 'Archive',
			'vendor_services.create_screen.dialog.add_question_title' => 'Add Customer Question',
			'vendor_services.create_screen.dialog.label' => 'Label',
			'vendor_services.create_screen.dialog.label_hint' => 'e.g., Vehicle Photo',
			'vendor_services.create_screen.dialog.type' => 'Type',
			'vendor_services.create_screen.dialog.required' => 'Required',
			'vendor_services.create_screen.dialog.options_label' => 'Options (comma-separated)',
			'vendor_services.create_screen.dialog.options_hint' => 'e.g., comprehensive, third_party, theft_fire',
			'vendor_services.create_screen.dialog.min' => 'Min',
			'vendor_services.create_screen.dialog.max' => 'Max',
			'vendor_services.create_screen.dialog.cancel' => 'Cancel',
			'vendor_services.create_screen.dialog.add' => 'Add',
			'vendor_services.create_screen.error.no_category' => 'No service category available. Please contact support.',
			'vendor_services.create_screen.error.load_category' => 'Failed to load category schema',
			'vendor_services.select_category.title' => 'SELECT CATEGORY',
			'vendor_services.select_category.search_hint' => 'Search categories...',
			'vendor_services.select_category.empty.title' => 'No Categories Available',
			'vendor_services.select_category.empty.subtitle' => 'Service categories have not been configured yet. Please contact support.',
			'vendor_services.select_category.search_empty.title' => 'No Categories Found',
			'vendor_services.select_category.search_empty.subtitle' => 'Try a different search term.',
			'vendor_services.select_category.error.title' => 'Failed to Load Categories',
			'vendor_services.select_category.error.subtitle' => 'Something went wrong. Please try again.',
			'vendor_services.select_category.error.retry' => 'Retry',
			'vendor_services.service_card.archived_badge' => 'Archived',
			'vendor_services.service_card.price_format' => '{price} KWD',
			'vendor_services.service_card.radius_format' => '{radius} km',
			'vendor_services.service_card.tooltip.edit' => 'Edit',
			'vendor_services.service_card.tooltip.archive' => 'Archive',
			'vendor_services.service_card.action.restore' => 'Restore',
			'vendor_services.category_section.fallback_name' => 'Services',
			'vendor_services.category_section.status' => '{active} active',
			'vendor_services.category_section.status_with_archived' => '{active} active • {archived} archived',
			'vendor_services.category_section.dialog.archive_title' => 'Archive Service',
			'vendor_services.category_section.dialog.archive_message' => 'Are you sure you want to archive "{name}"? It will be hidden from customers.',
			'vendor_services.category_section.dialog.archive_confirm' => 'Archive',
			'vendor_services.category_section.dialog.restore_title' => 'Restore Service',
			'vendor_services.category_section.dialog.restore_message' => 'Restore "{name}"? It will be visible to customers again.',
			'vendor_services.category_section.dialog.restore_confirm' => 'Restore',
			'vendor_services.category_section.snackbar.archive_success' => 'Service archived successfully',
			'vendor_services.category_section.snackbar.archive_failed' => 'Failed to archive service',
			'vendor_services.category_section.snackbar.restore_success' => 'Service restored successfully',
			'vendor_services.category_section.snackbar.restore_failed' => 'Failed to restore service',
			'vendor_product_analytics.screen_title' => 'Analytics',
			'vendor_product_analytics.stock' => 'Stock',
			'vendor_product_analytics.metrics.total_views' => 'Total Views',
			'vendor_product_analytics.metrics.conversion' => 'Conversion',
			'vendor_product_analytics.metrics.total_orders' => 'Total Orders',
			'vendor_product_analytics.time_period.k7d' => '7D',
			'vendor_product_analytics.time_period.k30d' => '30D',
			'vendor_product_analytics.time_period.k90d' => '90D',
			'vendor_product_analytics.charts.revenue_over_time' => 'Revenue Over Time',
			'vendor_product_analytics.charts.top_products' => 'Top Products',
			'vendor_product_analytics.charts.sales' => '{count} sales',
			'vendor_product_analytics.empty.no_revenue_data' => 'No revenue data available',
			'vendor_product_analytics.empty.no_product_sales_data' => 'No product sales data available',
			'vendor_product_analytics.error.title' => 'Error Loading Analytics',
			'vendor_product_analytics.error.message' => 'Something went wrong. Please try again.',
			'vendor_product_analytics.error.retry' => 'Retry',
			_ => null,
		};
	}
}
