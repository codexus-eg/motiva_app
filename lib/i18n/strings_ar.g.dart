///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsAr with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsAr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ar,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ar>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsAr _root = this; // ignore: unused_field

	@override 
	TranslationsAr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsAr(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsGeneralAr general = _TranslationsGeneralAr._(_root);
	@override late final _TranslationsAuthAr auth = _TranslationsAuthAr._(_root);
	@override late final _TranslationsBookingAr booking = _TranslationsBookingAr._(_root);
	@override late final _TranslationsHomeAr home = _TranslationsHomeAr._(_root);
	@override late final _TranslationsCartAr cart = _TranslationsCartAr._(_root);
	@override late final _TranslationsCheckoutAr checkout = _TranslationsCheckoutAr._(_root);
	@override late final _TranslationsPublicServicesAr public_services = _TranslationsPublicServicesAr._(_root);
	@override late final _TranslationsPublicMarketplaceAr public_marketplace = _TranslationsPublicMarketplaceAr._(_root);
	@override late final _TranslationsServicesAr services = _TranslationsServicesAr._(_root);
	@override late final _TranslationsBuyACarAr buy_a_car = _TranslationsBuyACarAr._(_root);
	@override late final _TranslationsReviewsAr reviews = _TranslationsReviewsAr._(_root);
	@override late final _TranslationsUserDashboardAr user_dashboard = _TranslationsUserDashboardAr._(_root);
	@override late final _TranslationsBottomNavAr bottom_nav = _TranslationsBottomNavAr._(_root);
	@override late final _TranslationsSellYourCarAr sell_your_car = _TranslationsSellYourCarAr._(_root);
	@override late final _TranslationsVendorDashboardAr vendor_dashboard = _TranslationsVendorDashboardAr._(_root);
	@override late final _TranslationsVendorListingsAr vendor_listings = _TranslationsVendorListingsAr._(_root);
	@override late final _TranslationsVendorProductsAr vendor_products = _TranslationsVendorProductsAr._(_root);
	@override late final _TranslationsInventoryAr inventory = _TranslationsInventoryAr._(_root);
	@override late final _TranslationsVendorServicesAr vendor_services = _TranslationsVendorServicesAr._(_root);
	@override late final _TranslationsVendorProductAnalyticsAr vendor_product_analytics = _TranslationsVendorProductAnalyticsAr._(_root);
}

// Path: general
class _TranslationsGeneralAr implements TranslationsGeneralEn {
	_TranslationsGeneralAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get app_name => 'تطبيق موتيفا';
}

// Path: auth
class _TranslationsAuthAr implements TranslationsAuthEn {
	_TranslationsAuthAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsAuthLoginAr login = _TranslationsAuthLoginAr._(_root);
	@override late final _TranslationsAuthRegisterAsAr register_as = _TranslationsAuthRegisterAsAr._(_root);
	@override late final _TranslationsAuthRegisterVendorAr register_vendor = _TranslationsAuthRegisterVendorAr._(_root);
	@override late final _TranslationsAuthRegisterCustomerAr register_customer = _TranslationsAuthRegisterCustomerAr._(_root);
	@override late final _TranslationsAuthVerifyAr verify = _TranslationsAuthVerifyAr._(_root);
	@override late final _TranslationsAuthCategoryAr category = _TranslationsAuthCategoryAr._(_root);
	@override late final _TranslationsAuthSplashAr splash = _TranslationsAuthSplashAr._(_root);
	@override String get phone_number => 'رقم الهاتف';
	@override String get password => 'كلمة المرور';
	@override String get confirm_password => 'تأكيد كلمة المرور';
	@override String get continue_button => 'متابعة';
	@override String get get_started => 'ابدأ';
	@override String get loading => 'جاري إرسال رمز التحقق...';
	@override String get already_have_account => 'لديك حساب بالفعل؟ ';
	@override String get login_button => 'تسجيل الدخول';
}

// Path: booking
class _TranslationsBookingAr implements TranslationsBookingEn {
	_TranslationsBookingAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBookingBookingScreenAr booking_screen = _TranslationsBookingBookingScreenAr._(_root);
	@override late final _TranslationsBookingOrderConfirmationAr order_confirmation = _TranslationsBookingOrderConfirmationAr._(_root);
}

// Path: home
class _TranslationsHomeAr implements TranslationsHomeEn {
	_TranslationsHomeAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsHomeServicesGridAr services_grid = _TranslationsHomeServicesGridAr._(_root);
	@override late final _TranslationsHomeCustomerAr customer = _TranslationsHomeCustomerAr._(_root);
	@override late final _TranslationsHomeVendorAr vendor = _TranslationsHomeVendorAr._(_root);
	@override late final _TranslationsHomeOperatorAr operator = _TranslationsHomeOperatorAr._(_root);
}

// Path: cart
class _TranslationsCartAr implements TranslationsCartEn {
	_TranslationsCartAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'سلة التسوق';
	@override String get error_loading => 'فشل تحميل السلة:';
	@override late final _TranslationsCartEmptyAr empty = _TranslationsCartEmptyAr._(_root);
	@override String get delivering_from => 'التوصيل من';
	@override String get all_items => 'جميع العناصر';
	@override String get special_request => 'طلب خاص';
	@override String get special_request_hint => 'اكتب أي طلب خاص بخصوص الطلب.';
	@override String get price => 'السعر';
	@override String get items => 'عناصر';
	@override String get promo_code => 'رمز الترويجي';
	@override String get total_amount => 'المبلغ الإجمالي';
	@override String get you_saved => 'لقد وفرت';
	@override String get order => 'في هذا الطلب';
	@override String get checkout_button => 'إتمام الشراء';
	@override String get vendor_subtitle => 'نحن جاهزون لخدمتك في أي وقت';
}

// Path: checkout
class _TranslationsCheckoutAr implements TranslationsCheckoutEn {
	_TranslationsCheckoutAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الدفع';
	@override String get order_summary => 'ملخص الطلب';
	@override String get subtotal => 'المجموع الفرعي';
	@override String get delivery_fee => 'رسوم التوصيل';
	@override String get voucher_discount => 'خصم القسيمة';
	@override String get wallet_used => 'المحفظة المستخدمة';
	@override String get total => 'الإجمالي';
	@override String get delivery_address => 'عنوان التوصيل';
	@override String get add_new_address => 'إضافة عنوان جديد';
	@override String get save_address => 'حفظ العنوان';
	@override String get voucher_code => 'رمز القسيمة';
	@override String get enter_voucher => 'أدخل رمز القسيمة';
	@override String get apply => 'تطبيق';
	@override String get voucher_applied => 'تم تطبيق القسيمة بنجاح!';
	@override String get wallet_balance => 'رصيد المحفظة';
	@override String get payment_methods => 'طرق الدفع';
	@override String get pay => 'ادفع';
	@override String get processing => 'جاري المعالجة...';
	@override String get order_confirmed => 'تم تأكيد الطلب!';
	@override String get order_placed => 'تم تقديم طلبك بنجاح.';
	@override String get total_payment => 'إجمالي الدفع';
	@override String get order_number => 'رقم الطلب #';
	@override String get payment_time => 'وقت الدفع';
	@override String get payment_method => 'طريقة الدفع';
	@override String get items => 'العناصر';
	@override String get estimated_delivery => 'التوصيل المتوقع';
	@override String get track_order => 'تتبع الطلب';
	@override String get back_home => 'العودة إلى الرئيسية';
	@override String get continue_shopping => 'مواصلة التسوق';
	@override String get motiva_wallet => 'محفظة موتيفا';
	@override String get balance => 'الرصيد:';
	@override String get fill_required_fields => 'يرجى ملء الحقول المطلوبة';
	@override String get address_label_hint => 'التسمية (مثال: المنزل، العمل)';
	@override String get street => 'الشارع *';
	@override String get area => 'المنطقة *';
	@override String get block => 'القطعة *';
	@override String get building => 'المبنى';
	@override String get floor => 'الدور';
	@override String get apartment => 'الشقة';
	@override String get notes => 'ملاحظات';
	@override String get default_address_label => 'العنوان';
	@override String get block_label => 'قطعة';
	@override String get building_label => 'مبنى';
	@override String get floor_label => 'الدور';
	@override String get apartment_label => 'شقة';
}

// Path: public_services
class _TranslationsPublicServicesAr implements TranslationsPublicServicesEn {
	_TranslationsPublicServicesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPublicServicesCategoryVendorsAr category_vendors = _TranslationsPublicServicesCategoryVendorsAr._(_root);
	@override late final _TranslationsPublicServicesVendorServicesAr vendor_services = _TranslationsPublicServicesVendorServicesAr._(_root);
	@override late final _TranslationsPublicServicesServicesDetailsAr services_details = _TranslationsPublicServicesServicesDetailsAr._(_root);
}

// Path: public_marketplace
class _TranslationsPublicMarketplaceAr implements TranslationsPublicMarketplaceEn {
	_TranslationsPublicMarketplaceAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPublicMarketplaceCategoryScreenAr category_screen = _TranslationsPublicMarketplaceCategoryScreenAr._(_root);
	@override late final _TranslationsPublicMarketplaceDetailsScreenAr details_screen = _TranslationsPublicMarketplaceDetailsScreenAr._(_root);
	@override late final _TranslationsPublicMarketplaceVendorDetailsScreenAr vendor_details_screen = _TranslationsPublicMarketplaceVendorDetailsScreenAr._(_root);
	@override late final _TranslationsPublicMarketplaceSparePartsAr spare_parts = _TranslationsPublicMarketplaceSparePartsAr._(_root);
}

// Path: services
class _TranslationsServicesAr implements TranslationsServicesEn {
	_TranslationsServicesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsServicesScreenAr screen = _TranslationsServicesScreenAr._(_root);
	@override late final _TranslationsServicesAllServicesGridAr all_services_grid = _TranslationsServicesAllServicesGridAr._(_root);
}

// Path: buy_a_car
class _TranslationsBuyACarAr implements TranslationsBuyACarEn {
	_TranslationsBuyACarAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBuyACarScreenAr screen = _TranslationsBuyACarScreenAr._(_root);
	@override late final _TranslationsBuyACarServiceSectionAr service_section = _TranslationsBuyACarServiceSectionAr._(_root);
	@override late final _TranslationsBuyACarGoodConditionScreenAr good_condition_screen = _TranslationsBuyACarGoodConditionScreenAr._(_root);
	@override late final _TranslationsBuyACarApprovedCarsScreenAr approved_cars_screen = _TranslationsBuyACarApprovedCarsScreenAr._(_root);
	@override late final _TranslationsBuyACarDamagedCarsScreenAr damaged_cars_screen = _TranslationsBuyACarDamagedCarsScreenAr._(_root);
	@override late final _TranslationsBuyACarDetailsScreenAr details_screen = _TranslationsBuyACarDetailsScreenAr._(_root);
	@override late final _TranslationsBuyACarCarChatAr car_chat = _TranslationsBuyACarCarChatAr._(_root);
	@override late final _TranslationsBuyACarListingCardAr listing_card = _TranslationsBuyACarListingCardAr._(_root);
	@override late final _TranslationsBuyACarFiltersAr filters = _TranslationsBuyACarFiltersAr._(_root);
}

// Path: reviews
class _TranslationsReviewsAr implements TranslationsReviewsEn {
	_TranslationsReviewsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'إرسال تقييم';
	@override String get rate_service => 'قيم الخدمة';
	@override String get your_review => 'تقييمك';
	@override String get review_placeholder => 'شارك تجربتك مع هذه الخدمة...';
	@override String get character_count => '/5000';
	@override String get submit_review => 'إرسال التقييم';
	@override String get submitting => 'جاري الإرسال...';
	@override String get success_message => 'تم إرسال التقييم بنجاح!';
	@override String get error_already_reviewed => 'لقد قمت بالفعل بتقييم هذا الطلب';
	@override String get error_validation => 'يرجى التحقق من إدخالك والمحاولة مرة أخرى';
	@override String get error_network => 'خطأ في الشبكة. يرجى المحاولة مرة أخرى';
	@override late final _TranslationsReviewsDisplayAr display = _TranslationsReviewsDisplayAr._(_root);
}

// Path: user_dashboard
class _TranslationsUserDashboardAr implements TranslationsUserDashboardEn {
	_TranslationsUserDashboardAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsUserDashboardProfileAr profile = _TranslationsUserDashboardProfileAr._(_root);
	@override late final _TranslationsUserDashboardMenuAr menu = _TranslationsUserDashboardMenuAr._(_root);
	@override late final _TranslationsUserDashboardWalletAr wallet = _TranslationsUserDashboardWalletAr._(_root);
	@override late final _TranslationsUserDashboardOrdersAr orders = _TranslationsUserDashboardOrdersAr._(_root);
	@override late final _TranslationsUserDashboardActiveOrdersPreviewAr active_orders_preview = _TranslationsUserDashboardActiveOrdersPreviewAr._(_root);
	@override late final _TranslationsUserDashboardLoyaltyAr loyalty = _TranslationsUserDashboardLoyaltyAr._(_root);
	@override late final _TranslationsUserDashboardListingsAr listings = _TranslationsUserDashboardListingsAr._(_root);
	@override late final _TranslationsUserDashboardListingDetailsAr listing_details = _TranslationsUserDashboardListingDetailsAr._(_root);
	@override late final _TranslationsUserDashboardEditSpecsAr edit_specs = _TranslationsUserDashboardEditSpecsAr._(_root);
	@override late final _TranslationsUserDashboardNotificationsAr notifications = _TranslationsUserDashboardNotificationsAr._(_root);
	@override late final _TranslationsUserDashboardSettingsAr settings = _TranslationsUserDashboardSettingsAr._(_root);
}

// Path: bottom_nav
class _TranslationsBottomNavAr implements TranslationsBottomNavEn {
	_TranslationsBottomNavAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBottomNavCustomerAr customer = _TranslationsBottomNavCustomerAr._(_root);
	@override late final _TranslationsBottomNavVendorAr vendor = _TranslationsBottomNavVendorAr._(_root);
	@override late final _TranslationsBottomNavOperatorAr operator = _TranslationsBottomNavOperatorAr._(_root);
}

// Path: sell_your_car
class _TranslationsSellYourCarAr implements TranslationsSellYourCarEn {
	_TranslationsSellYourCarAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsSellYourCarScreensAr screens = _TranslationsSellYourCarScreensAr._(_root);
	@override late final _TranslationsSellYourCarStepsAr steps = _TranslationsSellYourCarStepsAr._(_root);
	@override late final _TranslationsSellYourCarMakeTabAr make_tab = _TranslationsSellYourCarMakeTabAr._(_root);
	@override late final _TranslationsSellYourCarModelTabAr model_tab = _TranslationsSellYourCarModelTabAr._(_root);
	@override late final _TranslationsSellYourCarTrimTabAr trim_tab = _TranslationsSellYourCarTrimTabAr._(_root);
	@override late final _TranslationsSellYourCarYearTabAr year_tab = _TranslationsSellYourCarYearTabAr._(_root);
	@override late final _TranslationsSellYourCarMileageTabAr mileage_tab = _TranslationsSellYourCarMileageTabAr._(_root);
	@override late final _TranslationsSellYourCarSellingPriceTabAr selling_price_tab = _TranslationsSellYourCarSellingPriceTabAr._(_root);
	@override late final _TranslationsSellYourCarColorsTabAr colors_tab = _TranslationsSellYourCarColorsTabAr._(_root);
	@override late final _TranslationsSellYourCarCarColorAr car_color = _TranslationsSellYourCarCarColorAr._(_root);
	@override late final _TranslationsSellYourCarImagesTabAr images_tab = _TranslationsSellYourCarImagesTabAr._(_root);
	@override late final _TranslationsSellYourCarLocationTabAr location_tab = _TranslationsSellYourCarLocationTabAr._(_root);
	@override late final _TranslationsSellYourCarInspectionReportAr inspection_report = _TranslationsSellYourCarInspectionReportAr._(_root);
	@override late final _TranslationsSellYourCarCarConditionAr car_condition = _TranslationsSellYourCarCarConditionAr._(_root);
	@override late final _TranslationsSellYourCarDescriptionAr description = _TranslationsSellYourCarDescriptionAr._(_root);
	@override late final _TranslationsSellYourCarBodyPanelTabAr body_panel_tab = _TranslationsSellYourCarBodyPanelTabAr._(_root);
	@override late final _TranslationsSellYourCarPaintConditionTabAr paint_condition_tab = _TranslationsSellYourCarPaintConditionTabAr._(_root);
	@override late final _TranslationsSellYourCarEndTabAr end_tab = _TranslationsSellYourCarEndTabAr._(_root);
	@override late final _TranslationsSellYourCarEngineTabAr engine_tab = _TranslationsSellYourCarEngineTabAr._(_root);
	@override late final _TranslationsSellYourCarTransmissionTabAr transmission_tab = _TranslationsSellYourCarTransmissionTabAr._(_root);
	@override late final _TranslationsSellYourCarAdditionalInfoAr additional_info = _TranslationsSellYourCarAdditionalInfoAr._(_root);
	@override late final _TranslationsSellYourCarServiceSectionsAr service_sections = _TranslationsSellYourCarServiceSectionsAr._(_root);
	@override late final _TranslationsSellYourCarDurationTabAr duration_tab = _TranslationsSellYourCarDurationTabAr._(_root);
	@override late final _TranslationsSellYourCarFtDurationAr ft_duration = _TranslationsSellYourCarFtDurationAr._(_root);
	@override late final _TranslationsSellYourCarDurationAr duration = _TranslationsSellYourCarDurationAr._(_root);
}

// Path: vendor_dashboard
class _TranslationsVendorDashboardAr implements TranslationsVendorDashboardEn {
	_TranslationsVendorDashboardAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsVendorDashboardProfileAr profile = _TranslationsVendorDashboardProfileAr._(_root);
	@override late final _TranslationsVendorDashboardOrdersAr orders = _TranslationsVendorDashboardOrdersAr._(_root);
	@override late final _TranslationsVendorDashboardRequestDetailsAr request_details = _TranslationsVendorDashboardRequestDetailsAr._(_root);
	@override late final _TranslationsVendorDashboardScheduleAr schedule = _TranslationsVendorDashboardScheduleAr._(_root);
	@override late final _TranslationsVendorDashboardSupportAr support = _TranslationsVendorDashboardSupportAr._(_root);
	@override late final _TranslationsVendorDashboardWalletAr wallet = _TranslationsVendorDashboardWalletAr._(_root);
	@override late final _TranslationsVendorDashboardOperatorsAr operators = _TranslationsVendorDashboardOperatorsAr._(_root);
	@override late final _TranslationsVendorDashboardAddOperatorAr add_operator = _TranslationsVendorDashboardAddOperatorAr._(_root);
	@override late final _TranslationsVendorDashboardSettingsAr settings = _TranslationsVendorDashboardSettingsAr._(_root);
	@override late final _TranslationsVendorDashboardWorkingHoursAr working_hours = _TranslationsVendorDashboardWorkingHoursAr._(_root);
	@override late final _TranslationsVendorDashboardDocumentsAr documents = _TranslationsVendorDashboardDocumentsAr._(_root);
	@override late final _TranslationsVendorDashboardBusinessLogoAr business_logo = _TranslationsVendorDashboardBusinessLogoAr._(_root);
	@override late final _TranslationsVendorDashboardCoverImageAr cover_image = _TranslationsVendorDashboardCoverImageAr._(_root);
	@override late final _TranslationsVendorDashboardServiceAreaAr service_area = _TranslationsVendorDashboardServiceAreaAr._(_root);
	@override late final _TranslationsVendorDashboardServiceCategoriesAr service_categories = _TranslationsVendorDashboardServiceCategoriesAr._(_root);
	@override late final _TranslationsVendorDashboardScheduleExceptionsAr schedule_exceptions = _TranslationsVendorDashboardScheduleExceptionsAr._(_root);
	@override late final _TranslationsVendorDashboardRecentCompletedAr recent_completed = _TranslationsVendorDashboardRecentCompletedAr._(_root);
	@override late final _TranslationsVendorDashboardTodaysScheduleAr todays_schedule = _TranslationsVendorDashboardTodaysScheduleAr._(_root);
	@override late final _TranslationsVendorDashboardRequestCardsAr request_cards = _TranslationsVendorDashboardRequestCardsAr._(_root);
	@override late final _TranslationsVendorDashboardPromoBannerAr promo_banner = _TranslationsVendorDashboardPromoBannerAr._(_root);
	@override late final _TranslationsVendorDashboardProfileMenuAr profile_menu = _TranslationsVendorDashboardProfileMenuAr._(_root);
	@override late final _TranslationsVendorDashboardUnifiedOrderCardAr unified_order_card = _TranslationsVendorDashboardUnifiedOrderCardAr._(_root);
}

// Path: vendor_listings
class _TranslationsVendorListingsAr implements TranslationsVendorListingsEn {
	_TranslationsVendorListingsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'قوائمي';
	@override String get search_hint => 'البحث في القوائم...';
	@override String get filter_all => 'الكل';
	@override String get filter_product => 'منتج';
	@override String get filter_service => 'خدمة';
	@override late final _TranslationsVendorListingsSnackbarAr snackbar = _TranslationsVendorListingsSnackbarAr._(_root);
	@override late final _TranslationsVendorListingsDialogAr dialog = _TranslationsVendorListingsDialogAr._(_root);
	@override late final _TranslationsVendorListingsEmptyAr empty = _TranslationsVendorListingsEmptyAr._(_root);
	@override late final _TranslationsVendorListingsErrorAr error = _TranslationsVendorListingsErrorAr._(_root);
	@override late final _TranslationsVendorListingsBottomSheetAr bottom_sheet = _TranslationsVendorListingsBottomSheetAr._(_root);
	@override late final _TranslationsVendorListingsCardAr card = _TranslationsVendorListingsCardAr._(_root);
	@override late final _TranslationsVendorListingsTooltipAr tooltip = _TranslationsVendorListingsTooltipAr._(_root);
	@override late final _TranslationsVendorListingsCategoryAr category = _TranslationsVendorListingsCategoryAr._(_root);
}

// Path: vendor_products
class _TranslationsVendorProductsAr implements TranslationsVendorProductsEn {
	_TranslationsVendorProductsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'منتجاتي';
	@override String get search_hint => 'البحث في المنتجات...';
	@override String get filter_all => 'الكل';
	@override String get filter_active => 'نشط';
	@override String get filter_inactive => 'غير نشط';
	@override late final _TranslationsVendorProductsEmptyAr empty = _TranslationsVendorProductsEmptyAr._(_root);
	@override late final _TranslationsVendorProductsDialogAr dialog = _TranslationsVendorProductsDialogAr._(_root);
	@override late final _TranslationsVendorProductsSnackbarAr snackbar = _TranslationsVendorProductsSnackbarAr._(_root);
	@override late final _TranslationsVendorProductsErrorAr error = _TranslationsVendorProductsErrorAr._(_root);
	@override late final _TranslationsVendorProductsCardAr card = _TranslationsVendorProductsCardAr._(_root);
	@override late final _TranslationsVendorProductsTooltipAr tooltip = _TranslationsVendorProductsTooltipAr._(_root);
	@override late final _TranslationsVendorProductsCreateProductAr create_product = _TranslationsVendorProductsCreateProductAr._(_root);
}

// Path: inventory
class _TranslationsInventoryAr implements TranslationsInventoryEn {
	_TranslationsInventoryAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'سجل المخزون';
	@override String get filter_all => 'الكل';
	@override String get filter_stock_in => 'إضافة مخزون';
	@override String get filter_stock_out => 'سحب مخزون';
	@override String get filter_adjustment => 'تسوية';
	@override String get filter_refund => 'استرداد';
	@override late final _TranslationsInventoryEmptyAr empty = _TranslationsInventoryEmptyAr._(_root);
	@override late final _TranslationsInventoryErrorAr error = _TranslationsInventoryErrorAr._(_root);
	@override late final _TranslationsInventoryCardAr card = _TranslationsInventoryCardAr._(_root);
	@override String get from_date => 'من {date}';
	@override String get until_date => 'حتى {date}';
	@override late final _TranslationsInventoryTransactionTypeAr transaction_type = _TranslationsInventoryTransactionTypeAr._(_root);
}

// Path: vendor_services
class _TranslationsVendorServicesAr implements TranslationsVendorServicesEn {
	_TranslationsVendorServicesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsVendorServicesScreenAr screen = _TranslationsVendorServicesScreenAr._(_root);
	@override late final _TranslationsVendorServicesFilterAr filter = _TranslationsVendorServicesFilterAr._(_root);
	@override late final _TranslationsVendorServicesEmptyAr empty = _TranslationsVendorServicesEmptyAr._(_root);
	@override late final _TranslationsVendorServicesErrorAr error = _TranslationsVendorServicesErrorAr._(_root);
	@override late final _TranslationsVendorServicesCreateScreenAr create_screen = _TranslationsVendorServicesCreateScreenAr._(_root);
	@override late final _TranslationsVendorServicesSelectCategoryAr select_category = _TranslationsVendorServicesSelectCategoryAr._(_root);
	@override late final _TranslationsVendorServicesServiceCardAr service_card = _TranslationsVendorServicesServiceCardAr._(_root);
	@override late final _TranslationsVendorServicesCategorySectionAr category_section = _TranslationsVendorServicesCategorySectionAr._(_root);
}

// Path: vendor_product_analytics
class _TranslationsVendorProductAnalyticsAr implements TranslationsVendorProductAnalyticsEn {
	_TranslationsVendorProductAnalyticsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'التحليلات';
	@override String get stock => 'المخزون';
	@override late final _TranslationsVendorProductAnalyticsMetricsAr metrics = _TranslationsVendorProductAnalyticsMetricsAr._(_root);
	@override late final _TranslationsVendorProductAnalyticsTimePeriodAr time_period = _TranslationsVendorProductAnalyticsTimePeriodAr._(_root);
	@override late final _TranslationsVendorProductAnalyticsChartsAr charts = _TranslationsVendorProductAnalyticsChartsAr._(_root);
	@override late final _TranslationsVendorProductAnalyticsEmptyAr empty = _TranslationsVendorProductAnalyticsEmptyAr._(_root);
	@override late final _TranslationsVendorProductAnalyticsErrorAr error = _TranslationsVendorProductAnalyticsErrorAr._(_root);
}

// Path: auth.login
class _TranslationsAuthLoginAr implements TranslationsAuthLoginEn {
	_TranslationsAuthLoginAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تسجيل الدخول';
	@override String get loading => 'جاري تسجيل الدخول...';
	@override String get do_not_have_account => 'ليس لديك حساب؟ ';
	@override String get create_account => 'إنشاء حساب';
}

// Path: auth.register_as
class _TranslationsAuthRegisterAsAr implements TranslationsAuthRegisterAsEn {
	_TranslationsAuthRegisterAsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'التسجيل كـ';
	@override String get select_user_type => 'اختر نوع المستخدم';
	@override String get business_owner => 'صاحب عمل';
	@override String get customer => 'عميل';
	@override String get driver => 'سائق';
}

// Path: auth.register_vendor
class _TranslationsAuthRegisterVendorAr implements TranslationsAuthRegisterVendorEn {
	_TranslationsAuthRegisterVendorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get business_name => 'اسم النشاط التجاري';
	@override String get business_email => 'البريد الإلكتروني للعمل';
	@override String get representative_name => 'اسم المفوض';
	@override String get commercial_license => 'رقم السجل التجاري (اختياري)';
}

// Path: auth.register_customer
class _TranslationsAuthRegisterCustomerAr implements TranslationsAuthRegisterCustomerEn {
	_TranslationsAuthRegisterCustomerAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get name => 'الاسم';
	@override String get email => 'البريد الإلكتروني';
	@override String get country => 'الدولة';
	@override String get kuwait => 'الكويت';
	@override String get saudi_arabia => 'المملكة العربية السعودية';
	@override String get uae => 'الإمارات العربية المتحدة';
	@override String get city => 'المدينة';
	@override String get kuwait_city => 'مدينة الكويت';
	@override String get al_jahra => 'الجهراء';
	@override String get hawalli => 'حولي';
}

// Path: auth.verify
class _TranslationsAuthVerifyAr implements TranslationsAuthVerifyEn {
	_TranslationsAuthVerifyAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'التحقق من\nرقم الهاتف';
	@override String get description => 'لقد أرسلنا الرمز إلى';
	@override String get loading => 'جاري التحقق...';
	@override String get button => 'تحقق';
	@override String get resend => 'إعادة إرسال';
	@override String get resend_in => 'إعادة الإرسال خلال';
	@override String get did_not_receive_code => 'لم تستلم الرمز؟ ';
}

// Path: auth.category
class _TranslationsAuthCategoryAr implements TranslationsAuthCategoryEn {
	_TranslationsAuthCategoryAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اختر الفئة';
	@override String get select_category => 'اختر الفئة';
	@override String get loading => 'جاري التسجيل...';
	@override late final _TranslationsAuthCategoryErrorAr error = _TranslationsAuthCategoryErrorAr._(_root);
	@override String get registration_success => 'تم إرسال طلب التسجيل! حسابك يحتاج إلى موافقة المشرف قبل أن تتمكن من تسجيل الدخول.';
}

// Path: auth.splash
class _TranslationsAuthSplashAr implements TranslationsAuthSplashEn {
	_TranslationsAuthSplashAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsAuthSplashVendorAr vendor = _TranslationsAuthSplashVendorAr._(_root);
	@override late final _TranslationsAuthSplashErrorAr error = _TranslationsAuthSplashErrorAr._(_root);
	@override String get initializing => 'جاري التهيئة...';
	@override String get loading => 'جاري التحميل...';
	@override String get checking_auth => 'جاري التحقق من المصادقة...';
}

// Path: booking.booking_screen
class _TranslationsBookingBookingScreenAr implements TranslationsBookingBookingScreenEn {
	_TranslationsBookingBookingScreenAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'حجز خدمة';
	@override String get service_details => 'تفاصيل الخدمة';
	@override late final _TranslationsBookingBookingScreenLocationAr location = _TranslationsBookingBookingScreenLocationAr._(_root);
	@override late final _TranslationsBookingBookingScreenSchedulingAr scheduling = _TranslationsBookingBookingScreenSchedulingAr._(_root);
	@override late final _TranslationsBookingBookingScreenOrderAr order = _TranslationsBookingBookingScreenOrderAr._(_root);
	@override late final _TranslationsBookingBookingScreenButtonAr button = _TranslationsBookingBookingScreenButtonAr._(_root);
}

// Path: booking.order_confirmation
class _TranslationsBookingOrderConfirmationAr implements TranslationsBookingOrderConfirmationEn {
	_TranslationsBookingOrderConfirmationAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تم إرسال الحجز!';
	@override String get order => 'الطلب:';
	@override late final _TranslationsBookingOrderConfirmationStatusAr status = _TranslationsBookingOrderConfirmationStatusAr._(_root);
	@override late final _TranslationsBookingOrderConfirmationInfoAr info = _TranslationsBookingOrderConfirmationInfoAr._(_root);
	@override late final _TranslationsBookingOrderConfirmationButtonAr button = _TranslationsBookingOrderConfirmationButtonAr._(_root);
}

// Path: home.services_grid
class _TranslationsHomeServicesGridAr implements TranslationsHomeServicesGridEn {
	_TranslationsHomeServicesGridAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get spare_parts => 'قطع غيار';
}

// Path: home.customer
class _TranslationsHomeCustomerAr implements TranslationsHomeCustomerEn {
	_TranslationsHomeCustomerAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get search => 'البحث عن منتجات';
	@override late final _TranslationsHomeCustomerActiveOrdersAr active_orders = _TranslationsHomeCustomerActiveOrdersAr._(_root);
	@override late final _TranslationsHomeCustomerPremiumBannerAr premium_banner = _TranslationsHomeCustomerPremiumBannerAr._(_root);
	@override late final _TranslationsHomeCustomerAdBannerAr ad_banner = _TranslationsHomeCustomerAdBannerAr._(_root);
	@override late final _TranslationsHomeCustomerServicesGridAr services_grid = _TranslationsHomeCustomerServicesGridAr._(_root);
	@override late final _TranslationsHomeCustomerBuySellCardAr buy_sell_card = _TranslationsHomeCustomerBuySellCardAr._(_root);
	@override late final _TranslationsHomeCustomerPromoBannerAr promo_banner = _TranslationsHomeCustomerPromoBannerAr._(_root);
	@override late final _TranslationsHomeCustomerListingAr listing = _TranslationsHomeCustomerListingAr._(_root);
}

// Path: home.vendor
class _TranslationsHomeVendorAr implements TranslationsHomeVendorEn {
	_TranslationsHomeVendorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsHomeVendorServicesGridAr services_grid = _TranslationsHomeVendorServicesGridAr._(_root);
	@override late final _TranslationsHomeVendorStatsAr stats = _TranslationsHomeVendorStatsAr._(_root);
	@override String get completed_jobs => 'المهام المنجزة';
	@override late final _TranslationsHomeVendorAvailabilityCapacityAr availability_capacity = _TranslationsHomeVendorAvailabilityCapacityAr._(_root);
	@override late final _TranslationsHomeVendorActiveOrdersAr active_orders = _TranslationsHomeVendorActiveOrdersAr._(_root);
	@override late final _TranslationsHomeVendorCheckoutOrdersAr checkout_orders = _TranslationsHomeVendorCheckoutOrdersAr._(_root);
	@override String get empty => 'لم يتم العثور على الملف الشخصي';
	@override String get error => 'خطأ في تحميل البيانات';
}

// Path: home.operator
class _TranslationsHomeOperatorAr implements TranslationsHomeOperatorEn {
	_TranslationsHomeOperatorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get incoming_requests => 'الطلبات الواردة';
	@override String get accepted_requests => 'الطلبات المقبولة';
	@override String get rides_history => 'سجل الرحلات';
}

// Path: cart.empty
class _TranslationsCartEmptyAr implements TranslationsCartEmptyEn {
	_TranslationsCartEmptyAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'سلة التسوق فارغة';
	@override String get subtitle => 'تصفح خدماتنا واحجز موعدك القادم';
	@override String get browse_button => 'تصفح الخدمات';
}

// Path: public_services.category_vendors
class _TranslationsPublicServicesCategoryVendorsAr implements TranslationsPublicServicesCategoryVendorsEn {
	_TranslationsPublicServicesCategoryVendorsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get description => 'اعثر على أفضل الخدمات';
	@override String get search => 'البحث عن بائعين';
	@override String get all_vendors => 'جميع البائعين';
	@override String get error_vendor => 'فشل تحميل البائعين';
	@override String get null_vendor => 'لم يتم العثور على بائعين';
	@override late final _TranslationsPublicServicesCategoryVendorsVendorCardAr vendor_card = _TranslationsPublicServicesCategoryVendorsVendorCardAr._(_root);
}

// Path: public_services.vendor_services
class _TranslationsPublicServicesVendorServicesAr implements TranslationsPublicServicesVendorServicesEn {
	_TranslationsPublicServicesVendorServicesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get services => 'الخدمات';
	@override String get reviews => 'التقييمات';
	@override String get most_popular => 'الأكثر شيوعًا';
	@override String get search => 'البحث عن خدمة';
	@override String get error_service => 'فشل تحميل الخدمات';
	@override String get null_service => 'لم يتم العثور على خدمات';
	@override String get all_services => 'جميع الخدمات';
	@override late final _TranslationsPublicServicesVendorServicesServiceCardAr service_card = _TranslationsPublicServicesVendorServicesServiceCardAr._(_root);
}

// Path: public_services.services_details
class _TranslationsPublicServicesServicesDetailsAr implements TranslationsPublicServicesServicesDetailsEn {
	_TranslationsPublicServicesServicesDetailsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'عن هذه الخدمة';
	@override String get min => 'دقيقة';
	@override late final _TranslationsPublicServicesServicesDetailsDescriptionAr description = _TranslationsPublicServicesServicesDetailsDescriptionAr._(_root);
	@override String get service_details => 'تفاصيل الخدمة';
	@override String get provider => 'مزود الخدمة';
	@override String get services => 'الخدمات';
	@override String get reviews => 'التقييمات';
	@override late final _TranslationsPublicServicesServicesDetailsWorkingHoursAr working_hours = _TranslationsPublicServicesServicesDetailsWorkingHoursAr._(_root);
	@override late final _TranslationsPublicServicesServicesDetailsDaysAr days = _TranslationsPublicServicesServicesDetailsDaysAr._(_root);
	@override late final _TranslationsPublicServicesServicesDetailsButtonAr button = _TranslationsPublicServicesServicesDetailsButtonAr._(_root);
}

// Path: public_marketplace.category_screen
class _TranslationsPublicMarketplaceCategoryScreenAr implements TranslationsPublicMarketplaceCategoryScreenEn {
	_TranslationsPublicMarketplaceCategoryScreenAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title_accessories => 'اكسسوارات';
	@override String get title_spare_parts => 'قطع غيار';
	@override String get subtitle => 'اعثر على أفضل الخدمات';
	@override String get search_hint => 'البحث عن بائع';
	@override String get all_supplies => 'جميع المنتجات';
	@override String get no_vendors_match_search => 'لا يوجد بائعون يطابقون بحثك';
	@override String get no_vendors_found => 'لم يتم العثور على بائعين';
	@override String get label_accessories => 'اكسسوارات';
	@override String get label_spare_parts => 'قطع غيار';
	@override String get verified => 'موثق';
	@override String get error_loading => 'فشل تحميل البائعين';
}

// Path: public_marketplace.details_screen
class _TranslationsPublicMarketplaceDetailsScreenAr implements TranslationsPublicMarketplaceDetailsScreenEn {
	_TranslationsPublicMarketplaceDetailsScreenAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get app_bar_title => 'عن هذه الخدمة';
	@override String get product_not_found => 'لم يتم العثور على المنتج';
	@override String get description => 'الوصف';
	@override String get no_description => 'لا يوجد وصف متاح.';
	@override String get quantity => 'الكمية';
	@override String get added_to_cart => 'تمت الإضافة إلى سلة التسوق';
	@override String get add_to_cart_button => 'أضف إلى السلة';
	@override String get reviews => 'التقييمات';
	@override String get load_more_reviews => 'تحميل المزيد من التقييمات';
	@override String get similar_products => 'منتجات مماثلة';
	@override String get months_ago => 'شهر/أشهر مضت';
}

// Path: public_marketplace.vendor_details_screen
class _TranslationsPublicMarketplaceVendorDetailsScreenAr implements TranslationsPublicMarketplaceVendorDetailsScreenEn {
	_TranslationsPublicMarketplaceVendorDetailsScreenAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get search_hint => 'البحث عن خدمة';
	@override String get most_popular => 'الأكثر شيوعًا';
	@override String get all_services => 'جميع الخدمات';
	@override String get reviews => 'التقييمات';
	@override String get no_services_found => 'لم يتم العثور على خدمات';
	@override String get professional_service => 'خدمة احترافية';
	@override String get add_to_cart => 'أضف إلى السلة';
	@override String get services => 'خدمات';
	@override String get reviews_label => 'تقييمات';
}

// Path: public_marketplace.spare_parts
class _TranslationsPublicMarketplaceSparePartsAr implements TranslationsPublicMarketplaceSparePartsEn {
	_TranslationsPublicMarketplaceSparePartsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'قطع غيار';
	@override late final _TranslationsPublicMarketplaceSparePartsDetailsScreenAr details_screen = _TranslationsPublicMarketplaceSparePartsDetailsScreenAr._(_root);
	@override late final _TranslationsPublicMarketplaceSparePartsCategoryScreenAr category_screen = _TranslationsPublicMarketplaceSparePartsCategoryScreenAr._(_root);
	@override late final _TranslationsPublicMarketplaceSparePartsFilterSheetAr filter_sheet = _TranslationsPublicMarketplaceSparePartsFilterSheetAr._(_root);
}

// Path: services.screen
class _TranslationsServicesScreenAr implements TranslationsServicesScreenEn {
	_TranslationsServicesScreenAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'جميع الخدمات';
	@override String get search_hint => 'البحث عن خدمات';
}

// Path: services.all_services_grid
class _TranslationsServicesAllServicesGridAr implements TranslationsServicesAllServicesGridEn {
	_TranslationsServicesAllServicesGridAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsServicesAllServicesGridErrorAr error = _TranslationsServicesAllServicesGridErrorAr._(_root);
	@override late final _TranslationsServicesAllServicesGridEmptyAr empty = _TranslationsServicesAllServicesGridEmptyAr._(_root);
	@override late final _TranslationsServicesAllServicesGridStaticAr static = _TranslationsServicesAllServicesGridStaticAr._(_root);
}

// Path: buy_a_car.screen
class _TranslationsBuyACarScreenAr implements TranslationsBuyACarScreenEn {
	_TranslationsBuyACarScreenAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'شراء سيارات';
	@override String get subtitle => 'لدينا عروض بانتظارك';
}

// Path: buy_a_car.service_section
class _TranslationsBuyACarServiceSectionAr implements TranslationsBuyACarServiceSectionEn {
	_TranslationsBuyACarServiceSectionAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get good_condition_cars => 'سيارات بحالة جيدة';
	@override String get damaged_cars => 'سيارات تالفة';
	@override String get approved_cars => 'سيارات معتمدة';
	@override String get good_condition_description => 'تصفح مجموعتنا الواسعة من السيارات بحالة ممتازة.';
	@override String get damaged_cars_description => 'اعثر على سيارات تالفة لقطع الغيار أو مشاريع الإصلاح.';
	@override String get approved_cars_description => 'تسوق سيارات معتمدة ومعتمدة مع تقارير فحص كاملة.';
}

// Path: buy_a_car.good_condition_screen
class _TranslationsBuyACarGoodConditionScreenAr implements TranslationsBuyACarGoodConditionScreenEn {
	_TranslationsBuyACarGoodConditionScreenAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'استكشف السيارات';
	@override String get search_hint => 'البحث عن سيارات حسب الماركة والموديل...';
	@override String get all_cars => 'جميع السيارات';
	@override String get no_cars_found => 'لم يتم العثور على سيارات مطابقة';
	@override String get no_cars_available => 'لا توجد سيارات متاحة';
	@override String get failed_to_load => 'فشل تحميل السيارات';
	@override String get retry => 'إعادة المحاولة';
}

// Path: buy_a_car.approved_cars_screen
class _TranslationsBuyACarApprovedCarsScreenAr implements TranslationsBuyACarApprovedCarsScreenEn {
	_TranslationsBuyACarApprovedCarsScreenAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'سيارات معتمدة';
	@override String get search_hint => 'البحث عن سيارات معتمدة...';
	@override String get all_approved_cars => 'جميع السيارات المعتمدة';
	@override String get no_cars_found => 'لم يتم العثور على سيارات مطابقة';
	@override String get no_approved_cars_available => 'لا توجد سيارات معتمدة متاحة';
	@override String get failed_to_load => 'فشل تحميل السيارات';
	@override String get retry => 'إعادة المحاولة';
}

// Path: buy_a_car.damaged_cars_screen
class _TranslationsBuyACarDamagedCarsScreenAr implements TranslationsBuyACarDamagedCarsScreenEn {
	_TranslationsBuyACarDamagedCarsScreenAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'سيارات تالفة';
	@override String get search_hint => 'البحث عن سيارات تالفة...';
	@override String get all_damaged_cars => 'جميع السيارات التالفة';
	@override String get no_cars_found => 'لم يتم العثور على سيارات مطابقة';
	@override String get no_damaged_cars_available => 'لا توجد سيارات تالفة متاحة';
	@override String get failed_to_load => 'فشل تحميل السيارات';
	@override String get retry => 'إعادة المحاولة';
}

// Path: buy_a_car.details_screen
class _TranslationsBuyACarDetailsScreenAr implements TranslationsBuyACarDetailsScreenEn {
	_TranslationsBuyACarDetailsScreenAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get about_this_car => 'عن هذه السيارة';
	@override String get failed_to_load_listing => 'فشل تحميل الإعلان';
	@override String get retry => 'إعادة المحاولة';
	@override String get price_on_request => 'السعر عند الطلب';
	@override String get car_details => 'تفاصيل السيارة';
	@override String get location_not_specified => 'لم يتم تحديد الموقع';
	@override String get featured => 'مميز';
	@override String get inspected => 'تم الفحص';
	@override String get view_details => 'عرض التفاصيل';
	@override late final _TranslationsBuyACarDetailsScreenInspectionReportAr inspection_report = _TranslationsBuyACarDetailsScreenInspectionReportAr._(_root);
	@override String get specifications => 'المواصفات';
	@override late final _TranslationsBuyACarDetailsScreenSpecLabelsAr spec_labels = _TranslationsBuyACarDetailsScreenSpecLabelsAr._(_root);
	@override String get na => 'غير متاح';
	@override String get description => 'الوصف';
	@override String get no_description => 'لا يوجد وصف متاح.';
	@override String get location => 'الموقع';
	@override String get call_now => 'اتصل الآن';
	@override String get chat => 'دردشة';
	@override late final _TranslationsBuyACarDetailsScreenConditionAr condition = _TranslationsBuyACarDetailsScreenConditionAr._(_root);
	@override String get error_open_report => 'تعذر فتح تقرير الفحص';
}

// Path: buy_a_car.car_chat
class _TranslationsBuyACarCarChatAr implements TranslationsBuyACarCarChatEn {
	_TranslationsBuyACarCarChatAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تويوتا لاند كروزر 300';
	@override String get this_message_relates_to => 'هذه الرسالة تتعلق بـ:';
	@override String get buy_a_car => 'شراء سيارة';
	@override String get inspection_report_pdf => 'تقريرالفحص.pdf';
	@override String get size_kb => '487 كيلوبايت';
	@override String get download => 'تحميل';
	@override String get inspection_report_message => 'يرجى الاطلاع على تقرير الفحص هذا.';
	@override String get sender_initial => 'ر';
	@override String get sender_name => 'برايم كار كير';
	@override String get you => 'أنت';
	@override String get type_message => 'اكتب رسالة';
}

// Path: buy_a_car.listing_card
class _TranslationsBuyACarListingCardAr implements TranslationsBuyACarListingCardEn {
	_TranslationsBuyACarListingCardAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get featured => 'مميز';
	@override String get inspected => 'تم الفحص';
	@override String get not_inspected => 'لم يتم الفحص';
}

// Path: buy_a_car.filters
class _TranslationsBuyACarFiltersAr implements TranslationsBuyACarFiltersEn {
	_TranslationsBuyACarFiltersAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get clear_all => 'مسح الكل';
	@override String get make => 'الشركة المصنعة';
	@override String get model => 'الموديل';
	@override String get trim => 'الفئة';
	@override String get year => 'السنة';
	@override String get mileage => 'المسافة المقطوعة';
	@override String get transmission => 'ناقل الحركة';
	@override String get automatic => 'أوتوماتيك';
	@override String get manual => 'يدوي';
	@override String get search_makes => 'البحث عن الشركات المصنعة...';
	@override String get no_makes_found => 'لم يتم العثور على شركات مصنعة';
	@override String get failed_to_load_makes => 'فشل تحميل الشركات المصنعة';
	@override String get select_make_first => 'يرجى اختيار شركة مصنعة أولاً';
	@override String get search_models => 'البحث عن الموديلات...';
	@override String get no_models_found => 'لم يتم العثور على موديلات';
	@override String get failed_to_load_models => 'فشل تحميل الموديلات';
	@override String get select_model_first => 'يرجى اختيار موديل أولاً';
	@override String get search_trims => 'البحث عن الفئات...';
	@override String get no_trims_available => 'لا توجد فئات متاحة';
	@override String get no_trims_found => 'لم يتم العثور على فئات';
	@override String get failed_to_load_trims => 'فشل تحميل الفئات';
	@override String get from_year => 'من سنة';
	@override String get to_year => 'إلى سنة';
	@override String get select_year => 'اختر السنة';
	@override String get any => 'أي';
	@override String get failed_to_load_years => 'فشل تحميل السنوات';
	@override String get mileage_any => 'أي';
	@override String get under_50k => 'أقل من 50,000 كم';
	@override String get range_50k_100k => '50,000 - 100,000 كم';
	@override String get range_100k_150k => '100,000 - 150,000 كم';
	@override String get over_150k => '150,000+ كم';
}

// Path: reviews.display
class _TranslationsReviewsDisplayAr implements TranslationsReviewsDisplayEn {
	_TranslationsReviewsDisplayAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'التقييمات';
	@override String get review => 'التقييم';
	@override String get filter_all => 'الكل';
	@override String get filter_5_stars => '5★';
	@override String get filter_4_stars => '4★';
	@override String get filter_3_stars => '3★';
	@override String get filter_2_stars => '2★';
	@override String get filter_1_star => '1★';
	@override String get sort_most_recent => 'الأحدث';
	@override String get sort_highest => 'الأعلى';
	@override String get sort_lowest => 'الأقل';
	@override String get verified_badge => 'موثق';
	@override String get empty_state_title => 'لا توجد تقييمات بعد';
	@override String get empty_state_message => 'كن أول من يترك تقييمًا!';
	@override String get load_more => 'تحميل المزيد';
}

// Path: user_dashboard.profile
class _TranslationsUserDashboardProfileAr implements TranslationsUserDashboardProfileEn {
	_TranslationsUserDashboardProfileAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get greeting => 'مرحبًا {name}!';
	@override String get guest => 'ضيف';
	@override String get guest_initial => 'ض';
	@override String get location => 'الكويت';
}

// Path: user_dashboard.menu
class _TranslationsUserDashboardMenuAr implements TranslationsUserDashboardMenuEn {
	_TranslationsUserDashboardMenuAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get wallet => 'المحفظة';
	@override String get orders => 'الطلبات';
	@override String get listings => 'الإعلانات';
	@override String get loyalty_program => 'برنامج الولاء';
}

// Path: user_dashboard.wallet
class _TranslationsUserDashboardWalletAr implements TranslationsUserDashboardWalletEn {
	_TranslationsUserDashboardWalletAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'محفظة موتيفا';
	@override String get encrypted => 'جميع البيانات مشفرة';
	@override String get total => 'الإجمالي (د.ك):';
	@override String get use_now => 'استخدمها الآن';
	@override String get history => 'السجل';
	@override String get use_reward_balance => 'استخدم رصيد المكافآت';
	@override String get coming_soon => 'قريباً';
	@override String get coming_soon_message => 'يمكن استخدام رصيد المحفظة للمدفوعات — قريباً!';
	@override String get no_transactions => 'لا توجد معاملات بعد';
	@override String get error_loading => 'فشل تحميل بيانات المحفظة';
	@override String get available_balance => 'الرصيد المتاح';
	@override String get failed_to_load_balance => 'فشل تحميل الرصيد';
	@override String get credit => 'دائن';
	@override String get debit => 'مدين';
	@override String get balance_available => 'الرصيد المتاح';
	@override String get retry => 'إعادة المحاولة';
	@override late final _TranslationsUserDashboardWalletReferenceTypesAr reference_types = _TranslationsUserDashboardWalletReferenceTypesAr._(_root);
	@override late final _TranslationsUserDashboardWalletTransactionDetailsAr transaction_details = _TranslationsUserDashboardWalletTransactionDetailsAr._(_root);
	@override late final _TranslationsUserDashboardWalletRewardCardsAr reward_cards = _TranslationsUserDashboardWalletRewardCardsAr._(_root);
	@override late final _TranslationsUserDashboardWalletTransactionAr transaction = _TranslationsUserDashboardWalletTransactionAr._(_root);
	@override late final _TranslationsUserDashboardWalletMonthsAr months = _TranslationsUserDashboardWalletMonthsAr._(_root);
	@override late final _TranslationsUserDashboardWalletDetailLabelsAr detail_labels = _TranslationsUserDashboardWalletDetailLabelsAr._(_root);
}

// Path: user_dashboard.orders
class _TranslationsUserDashboardOrdersAr implements TranslationsUserDashboardOrdersEn {
	_TranslationsUserDashboardOrdersAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'الطلبات';
	@override String get search_hint => 'البحث عن طلبات...';
	@override String get filter_all => 'الكل';
	@override String get filter_service => 'خدمة';
	@override String get filter_product => 'منتج';
	@override String get tab_all => 'الكل';
	@override String get tab_active => 'نشط';
	@override String get tab_completed => 'مكتمل';
	@override String get service_details => 'تفاصيل الخدمة متاحة في العرض الكامل';
	@override late final _TranslationsUserDashboardOrdersEmptyAr empty = _TranslationsUserDashboardOrdersEmptyAr._(_root);
	@override late final _TranslationsUserDashboardOrdersErrorAr error = _TranslationsUserDashboardOrdersErrorAr._(_root);
	@override late final _TranslationsUserDashboardOrdersCardAr card = _TranslationsUserDashboardOrdersCardAr._(_root);
	@override late final _TranslationsUserDashboardOrdersStatusAr status = _TranslationsUserDashboardOrdersStatusAr._(_root);
	@override late final _TranslationsUserDashboardOrdersDetailsAr details = _TranslationsUserDashboardOrdersDetailsAr._(_root);
}

// Path: user_dashboard.active_orders_preview
class _TranslationsUserDashboardActiveOrdersPreviewAr implements TranslationsUserDashboardActiveOrdersPreviewEn {
	_TranslationsUserDashboardActiveOrdersPreviewAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get empty_title => 'لا توجد طلبات نشطة';
	@override String get empty_subtitle => 'ستظهر طلبات الخدمة النشطة هنا.';
	@override String get section_title => 'طلباتي النشطة';
	@override String get view_all => 'عرض الكل';
	@override String get unknown_service => 'خدمة غير معروفة';
	@override String get unknown_vendor => 'بائع غير معروف';
	@override late final _TranslationsUserDashboardActiveOrdersPreviewTimeAgoAr time_ago = _TranslationsUserDashboardActiveOrdersPreviewTimeAgoAr._(_root);
}

// Path: user_dashboard.loyalty
class _TranslationsUserDashboardLoyaltyAr implements TranslationsUserDashboardLoyaltyEn {
	_TranslationsUserDashboardLoyaltyAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'برنامج الولاء';
	@override String get points_balance => 'رصيد النقاط';
	@override String get points => 'نقاط';
	@override String get progress_to_reward => 'التقدم نحو المكافأة';
	@override String get of_points_to_reward => '{current} من {total} نقطة للمكافأة التالية';
	@override String get redeem_points => 'استبدال النقاط';
	@override String get transactions => 'المعاملات';
	@override String get earn => 'كسب';
	@override String get redeem => 'استبدال';
	@override String get expire => 'انتهاء';
	@override String get adjust => 'تعديل';
	@override String get empty_title => 'لا توجد معاملات بعد';
	@override String get empty_subtitle => 'ستظهر معاملات الولاء هنا.';
	@override String get error_title => 'فشل التحميل';
	@override String get retry => 'إعادة المحاولة';
}

// Path: user_dashboard.listings
class _TranslationsUserDashboardListingsAr implements TranslationsUserDashboardListingsEn {
	_TranslationsUserDashboardListingsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'الإعلانات';
	@override String get search_hint => 'البحث عن سيارة معلنة';
	@override late final _TranslationsUserDashboardListingsErrorAr error = _TranslationsUserDashboardListingsErrorAr._(_root);
	@override late final _TranslationsUserDashboardListingsEmptyAr empty = _TranslationsUserDashboardListingsEmptyAr._(_root);
	@override late final _TranslationsUserDashboardListingsCardAr card = _TranslationsUserDashboardListingsCardAr._(_root);
}

// Path: user_dashboard.listing_details
class _TranslationsUserDashboardListingDetailsAr implements TranslationsUserDashboardListingDetailsEn {
	_TranslationsUserDashboardListingDetailsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'عن هذه السيارة';
	@override String get featured => 'مميز';
	@override String get price_on_request => 'السعر عند الطلب';
	@override String get inspected => 'تم الفحص';
	@override String get not_inspected => 'لم يتم الفحص';
	@override String get view_details => 'عرض التفاصيل';
	@override String get unknown_location => 'موقع غير معروف';
	@override late final _TranslationsUserDashboardListingDetailsTimeAgoAr time_ago = _TranslationsUserDashboardListingDetailsTimeAgoAr._(_root);
	@override late final _TranslationsUserDashboardListingDetailsInspectionAr inspection = _TranslationsUserDashboardListingDetailsInspectionAr._(_root);
	@override late final _TranslationsUserDashboardListingDetailsSpecificationsAr specifications = _TranslationsUserDashboardListingDetailsSpecificationsAr._(_root);
	@override late final _TranslationsUserDashboardListingDetailsDescriptionAr description = _TranslationsUserDashboardListingDetailsDescriptionAr._(_root);
	@override String get save_button => 'حفظ';
}

// Path: user_dashboard.edit_specs
class _TranslationsUserDashboardEditSpecsAr implements TranslationsUserDashboardEditSpecsEn {
	_TranslationsUserDashboardEditSpecsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'تعديل المواصفات';
	@override late final _TranslationsUserDashboardEditSpecsStepsAr steps = _TranslationsUserDashboardEditSpecsStepsAr._(_root);
	@override String get save_button_loading => 'جاري الحفظ...';
	@override String get save_button => 'حفظ التغييرات';
	@override late final _TranslationsUserDashboardEditSpecsValidationAr validation = _TranslationsUserDashboardEditSpecsValidationAr._(_root);
}

// Path: user_dashboard.notifications
class _TranslationsUserDashboardNotificationsAr implements TranslationsUserDashboardNotificationsEn {
	_TranslationsUserDashboardNotificationsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'الإشعارات';
	@override String get read_all => 'قراءة الكل';
	@override String get tab_all => 'الكل';
	@override String get tab_orders => 'الطلبات';
	@override String get tab_offers => 'العروض';
	@override String get tab_system => 'النظام';
	@override late final _TranslationsUserDashboardNotificationsEmptyAr empty = _TranslationsUserDashboardNotificationsEmptyAr._(_root);
}

// Path: user_dashboard.settings
class _TranslationsUserDashboardSettingsAr implements TranslationsUserDashboardSettingsEn {
	_TranslationsUserDashboardSettingsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'الإعدادات';
	@override String get search_hint => 'البحث في الإعدادات';
	@override String get not_found => 'لم يتم العثور على إعدادات';
	@override late final _TranslationsUserDashboardSettingsMenuAr menu = _TranslationsUserDashboardSettingsMenuAr._(_root);
	@override late final _TranslationsUserDashboardSettingsDeleteAccountConfirmAr delete_account_confirm = _TranslationsUserDashboardSettingsDeleteAccountConfirmAr._(_root);
	@override late final _TranslationsUserDashboardSettingsAccountInfoAr account_info = _TranslationsUserDashboardSettingsAccountInfoAr._(_root);
	@override late final _TranslationsUserDashboardSettingsChangeEmailAr change_email = _TranslationsUserDashboardSettingsChangeEmailAr._(_root);
	@override late final _TranslationsUserDashboardSettingsChangePasswordAr change_password = _TranslationsUserDashboardSettingsChangePasswordAr._(_root);
	@override late final _TranslationsUserDashboardSettingsLanguageAr language = _TranslationsUserDashboardSettingsLanguageAr._(_root);
	@override late final _TranslationsUserDashboardSettingsAppModeAr app_mode = _TranslationsUserDashboardSettingsAppModeAr._(_root);
	@override late final _TranslationsUserDashboardSettingsCountryAr country = _TranslationsUserDashboardSettingsCountryAr._(_root);
	@override late final _TranslationsUserDashboardSettingsSavedAddressesAr saved_addresses = _TranslationsUserDashboardSettingsSavedAddressesAr._(_root);
	@override late final _TranslationsUserDashboardSettingsNotificationPreferencesAr notification_preferences = _TranslationsUserDashboardSettingsNotificationPreferencesAr._(_root);
	@override late final _TranslationsUserDashboardSettingsVerifyEmailOtpAr verify_email_otp = _TranslationsUserDashboardSettingsVerifyEmailOtpAr._(_root);
	@override late final _TranslationsUserDashboardSettingsEditAddressAr edit_address = _TranslationsUserDashboardSettingsEditAddressAr._(_root);
	@override late final _TranslationsUserDashboardSettingsAddressTileAr address_tile = _TranslationsUserDashboardSettingsAddressTileAr._(_root);
}

// Path: bottom_nav.customer
class _TranslationsBottomNavCustomerAr implements TranslationsBottomNavCustomerEn {
	_TranslationsBottomNavCustomerAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get home => 'الرئيسية';
	@override String get services => 'الخدمات';
	@override String get offers => 'العروض';
	@override String get cart => 'السلة';
	@override String get profile => 'الملف الشخصي';
}

// Path: bottom_nav.vendor
class _TranslationsBottomNavVendorAr implements TranslationsBottomNavVendorEn {
	_TranslationsBottomNavVendorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get home => 'الرئيسية';
	@override String get listings => 'القوائم';
	@override String get orders => 'الطلبات';
	@override String get operator => 'المشغل';
	@override String get profile => 'الملف الشخصي';
}

// Path: bottom_nav.operator
class _TranslationsBottomNavOperatorAr implements TranslationsBottomNavOperatorEn {
	_TranslationsBottomNavOperatorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get home => 'الرئيسية';
	@override String get orders => 'الطلبات';
	@override String get profile => 'الملف الشخصي';
}

// Path: sell_your_car.screens
class _TranslationsSellYourCarScreensAr implements TranslationsSellYourCarScreensEn {
	_TranslationsSellYourCarScreensAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsSellYourCarScreensConditionCarAr condition_car = _TranslationsSellYourCarScreensConditionCarAr._(_root);
	@override late final _TranslationsSellYourCarScreensSellACarAr sell_a_car = _TranslationsSellYourCarScreensSellACarAr._(_root);
	@override late final _TranslationsSellYourCarScreensSellOrBuyCarAr sell_or_buy_car = _TranslationsSellYourCarScreensSellOrBuyCarAr._(_root);
	@override late final _TranslationsSellYourCarScreensFastTrackConditionAr fast_track_condition = _TranslationsSellYourCarScreensFastTrackConditionAr._(_root);
	@override late final _TranslationsSellYourCarScreensFastTrackSaleAr fast_track_sale = _TranslationsSellYourCarScreensFastTrackSaleAr._(_root);
	@override late final _TranslationsSellYourCarScreensOpenAnAuctionAr open_an_auction = _TranslationsSellYourCarScreensOpenAnAuctionAr._(_root);
	@override late final _TranslationsSellYourCarScreensCarDetailsAr car_details = _TranslationsSellYourCarScreensCarDetailsAr._(_root);
	@override late final _TranslationsSellYourCarScreensSuccessDialogAr success_dialog = _TranslationsSellYourCarScreensSuccessDialogAr._(_root);
	@override late final _TranslationsSellYourCarScreensRequestReceivedDialogAr request_received_dialog = _TranslationsSellYourCarScreensRequestReceivedDialogAr._(_root);
	@override late final _TranslationsSellYourCarScreensErrorDialogAr error_dialog = _TranslationsSellYourCarScreensErrorDialogAr._(_root);
}

// Path: sell_your_car.steps
class _TranslationsSellYourCarStepsAr implements TranslationsSellYourCarStepsEn {
	_TranslationsSellYourCarStepsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get make => 'الشركة المصنعة';
	@override String get model => 'الموديل';
	@override String get trim => 'الفئة';
	@override String get year => 'السنة';
	@override String get mileage => 'المسافة المقطوعة';
	@override String get selling_price => 'سعر البيع';
	@override String get car_specs => 'مواصفات السيارة';
	@override String get car_condition => 'حالة السيارة';
	@override String get colors => 'الألوان';
	@override String get images => 'الصور';
	@override String get location => 'الموقع';
	@override String get additional_info => 'معلومات إضافية';
	@override String get duration => 'المدة';
	@override String get color => 'اللون';
	@override String get image => 'صورة';
}

// Path: sell_your_car.make_tab
class _TranslationsSellYourCarMakeTabAr implements TranslationsSellYourCarMakeTabEn {
	_TranslationsSellYourCarMakeTabAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اختر شركة السيارة';
	@override String get search_hint => 'ابحث عن شركة السيارة';
	@override String get no_available => 'لا توجد شركات متاحة';
	@override String get no_found => 'لم يتم العثور على شركات';
	@override String get retry => 'إعادة المحاولة';
}

// Path: sell_your_car.model_tab
class _TranslationsSellYourCarModelTabAr implements TranslationsSellYourCarModelTabEn {
	_TranslationsSellYourCarModelTabAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اختر موديل السيارة';
	@override String get search_hint => 'ابحث عن موديل السيارة';
	@override String get select_make_first => 'يرجى اختيار الشركة المصنعة أولاً';
	@override String get no_available => 'لا توجد موديلات متاحة';
	@override String get no_found => 'لم يتم العثور على موديلات';
	@override String get retry => 'إعادة المحاولة';
}

// Path: sell_your_car.trim_tab
class _TranslationsSellYourCarTrimTabAr implements TranslationsSellYourCarTrimTabEn {
	_TranslationsSellYourCarTrimTabAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اختر فئة السيارة';
	@override String get search_hint => 'ابحث عن فئة السيارة';
	@override String get select_model_first => 'يرجى اختيار الموديل أولاً';
	@override String get no_available => 'لا توجد فئات متاحة';
	@override String get no_found => 'لم يتم العثور على فئات';
	@override String get retry => 'إعادة المحاولة';
}

// Path: sell_your_car.year_tab
class _TranslationsSellYourCarYearTabAr implements TranslationsSellYourCarYearTabEn {
	_TranslationsSellYourCarYearTabAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'أدخل سنة الموديل';
	@override String get error => 'يرجى إدخال سنة بين 1900 و {year}';
}

// Path: sell_your_car.mileage_tab
class _TranslationsSellYourCarMileageTabAr implements TranslationsSellYourCarMileageTabEn {
	_TranslationsSellYourCarMileageTabAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'أدخل المسافة المقطوعة';
	@override String get unit => 'كم';
	@override String get kContinue => 'متابعة';
}

// Path: sell_your_car.selling_price_tab
class _TranslationsSellYourCarSellingPriceTabAr implements TranslationsSellYourCarSellingPriceTabEn {
	_TranslationsSellYourCarSellingPriceTabAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'أدخل سعر البيع';
	@override String get unit => 'د.ك';
	@override String get kContinue => 'متابعة';
}

// Path: sell_your_car.colors_tab
class _TranslationsSellYourCarColorsTabAr implements TranslationsSellYourCarColorsTabEn {
	_TranslationsSellYourCarColorsTabAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اختر ألوان سيارتك';
	@override String get exterior_title => 'اختر لون الهيكل الخارجي';
	@override String get interior_title => 'اختر لون المقاعد الداخلي';
	@override String get view_more => 'عرض المزيد';
	@override String get kContinue => 'متابعة';
}

// Path: sell_your_car.car_color
class _TranslationsSellYourCarCarColorAr implements TranslationsSellYourCarCarColorEn {
	_TranslationsSellYourCarCarColorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get white => 'أبيض';
	@override String get black => 'أسود';
	@override String get orange => 'برتقالي';
	@override String get blue => 'أزرق';
	@override String get red => 'أحمر';
	@override String get green => 'أخضر';
	@override String get purple => 'بنفسجي';
	@override String get yellow => 'أصفر';
	@override String get aqua => 'أزرق مائي';
	@override String get snow => 'ثلجي';
	@override String get beige => 'بيج';
	@override String get dim_gray => 'رمادي داكن';
}

// Path: sell_your_car.images_tab
class _TranslationsSellYourCarImagesTabAr implements TranslationsSellYourCarImagesTabEn {
	_TranslationsSellYourCarImagesTabAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get car_images_title => 'تحميل صور السيارة';
	@override String get car_images_hint => 'أضف صور لسيارتك (الخارج، الداخل، المحرك)';
	@override String get damage_images_title => 'تحميل صور الأضرار';
	@override String get damage_images_hint => 'أضف صور تبين مناطق الضرر';
	@override String get camera => 'الكاميرا';
	@override String get gallery => 'المعرض';
	@override String get add_photo => 'إضافة صورة';
	@override String get select_source => 'اختر مصدر الصورة';
	@override String get uploading => 'جاري رفع الصور...';
	@override String get skip => 'تخطي';
	@override String get kContinue => 'متابعة';
	@override String get car_label => 'سيارة';
	@override String get damage_label => 'ضرر';
	@override String get image_label => 'صورة {number}';
}

// Path: sell_your_car.location_tab
class _TranslationsSellYourCarLocationTabAr implements TranslationsSellYourCarLocationTabEn {
	_TranslationsSellYourCarLocationTabAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get pick_location => 'اختر موقعك';
	@override String get select_location_title => 'اختر الموقع';
	@override String get select => 'اختيار';
	@override String get cancel => 'إلغاء';
	@override String get country => 'الدولة';
	@override String get city => 'المدينة';
	@override String get kContinue => 'متابعة';
	@override String get failed_picker => 'فشل فتح محدد الموقع';
}

// Path: sell_your_car.inspection_report
class _TranslationsSellYourCarInspectionReportAr implements TranslationsSellYourCarInspectionReportEn {
	_TranslationsSellYourCarInspectionReportAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'هل لديك تقرير فحص حديث؟';
	@override String get browse => 'تصفح ';
	@override String get your_file => 'ملفك';
	@override String get max_size => 'يسمح بملفات حتى 10 ميجابايت';
	@override String get file_types => 'PDF, JPG, PNG';
	@override String get uploaded_success => 'تم الرفع بنجاح';
	@override String get no_report => 'لا، ليس لدي';
	@override String get inspect_question => 'هل تريد منا فحص سيارتك؟';
	@override String get inspect_description => 'احصل على فحص احترافي لسيارتك لراحة البال. أضف هذه الخدمة للتحقق الشامل من أنها في أفضل حالة.';
	@override String get inspect_price => '20 د.ك   + 3 نجوم';
	@override String get dialog_title => 'أدخل رابط تقرير الفحص';
	@override String get cancel => 'إلغاء';
	@override String get upload => 'رفع';
	@override String get kContinue => 'متابعة';
	@override String get uploading => 'جاري رفع الملف...';
	@override String get file_size_error => 'يجب أن يكون حجم الملف أقل من 10 ميجابايت';
	@override String get pick_error => 'خطأ في اختيار الملف: {error}';
	@override String get upload_error => 'فشل رفع الملف. يرجى المحاولة مرة أخرى.';
	@override String get upload_error_generic => 'خطأ في رفع الملف: {error}';
}

// Path: sell_your_car.car_condition
class _TranslationsSellYourCarCarConditionAr implements TranslationsSellYourCarCarConditionEn {
	_TranslationsSellYourCarCarConditionAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get chassis_title => 'هل هناك أي مشاكل في الهيكل؟';
	@override String get mechanical_title => 'هل هناك أي مشاكل ميكانيكية في السيارة؟';
	@override String get warning_lights_title => 'هل هناك أي أضواء تحذيرية مضاءة؟';
	@override String get tires_title => 'ما هي حالة الإطارات؟';
	@override String get tires_new => 'جديد';
	@override String get tires_good => 'جيد';
	@override String get tires_needs_change => 'يحتاج تغيير';
	@override String get runs_drives_title => 'هل السيارة تعمل وتسير؟';
	@override String get runs_drives_yes => 'نعم، تعمل وتسير';
	@override String get runs_drives_no => 'لا، لا تعمل/تسير';
	@override String get yes => 'نعم';
	@override String get no => 'لا';
	@override String get dont_know => 'لا أعرف';
	@override String get kContinue => 'متابعة';
}

// Path: sell_your_car.description
class _TranslationsSellYourCarDescriptionAr implements TranslationsSellYourCarDescriptionEn {
	_TranslationsSellYourCarDescriptionAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الوصف';
	@override String get hint => 'اكتب أي تفاصيل إضافية عن سيارتك.';
}

// Path: sell_your_car.body_panel_tab
class _TranslationsSellYourCarBodyPanelTabAr implements TranslationsSellYourCarBodyPanelTabEn {
	_TranslationsSellYourCarBodyPanelTabAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'هل هناك أي عيوب أو أضرار طفيفة في ألواح الجسم؟';
	@override String get yes => 'نعم';
	@override String get no => 'لا';
	@override String get dont_know => 'لا أعرف';
	@override String get kContinue => 'متابعة';
}

// Path: sell_your_car.paint_condition_tab
class _TranslationsSellYourCarPaintConditionTabAr implements TranslationsSellYourCarPaintConditionTabEn {
	_TranslationsSellYourCarPaintConditionTabAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'ما هي حالة الدهان؟';
	@override String get kContinue => 'متابعة';
}

// Path: sell_your_car.end_tab
class _TranslationsSellYourCarEndTabAr implements TranslationsSellYourCarEndTabEn {
	_TranslationsSellYourCarEndTabAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get proceed_payment => 'المتابعة إلى الدفع';
}

// Path: sell_your_car.engine_tab
class _TranslationsSellYourCarEngineTabAr implements TranslationsSellYourCarEngineTabEn {
	_TranslationsSellYourCarEngineTabAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اختر محرك سيارتك';
	@override String get other => 'أخرى';
}

// Path: sell_your_car.transmission_tab
class _TranslationsSellYourCarTransmissionTabAr implements TranslationsSellYourCarTransmissionTabEn {
	_TranslationsSellYourCarTransmissionTabAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اختر ناقل حركة سيارتك';
	@override String get manual => 'يدوي';
	@override String get automatic => 'أوتوماتيك';
	@override String get kContinue => 'متابعة';
}

// Path: sell_your_car.additional_info
class _TranslationsSellYourCarAdditionalInfoAr implements TranslationsSellYourCarAdditionalInfoEn {
	_TranslationsSellYourCarAdditionalInfoAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get features_title => 'اختر ميزات سيارتك';
	@override String get feature_your_car => 'مميزة سيارتك';
	@override String get feature_description => 'تمييز سيارتك سيسمح لمزيد من الأشخاص برؤيتها وبيعها بسرعة.';
	@override String get one_week => 'أسبوع واحد';
	@override String get two_weeks => 'أسبوعان';
	@override String get one_month => 'شهر واحد';
	@override String get total_price => 'السعر الإجمالي : ';
	@override String get saving => 'جاري الحفظ...';
	@override String get submit_listing => 'إرسال الإدراج';
	@override String get listing_created => 'تم إنشاء الإدراج بنجاح!';
	@override String get listing_saved => 'تم حفظ إدراج سيارتك.\nرقم الإدراج: {id}';
	@override String get done => 'تم';
}

// Path: sell_your_car.service_sections
class _TranslationsSellYourCarServiceSectionsAr implements TranslationsSellYourCarServiceSectionsEn {
	_TranslationsSellYourCarServiceSectionsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get all_services => 'جميع الخدمات';
	@override String get sell_your_car => 'بيع سيارتك';
	@override String get sell_a_car => 'بيع سيارة';
	@override String get buy_a_car => 'شراء سيارة';
	@override String get good_condition_car => 'سيارة بحالة جيدة';
	@override String get damaged_car => 'سيارة تالفة';
	@override String get open_an_auction => 'افتح مزاد';
	@override String get fast_track_car_sale => 'بيع سريع للسيارة';
	@override String get lorem_description => 'لوريم إيبسوم دولور سيت أميت، كونسيكتيتور أديبيسيسينغ إليت، سيد دو إيسيمود تيمبور تيمبور';
}

// Path: sell_your_car.duration_tab
class _TranslationsSellYourCarDurationTabAr implements TranslationsSellYourCarDurationTabEn {
	_TranslationsSellYourCarDurationTabAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اختر مدة المزاد';
	@override String get auction_start => 'يجب أن يبدأ المزاد من';
	@override String get starting_price => 'السعر الابتدائي';
	@override String get feature_auction => 'تميز مزادك';
	@override String get feature_description => 'تميز مزادك لزيادة الظهور والمزايدة التنافسية!';
	@override String get total_price => 'السعر الإجمالي : ';
	@override String get days_3 => '3 أيام';
	@override String get days_5 => '5 أيام';
	@override String get days_7 => '7 أيام';
	@override String get kContinue => 'متابعة';
	@override String get proceed_payment => 'الاستمرار في الدفع';
}

// Path: sell_your_car.ft_duration
class _TranslationsSellYourCarFtDurationAr implements TranslationsSellYourCarFtDurationEn {
	_TranslationsSellYourCarFtDurationAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اختر متى تريد استلام نقودك؟';
	@override String get hours_label => 'خلال {hours} ساعة - {discount}% أقل من سعر السوق';
	@override String get fallback_tooltip => 'استخدام الخيارات الافتراضية - الخادم غير متاح';
	@override String get failed_load => 'فشل تحميل خيارات المدة';
	@override String get retry => 'إعادة المحاولة';
	@override String get submit_request => 'إرسال الطلب';
	@override String get total_price => 'السعر الإجمالي : ';
}

// Path: sell_your_car.duration
class _TranslationsSellYourCarDurationAr implements TranslationsSellYourCarDurationEn {
	_TranslationsSellYourCarDurationAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'مدة المزاد';
	@override String get one_day => 'يوم واحد';
	@override String get three_days => '3 أيام';
	@override String get seven_days => '7 أيام';
	@override String get kContinue => 'متابعة';
}

// Path: vendor_dashboard.profile
class _TranslationsVendorDashboardProfileAr implements TranslationsVendorDashboardProfileEn {
	_TranslationsVendorDashboardProfileAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get not_found_title => 'لم يتم العثور على الملف الشخصي';
	@override String get not_found_description => 'لم يتم إعداد ملفك الشخصي بعد. يرجى التواصل مع الدعم لإكمال تسجيلك.';
	@override String get error_loading_title => 'خطأ في تحميل الملف الشخصي';
	@override String get retry => 'إعادة المحاولة';
	@override String get verified => 'تم التحقق';
	@override String get reviews => 'تقييم';
	@override String get vendor_profile => 'ملف البائع الشخصي';
	@override String get profile_not_set_up => 'لم يتم إعداد الملف الشخصي';
	@override String get unable_to_load_profile => 'تعذر تحميل الملف الشخصي';
}

// Path: vendor_dashboard.orders
class _TranslationsVendorDashboardOrdersAr implements TranslationsVendorDashboardOrdersEn {
	_TranslationsVendorDashboardOrdersAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'جميع الطلبات';
	@override String get tab_title => 'الطلبات';
	@override String get tab_subtitle => 'إدارة عملك';
	@override String get live_badge => '{count} طلب';
	@override String get search_hint => 'البحث في الطلبات...';
	@override String get filter_all => 'الكل';
	@override String get filter_services => 'خدمات';
	@override String get filter_products => 'منتجات';
	@override String get tab_all => 'الكل';
	@override String get tab_new => 'جديد';
	@override String get tab_processing => 'قيد المعالجة';
	@override String get tab_completed => 'مكتمل';
	@override String get empty_search_title => 'لم يتم العثور على نتائج';
	@override String get empty_search_subtitle => 'حاول تعديل مصطلحات البحث.';
	@override String get empty_tab => 'لا توجد طلبات {tabName}';
	@override String get empty_tab_subtitle => 'ستظهر الطلبات هنا بمجرد توفرها.';
	@override String get error_loading => 'خطأ في تحميل الطلبات';
}

// Path: vendor_dashboard.request_details
class _TranslationsVendorDashboardRequestDetailsAr implements TranslationsVendorDashboardRequestDetailsEn {
	_TranslationsVendorDashboardRequestDetailsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'تفاصيل الطلب';
	@override String get order_accepted => 'تم قبول الطلب بنجاح';
	@override String get accept_failed => 'فشل قبول الطلب: {error}';
	@override String get status_on_the_way => 'تم تحديث الحالة: في الطريق';
	@override String get status_arrived => 'تم تحديث الحالة: وصل إلى الموقع';
	@override String get service_started => 'بدأت الخدمة';
	@override String get action_failed => 'فشل: {error}';
	@override String get error => 'خطأ: {error}';
	@override String get service_fallback => 'خدمة';
	@override String get order_ref => 'رقم الطلب';
	@override String get amount => 'المبلغ';
	@override String get created => 'تم الإنشاء';
	@override String get scheduled => 'مجدول';
	@override String get route => 'المسار';
	@override String get location => 'الموقع';
	@override String get pickup => 'الاستلام';
	@override String get dropoff => 'التسليم';
	@override String get address => 'العنوان';
	@override String get no_address => 'لم يتم توفير عنوان';
	@override String get open_in_maps => 'فتح في الخرائط';
	@override String get order_details => 'تفاصيل الطلب';
	@override String get base_amount => 'المبلغ الأساسي';
	@override String get total => 'الإجمالي';
	@override String get service_specifications => 'مواصفات الخدمة';
	@override String get customer_information => 'معلومات العميل';
	@override String get attributes => 'السمات';
	@override String get customer => 'العميل';
	@override String get rejection_reason => 'سبب الرفض';
	@override String get no_reason => 'لم يتم تقديم سبب';
	@override String get cancellation_details => 'تفاصيل الإلغاء';
	@override String get cancellation_reason_label => 'السبب: {reason}';
	@override String get penalty_fee => 'رسوم الإلغاء: {fee} د.ك';
	@override String get documents => 'المستندات';
	@override String get document_fallback => 'مستند';
	@override String get reject => 'رفض';
	@override String get accept => 'قبول';
	@override String get assign_operator => 'تعيين مشغل';
	@override String get start_travel => 'بدء التنقل';
	@override String get mark_arrived => 'تحديد الوصول';
	@override String get start_service => 'بدء الخدمة';
	@override String get complete => 'إكمال';
}

// Path: vendor_dashboard.schedule
class _TranslationsVendorDashboardScheduleAr implements TranslationsVendorDashboardScheduleEn {
	_TranslationsVendorDashboardScheduleAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'الجدول';
	@override String get error_loading => 'خطأ في تحميل الطلبات';
	@override String get no_appointments => 'لا توجد مواعيد';
	@override String get no_scheduled_for_date => 'لا توجد طلبات مجدولة لـ {date}';
	@override String get appointment_singular => 'موعد';
	@override String get appointment_plural => 'مواعيد';
	@override String get service_fallback => 'خدمة';
	@override String get customer_fallback => 'عميل';
	@override String get status_pending => 'معلق';
	@override String get status_accepted => 'مقبول';
	@override String get status_en_route => 'في الطريق';
	@override String get status_arrived => 'وصل';
	@override String get status_active => 'نشط';
	@override String get status_done => 'تم';
	@override String get status_cancelled => 'ملغى';
	@override String get status_unknown => 'غير معروف';
}

// Path: vendor_dashboard.support
class _TranslationsVendorDashboardSupportAr implements TranslationsVendorDashboardSupportEn {
	_TranslationsVendorDashboardSupportAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'الدعم';
	@override String get faq_title => 'الأسئلة الشائعة';
	@override String get contact_us => 'اتصل بنا';
	@override String get contact_description => 'تواصل معنا عبر الدردشة المباشرة أو البريد الإلكتروني للحصول على مساعدة سريعة.';
	@override String get email_us => 'راسلنا';
	@override String get chat => 'دردشة';
	@override String get or => 'أو';
	@override String get submit_ticket => 'إرسال تذكرة';
	@override String get faq_1_question => '1. كيف يمكنني التسجيل كبائع؟';
	@override String get faq_1_answer => 'للتسجيل، انقر على خيار "التسجيل كبائع"، وأكمل استمارة التسجيل بتفاصيل عملك، وأرسل المستندات المطلوبة للتحقق.';
	@override String get faq_2_question => '2. هل هناك رسوم لإدراج خدماتي؟';
	@override String get faq_3_question => '3. كيف سأتلقى المدفوعات؟';
	@override String get faq_4_question => '4. هل يمكنني تعديل قائمة خدماتي؟';
	@override String get faq_5_question => '5. كيف أتواصل مع دعم العملاء؟';
}

// Path: vendor_dashboard.wallet
class _TranslationsVendorDashboardWalletAr implements TranslationsVendorDashboardWalletEn {
	_TranslationsVendorDashboardWalletAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'محفظة موتيفا';
	@override String get total_label => 'الإجمالي (د.ك):';
	@override String get withdraw => 'سحب';
	@override late final _TranslationsVendorDashboardWalletTabsAr tabs = _TranslationsVendorDashboardWalletTabsAr._(_root);
	@override String get completed_jobs => 'الوظائف المكتملة';
	@override String get history => 'السجل';
	@override late final _TranslationsVendorDashboardWalletStatsAr stats = _TranslationsVendorDashboardWalletStatsAr._(_root);
	@override late final _TranslationsVendorDashboardWalletHistoryStatusAr history_status = _TranslationsVendorDashboardWalletHistoryStatusAr._(_root);
	@override String get id_label => 'رقم: {id}';
	@override late final _TranslationsVendorDashboardWalletPayoutRequestAr payout_request = _TranslationsVendorDashboardWalletPayoutRequestAr._(_root);
	@override String get coming_soon_message => 'يمكن استخدام رصيد المحفظة للمدفوعات — قريباً!';
	@override String get no_transactions => 'لا توجد معاملات بعد';
	@override String get error_loading => 'فشل تحميل بيانات المحفظة';
	@override String get retry => 'إعادة المحاولة';
	@override late final _TranslationsVendorDashboardWalletPayoutStatusAr payout_status = _TranslationsVendorDashboardWalletPayoutStatusAr._(_root);
	@override String get payout_request_card_title => 'طلب سحب';
	@override String get available_balance => 'الرصيد المتاح';
	@override String get failed_to_load_balance => 'فشل تحميل الرصيد';
	@override String get submitting => 'جارٍ الإرسال...';
	@override late final _TranslationsVendorDashboardWalletMonthsAr months = _TranslationsVendorDashboardWalletMonthsAr._(_root);
	@override late final _TranslationsVendorDashboardWalletReferenceTypesAr reference_types = _TranslationsVendorDashboardWalletReferenceTypesAr._(_root);
}

// Path: vendor_dashboard.operators
class _TranslationsVendorDashboardOperatorsAr implements TranslationsVendorDashboardOperatorsEn {
	_TranslationsVendorDashboardOperatorsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'المشغلون';
	@override String get active => 'نشط';
	@override String get inactive => 'غير نشط';
	@override String get empty_title => 'لا يوجد مشغلون بعد';
	@override String get empty_subtitle => 'أضف أول مشغل للبدء';
	@override String get error_loading => 'خطأ في تحميل المشغلين';
	@override String get add_new => 'إضافة مشغل جديد';
}

// Path: vendor_dashboard.add_operator
class _TranslationsVendorDashboardAddOperatorAr implements TranslationsVendorDashboardAddOperatorEn {
	_TranslationsVendorDashboardAddOperatorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'إضافة مشغل جديد';
	@override String get success => 'تمت إضافة المشغل بنجاح';
	@override String get email_exists => 'هذا البريد الإلكتروني مسجل بالفعل';
	@override String get phone_exists => 'رقم الهاتف مسجل بالفعل';
	@override String get failed => 'فشل إضافة المشغل';
	@override String get section_title => 'معلومات المشغل';
	@override String get full_name => 'الاسم الكامل';
	@override String get name_error => 'الرجاء إدخال اسم المشغل';
	@override String get phone_number => 'رقم الهاتف';
	@override String get phone_error => 'الرجاء إدخال رقم هاتف المشغل';
	@override String get email_address => 'عنوان البريد الإلكتروني';
	@override String get email_error => 'الرجاء إدخال البريد الإلكتروني للمشغل';
	@override String get password => 'كلمة المرور';
	@override String get password_error => 'الرجاء إدخال كلمة مرور';
	@override String get password_min_error => 'يجب أن تكون كلمة المرور 8 أحرف على الأقل';
	@override String get loading => 'جاري التحميل';
	@override String get add_operator_button => 'إضافة مشغل';
}

// Path: vendor_dashboard.settings
class _TranslationsVendorDashboardSettingsAr implements TranslationsVendorDashboardSettingsEn {
	_TranslationsVendorDashboardSettingsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'الإعدادات';
	@override String get search_hint => 'البحث في الإعدادات';
	@override String get not_found => 'لم يتم العثور على إعدادات';
	@override late final _TranslationsVendorDashboardSettingsMenuAr menu = _TranslationsVendorDashboardSettingsMenuAr._(_root);
	@override late final _TranslationsVendorDashboardSettingsDeleteAccountConfirmAr delete_account_confirm = _TranslationsVendorDashboardSettingsDeleteAccountConfirmAr._(_root);
}

// Path: vendor_dashboard.working_hours
class _TranslationsVendorDashboardWorkingHoursAr implements TranslationsVendorDashboardWorkingHoursEn {
	_TranslationsVendorDashboardWorkingHoursAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'ساعات العمل';
	@override String get schedule_exceptions => 'استثناءات الجدول';
	@override String get starting_hour => 'ساعة البدء';
	@override String get closing_hour => 'ساعة الإغلاق';
	@override String get off_days => 'أيام العطلة';
	@override String get saving => 'جاري الحفظ...';
	@override String get save => 'حفظ';
	@override String get update_success => 'تم تحديث ساعات العمل بنجاح';
	@override String get update_failed => 'فشل تحديث ساعات العمل';
	@override String get select_off_days => 'اختر أيام العطلة';
	@override String get done => 'تم';
	@override String get error => 'خطأ: {error}';
}

// Path: vendor_dashboard.documents
class _TranslationsVendorDashboardDocumentsAr implements TranslationsVendorDashboardDocumentsEn {
	_TranslationsVendorDashboardDocumentsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'المستندات';
	@override String get commercial_license => 'السجل التجاري';
	@override String get civil_id => 'البطاقة المدنية';
	@override String get upload_success => 'تم الرفع بنجاح';
	@override String get re_upload_note => 'إعادة الرفع تتطلب موافقة المشرف.';
	@override String get browse => 'تصفح';
	@override String get your_file => 'ملفك';
	@override String get max_size => 'الحد الأقصى 10 ميغابايت';
}

// Path: vendor_dashboard.business_logo
class _TranslationsVendorDashboardBusinessLogoAr implements TranslationsVendorDashboardBusinessLogoEn {
	_TranslationsVendorDashboardBusinessLogoAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'شعار النشاط';
	@override String get instructions_title => 'تعليمات الرفع العامة';
	@override String get instructions_text => 'عند رفع الشعار، تأكد من أنه يتوافق مع الأبعاد الموصى بها 500×500 بكسل أو أكبر للحصول على أفضل جودة.\nاستخدم صيغ PNG أو JPEG بحد أقصى 2 ميغابايت.\nبالنسبة لملفات PNG، الخلفية الشفافة هي المثلى، بينما يجب أن يكون خلفية JPEG بسيطة.\nتأكد من أن الشعار واضح وخالي من التشويش للحفاظ على مظهر احترافي.';
	@override String get logo_updated => 'تم تحديث الشعار بنجاح';
}

// Path: vendor_dashboard.cover_image
class _TranslationsVendorDashboardCoverImageAr implements TranslationsVendorDashboardCoverImageEn {
	_TranslationsVendorDashboardCoverImageAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'صورة الغلاف';
	@override String get updated_success => 'تم تحديث صورة الغلاف بنجاح';
	@override String get guidelines_title => 'إرشادات صورة الغلاف';
	@override String get guidelines_text => 'يتم عرض صورة الغلاف أعلى صفحة البائع.\n\nالأبعاد الموصى بها: 1200 × 400 بكسل أو أكبر.\nاستخدم صيغ PNG أو JPEG بحد أقصى 10 ميغابايت.\n\nنصائح:\n• استخدم صورة عالية الجودة تمثل عملك\n• تجنب الصور ذات النص الكثيف لأنها قد يصعب قراءتها على الجوال\n• تأكد من أن الصورة غير مشوشة أو ضبابية';
	@override String get delete => 'حذف';
}

// Path: vendor_dashboard.service_area
class _TranslationsVendorDashboardServiceAreaAr implements TranslationsVendorDashboardServiceAreaEn {
	_TranslationsVendorDashboardServiceAreaAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'مدن الخدمة';
	@override String get search_hint => 'البحث عن مدينة';
}

// Path: vendor_dashboard.service_categories
class _TranslationsVendorDashboardServiceCategoriesAr implements TranslationsVendorDashboardServiceCategoriesEn {
	_TranslationsVendorDashboardServiceCategoriesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'فئات الخدمة';
	@override String get add_new => 'إضافة جديدة';
	@override String get oil_filters => 'فلاتر الزيت';
	@override String get fix_my_car => 'أصلح سيارتي';
	@override String get car_batteries => 'بطاريات السيارات';
}

// Path: vendor_dashboard.schedule_exceptions
class _TranslationsVendorDashboardScheduleExceptionsAr implements TranslationsVendorDashboardScheduleExceptionsEn {
	_TranslationsVendorDashboardScheduleExceptionsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'استثناءات الجدول';
	@override String get load_failed => 'فشل تحميل استثناءات الجدول';
	@override String get retry => 'إعادة المحاولة';
	@override String get empty_title => 'لا توجد استثناءات';
	@override String get empty_subtitle => 'أضف استثناءات للعطلات أو الأيام الخاصة';
	@override String get add_button => 'إضافة استثناء';
	@override String get delete_tooltip => 'حذف الاستثناء';
	@override String get fully_closed => 'مغلق بالكامل';
	@override String get modified_hours => 'ساعات معدلة';
	@override String get hours_label => 'الساعات: {start} - {end}';
	@override String get reason_label => 'السبب: {reason}';
	@override String get delete_dialog_title => 'حذف الاستثناء';
	@override String get delete_dialog_message => 'هل أنت متأكد أنك تريد حذف هذا الاستثناء؟';
	@override String get cancel => 'إلغاء';
	@override String get delete => 'حذف';
	@override String get delete_success => 'تم حذف الاستثناء بنجاح';
	@override String get delete_failed => 'فشل حذف الاستثناء';
	@override String get add_dialog_title => 'إضافة استثناء للجدول';
	@override String get date_label => 'التاريخ';
	@override String get fully_closed_switch => 'مغلق بالكامل';
	@override String get start_time => 'وقت البدء';
	@override String get select_time => 'اختر';
	@override String get end_time => 'وقت الانتهاء';
	@override String get reason_optional => 'السبب (اختياري)';
	@override String get select_times_error => 'الرجاء اختيار أوقات البدء والانتهاء';
	@override String get add_success => 'تمت إضافة الاستثناء بنجاح';
	@override String get add_failed => 'فشل إضافة الاستثناء';
	@override String get add_button_dialog => 'إضافة';
	@override String get error => 'خطأ: {error}';
}

// Path: vendor_dashboard.recent_completed
class _TranslationsVendorDashboardRecentCompletedAr implements TranslationsVendorDashboardRecentCompletedEn {
	_TranslationsVendorDashboardRecentCompletedAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'مكتملة حديثاً';
	@override String get see_all => 'عرض الكل';
	@override String get empty => 'لا توجد طلبات مكتملة بعد';
	@override String get service_fallback => 'خدمة';
	@override String get customer_fallback => 'عميل';
}

// Path: vendor_dashboard.todays_schedule
class _TranslationsVendorDashboardTodaysScheduleAr implements TranslationsVendorDashboardTodaysScheduleEn {
	_TranslationsVendorDashboardTodaysScheduleAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'جدول اليوم';
	@override String get view_calendar => 'عرض التقويم';
	@override String get view_full_calendar => 'عرض التقويم الكامل';
	@override String get empty => 'لا توجد مواعيد اليوم';
	@override String get asap => 'فوري';
	@override String get service_fallback => 'خدمة';
}

// Path: vendor_dashboard.request_cards
class _TranslationsVendorDashboardRequestCardsAr implements TranslationsVendorDashboardRequestCardsEn {
	_TranslationsVendorDashboardRequestCardsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get order_ref => 'رقم الطلب';
	@override String get amount => 'المبلغ';
	@override String get completed => 'مكتمل';
	@override String get time => 'الوقت';
	@override String get status => 'الحالة';
	@override String get view_details => 'عرض التفاصيل';
	@override String get view_details_normal => 'عرض التفاصيل';
	@override String get proceed => 'متابعة';
	@override String get service_fallback => 'خدمة';
	@override String get customer_fallback => 'عميل';
}

// Path: vendor_dashboard.promo_banner
class _TranslationsVendorDashboardPromoBannerAr implements TranslationsVendorDashboardPromoBannerEn {
	_TranslationsVendorDashboardPromoBannerAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'وفّر حتى 5 د.ك';
	@override String get description => 'عرض لفترة محدودة على\nخدمات محددة';
}

// Path: vendor_dashboard.profile_menu
class _TranslationsVendorDashboardProfileMenuAr implements TranslationsVendorDashboardProfileMenuEn {
	_TranslationsVendorDashboardProfileMenuAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get all_orders => 'جميع الطلبات';
	@override String get my_listings => 'قوائمي';
	@override String get inventory_history => 'سجل المخزون';
	@override String get wallet => 'المحفظة';
	@override String get faqs => 'الأسئلة الشائعة';
}

// Path: vendor_dashboard.unified_order_card
class _TranslationsVendorDashboardUnifiedOrderCardAr implements TranslationsVendorDashboardUnifiedOrderCardEn {
	_TranslationsVendorDashboardUnifiedOrderCardAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get service_order => 'طلب خدمة';
	@override String get product_order => 'طلب منتج';
	@override String get service_fallback => 'خدمة';
	@override String get customer_fallback => 'عميل';
	@override String get item_singular => 'عنصر';
	@override String get item_plural => 'عناصر';
	@override String get reference => 'المرجع';
	@override String get amount => 'المبلغ';
	@override String get time => 'الوقت';
	@override String get status => 'الحالة';
	@override String get date => 'التاريخ';
}

// Path: vendor_listings.snackbar
class _TranslationsVendorListingsSnackbarAr implements TranslationsVendorListingsSnackbarEn {
	_TranslationsVendorListingsSnackbarAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get product_deactivated => 'تم إلغاء تفعيل المنتج';
	@override String get product_activated => 'تم تفعيل المنتج';
	@override String get update_status_failed => 'فشل تحديث حالة المنتج';
	@override String get product_deleted => 'تم حذف المنتج بنجاح';
	@override String get delete_failed => 'فشل حذف المنتج';
	@override String get service_archived => 'تم أرشفة الخدمة بنجاح';
	@override String get archive_failed => 'فشل أرشفة الخدمة';
	@override String get service_restored => 'تم استعادة الخدمة بنجاح';
	@override String get restore_failed => 'فشل استعادة الخدمة';
}

// Path: vendor_listings.dialog
class _TranslationsVendorListingsDialogAr implements TranslationsVendorListingsDialogEn {
	_TranslationsVendorListingsDialogAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get delete_product_title => 'حذف المنتج';
	@override String get delete_product_message => 'هل أنت متأكد أنك تريد حذف "{name}"؟ لا يمكن التراجع عن هذا الإجراء.';
	@override String get delete_confirm => 'حذف';
	@override String get archive_service_title => 'أرشفة الخدمة';
	@override String get archive_service_message => 'هل أنت متأكد أنك تريد أرشفة "{name}"؟ سيتم إخفاؤها عن العملاء.';
	@override String get archive_confirm => 'أرشفة';
}

// Path: vendor_listings.empty
class _TranslationsVendorListingsEmptyAr implements TranslationsVendorListingsEmptyEn {
	_TranslationsVendorListingsEmptyAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get no_results => 'لم يتم العثور على نتائج';
	@override String get no_products => 'لا توجد منتجات بعد';
	@override String get no_services => 'لا توجد خدمات بعد';
	@override String get no_listings => 'لا توجد قوائم بعد';
	@override String get adjust_search => 'حاول تعديل مصطلحات البحث.';
	@override String get create_product_prompt => 'أنشئ منتجك الأول لبدء البيع.';
	@override String get create_service_prompt => 'أنشئ خدمتك الأولى لبدء استقبال الطلبات.';
	@override String get create_listing_prompt => 'أنشئ قائمتك الأولى لبدء استقبال الطلبات.';
	@override String get create_listing_button => 'إنشاء قائمة';
}

// Path: vendor_listings.error
class _TranslationsVendorListingsErrorAr implements TranslationsVendorListingsErrorEn {
	_TranslationsVendorListingsErrorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'خطأ في تحميل القوائم';
	@override String get message => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';
	@override String get retry => 'إعادة المحاولة';
}

// Path: vendor_listings.bottom_sheet
class _TranslationsVendorListingsBottomSheetAr implements TranslationsVendorListingsBottomSheetEn {
	_TranslationsVendorListingsBottomSheetAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'إنشاء جديد';
	@override String get product_label => 'منتج';
	@override String get product_description => 'أضف منتجًا جديدًا إلى كتالوجك';
	@override String get service_label => 'خدمة';
	@override String get service_description => 'أضف خدمة جديدة';
}

// Path: vendor_listings.card
class _TranslationsVendorListingsCardAr implements TranslationsVendorListingsCardEn {
	_TranslationsVendorListingsCardAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get type_product => 'منتج';
	@override String get type_service => 'خدمة';
	@override String get stock_label => 'المخزون: {count}';
	@override String get status_active => 'نشط';
	@override String get status_inactive => 'غير نشط';
	@override String get status_archived => 'مؤرشف';
	@override String get currency_suffix => ' د.ك';
}

// Path: vendor_listings.tooltip
class _TranslationsVendorListingsTooltipAr implements TranslationsVendorListingsTooltipEn {
	_TranslationsVendorListingsTooltipAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get activate => 'تفعيل';
	@override String get deactivate => 'إلغاء التفعيل';
	@override String get archive => 'أرشفة';
	@override String get restore => 'استعادة';
	@override String get edit => 'تعديل';
	@override String get delete => 'حذف';
}

// Path: vendor_listings.category
class _TranslationsVendorListingsCategoryAr implements TranslationsVendorListingsCategoryEn {
	_TranslationsVendorListingsCategoryAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get active => 'نشط';
	@override String get inactive => 'غير نشط';
	@override String get services_fallback => 'خدمات';
	@override String get products_fallback => 'منتجات';
}

// Path: vendor_products.empty
class _TranslationsVendorProductsEmptyAr implements TranslationsVendorProductsEmptyEn {
	_TranslationsVendorProductsEmptyAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get no_results => 'لم يتم العثور على نتائج';
	@override String get no_products => 'لا توجد منتجات بعد';
	@override String get no_inactive_products => 'لا توجد منتجات غير نشطة';
	@override String get inactive_subtitle => 'ستظهر المنتجات غير النشطة هنا.';
	@override String get adjust_search => 'حاول تعديل مصطلحات البحث.';
	@override String get create_product_prompt => 'أنشئ منتجك الأول لبدء البيع.';
	@override String get create_product_button => 'إنشاء منتج';
}

// Path: vendor_products.dialog
class _TranslationsVendorProductsDialogAr implements TranslationsVendorProductsDialogEn {
	_TranslationsVendorProductsDialogAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get delete_title => 'حذف المنتج';
	@override String get delete_message => 'هل أنت متأكد أنك تريد حذف "{name}"؟ لا يمكن التراجع عن هذا الإجراء.';
	@override String get cancel => 'إلغاء';
	@override String get delete => 'حذف';
}

// Path: vendor_products.snackbar
class _TranslationsVendorProductsSnackbarAr implements TranslationsVendorProductsSnackbarEn {
	_TranslationsVendorProductsSnackbarAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get product_deleted => 'تم حذف المنتج بنجاح';
	@override String get delete_failed => 'فشل حذف المنتج';
	@override String get product_deactivated => 'تم إلغاء تفعيل المنتج';
	@override String get product_activated => 'تم تفعيل المنتج';
	@override String get update_status_failed => 'فشل تحديث حالة المنتج';
}

// Path: vendor_products.error
class _TranslationsVendorProductsErrorAr implements TranslationsVendorProductsErrorEn {
	_TranslationsVendorProductsErrorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'خطأ في تحميل المنتجات';
	@override String get message => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';
	@override String get retry => 'إعادة المحاولة';
}

// Path: vendor_products.card
class _TranslationsVendorProductsCardAr implements TranslationsVendorProductsCardEn {
	_TranslationsVendorProductsCardAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get inactive => 'غير نشط';
	@override String get stock_label => 'المخزون: {count}';
	@override String get type_accessory => 'إكسسوار';
	@override String get type_spare_part => 'قطع غيار';
}

// Path: vendor_products.tooltip
class _TranslationsVendorProductsTooltipAr implements TranslationsVendorProductsTooltipEn {
	_TranslationsVendorProductsTooltipAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get activate => 'تفعيل';
	@override String get deactivate => 'إلغاء التفعيل';
	@override String get edit => 'تعديل';
	@override String get delete => 'حذف';
}

// Path: vendor_products.create_product
class _TranslationsVendorProductsCreateProductAr implements TranslationsVendorProductsCreateProductEn {
	_TranslationsVendorProductsCreateProductAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get app_bar_new => 'منتج جديد';
	@override String get app_bar_edit => 'تعديل المنتج';
	@override String get field_name_label => 'اسم المنتج';
	@override String get field_name_hint => 'مثال: فرامل';
	@override String get field_description_label => 'الوصف (اختياري)';
	@override String get field_description_hint => 'صف منتجك';
	@override String get field_price_label => 'السعر (د.ك)';
	@override String get field_price_hint => '0.00';
	@override String get field_stock_label => 'كمية المخزون';
	@override String get field_stock_hint => '10';
	@override String get product_type_label => 'نوع المنتج';
	@override String get product_type_accessory => 'إكسسوار';
	@override String get product_type_spare_part => 'قطع غيار';
	@override String get images_title => 'صور المنتج';
	@override String get images_subtitle => 'قم بتحميل صور لعرض منتجك';
	@override String get add_image_button => 'إضافة';
	@override String get button_create => 'إنشاء منتج';
	@override String get button_save => 'حفظ التغييرات';
	@override String get snackbar_created => 'تم إنشاء المنتج بنجاح';
	@override String get snackbar_updated => 'تم تحديث المنتج بنجاح';
	@override String get snackbar_create_failed => 'فشل إنشاء المنتج. يرجى التحقق من المدخلات والمحاولة مرة أخرى.';
	@override String get snackbar_update_failed => 'فشل تحديث المنتج. يرجى التحقق من المدخلات والمحاولة مرة أخرى.';
	@override String get validation_required => '{field} مطلوب';
	@override String get validation_valid_number => 'أدخل {field} صالح';
	@override String get spare_part_section_title => 'مواصفات قطعة الغيار';
	@override String get part_number_label => 'رقم القطعة';
	@override String get brand_label => 'الماركة';
	@override String get warranty_label => 'الضمان (بالأشهر)';
	@override String get compatibility_label => 'التوافق';
	@override String get compatibility_empty => 'لا توجد إدخالات توافق';
	@override String get compatibility_make => 'الشركة المصنعة';
	@override String get compatibility_model => 'الطراز';
	@override String get compatibility_year_from => 'السنة من';
	@override String get compatibility_year_to => 'السنة إلى';
	@override String get compatibility_add => 'إضافة';
}

// Path: inventory.empty
class _TranslationsInventoryEmptyAr implements TranslationsInventoryEmptyEn {
	_TranslationsInventoryEmptyAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'لم يتم العثور على معاملات';
	@override String get filtered_subtitle => 'حاول تعديل عوامل التصفية.';
	@override String get subtitle => 'ستظهر معاملات المخزون هنا.';
}

// Path: inventory.error
class _TranslationsInventoryErrorAr implements TranslationsInventoryErrorEn {
	_TranslationsInventoryErrorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'خطأ في تحميل المعاملات';
	@override String get message => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';
	@override String get retry => 'إعادة المحاولة';
}

// Path: inventory.card
class _TranslationsInventoryCardAr implements TranslationsInventoryCardEn {
	_TranslationsInventoryCardAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get before => 'قبل:';
	@override String get after => 'بعد:';
	@override String get reason => 'السبب:';
}

// Path: inventory.transaction_type
class _TranslationsInventoryTransactionTypeAr implements TranslationsInventoryTransactionTypeEn {
	_TranslationsInventoryTransactionTypeAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get sale => 'سحب مخزون';
	@override String get restock => 'إضافة مخزون';
	@override String get adjustment => 'تسوية';
	@override String get refund => 'استرداد';
}

// Path: vendor_services.screen
class _TranslationsVendorServicesScreenAr implements TranslationsVendorServicesScreenEn {
	_TranslationsVendorServicesScreenAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'خدماتي';
	@override String get search_hint => 'ابحث في الخدمات... ';
}

// Path: vendor_services.filter
class _TranslationsVendorServicesFilterAr implements TranslationsVendorServicesFilterEn {
	_TranslationsVendorServicesFilterAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get all => 'الكل';
	@override String get active => 'نشط';
	@override String get archived => 'مؤرشف';
}

// Path: vendor_services.empty
class _TranslationsVendorServicesEmptyAr implements TranslationsVendorServicesEmptyEn {
	_TranslationsVendorServicesEmptyAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsVendorServicesEmptySearchAr search = _TranslationsVendorServicesEmptySearchAr._(_root);
	@override late final _TranslationsVendorServicesEmptyArchivedAr archived = _TranslationsVendorServicesEmptyArchivedAr._(_root);
	@override late final _TranslationsVendorServicesEmptyNoServicesAr no_services = _TranslationsVendorServicesEmptyNoServicesAr._(_root);
}

// Path: vendor_services.error
class _TranslationsVendorServicesErrorAr implements TranslationsVendorServicesErrorEn {
	_TranslationsVendorServicesErrorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'خطأ في تحميل الخدمات';
	@override String get subtitle => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';
	@override String get retry => 'إعادة المحاولة';
}

// Path: vendor_services.create_screen
class _TranslationsVendorServicesCreateScreenAr implements TranslationsVendorServicesCreateScreenEn {
	_TranslationsVendorServicesCreateScreenAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsVendorServicesCreateScreenAppBarAr app_bar = _TranslationsVendorServicesCreateScreenAppBarAr._(_root);
	@override late final _TranslationsVendorServicesCreateScreenFormAr form = _TranslationsVendorServicesCreateScreenFormAr._(_root);
	@override late final _TranslationsVendorServicesCreateScreenImageUploadAr image_upload = _TranslationsVendorServicesCreateScreenImageUploadAr._(_root);
	@override late final _TranslationsVendorServicesCreateScreenAttributesAr attributes = _TranslationsVendorServicesCreateScreenAttributesAr._(_root);
	@override late final _TranslationsVendorServicesCreateScreenCustomerQuestionsAr customer_questions = _TranslationsVendorServicesCreateScreenCustomerQuestionsAr._(_root);
	@override late final _TranslationsVendorServicesCreateScreenButtonAr button = _TranslationsVendorServicesCreateScreenButtonAr._(_root);
	@override late final _TranslationsVendorServicesCreateScreenSnackbarAr snackbar = _TranslationsVendorServicesCreateScreenSnackbarAr._(_root);
	@override late final _TranslationsVendorServicesCreateScreenDialogAr dialog = _TranslationsVendorServicesCreateScreenDialogAr._(_root);
	@override late final _TranslationsVendorServicesCreateScreenErrorAr error = _TranslationsVendorServicesCreateScreenErrorAr._(_root);
}

// Path: vendor_services.select_category
class _TranslationsVendorServicesSelectCategoryAr implements TranslationsVendorServicesSelectCategoryEn {
	_TranslationsVendorServicesSelectCategoryAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اختيار الفئة';
	@override String get search_hint => 'ابحث في الفئات...';
	@override late final _TranslationsVendorServicesSelectCategoryEmptyAr empty = _TranslationsVendorServicesSelectCategoryEmptyAr._(_root);
	@override late final _TranslationsVendorServicesSelectCategorySearchEmptyAr search_empty = _TranslationsVendorServicesSelectCategorySearchEmptyAr._(_root);
	@override late final _TranslationsVendorServicesSelectCategoryErrorAr error = _TranslationsVendorServicesSelectCategoryErrorAr._(_root);
}

// Path: vendor_services.service_card
class _TranslationsVendorServicesServiceCardAr implements TranslationsVendorServicesServiceCardEn {
	_TranslationsVendorServicesServiceCardAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get archived_badge => 'مؤرشف';
	@override String get price_format => '{price} د.ك';
	@override String get radius_format => '{radius} كم';
	@override late final _TranslationsVendorServicesServiceCardTooltipAr tooltip = _TranslationsVendorServicesServiceCardTooltipAr._(_root);
	@override late final _TranslationsVendorServicesServiceCardActionAr action = _TranslationsVendorServicesServiceCardActionAr._(_root);
}

// Path: vendor_services.category_section
class _TranslationsVendorServicesCategorySectionAr implements TranslationsVendorServicesCategorySectionEn {
	_TranslationsVendorServicesCategorySectionAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get fallback_name => 'الخدمات';
	@override String get status => '{active} نشط';
	@override String get status_with_archived => '{active} نشط • {archived} مؤرشف';
	@override late final _TranslationsVendorServicesCategorySectionDialogAr dialog = _TranslationsVendorServicesCategorySectionDialogAr._(_root);
	@override late final _TranslationsVendorServicesCategorySectionSnackbarAr snackbar = _TranslationsVendorServicesCategorySectionSnackbarAr._(_root);
}

// Path: vendor_product_analytics.metrics
class _TranslationsVendorProductAnalyticsMetricsAr implements TranslationsVendorProductAnalyticsMetricsEn {
	_TranslationsVendorProductAnalyticsMetricsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get total_views => 'إجمالي المشاهدات';
	@override String get conversion => 'معدل التحويل';
	@override String get total_orders => 'إجمالي الطلبات';
}

// Path: vendor_product_analytics.time_period
class _TranslationsVendorProductAnalyticsTimePeriodAr implements TranslationsVendorProductAnalyticsTimePeriodEn {
	_TranslationsVendorProductAnalyticsTimePeriodAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get k7d => '٧ي';
	@override String get k30d => '٣٠ي';
	@override String get k90d => '٩٠ي';
}

// Path: vendor_product_analytics.charts
class _TranslationsVendorProductAnalyticsChartsAr implements TranslationsVendorProductAnalyticsChartsEn {
	_TranslationsVendorProductAnalyticsChartsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get revenue_over_time => 'الإيرادات عبر الزمن';
	@override String get top_products => 'أفضل المنتجات';
	@override String get sales => '{count} مبيعات';
}

// Path: vendor_product_analytics.empty
class _TranslationsVendorProductAnalyticsEmptyAr implements TranslationsVendorProductAnalyticsEmptyEn {
	_TranslationsVendorProductAnalyticsEmptyAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get no_revenue_data => 'لا توجد بيانات إيرادات متاحة';
	@override String get no_product_sales_data => 'لا توجد بيانات مبيعات منتجات متاحة';
}

// Path: vendor_product_analytics.error
class _TranslationsVendorProductAnalyticsErrorAr implements TranslationsVendorProductAnalyticsErrorEn {
	_TranslationsVendorProductAnalyticsErrorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'خطأ في تحميل التحليلات';
	@override String get message => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';
	@override String get retry => 'إعادة المحاولة';
}

// Path: auth.category.error
class _TranslationsAuthCategoryErrorAr implements TranslationsAuthCategoryErrorEn {
	_TranslationsAuthCategoryErrorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get null_category => 'يرجى اختيار فئة';
	@override String get no_categories => 'لا توجد فئات متاحة';
	@override String get failed_to_load => 'فشل تحميل الفئات';
	@override String get button => 'إعادة المحاولة';
	@override String get registration_failed => 'فشل التسجيل. يرجى المحاولة مرة أخرى.';
}

// Path: auth.splash.vendor
class _TranslationsAuthSplashVendorAr implements TranslationsAuthSplashVendorEn {
	_TranslationsAuthSplashVendorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'جاري التحقق من الملف الشخصي...';
	@override String get login_error => 'فشل التحقق من ملف البائع الشخصي';
	@override String get logout_error => 'ملف البائع الشخصي غير مكتمل أو لم يتم العثور عليه.\nيرجى التواصل مع الدعم أو إكمال التسجيل للمتابعة.';
}

// Path: auth.splash.error
class _TranslationsAuthSplashErrorAr implements TranslationsAuthSplashErrorEn {
	_TranslationsAuthSplashErrorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get splash_failed => 'خطأ في المصادقة عند التشغيل';
	@override String get auth_failed => 'فشلت المصادقة. يرجى تسجيل الدخول مرة أخرى.';
}

// Path: booking.booking_screen.location
class _TranslationsBookingBookingScreenLocationAr implements TranslationsBookingBookingScreenLocationEn {
	_TranslationsBookingBookingScreenLocationAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'موقع الخدمة';
	@override String get selected => 'تم الاختيار';
	@override String get tap_to_select => 'اضغط للاختيار';
	@override String get tap_to_select_location => 'اضغط لاختيار الموقع على الخريطة';
	@override String get pick => 'اختيار';
	@override String get pick_location => 'اختيار الموقع';
	@override String get additional_details => 'تفاصيل العنوان الإضافية (اختياري)';
	@override String get pickup => 'موقع الاستلام';
	@override String get drop_off => 'موقع التسليم';
	@override String get location_selected => 'تم اختيار الموقع';
	@override String get success => 'تم الاختيار بنجاح';
	@override String get success_location => 'تم اختيار الموقع بنجاح';
	@override String get null_location => 'يرجى اختيار موقعك';
	@override String get null_pickup => 'يرجى اختيار موقع الاستلام';
	@override String get null_drop_off => 'يرجى اختيار موقع التسليم';
}

// Path: booking.booking_screen.scheduling
class _TranslationsBookingBookingScreenSchedulingAr implements TranslationsBookingBookingScreenSchedulingEn {
	_TranslationsBookingBookingScreenSchedulingAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'جدولة';
	@override String get date => 'اختر التاريخ';
	@override String get jan => 'يناير';
	@override String get feb => 'فبراير';
	@override String get mar => 'مارس';
	@override String get apr => 'أبريل';
	@override String get may => 'مايو';
	@override String get jun => 'يونيو';
	@override String get jul => 'يوليو';
	@override String get aug => 'أغسطس';
	@override String get sep => 'سبتمبر';
	@override String get oct => 'أكتوبر';
	@override String get nov => 'نوفمبر';
	@override String get dec => 'ديسمبر';
	@override String get time => 'الوقت المتاح';
	@override String get clear => 'مسح';
	@override String get null_time => 'لا توجد أوقات متاحة لهذا التاريخ. يرجى اختيار تاريخ آخر.';
	@override String get select_time => 'يرجى اختيار وقت';
	@override String get error_time => 'لا يوجد وقت متاح';
	@override String get next_available => 'التالي المتاح';
	@override String get select_next_available => 'اختر هذا اليوم';
}

// Path: booking.booking_screen.order
class _TranslationsBookingBookingScreenOrderAr implements TranslationsBookingBookingScreenOrderEn {
	_TranslationsBookingBookingScreenOrderAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'ملخص الطلب';
	@override String get base_amount => 'المبلغ الأساسي';
	@override String get description => 'سيتم تأكيد المبلغ النهائي من قبل البائع';
}

// Path: booking.booking_screen.button
class _TranslationsBookingBookingScreenButtonAr implements TranslationsBookingBookingScreenButtonEn {
	_TranslationsBookingBookingScreenButtonAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تأكيد الحجز';
	@override String get error_location => 'يرجى اختيار موقعك للمتابعة';
	@override String get error_pickup => 'يرجى اختيار موقع الاستلام';
	@override String get error_drop_off => 'يرجى اختيار موقع التسليم';
}

// Path: booking.order_confirmation.status
class _TranslationsBookingOrderConfirmationStatusAr implements TranslationsBookingOrderConfirmationStatusEn {
	_TranslationsBookingOrderConfirmationStatusAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تم تأكيد الحجز';
	@override String get description => 'تم قبول حجزك وتأكيده تلقائيًا بنجاح.';
}

// Path: booking.order_confirmation.info
class _TranslationsBookingOrderConfirmationInfoAr implements TranslationsBookingOrderConfirmationInfoEn {
	_TranslationsBookingOrderConfirmationInfoAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get service => 'الخدمة';
	@override String get vendor => 'البائع';
	@override String get base_amount => 'المبلغ الأساسي';
	@override String get scheduled => 'المجدول';
	@override String get location => 'الموقع';
}

// Path: booking.order_confirmation.button
class _TranslationsBookingOrderConfirmationButtonAr implements TranslationsBookingOrderConfirmationButtonEn {
	_TranslationsBookingOrderConfirmationButtonAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get primary => 'العودة إلى الرئيسية';
	@override String get secondary => 'الذهاب إلى طلباتي';
}

// Path: home.customer.active_orders
class _TranslationsHomeCustomerActiveOrdersAr implements TranslationsHomeCustomerActiveOrdersEn {
	_TranslationsHomeCustomerActiveOrdersAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsHomeCustomerActiveOrdersEmptyAr empty = _TranslationsHomeCustomerActiveOrdersEmptyAr._(_root);
	@override late final _TranslationsHomeCustomerActiveOrdersOrderAr order = _TranslationsHomeCustomerActiveOrdersOrderAr._(_root);
}

// Path: home.customer.premium_banner
class _TranslationsHomeCustomerPremiumBannerAr implements TranslationsHomeCustomerPremiumBannerEn {
	_TranslationsHomeCustomerPremiumBannerAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'ترقية إلى بريميوم\nللحصول على مزايا\nحصرية!';
	@override String get button => 'ترقية الآن';
}

// Path: home.customer.ad_banner
class _TranslationsHomeCustomerAdBannerAr implements TranslationsHomeCustomerAdBannerEn {
	_TranslationsHomeCustomerAdBannerAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'مساعدة الطريق\nبخصم 10% - احجز الآن!';
}

// Path: home.customer.services_grid
class _TranslationsHomeCustomerServicesGridAr implements TranslationsHomeCustomerServicesGridEn {
	_TranslationsHomeCustomerServicesGridAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الخدمات المتاحة';
	@override String get view_all => 'عرض الكل';
	@override String get error_category => 'فشل تحميل فئات الخدمات';
	@override late final _TranslationsHomeCustomerServicesGridErrorAr error = _TranslationsHomeCustomerServicesGridErrorAr._(_root);
	@override late final _TranslationsHomeCustomerServicesGridEmptyAr empty = _TranslationsHomeCustomerServicesGridEmptyAr._(_root);
}

// Path: home.customer.buy_sell_card
class _TranslationsHomeCustomerBuySellCardAr implements TranslationsHomeCustomerBuySellCardEn {
	_TranslationsHomeCustomerBuySellCardAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get buy => 'شراء سيارة';
	@override String get sell => 'بيع سيارتك';
	@override String get tap => 'اضغط هنا';
}

// Path: home.customer.promo_banner
class _TranslationsHomeCustomerPromoBannerAr implements TranslationsHomeCustomerPromoBannerEn {
	_TranslationsHomeCustomerPromoBannerAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'وفر حتى 5 د.ك';
	@override String get description => 'عرض محدود على خدمات\nمحددة';
}

// Path: home.customer.listing
class _TranslationsHomeCustomerListingAr implements TranslationsHomeCustomerListingEn {
	_TranslationsHomeCustomerListingAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get popular_today => 'الأكثر شيوعًا اليوم';
	@override String get top_vendors => 'أفضل البائعين';
	@override String get new_vendors => 'بائعون جدد';
}

// Path: home.vendor.services_grid
class _TranslationsHomeVendorServicesGridAr implements TranslationsHomeVendorServicesGridEn {
	_TranslationsHomeVendorServicesGridAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get messages => 'الرسائل';
	@override String get support => 'الدعم';
	@override String get requests => 'الطلبات';
	@override String get orders => 'الطلبات';
	@override String get add_services => 'إضافة خدمات';
	@override String get current_services => 'الخدمات الحالية';
}

// Path: home.vendor.stats
class _TranslationsHomeVendorStatsAr implements TranslationsHomeVendorStatsEn {
	_TranslationsHomeVendorStatsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get today => 'اليوم';
	@override String get weekly => 'أسبوعي';
	@override String get monthly => 'شهري';
	@override String get this_weekly => 'هذا الأسبوع';
	@override String get this_monthly => 'هذا الشهر';
	@override late final _TranslationsHomeVendorStatsStatsCardAr stats_card = _TranslationsHomeVendorStatsStatsCardAr._(_root);
}

// Path: home.vendor.availability_capacity
class _TranslationsHomeVendorAvailabilityCapacityAr implements TranslationsHomeVendorAvailabilityCapacityEn {
	_TranslationsHomeVendorAvailabilityCapacityAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'التوفر والسعة';
	@override late final _TranslationsHomeVendorAvailabilityCapacityAvailabilityAr availability = _TranslationsHomeVendorAvailabilityCapacityAvailabilityAr._(_root);
	@override late final _TranslationsHomeVendorAvailabilityCapacityStatusAr status = _TranslationsHomeVendorAvailabilityCapacityStatusAr._(_root);
	@override late final _TranslationsHomeVendorAvailabilityCapacityCapacityAr capacity = _TranslationsHomeVendorAvailabilityCapacityCapacityAr._(_root);
}

// Path: home.vendor.active_orders
class _TranslationsHomeVendorActiveOrdersAr implements TranslationsHomeVendorActiveOrdersEn {
	_TranslationsHomeVendorActiveOrdersAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الطلبات النشطة';
	@override String get all => 'الكل';
	@override String get en_route => 'في الطريق';
	@override String get arrived => 'وصل';
	@override String get in_progress => 'قيد التنفيذ';
	@override String get empty => 'لا توجد طلبات';
	@override String get service => 'الخدمة';
	@override String get customer => 'العميل';
	@override String get asap => 'في أقرب وقت';
}

// Path: home.vendor.checkout_orders
class _TranslationsHomeVendorCheckoutOrdersAr implements TranslationsHomeVendorCheckoutOrdersEn {
	_TranslationsHomeVendorCheckoutOrdersAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'طلبات المنتجات';
	@override String get all => 'الكل';
	@override String get pending => 'معلق';
	@override String get processing => 'قيد المعالجة';
	@override String get confirmed => 'مؤكد';
	@override String get shipped => 'تم الشحن';
	@override String get empty => 'لا توجد طلبات منتجات';
	@override String get order_number => 'طلب #';
	@override String get items_count => 'عناصر';
	@override String get item => 'عنصر';
	@override String get payment_method => 'الدفع: نقدًا عند التسليم';
	@override String get cancel => 'إلغاء';
	@override String get ship => 'تحديد كمشحون';
	@override String get deliver => 'تحديد كمسلم';
	@override String get product_order => 'طلب منتج';
	@override String get placed => 'تم الطلب';
	@override String get total => 'الإجمالي';
	@override String get status_timeline => 'الجدول الزمني للحالة';
	@override late final _TranslationsHomeVendorCheckoutOrdersTimelineAr timeline = _TranslationsHomeVendorCheckoutOrdersTimelineAr._(_root);
	@override late final _TranslationsHomeVendorCheckoutOrdersStatusAr status = _TranslationsHomeVendorCheckoutOrdersStatusAr._(_root);
	@override String get customer => 'العميل';
	@override String get order_items => 'عناصر الطلب';
	@override String get delivery => 'التوصيل';
	@override String get delivery_address => 'عنوان التوصيل';
	@override String get no_address_provided => 'لم يتم تقديم عنوان';
	@override String get payment => 'الدفع';
	@override String get payment_status => 'الحالة';
	@override String get payment_paid => 'مدفوع';
	@override String get payment_pending => 'معلق';
	@override String get order_info => 'معلومات الطلب';
	@override String get order_id => 'رقم الطلب';
	@override String get placed_on => 'تم الطلب في';
	@override String get last_updated => 'آخر تحديث';
	@override String get est_delivery => 'التسليم المتوقع';
	@override String get cancellation => 'الإلغاء';
	@override String get cancellation_reason => 'سبب الإلغاء';
	@override String get no_reason_provided => 'لم يتم تقديم سبب';
	@override String get loading_order => 'جاري تحميل الطلب...';
	@override String get failed_to_load => 'فشل التحميل';
	@override String get try_again => 'حاول مرة أخرى';
	@override String get mark_shipped => 'تحديد كمشحون';
	@override String get mark_delivered => 'تم التسليم';
	@override String get order_shipped_success => 'تم شحن الطلب!';
	@override String get order_delivered_success => 'تم تسليم الطلب!';
	@override String get failed => 'فشل';
	@override String get not_specified => 'غير محدد';
	@override String get cash_on_delivery => 'الدفع عند التسليم';
	@override String get credit_debit_card => 'بطاقة ائتمان/خصم';
}

// Path: public_services.category_vendors.vendor_card
class _TranslationsPublicServicesCategoryVendorsVendorCardAr implements TranslationsPublicServicesCategoryVendorsVendorCardEn {
	_TranslationsPublicServicesCategoryVendorsVendorCardAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get sub_title => 'خدمات متاحة';
	@override String get badge_title => 'موثق';
}

// Path: public_services.vendor_services.service_card
class _TranslationsPublicServicesVendorServicesServiceCardAr implements TranslationsPublicServicesVendorServicesServiceCardEn {
	_TranslationsPublicServicesVendorServicesServiceCardAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get description => 'خدمة احترافية';
	@override String get button => 'عرض التفاصيل';
}

// Path: public_services.services_details.description
class _TranslationsPublicServicesServicesDetailsDescriptionAr implements TranslationsPublicServicesServicesDetailsDescriptionEn {
	_TranslationsPublicServicesServicesDetailsDescriptionAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الوصف';
	@override String get dec => 'خدمة احترافية من';
}

// Path: public_services.services_details.working_hours
class _TranslationsPublicServicesServicesDetailsWorkingHoursAr implements TranslationsPublicServicesServicesDetailsWorkingHoursEn {
	_TranslationsPublicServicesServicesDetailsWorkingHoursAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'ساعات العمل';
	@override String get closed => 'مغلق';
	@override String get open => 'مفتوح';
}

// Path: public_services.services_details.days
class _TranslationsPublicServicesServicesDetailsDaysAr implements TranslationsPublicServicesServicesDetailsDaysEn {
	_TranslationsPublicServicesServicesDetailsDaysAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get Monday => 'الإثنين';
	@override String get Tuesday => 'الثلاثاء';
	@override String get Wednesday => 'الأربعاء';
	@override String get Thursday => 'الخميس';
	@override String get Friday => 'الجمعة';
	@override String get Saturday => 'السبت';
	@override String get Sunday => 'الأحد';
}

// Path: public_services.services_details.button
class _TranslationsPublicServicesServicesDetailsButtonAr implements TranslationsPublicServicesServicesDetailsButtonEn {
	_TranslationsPublicServicesServicesDetailsButtonAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اطلب الآن';
	@override String get null_service => 'جاري تحميل تفاصيل الخدمة...';
	@override String get error_service => 'تتطلب هذه الخدمة عرض سعر. يرجى التواصل مع البائع مباشرة.';
}

// Path: public_marketplace.spare_parts.details_screen
class _TranslationsPublicMarketplaceSparePartsDetailsScreenAr implements TranslationsPublicMarketplaceSparePartsDetailsScreenEn {
	_TranslationsPublicMarketplaceSparePartsDetailsScreenAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get specifications => 'المواصفات';
	@override String get brand => 'الماركة';
	@override String get part_number => 'رقم القطعة';
	@override String get warranty => 'الضمان';
	@override String get warranty_months_suffix => '{months} شهر ضمان';
	@override String get compatibility => 'التوافق';
	@override String get compatibility_empty => 'لا توجد معلومات توافق';
	@override String get no_value => '—';
}

// Path: public_marketplace.spare_parts.category_screen
class _TranslationsPublicMarketplaceSparePartsCategoryScreenAr implements TranslationsPublicMarketplaceSparePartsCategoryScreenEn {
	_TranslationsPublicMarketplaceSparePartsCategoryScreenAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'قطع غيار';
	@override String get filter_button_tooltip => 'تصفية قطع الغيار';
	@override String get chip_make => 'الشركة: {value}';
	@override String get chip_model => 'الطراز: {value}';
	@override String get chip_year_from => 'السنة {value}+';
	@override String get chip_year_to => 'إلى {value}';
	@override String get chip_brand => 'الماركة: {value}';
	@override String get chip_min_price => 'الحد الأدنى: {value}';
	@override String get chip_max_price => 'الحد الأقصى: {value}';
	@override String get chip_clear_all => 'مسح الكل';
}

// Path: public_marketplace.spare_parts.filter_sheet
class _TranslationsPublicMarketplaceSparePartsFilterSheetAr implements TranslationsPublicMarketplaceSparePartsFilterSheetEn {
	_TranslationsPublicMarketplaceSparePartsFilterSheetAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تصفية قطع الغيار';
	@override String get make_label => 'الشركة المصنعة';
	@override String get model_label => 'الطراز';
	@override String get year_from_label => 'السنة من';
	@override String get year_to_label => 'السنة إلى';
	@override String get brand_label => 'الماركة';
	@override String get min_price_label => 'السعر الأدنى (د.ك)';
	@override String get max_price_label => 'السعر الأقصى (د.ك)';
	@override String get apply => 'تطبيق';
	@override String get reset => 'إعادة تعيين';
	@override String get cancel => 'إلغاء';
}

// Path: services.all_services_grid.error
class _TranslationsServicesAllServicesGridErrorAr implements TranslationsServicesAllServicesGridErrorEn {
	_TranslationsServicesAllServicesGridErrorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'فشل تحميل الخدمات';
	@override String get retry => 'إعادة المحاولة';
}

// Path: services.all_services_grid.empty
class _TranslationsServicesAllServicesGridEmptyAr implements TranslationsServicesAllServicesGridEmptyEn {
	_TranslationsServicesAllServicesGridEmptyAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'لم يتم العثور على خدمات لبحثك';
}

// Path: services.all_services_grid.static
class _TranslationsServicesAllServicesGridStaticAr implements TranslationsServicesAllServicesGridStaticEn {
	_TranslationsServicesAllServicesGridStaticAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get buy_a_car => 'شراء سيارة';
	@override String get sell_your_car => 'بيع سيارتك';
	@override String get car_accessories => 'اكسسوارات السيارات';
	@override String get spare_parts => 'قطع غيار';
}

// Path: buy_a_car.details_screen.inspection_report
class _TranslationsBuyACarDetailsScreenInspectionReportAr implements TranslationsBuyACarDetailsScreenInspectionReportEn {
	_TranslationsBuyACarDetailsScreenInspectionReportAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تقرير الفحص';
	@override String get description => 'قم بتنزيل وعرض\n تقرير الفحص لهذه السيارة.';
	@override String get view_report => 'عرض تقرير الفحص';
}

// Path: buy_a_car.details_screen.spec_labels
class _TranslationsBuyACarDetailsScreenSpecLabelsAr implements TranslationsBuyACarDetailsScreenSpecLabelsEn {
	_TranslationsBuyACarDetailsScreenSpecLabelsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get make => 'الشركة المصنعة';
	@override String get model => 'الموديل';
	@override String get trim => 'الفئة';
	@override String get year => 'السنة';
	@override String get mileage => 'المسافة المقطوعة';
	@override String get transmission => 'ناقل الحركة';
	@override String get engine => 'المحرك';
	@override String get color => 'اللون';
}

// Path: buy_a_car.details_screen.condition
class _TranslationsBuyACarDetailsScreenConditionAr implements TranslationsBuyACarDetailsScreenConditionEn {
	_TranslationsBuyACarDetailsScreenConditionAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get excellent => 'ممتازة';
	@override String get good => 'جيدة';
	@override String get fair => 'مقبولة';
	@override String get poor => 'ضعيفة';
	@override String get damaged => 'تالفة';
}

// Path: user_dashboard.wallet.reference_types
class _TranslationsUserDashboardWalletReferenceTypesAr implements TranslationsUserDashboardWalletReferenceTypesEn {
	_TranslationsUserDashboardWalletReferenceTypesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get order => 'دفعة الطلب';
	@override String get refund => 'استرداد';
	@override String get voucher => 'استرداد القسيمة';
	@override String get adjustment => 'تعديل';
	@override String get admin => 'رصيد إداري';
	@override String get payout_hold => 'حجز السحب';
	@override String get payout_release => 'إلغاء حجز السحب';
	@override String get product_order => 'طلب منتج';
}

// Path: user_dashboard.wallet.transaction_details
class _TranslationsUserDashboardWalletTransactionDetailsAr implements TranslationsUserDashboardWalletTransactionDetailsEn {
	_TranslationsUserDashboardWalletTransactionDetailsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get description => 'الوصف';
	@override String get reference_id => 'رقم المرجع';
	@override String get type => 'النوع';
	@override String get date => 'التاريخ';
}

// Path: user_dashboard.wallet.reward_cards
class _TranslationsUserDashboardWalletRewardCardsAr implements TranslationsUserDashboardWalletRewardCardsEn {
	_TranslationsUserDashboardWalletRewardCardsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get buy_a_car => 'شراء سيارة';
	@override String get car_accessories => 'اكسسوارات السيارات';
	@override String get spare_parts => 'قطع الغيار';
}

// Path: user_dashboard.wallet.transaction
class _TranslationsUserDashboardWalletTransactionAr implements TranslationsUserDashboardWalletTransactionEn {
	_TranslationsUserDashboardWalletTransactionAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get compensation => 'تعويض';
	@override String get used => 'مستخدم';
}

// Path: user_dashboard.wallet.months
class _TranslationsUserDashboardWalletMonthsAr implements TranslationsUserDashboardWalletMonthsEn {
	_TranslationsUserDashboardWalletMonthsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get jan => 'يناير';
	@override String get feb => 'فبراير';
	@override String get mar => 'مارس';
	@override String get apr => 'أبريل';
	@override String get may => 'مايو';
	@override String get jun => 'يونيو';
	@override String get jul => 'يوليو';
	@override String get aug => 'أغسطس';
	@override String get sep => 'سبتمبر';
	@override String get oct => 'أكتوبر';
	@override String get nov => 'نوفمبر';
	@override String get dec => 'ديسمبر';
}

// Path: user_dashboard.wallet.detail_labels
class _TranslationsUserDashboardWalletDetailLabelsAr implements TranslationsUserDashboardWalletDetailLabelsEn {
	_TranslationsUserDashboardWalletDetailLabelsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get service_type => 'نوع الخدمة';
	@override String get vendor_name => 'اسم البائع';
	@override String get liters => 'لترات';
	@override String get order_id => 'رقم الطلب';
	@override String get status => 'الحالة';
}

// Path: user_dashboard.orders.empty
class _TranslationsUserDashboardOrdersEmptyAr implements TranslationsUserDashboardOrdersEmptyEn {
	_TranslationsUserDashboardOrdersEmptyAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get no_results => 'لم يتم العثور على نتائج';
	@override String get no_tab_orders => 'لا توجد طلبات {tabName}';
	@override String get adjust_search => 'حاول تعديل مصطلحات البحث.';
	@override String get orders_appear_here => 'ستظهر الطلبات هنا بمجرد توفرها.';
}

// Path: user_dashboard.orders.error
class _TranslationsUserDashboardOrdersErrorAr implements TranslationsUserDashboardOrdersErrorEn {
	_TranslationsUserDashboardOrdersErrorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'خطأ في تحميل الطلبات';
	@override String get retry => 'إعادة المحاولة';
}

// Path: user_dashboard.orders.card
class _TranslationsUserDashboardOrdersCardAr implements TranslationsUserDashboardOrdersCardEn {
	_TranslationsUserDashboardOrdersCardAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get service_order => 'طلب خدمة';
	@override String get product_order => 'طلب منتج';
	@override String get fallback_service => 'خدمة';
	@override String get fallback_vendor => 'بائع';
	@override String get item => 'عنصر';
	@override String get items => 'عناصر';
	@override String get reference => 'المرجع';
	@override String get amount => 'المبلغ';
	@override String get time => 'الوقت';
	@override String get order_id => 'رقم الطلب';
	@override String get date => 'التاريخ';
	@override String get delivery_address => 'عنوان التوصيل';
	@override String get order_summary => 'ملخص الطلب';
	@override String get download_receipt => 'تحميل الإيصال';
	@override String get subtotal => 'المجموع الفرعي';
	@override String get total => 'الإجمالي';
	@override String get payment_method => 'طريقة الدفع';
	@override String get failed_details => 'فشل تحميل التفاصيل: {error}';
	@override String get more_items => '+ {count} إضافي';
	@override String get view_details => 'عرض التفاصيل';
	@override String get add_review => 'إضافة تقييم';
}

// Path: user_dashboard.orders.status
class _TranslationsUserDashboardOrdersStatusAr implements TranslationsUserDashboardOrdersStatusEn {
	_TranslationsUserDashboardOrdersStatusAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get pending => 'معلق';
	@override String get accepted => 'مقبول';
	@override String get on_the_way => 'في الطريق';
	@override String get arrived => 'وصل';
	@override String get in_progress => 'قيد التنفيذ';
	@override String get completed => 'مكتمل';
	@override String get rejected => 'مرفوض';
	@override String get cancelled => 'ملغى';
	@override String get processing => 'قيد المعالجة';
	@override String get confirmed => 'مؤكد';
	@override String get shipped => 'تم الشحن';
	@override String get delivered => 'تم التسليم';
}

// Path: user_dashboard.orders.details
class _TranslationsUserDashboardOrdersDetailsAr implements TranslationsUserDashboardOrdersDetailsEn {
	_TranslationsUserDashboardOrdersDetailsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'تفاصيل الطلب';
	@override String get service_specifications => 'مواصفات الخدمة';
	@override String get your_details => 'تفاصيلك';
	@override String get failed_to_load => 'فشل تحميل الطلب';
	@override String get unknown_service => 'خدمة غير معروفة';
	@override String get unknown_vendor => 'بائع غير معروف';
	@override String get order_information => 'معلومات الطلب';
	@override String get order_reference => 'الرقم المرجعي';
	@override String get service => 'الخدمة';
	@override String get vendor => 'البائع';
	@override String get base_amount => 'المبلغ الأساسي';
	@override String get total_amount => 'المبلغ الإجمالي';
	@override String get scheduled_date_time => 'التاريخ والوقت المجدول';
	@override String get date => 'التاريخ';
	@override String get time => 'الوقت';
	@override String get service_location => 'موقع الخدمة';
	@override String get open_in_maps => 'فتح في الخرائط';
	@override String get timeline => 'الجدول الزمني';
	@override String get order_placed => 'تم تقديم الطلب';
	@override String get vendor_accepted => 'قبول البائع';
	@override String get service_completed => 'اكتمال الخدمة';
	@override String get order_cancelled => 'تم إلغاء الطلب';
	@override String get documents => 'المستندات';
	@override String get document => 'مستند';
	@override String get rejection_reason => 'سبب الرفض';
	@override String get cancellation_reason => 'سبب الإلغاء';
	@override String get call_vendor => 'اتصل بالبائع';
	@override String get write_review => 'كتابة تقييم';
	@override String get book_again => 'حجز مرة أخرى';
	@override String get phone_not_available => 'رقم هاتف البائع غير متوفر';
	@override String get could_not_launch_dialer => 'تعذر فتح برنامج الاتصال';
	@override String get review_coming_soon => 'ميزة التقييم قريباً';
	@override String get screen_title_product => 'تفاصيل الطلب';
	@override String get order_date => 'تاريخ الطلب';
	@override String get order_items => 'عناصر الطلب';
	@override String get quantity_label => 'الكمية: {qty}';
	@override String get payment_summary => 'ملخص الدفع';
	@override String get order_updated => 'تم تحديث الطلب';
}

// Path: user_dashboard.active_orders_preview.time_ago
class _TranslationsUserDashboardActiveOrdersPreviewTimeAgoAr implements TranslationsUserDashboardActiveOrdersPreviewTimeAgoEn {
	_TranslationsUserDashboardActiveOrdersPreviewTimeAgoAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get just_now => 'الآن';
	@override String get minutes_ago => '{n}د مضت';
	@override String get hours_ago => '{n}س مضت';
	@override String get days_ago => '{n}ي مضت';
}

// Path: user_dashboard.listings.error
class _TranslationsUserDashboardListingsErrorAr implements TranslationsUserDashboardListingsErrorEn {
	_TranslationsUserDashboardListingsErrorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get failed_to_load => 'فشل تحميل الإعلانات';
	@override String get retry => 'إعادة المحاولة';
}

// Path: user_dashboard.listings.empty
class _TranslationsUserDashboardListingsEmptyAr implements TranslationsUserDashboardListingsEmptyEn {
	_TranslationsUserDashboardListingsEmptyAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get no_results => 'لم يتم العثور على نتائج';
	@override String get no_listings_yet => 'لا توجد إعلانات بعد';
	@override String get no_match => 'لا توجد إعلانات مطابقة.';
	@override String get appear_here => 'ستظهر إعلانات سياراتك هنا';
}

// Path: user_dashboard.listings.card
class _TranslationsUserDashboardListingsCardAr implements TranslationsUserDashboardListingsCardEn {
	_TranslationsUserDashboardListingsCardAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get featured => 'مميز';
	@override String get inspected => 'تم الفحص';
	@override String get not_inspected => 'لم يتم الفحص';
}

// Path: user_dashboard.listing_details.time_ago
class _TranslationsUserDashboardListingDetailsTimeAgoAr implements TranslationsUserDashboardListingDetailsTimeAgoEn {
	_TranslationsUserDashboardListingDetailsTimeAgoAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get just_now => 'الآن';
	@override String get minutes_ago => '{n} دقيقة/دقائق مضت';
	@override String get hours_ago => '{n} ساعة/ساعات مضت';
	@override String get days_ago => '{n} يوم/أيام مضت';
	@override String get months_ago => '{n} شهر/أشهر مضت';
}

// Path: user_dashboard.listing_details.inspection
class _TranslationsUserDashboardListingDetailsInspectionAr implements TranslationsUserDashboardListingDetailsInspectionEn {
	_TranslationsUserDashboardListingDetailsInspectionAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تقرير الفحص';
	@override String get has_report_desc => 'قم بتنزيل وعرض\n تقرير الفحص لهذه السيارة.';
	@override String get no_report_desc => 'لا يوجد تقرير فحص\n متاح لهذه السيارة.';
	@override String get view_report => 'عرض تقرير الفحص';
}

// Path: user_dashboard.listing_details.specifications
class _TranslationsUserDashboardListingDetailsSpecificationsAr implements TranslationsUserDashboardListingDetailsSpecificationsEn {
	_TranslationsUserDashboardListingDetailsSpecificationsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'المواصفات';
	@override String get edit => 'تعديل';
	@override late final _TranslationsUserDashboardListingDetailsSpecificationsLabelsAr labels = _TranslationsUserDashboardListingDetailsSpecificationsLabelsAr._(_root);
	@override String get na => 'غير متاح';
}

// Path: user_dashboard.listing_details.description
class _TranslationsUserDashboardListingDetailsDescriptionAr implements TranslationsUserDashboardListingDetailsDescriptionEn {
	_TranslationsUserDashboardListingDetailsDescriptionAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الوصف';
	@override String get no_description => 'لا يوجد وصف متاح.';
	@override String get edit_dialog_title => 'تعديل الوصف';
	@override String get edit_dialog_hint => 'أدخل وصفًا جديدًا...';
	@override String get cancel => 'إلغاء';
	@override String get save => 'حفظ';
}

// Path: user_dashboard.edit_specs.steps
class _TranslationsUserDashboardEditSpecsStepsAr implements TranslationsUserDashboardEditSpecsStepsEn {
	_TranslationsUserDashboardEditSpecsStepsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get make => 'الشركة المصنعة';
	@override String get model => 'الموديل';
	@override String get trim => 'الفئة';
	@override String get year => 'السنة';
	@override String get mileage => 'المسافة المقطوعة';
	@override String get transmission => 'ناقل الحركة';
	@override String get color => 'اللون';
}

// Path: user_dashboard.edit_specs.validation
class _TranslationsUserDashboardEditSpecsValidationAr implements TranslationsUserDashboardEditSpecsValidationEn {
	_TranslationsUserDashboardEditSpecsValidationAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get complete_all_fields => 'يرجى إكمال جميع الحقول';
}

// Path: user_dashboard.notifications.empty
class _TranslationsUserDashboardNotificationsEmptyAr implements TranslationsUserDashboardNotificationsEmptyEn {
	_TranslationsUserDashboardNotificationsEmptyAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'ليس هناك جديد!';
	@override String get subtitle => 'لا توجد إشعارات جديدة للعرض.';
}

// Path: user_dashboard.settings.menu
class _TranslationsUserDashboardSettingsMenuAr implements TranslationsUserDashboardSettingsMenuEn {
	_TranslationsUserDashboardSettingsMenuAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get account_info => 'معلومات الحساب';
	@override String get saved_addresses => 'العناوين المحفوظة';
	@override String get change_email => 'تغيير البريد الإلكتروني';
	@override String get change_password => 'تغيير كلمة المرور';
	@override String get country => 'الدولة';
	@override String get notifications => 'الإشعارات';
	@override String get language => 'اللغة';
	@override String get app_mode => 'وضع التطبيق';
	@override String get logout => 'تسجيل الخروج';
	@override String get delete_account => 'حذف الحساب';
}

// Path: user_dashboard.settings.delete_account_confirm
class _TranslationsUserDashboardSettingsDeleteAccountConfirmAr implements TranslationsUserDashboardSettingsDeleteAccountConfirmEn {
	_TranslationsUserDashboardSettingsDeleteAccountConfirmAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'حذف الحساب؟';
	@override String get message => 'هل أنت متأكد من أنك تريد حذف حسابك؟ هذا الإجراء دائم ولا يمكن التراجع عنه.';
	@override String get confirm => 'حذف';
	@override String get cancel => 'إلغاء';
	@override String get error => 'فشل حذف الحساب. يرجى المحاولة مرة أخرى.';
}

// Path: user_dashboard.settings.account_info
class _TranslationsUserDashboardSettingsAccountInfoAr implements TranslationsUserDashboardSettingsAccountInfoEn {
	_TranslationsUserDashboardSettingsAccountInfoAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'معلومات الحساب';
	@override String get edit => 'تعديل';
	@override late final _TranslationsUserDashboardSettingsAccountInfoFieldsAr fields = _TranslationsUserDashboardSettingsAccountInfoFieldsAr._(_root);
	@override late final _TranslationsUserDashboardSettingsAccountInfoGenderAr gender = _TranslationsUserDashboardSettingsAccountInfoGenderAr._(_root);
	@override late final _TranslationsUserDashboardSettingsAccountInfoPreferencesAr preferences = _TranslationsUserDashboardSettingsAccountInfoPreferencesAr._(_root);
	@override String get delete_account => 'حذف الحساب';
}

// Path: user_dashboard.settings.change_email
class _TranslationsUserDashboardSettingsChangeEmailAr implements TranslationsUserDashboardSettingsChangeEmailEn {
	_TranslationsUserDashboardSettingsChangeEmailAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'تغيير البريد الإلكتروني';
	@override String get field_hint => 'عنوان البريد الإلكتروني الجديد';
	@override String get validation_error => 'يرجى إدخال عنوان بريد إلكتروني صالح';
	@override String get confirm_button_loading => 'جاري التأكيد...';
	@override String get confirm_button => 'تأكيد';
	@override String get success => 'تم تحديث البريد الإلكتروني بنجاح';
	@override String get error => 'فشل تحديث البريد الإلكتروني. يرجى المحاولة مرة أخرى.';
}

// Path: user_dashboard.settings.change_password
class _TranslationsUserDashboardSettingsChangePasswordAr implements TranslationsUserDashboardSettingsChangePasswordEn {
	_TranslationsUserDashboardSettingsChangePasswordAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'تغيير كلمة المرور';
	@override late final _TranslationsUserDashboardSettingsChangePasswordFieldsAr fields = _TranslationsUserDashboardSettingsChangePasswordFieldsAr._(_root);
	@override late final _TranslationsUserDashboardSettingsChangePasswordValidationAr validation = _TranslationsUserDashboardSettingsChangePasswordValidationAr._(_root);
	@override String get button_loading => 'جاري التغيير...';
	@override String get button => 'تغيير كلمة المرور';
	@override String get success => 'تم تغيير كلمة المرور بنجاح.';
	@override String get error => 'فشل تغيير كلمة المرور. يرجى المحاولة مرة أخرى.';
}

// Path: user_dashboard.settings.language
class _TranslationsUserDashboardSettingsLanguageAr implements TranslationsUserDashboardSettingsLanguageEn {
	_TranslationsUserDashboardSettingsLanguageAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اللغة';
	@override String get english => 'الإنجليزية';
	@override String get arabic => 'العربية';
}

// Path: user_dashboard.settings.app_mode
class _TranslationsUserDashboardSettingsAppModeAr implements TranslationsUserDashboardSettingsAppModeEn {
	_TranslationsUserDashboardSettingsAppModeAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'وضع التطبيق';
	@override String get dark => 'داكن';
	@override String get light => 'فاتح';
}

// Path: user_dashboard.settings.country
class _TranslationsUserDashboardSettingsCountryAr implements TranslationsUserDashboardSettingsCountryEn {
	_TranslationsUserDashboardSettingsCountryAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الدولة';
	@override String get kuwait => 'الكويت';
	@override String get bahrain => 'البحرين';
	@override String get uae => 'الإمارات العربية المتحدة';
	@override String get oman => 'عمان';
	@override String get qatar => 'قطر';
	@override String get saudi_arabia => 'المملكة العربية السعودية';
}

// Path: user_dashboard.settings.saved_addresses
class _TranslationsUserDashboardSettingsSavedAddressesAr implements TranslationsUserDashboardSettingsSavedAddressesEn {
	_TranslationsUserDashboardSettingsSavedAddressesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'العناوين';
	@override String get add_button => 'إضافة';
	@override String get empty_title => 'لا توجد عناوين محفوظة';
	@override String get add_new_button => 'إضافة عنوان جديد';
}

// Path: user_dashboard.settings.notification_preferences
class _TranslationsUserDashboardSettingsNotificationPreferencesAr implements TranslationsUserDashboardSettingsNotificationPreferencesEn {
	_TranslationsUserDashboardSettingsNotificationPreferencesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get screen_title => 'تفضيلات الإشعارات';
	@override String get order_updates => 'تحديثات الطلبات';
	@override String get promotions => 'العروض الترويجية';
}

// Path: user_dashboard.settings.verify_email_otp
class _TranslationsUserDashboardSettingsVerifyEmailOtpAr implements TranslationsUserDashboardSettingsVerifyEmailOtpEn {
	_TranslationsUserDashboardSettingsVerifyEmailOtpAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'التحقق من البريد الإلكتروني';
	@override String get sent_code => 'لقد أرسلنا رمزًا إلى ';
	@override String get otp_error => 'يرجى إدخال رمز التحقق الكامل';
	@override String get verify_button_loading => 'جاري التحقق...';
	@override String get verify_button => 'تحقق';
	@override String get success => 'تم تحديث البريد الإلكتروني بنجاح';
	@override String get error => 'فشل تحديث البريد الإلكتروني. يرجى المحاولة مرة أخرى.';
	@override String get otp_sent => 'تم إرسال الرمز بنجاح';
	@override late final _TranslationsUserDashboardSettingsVerifyEmailOtpResendAr resend = _TranslationsUserDashboardSettingsVerifyEmailOtpResendAr._(_root);
}

// Path: user_dashboard.settings.edit_address
class _TranslationsUserDashboardSettingsEditAddressAr implements TranslationsUserDashboardSettingsEditAddressEn {
	_TranslationsUserDashboardSettingsEditAddressAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get edit_title => 'تعديل العنوان';
	@override String get add_title => 'إضافة عنوان';
	@override String get delete => 'حذف';
	@override late final _TranslationsUserDashboardSettingsEditAddressDeleteDialogAr delete_dialog = _TranslationsUserDashboardSettingsEditAddressDeleteDialogAr._(_root);
	@override late final _TranslationsUserDashboardSettingsEditAddressValidationAr validation = _TranslationsUserDashboardSettingsEditAddressValidationAr._(_root);
	@override late final _TranslationsUserDashboardSettingsEditAddressAreaAr area = _TranslationsUserDashboardSettingsEditAddressAreaAr._(_root);
	@override late final _TranslationsUserDashboardSettingsEditAddressPropertyTypesAr property_types = _TranslationsUserDashboardSettingsEditAddressPropertyTypesAr._(_root);
	@override late final _TranslationsUserDashboardSettingsEditAddressFieldsAr fields = _TranslationsUserDashboardSettingsEditAddressFieldsAr._(_root);
	@override String get save_button => 'حفظ العنوان';
	@override String get default_label => 'عنوان';
}

// Path: user_dashboard.settings.address_tile
class _TranslationsUserDashboardSettingsAddressTileAr implements TranslationsUserDashboardSettingsAddressTileEn {
	_TranslationsUserDashboardSettingsAddressTileAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get block => 'قطعة {n}';
	@override String get building => 'مبنى {n}';
	@override String get apt => 'شقة {n}';
	@override String get mobile_number => 'رقم الجوال: {n}';
}

// Path: sell_your_car.screens.condition_car
class _TranslationsSellYourCarScreensConditionCarAr implements TranslationsSellYourCarScreensConditionCarEn {
	_TranslationsSellYourCarScreensConditionCarAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'بيع سياراتك';
	@override String get subtitle => 'لدينا عروض بانتظارك';
}

// Path: sell_your_car.screens.sell_a_car
class _TranslationsSellYourCarScreensSellACarAr implements TranslationsSellYourCarScreensSellACarEn {
	_TranslationsSellYourCarScreensSellACarAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'بيع سيارة';
	@override String get subtitle => 'لدينا عروض بانتظارك';
}

// Path: sell_your_car.screens.sell_or_buy_car
class _TranslationsSellYourCarScreensSellOrBuyCarAr implements TranslationsSellYourCarScreensSellOrBuyCarEn {
	_TranslationsSellYourCarScreensSellOrBuyCarAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'بيع أو شراء سياراتك';
	@override String get subtitle => 'بيع وشراء سيارتك بسرعة وسهولة';
}

// Path: sell_your_car.screens.fast_track_condition
class _TranslationsSellYourCarScreensFastTrackConditionAr implements TranslationsSellYourCarScreensFastTrackConditionEn {
	_TranslationsSellYourCarScreensFastTrackConditionAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'بيع سريع للسيارة';
	@override String get subtitle => 'لدينا عروض بانتظارك';
}

// Path: sell_your_car.screens.fast_track_sale
class _TranslationsSellYourCarScreensFastTrackSaleAr implements TranslationsSellYourCarScreensFastTrackSaleEn {
	_TranslationsSellYourCarScreensFastTrackSaleAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'بيع سريع للسيارة';
	@override String get subtitle => 'لدينا عروض بانتظارك';
	@override String get description_title => 'الوصف';
	@override String get description => 'تم تصميم البيع السريع للسيارة لأولئك الذين يحتاجون لبيع سيارتهم بسرعة وكفاءة. من خلال الإدراج بسعر مخفض، يمكن بيع سيارتك في غضون 15 ساعة. بمجرد موافقتك على العرض، سيتولى فريقنا العملية، مما يضمن معاملة سلسة وسهلة. سيتواصل معك أحد الممثلين لإنهاء البيع بعد موافقتك.';
	@override String get terms_title => 'الشروط والأحكام';
	@override String get terms_intro => 'باستخدام خدمات إدراج السيارات لدينا، فإنك توافق على الشروط والأحكام التالية:';
	@override String get bullet_1 => 'يجب أن تكون السيارات المدرجة ضمن البيع السريع مخفضة بنسبة 30% عن أقل قيمة سوقية.';
	@override String get bullet_2 => 'رسوم الإدراج غير قابلة للاسترداد.';
	@override String get bullet_3 => 'تخضع المعاملات لرسوم 5% على كل من البائع والمشتري.';
	@override String get bullet_4 => 'يجب على البائع الموافقة على العرض والشروط قبل المتابعة.';
	@override String get bullet_5 => 'تصبح القوائم والعروض سارية فقط بعد موافقة موتيفا.';
	@override String get approve_checkbox => 'نعم، أوافق على شروط وأحكام موتيفا الخاصة بالبيع السريع للسيارة.';
	@override String get kContinue => 'متابعة';
}

// Path: sell_your_car.screens.open_an_auction
class _TranslationsSellYourCarScreensOpenAnAuctionAr implements TranslationsSellYourCarScreensOpenAnAuctionEn {
	_TranslationsSellYourCarScreensOpenAnAuctionAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'افتح مزاد';
	@override String get subtitle => 'بيع سريع من خلال المزاد';
	@override String get description_title => 'الوصف';
	@override String get description => 'أدرج سيارتك للبيع بسهولة باستخدام منصتنا. اختر من بين خيارات العادي، أو المزاد، أو البيع السريع للعثور على مشترين بسرعة وأمان. اختر الإضافات مثل تقرير الفحص لتعزيز مصداقية إدراجك. يضمن البيع السريع بيعًا مضمونًا في غضون 15 ساعة بسعر أقل بنسبة 30% من أقل سعر سوقي.';
	@override String get terms_title => 'الشروط والأحكام';
	@override String get terms_intro => 'باستخدام خدمات إدراج السيارات لدينا، فإنك توافق على الشروط والأحكام التالية:';
	@override String get bullet_1 => 'يجب أن تكون جميع تفاصيل السيارة دقيقة ومحدثة.';
	@override String get bullet_2 => 'رسوم الإدراج غير قابلة للاسترداد وتختلف حسب نوع الخدمة.';
	@override String get bullet_3 => 'تتطلب المبيعات السريعة خصمًا بنسبة 30% على أقل سعر سوقي.';
	@override String get bullet_4 => 'تنطبق رسوم معاملة 5% على كل من البائع والمشتري في حالات البيع الناجحة.';
	@override String get bullet_5 => 'يجب أن تكون تقارير الفحص صالحة ودقيقة.';
	@override String get approve_checkbox => 'نعم، أوافق على شروط وأحكام موتيفا الخاصة بفتح المزاد.';
	@override String get kContinue => 'متابعة';
}

// Path: sell_your_car.screens.car_details
class _TranslationsSellYourCarScreensCarDetailsAr implements TranslationsSellYourCarScreensCarDetailsEn {
	_TranslationsSellYourCarScreensCarDetailsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تفاصيل السيارة';
	@override String get submitting_listing => 'جاري إرسال إدراجك...';
	@override String get submitting_request => 'جاري إرسال طلبك...';
}

// Path: sell_your_car.screens.success_dialog
class _TranslationsSellYourCarScreensSuccessDialogAr implements TranslationsSellYourCarScreensSuccessDialogEn {
	_TranslationsSellYourCarScreensSuccessDialogAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'نجاح!';
	@override String get damaged_car_message => 'تم إرسال إدراج سيارتك التالفة بنجاح.';
	@override String get listing_created => 'تم إنشاء الإدراج بنجاح!';
	@override String get listing_saved => 'تم حفظ إدراج سيارتك.';
	@override String get ok => 'موافق';
	@override String get done => 'تم';
}

// Path: sell_your_car.screens.request_received_dialog
class _TranslationsSellYourCarScreensRequestReceivedDialogAr implements TranslationsSellYourCarScreensRequestReceivedDialogEn {
	_TranslationsSellYourCarScreensRequestReceivedDialogAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تم استلام الطلب!';
	@override String get message => 'تم إرسال الطلب إلى مسؤولي موتيفا — سنتواصل معك بعرض';
}

// Path: sell_your_car.screens.error_dialog
class _TranslationsSellYourCarScreensErrorDialogAr implements TranslationsSellYourCarScreensErrorDialogEn {
	_TranslationsSellYourCarScreensErrorDialogAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'خطأ';
}

// Path: vendor_dashboard.wallet.tabs
class _TranslationsVendorDashboardWalletTabsAr implements TranslationsVendorDashboardWalletTabsEn {
	_TranslationsVendorDashboardWalletTabsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get daily => 'يومي';
	@override String get weekly => 'أسبوعي';
	@override String get monthly => 'شهري';
}

// Path: vendor_dashboard.wallet.stats
class _TranslationsVendorDashboardWalletStatsAr implements TranslationsVendorDashboardWalletStatsEn {
	_TranslationsVendorDashboardWalletStatsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get total_sales => 'إجمالي المبيعات';
	@override String get total_earnings => 'إجمالي الأرباح';
	@override String get average_rating => 'متوسط التقييم';
	@override String get cancellation_rate => 'معدل الإلغاء';
}

// Path: vendor_dashboard.wallet.history_status
class _TranslationsVendorDashboardWalletHistoryStatusAr implements TranslationsVendorDashboardWalletHistoryStatusEn {
	_TranslationsVendorDashboardWalletHistoryStatusAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get in_progress => 'قيد التنفيذ';
	@override String get rejected => 'مرفوض';
}

// Path: vendor_dashboard.wallet.payout_request
class _TranslationsVendorDashboardWalletPayoutRequestAr implements TranslationsVendorDashboardWalletPayoutRequestEn {
	_TranslationsVendorDashboardWalletPayoutRequestAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'سحب الأموال';
	@override String get amount_label => 'المبلغ (د.ك)';
	@override String get amount_hint => 'أدخل المبلغ المراد سحبه';
	@override String get bank_details => 'تفاصيل البنك';
	@override String get bank_name => 'اسم البنك';
	@override String get account_number => 'رقم الحساب';
	@override String get account_holder => 'صاحب الحساب';
	@override String get kuwait_code => 'رمز الكويت';
	@override String get update_bank_details => 'تحديث تفاصيل البنك';
	@override String get submit => 'إرسال طلب السحب';
	@override String get insufficient_balance => 'رصيد المحفظة غير كافٍ';
	@override String get invalid_amount => 'يرجى إدخال مبلغ صحيح';
	@override String get success => 'تم إرسال طلب السحب بنجاح';
	@override String get error => 'فشل إرسال طلب السحب';
	@override String get no_bank_details => 'لم يتم العثور على تفاصيل البنك. يرجى إضافة تفاصيل البنك أولاً.';
}

// Path: vendor_dashboard.wallet.payout_status
class _TranslationsVendorDashboardWalletPayoutStatusAr implements TranslationsVendorDashboardWalletPayoutStatusEn {
	_TranslationsVendorDashboardWalletPayoutStatusAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get pending => 'قيد الانتظار';
	@override String get processed => 'تمت المعالجة';
	@override String get rejected => 'مرفوض';
}

// Path: vendor_dashboard.wallet.months
class _TranslationsVendorDashboardWalletMonthsAr implements TranslationsVendorDashboardWalletMonthsEn {
	_TranslationsVendorDashboardWalletMonthsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get jan => 'يناير';
	@override String get feb => 'فبراير';
	@override String get mar => 'مارس';
	@override String get apr => 'أبريل';
	@override String get may => 'مايو';
	@override String get jun => 'يونيو';
	@override String get jul => 'يوليو';
	@override String get aug => 'أغسطس';
	@override String get sep => 'سبتمبر';
	@override String get oct => 'أكتوبر';
	@override String get nov => 'نوفمبر';
	@override String get dec => 'ديسمبر';
}

// Path: vendor_dashboard.wallet.reference_types
class _TranslationsVendorDashboardWalletReferenceTypesAr implements TranslationsVendorDashboardWalletReferenceTypesEn {
	_TranslationsVendorDashboardWalletReferenceTypesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get order => 'دفعة الطلب';
	@override String get refund => 'استرداد';
	@override String get voucher => 'استرداد القسيمة';
	@override String get adjustment => 'تعديل';
	@override String get admin => 'رصيد إداري';
	@override String get payout_hold => 'حجز السحب';
	@override String get payout_release => 'إلغاء حجز السحب';
	@override String get product_order => 'طلب منتج';
}

// Path: vendor_dashboard.settings.menu
class _TranslationsVendorDashboardSettingsMenuAr implements TranslationsVendorDashboardSettingsMenuEn {
	_TranslationsVendorDashboardSettingsMenuAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get uploaded_documents => 'الوثائق المرفوعة';
	@override String get service_area => 'منطقة الخدمة';
	@override String get business_logo => 'شعار النشاط';
	@override String get cover_image => 'صورة الغلاف';
	@override String get working_hours => 'ساعات العمل';
	@override String get notifications => 'الإشعارات';
	@override String get language => 'اللغة';
	@override String get app_mode => 'وضع التطبيق';
	@override String get logout => 'تسجيل الخروج';
	@override String get delete_account => 'حذف الحساب';
}

// Path: vendor_dashboard.settings.delete_account_confirm
class _TranslationsVendorDashboardSettingsDeleteAccountConfirmAr implements TranslationsVendorDashboardSettingsDeleteAccountConfirmEn {
	_TranslationsVendorDashboardSettingsDeleteAccountConfirmAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'حذف الحساب؟';
	@override String get message => 'هل أنت متأكد من أنك تريد حذف حسابك؟ هذا الإجراء دائم ولا يمكن التراجع عنه.';
	@override String get confirm => 'حذف';
	@override String get cancel => 'إلغاء';
	@override String get error => 'فشل حذف الحساب. يرجى المحاولة مرة أخرى.';
}

// Path: vendor_services.empty.search
class _TranslationsVendorServicesEmptySearchAr implements TranslationsVendorServicesEmptySearchEn {
	_TranslationsVendorServicesEmptySearchAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'لم يتم العثور على نتائج';
	@override String get subtitle => 'حاول تعديل مصطلحات البحث.';
}

// Path: vendor_services.empty.archived
class _TranslationsVendorServicesEmptyArchivedAr implements TranslationsVendorServicesEmptyArchivedEn {
	_TranslationsVendorServicesEmptyArchivedAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'لا توجد خدمات مؤرشفة';
	@override String get subtitle => 'ستظهر الخدمات المؤرشفة هنا.';
}

// Path: vendor_services.empty.no_services
class _TranslationsVendorServicesEmptyNoServicesAr implements TranslationsVendorServicesEmptyNoServicesEn {
	_TranslationsVendorServicesEmptyNoServicesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'لا توجد خدمات بعد';
	@override String get subtitle => 'أنشئ خدمتك الأولى لبدء استلام الطلبات.';
	@override String get action => 'إنشاء خدمة';
}

// Path: vendor_services.create_screen.app_bar
class _TranslationsVendorServicesCreateScreenAppBarAr implements TranslationsVendorServicesCreateScreenAppBarEn {
	_TranslationsVendorServicesCreateScreenAppBarAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get new_title => 'خدمة جديدة';
	@override String get edit => 'تعديل الخدمة';
}

// Path: vendor_services.create_screen.form
class _TranslationsVendorServicesCreateScreenFormAr implements TranslationsVendorServicesCreateScreenFormEn {
	_TranslationsVendorServicesCreateScreenFormAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsVendorServicesCreateScreenFormServiceNameAr service_name = _TranslationsVendorServicesCreateScreenFormServiceNameAr._(_root);
	@override late final _TranslationsVendorServicesCreateScreenFormDescriptionAr description = _TranslationsVendorServicesCreateScreenFormDescriptionAr._(_root);
	@override late final _TranslationsVendorServicesCreateScreenFormBasePriceAr base_price = _TranslationsVendorServicesCreateScreenFormBasePriceAr._(_root);
	@override late final _TranslationsVendorServicesCreateScreenFormRadiusAr radius = _TranslationsVendorServicesCreateScreenFormRadiusAr._(_root);
}

// Path: vendor_services.create_screen.image_upload
class _TranslationsVendorServicesCreateScreenImageUploadAr implements TranslationsVendorServicesCreateScreenImageUploadEn {
	_TranslationsVendorServicesCreateScreenImageUploadAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'صورة الخدمة';
	@override String get subtitle => 'ارفع صورة لعرض خدمتك';
	@override String get uploading => 'جاري الرفع...';
	@override String get change => 'تغيير الصورة';
	@override String get placeholder_title => 'اضغط لرفع صورة الخدمة';
	@override String get placeholder_subtitle => 'مُوصى به: 800x600 بكسل';
}

// Path: vendor_services.create_screen.attributes
class _TranslationsVendorServicesCreateScreenAttributesAr implements TranslationsVendorServicesCreateScreenAttributesEn {
	_TranslationsVendorServicesCreateScreenAttributesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'خصائص الخدمة';
	@override String get required_badge => 'مطلوب';
	@override String get subtitle => 'املأ التفاصيل الخاصة بنوع هذه الخدمة';
	@override String get hint => 'أدخل {field}';
}

// Path: vendor_services.create_screen.customer_questions
class _TranslationsVendorServicesCreateScreenCustomerQuestionsAr implements TranslationsVendorServicesCreateScreenCustomerQuestionsEn {
	_TranslationsVendorServicesCreateScreenCustomerQuestionsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'أسئلة العملاء';
	@override String get subtitle => 'حدد الأسئلة التي يجب على العملاء الإجابة عليها عند حجز هذه الخدمة.';
	@override String get add_button => 'إضافة سؤال للعميل';
	@override String get required_suffix => ' *';
}

// Path: vendor_services.create_screen.button
class _TranslationsVendorServicesCreateScreenButtonAr implements TranslationsVendorServicesCreateScreenButtonEn {
	_TranslationsVendorServicesCreateScreenButtonAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get save => 'حفظ التغييرات';
	@override String get create => 'إنشاء خدمة';
	@override String get restore => 'استعادة الخدمة';
}

// Path: vendor_services.create_screen.snackbar
class _TranslationsVendorServicesCreateScreenSnackbarAr implements TranslationsVendorServicesCreateScreenSnackbarEn {
	_TranslationsVendorServicesCreateScreenSnackbarAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get create_success => 'تم إنشاء الخدمة بنجاح';
	@override String get update_success => 'تم تحديث الخدمة بنجاح';
	@override String get create_failed => 'فشل إنشاء الخدمة. يرجى التحقق من المدخلات والمحاولة مرة أخرى.';
	@override String get update_failed => 'فشل تحديث الخدمة. يرجى التحقق من المدخلات والمحاولة مرة أخرى.';
	@override String get archive_success => 'تم أرشفة الخدمة بنجاح';
	@override String get archive_failed => 'فشل أرشفة الخدمة';
	@override String get restore_success => 'تم استعادة الخدمة بنجاح';
	@override String get restore_failed => 'فشل استعادة الخدمة';
	@override String get question_added => 'تم إضافة سؤال العميل';
}

// Path: vendor_services.create_screen.dialog
class _TranslationsVendorServicesCreateScreenDialogAr implements TranslationsVendorServicesCreateScreenDialogEn {
	_TranslationsVendorServicesCreateScreenDialogAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get archive_title => 'أرشفة الخدمة';
	@override String get archive_message => 'هل أنت متأكد من أرشفة "{name}"؟ سيتم إخفاؤها عن العملاء.';
	@override String get archive_confirm => 'أرشفة';
	@override String get add_question_title => 'إضافة سؤال للعميل';
	@override String get label => 'التسمية';
	@override String get label_hint => 'مثال: صورة المركبة';
	@override String get type => 'النوع';
	@override String get required => 'مطلوب';
	@override String get options_label => 'الخيارات (مفصولة بفاصلة)';
	@override String get options_hint => 'مثال: شامل، ضد الغير، سرقة_حرق';
	@override String get min => 'الحد الأدنى';
	@override String get max => 'الحد الأقصى';
	@override String get cancel => 'إلغاء';
	@override String get add => 'إضافة';
}

// Path: vendor_services.create_screen.error
class _TranslationsVendorServicesCreateScreenErrorAr implements TranslationsVendorServicesCreateScreenErrorEn {
	_TranslationsVendorServicesCreateScreenErrorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get no_category => 'لا توجد فئة خدمة متاحة. يرجى التواصل مع الدعم.';
	@override String get load_category => 'فشل تحميل مخطط الفئة';
}

// Path: vendor_services.select_category.empty
class _TranslationsVendorServicesSelectCategoryEmptyAr implements TranslationsVendorServicesSelectCategoryEmptyEn {
	_TranslationsVendorServicesSelectCategoryEmptyAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'لا توجد فئات متاحة';
	@override String get subtitle => 'لم يتم تكوين فئات الخدمات بعد. يرجى التواصل مع الدعم.';
}

// Path: vendor_services.select_category.search_empty
class _TranslationsVendorServicesSelectCategorySearchEmptyAr implements TranslationsVendorServicesSelectCategorySearchEmptyEn {
	_TranslationsVendorServicesSelectCategorySearchEmptyAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'لم يتم العثور على فئات';
	@override String get subtitle => 'جرب مصطلح بحث مختلف.';
}

// Path: vendor_services.select_category.error
class _TranslationsVendorServicesSelectCategoryErrorAr implements TranslationsVendorServicesSelectCategoryErrorEn {
	_TranslationsVendorServicesSelectCategoryErrorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'فشل تحميل الفئات';
	@override String get subtitle => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';
	@override String get retry => 'إعادة المحاولة';
}

// Path: vendor_services.service_card.tooltip
class _TranslationsVendorServicesServiceCardTooltipAr implements TranslationsVendorServicesServiceCardTooltipEn {
	_TranslationsVendorServicesServiceCardTooltipAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get edit => 'تعديل';
	@override String get archive => 'أرشفة';
}

// Path: vendor_services.service_card.action
class _TranslationsVendorServicesServiceCardActionAr implements TranslationsVendorServicesServiceCardActionEn {
	_TranslationsVendorServicesServiceCardActionAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get restore => 'استعادة';
}

// Path: vendor_services.category_section.dialog
class _TranslationsVendorServicesCategorySectionDialogAr implements TranslationsVendorServicesCategorySectionDialogEn {
	_TranslationsVendorServicesCategorySectionDialogAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get archive_title => 'أرشفة الخدمة';
	@override String get archive_message => 'هل أنت متأكد من أرشفة "{name}"؟ سيتم إخفاؤها عن العملاء.';
	@override String get archive_confirm => 'أرشفة';
	@override String get restore_title => 'استعادة الخدمة';
	@override String get restore_message => 'استعادة "{name}"؟ سيكون مرئياً للعملاء مرة أخرى.';
	@override String get restore_confirm => 'استعادة';
}

// Path: vendor_services.category_section.snackbar
class _TranslationsVendorServicesCategorySectionSnackbarAr implements TranslationsVendorServicesCategorySectionSnackbarEn {
	_TranslationsVendorServicesCategorySectionSnackbarAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get archive_success => 'تم أرشفة الخدمة بنجاح';
	@override String get archive_failed => 'فشل أرشفة الخدمة';
	@override String get restore_success => 'تم استعادة الخدمة بنجاح';
	@override String get restore_failed => 'فشل استعادة الخدمة';
}

// Path: home.customer.active_orders.empty
class _TranslationsHomeCustomerActiveOrdersEmptyAr implements TranslationsHomeCustomerActiveOrdersEmptyEn {
	_TranslationsHomeCustomerActiveOrdersEmptyAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'لا توجد طلبات نشطة';
	@override String get description => 'ستظهر طلباتك النشطة هنا';
}

// Path: home.customer.active_orders.order
class _TranslationsHomeCustomerActiveOrdersOrderAr implements TranslationsHomeCustomerActiveOrdersOrderEn {
	_TranslationsHomeCustomerActiveOrdersOrderAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الطلبات النشطة';
	@override String get more_orders => 'طلبات إضافية';
	@override String get view_all => 'عرض جميع الطلبات';
	@override late final _TranslationsHomeCustomerActiveOrdersOrderOrderCardAr order_card = _TranslationsHomeCustomerActiveOrdersOrderOrderCardAr._(_root);
}

// Path: home.customer.services_grid.error
class _TranslationsHomeCustomerServicesGridErrorAr implements TranslationsHomeCustomerServicesGridErrorEn {
	_TranslationsHomeCustomerServicesGridErrorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'فشل تحميل الخدمات';
	@override String get retry => 'إعادة المحاولة';
}

// Path: home.customer.services_grid.empty
class _TranslationsHomeCustomerServicesGridEmptyAr implements TranslationsHomeCustomerServicesGridEmptyEn {
	_TranslationsHomeCustomerServicesGridEmptyAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'لا توجد خدمات متاحة';
	@override String get refresh => 'تحديث';
}

// Path: home.vendor.stats.stats_card
class _TranslationsHomeVendorStatsStatsCardAr implements TranslationsHomeVendorStatsStatsCardEn {
	_TranslationsHomeVendorStatsStatsCardAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الإحصائيات';
	@override String get earnings => 'الأرباح';
	@override String get orders => 'الطلبات';
	@override String get rating => 'التقييم';
	@override String get sales => 'المبيعات';
}

// Path: home.vendor.availability_capacity.availability
class _TranslationsHomeVendorAvailabilityCapacityAvailabilityAr implements TranslationsHomeVendorAvailabilityCapacityAvailabilityEn {
	_TranslationsHomeVendorAvailabilityCapacityAvailabilityAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'قبول طلبات جديدة';
	@override String get available => 'متاح';
	@override String get not_available => 'غير متاح';
}

// Path: home.vendor.availability_capacity.status
class _TranslationsHomeVendorAvailabilityCapacityStatusAr implements TranslationsHomeVendorAvailabilityCapacityStatusEn {
	_TranslationsHomeVendorAvailabilityCapacityStatusAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'حالة البائع';
	@override String get open => 'مفتوح';
	@override String get busy => 'مشغول';
}

// Path: home.vendor.availability_capacity.capacity
class _TranslationsHomeVendorAvailabilityCapacityCapacityAr implements TranslationsHomeVendorAvailabilityCapacityCapacityEn {
	_TranslationsHomeVendorAvailabilityCapacityCapacityAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'سعة الطلبات';
	@override String get description => 'الحد الأقصى للطلبات المتزامنة';
}

// Path: home.vendor.checkout_orders.timeline
class _TranslationsHomeVendorCheckoutOrdersTimelineAr implements TranslationsHomeVendorCheckoutOrdersTimelineEn {
	_TranslationsHomeVendorCheckoutOrdersTimelineAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get pending => 'معلق';
	@override String get pending_sublabel => 'تم الاستلام';
	@override String get processing => 'قيد المعالجة';
	@override String get processing_sublabel => 'قيد التحضير';
	@override String get shipped => 'تم الشحن';
	@override String get shipped_sublabel => 'في الطريق';
	@override String get delivered => 'تم التسليم';
	@override String get delivered_sublabel => 'تم';
}

// Path: home.vendor.checkout_orders.status
class _TranslationsHomeVendorCheckoutOrdersStatusAr implements TranslationsHomeVendorCheckoutOrdersStatusEn {
	_TranslationsHomeVendorCheckoutOrdersStatusAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get pending => 'معلق';
	@override String get processing => 'قيد المعالجة';
	@override String get confirmed => 'مؤكد';
	@override String get shipped => 'تم الشحن';
	@override String get delivered => 'تم التسليم';
	@override String get cancelled => 'ملغى';
}

// Path: user_dashboard.listing_details.specifications.labels
class _TranslationsUserDashboardListingDetailsSpecificationsLabelsAr implements TranslationsUserDashboardListingDetailsSpecificationsLabelsEn {
	_TranslationsUserDashboardListingDetailsSpecificationsLabelsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get make => 'الشركة المصنعة';
	@override String get model => 'الموديل';
	@override String get trim => 'الفئة';
	@override String get year => 'السنة';
	@override String get mileage => 'المسافة المقطوعة';
	@override String get transmission => 'ناقل الحركة';
	@override String get engine => 'المحرك';
	@override String get color => 'اللون';
}

// Path: user_dashboard.settings.account_info.fields
class _TranslationsUserDashboardSettingsAccountInfoFieldsAr implements TranslationsUserDashboardSettingsAccountInfoFieldsEn {
	_TranslationsUserDashboardSettingsAccountInfoFieldsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get first_name => 'الاسم الأول';
	@override String get last_name => 'اسم العائلة';
	@override String get email => 'البريد الإلكتروني';
	@override String get date_of_birth => 'تاريخ الميلاد';
	@override String get phone_number => 'رقم الهاتف';
}

// Path: user_dashboard.settings.account_info.gender
class _TranslationsUserDashboardSettingsAccountInfoGenderAr implements TranslationsUserDashboardSettingsAccountInfoGenderEn {
	_TranslationsUserDashboardSettingsAccountInfoGenderAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الجنس';
	@override String get male => 'ذكر';
	@override String get female => 'أنثى';
}

// Path: user_dashboard.settings.account_info.preferences
class _TranslationsUserDashboardSettingsAccountInfoPreferencesAr implements TranslationsUserDashboardSettingsAccountInfoPreferencesEn {
	_TranslationsUserDashboardSettingsAccountInfoPreferencesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get receive_offers => 'نعم، أريد تلقي العروض والخصومات';
	@override String get newsletter => 'الاشتراك في النشرة الإخبارية';
}

// Path: user_dashboard.settings.change_password.fields
class _TranslationsUserDashboardSettingsChangePasswordFieldsAr implements TranslationsUserDashboardSettingsChangePasswordFieldsEn {
	_TranslationsUserDashboardSettingsChangePasswordFieldsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get current_password => 'كلمة المرور الحالية';
	@override String get new_password => 'كلمة المرور الجديدة';
	@override String get confirm_password => 'تأكيد كلمة المرور الجديدة';
}

// Path: user_dashboard.settings.change_password.validation
class _TranslationsUserDashboardSettingsChangePasswordValidationAr implements TranslationsUserDashboardSettingsChangePasswordValidationEn {
	_TranslationsUserDashboardSettingsChangePasswordValidationAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get current_required => 'كلمة المرور الحالية مطلوبة';
	@override String get min_length => 'يجب أن تكون كلمة المرور 8 أحرف على الأقل';
	@override String get match => 'كلمات المرور غير متطابقة';
}

// Path: user_dashboard.settings.verify_email_otp.resend
class _TranslationsUserDashboardSettingsVerifyEmailOtpResendAr implements TranslationsUserDashboardSettingsVerifyEmailOtpResendEn {
	_TranslationsUserDashboardSettingsVerifyEmailOtpResendAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get did_not_receive => 'لم تستلم الرمز؟ ';
	@override String get resend_in => 'إعادة الإرسال خلال {time}';
	@override String get resend_button => 'إعادة إرسال';
}

// Path: user_dashboard.settings.edit_address.delete_dialog
class _TranslationsUserDashboardSettingsEditAddressDeleteDialogAr implements TranslationsUserDashboardSettingsEditAddressDeleteDialogEn {
	_TranslationsUserDashboardSettingsEditAddressDeleteDialogAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'حذف العنوان';
	@override String get description => 'هل أنت متأكد أنك تريد حذف هذا العنوان؟';
	@override String get yes => 'نعم';
	@override String get no => 'لا';
}

// Path: user_dashboard.settings.edit_address.validation
class _TranslationsUserDashboardSettingsEditAddressValidationAr implements TranslationsUserDashboardSettingsEditAddressValidationEn {
	_TranslationsUserDashboardSettingsEditAddressValidationAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get required_fields => 'يرجى ملء الحقول المطلوبة';
}

// Path: user_dashboard.settings.edit_address.area
class _TranslationsUserDashboardSettingsEditAddressAreaAr implements TranslationsUserDashboardSettingsEditAddressAreaEn {
	_TranslationsUserDashboardSettingsEditAddressAreaAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get label => 'المنطقة';
	@override String get hint => 'اضغط تغيير لتحديد المنطقة';
	@override String get change_button => 'تغيير';
	@override String get dialog_title => 'المنطقة';
	@override String get dialog_hint => 'أدخل المنطقة';
	@override String get cancel => 'إلغاء';
	@override String get ok => 'موافق';
}

// Path: user_dashboard.settings.edit_address.property_types
class _TranslationsUserDashboardSettingsEditAddressPropertyTypesAr implements TranslationsUserDashboardSettingsEditAddressPropertyTypesEn {
	_TranslationsUserDashboardSettingsEditAddressPropertyTypesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get apartment => 'شقة';
	@override String get house => 'منزل';
	@override String get office => 'مكتب';
}

// Path: user_dashboard.settings.edit_address.fields
class _TranslationsUserDashboardSettingsEditAddressFieldsAr implements TranslationsUserDashboardSettingsEditAddressFieldsEn {
	_TranslationsUserDashboardSettingsEditAddressFieldsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get address_title => 'عنوان العنوان';
	@override String get building_name => 'اسم المبنى';
	@override String get apt_number => 'رقم الشقة';
	@override String get street => 'الشارع';
	@override String get block => 'القطعة';
	@override String get avenue_optional => 'الجادة (اختياري)';
	@override String get directions_optional => 'اتجاهات إضافية (اختياري)';
	@override String get phone_number => 'رقم الهاتف';
	@override String get address_label_optional => 'تسمية العنوان (اختياري)';
}

// Path: vendor_services.create_screen.form.service_name
class _TranslationsVendorServicesCreateScreenFormServiceNameAr implements TranslationsVendorServicesCreateScreenFormServiceNameEn {
	_TranslationsVendorServicesCreateScreenFormServiceNameAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get label => 'اسم الخدمة';
	@override String get hint => 'مثال: غسيل السيارة المتميز';
	@override String get required => '{field} مطلوب';
}

// Path: vendor_services.create_screen.form.description
class _TranslationsVendorServicesCreateScreenFormDescriptionAr implements TranslationsVendorServicesCreateScreenFormDescriptionEn {
	_TranslationsVendorServicesCreateScreenFormDescriptionAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get label => 'الوصف (اختياري)';
	@override String get hint => 'صف خدمتك';
}

// Path: vendor_services.create_screen.form.base_price
class _TranslationsVendorServicesCreateScreenFormBasePriceAr implements TranslationsVendorServicesCreateScreenFormBasePriceEn {
	_TranslationsVendorServicesCreateScreenFormBasePriceAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get label => 'السعر الأساسي (د.ك)';
	@override String get hint => '0.00';
}

// Path: vendor_services.create_screen.form.radius
class _TranslationsVendorServicesCreateScreenFormRadiusAr implements TranslationsVendorServicesCreateScreenFormRadiusEn {
	_TranslationsVendorServicesCreateScreenFormRadiusAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get label => 'نطاق الخدمة (كم)';
	@override String get hint => '20';
}

// Path: home.customer.active_orders.order.order_card
class _TranslationsHomeCustomerActiveOrdersOrderOrderCardAr implements TranslationsHomeCustomerActiveOrdersOrderOrderCardEn {
	_TranslationsHomeCustomerActiveOrdersOrderOrderCardAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get service => 'الخدمة';
	@override String get scheduled => 'المجدول';
	@override String get asap => 'في أقرب وقت';
	@override late final _TranslationsHomeCustomerActiveOrdersOrderOrderCardStatusAr status = _TranslationsHomeCustomerActiveOrdersOrderOrderCardStatusAr._(_root);
}

// Path: home.customer.active_orders.order.order_card.status
class _TranslationsHomeCustomerActiveOrdersOrderOrderCardStatusAr implements TranslationsHomeCustomerActiveOrdersOrderOrderCardStatusEn {
	_TranslationsHomeCustomerActiveOrdersOrderOrderCardStatusAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get pending => 'معلق';
	@override String get accepted => 'مقبول';
	@override String get en_route => 'في الطريق';
	@override String get arrived => 'وصل';
	@override String get active => 'نشط';
}

/// The flat map containing all translations for locale <ar>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsAr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'general.app_name' => 'تطبيق موتيفا',
			'auth.login.title' => 'تسجيل الدخول',
			'auth.login.loading' => 'جاري تسجيل الدخول...',
			'auth.login.do_not_have_account' => 'ليس لديك حساب؟ ',
			'auth.login.create_account' => 'إنشاء حساب',
			'auth.register_as.title' => 'التسجيل كـ',
			'auth.register_as.select_user_type' => 'اختر نوع المستخدم',
			'auth.register_as.business_owner' => 'صاحب عمل',
			'auth.register_as.customer' => 'عميل',
			'auth.register_as.driver' => 'سائق',
			'auth.register_vendor.business_name' => 'اسم النشاط التجاري',
			'auth.register_vendor.business_email' => 'البريد الإلكتروني للعمل',
			'auth.register_vendor.representative_name' => 'اسم المفوض',
			'auth.register_vendor.commercial_license' => 'رقم السجل التجاري (اختياري)',
			'auth.register_customer.name' => 'الاسم',
			'auth.register_customer.email' => 'البريد الإلكتروني',
			'auth.register_customer.country' => 'الدولة',
			'auth.register_customer.kuwait' => 'الكويت',
			'auth.register_customer.saudi_arabia' => 'المملكة العربية السعودية',
			'auth.register_customer.uae' => 'الإمارات العربية المتحدة',
			'auth.register_customer.city' => 'المدينة',
			'auth.register_customer.kuwait_city' => 'مدينة الكويت',
			'auth.register_customer.al_jahra' => 'الجهراء',
			'auth.register_customer.hawalli' => 'حولي',
			'auth.verify.title' => 'التحقق من\nرقم الهاتف',
			'auth.verify.description' => 'لقد أرسلنا الرمز إلى',
			'auth.verify.loading' => 'جاري التحقق...',
			'auth.verify.button' => 'تحقق',
			'auth.verify.resend' => 'إعادة إرسال',
			'auth.verify.resend_in' => 'إعادة الإرسال خلال',
			'auth.verify.did_not_receive_code' => 'لم تستلم الرمز؟ ',
			'auth.category.title' => 'اختر الفئة',
			'auth.category.select_category' => 'اختر الفئة',
			'auth.category.loading' => 'جاري التسجيل...',
			'auth.category.error.null_category' => 'يرجى اختيار فئة',
			'auth.category.error.no_categories' => 'لا توجد فئات متاحة',
			'auth.category.error.failed_to_load' => 'فشل تحميل الفئات',
			'auth.category.error.button' => 'إعادة المحاولة',
			'auth.category.error.registration_failed' => 'فشل التسجيل. يرجى المحاولة مرة أخرى.',
			'auth.category.registration_success' => 'تم إرسال طلب التسجيل! حسابك يحتاج إلى موافقة المشرف قبل أن تتمكن من تسجيل الدخول.',
			'auth.splash.vendor.title' => 'جاري التحقق من الملف الشخصي...',
			'auth.splash.vendor.login_error' => 'فشل التحقق من ملف البائع الشخصي',
			'auth.splash.vendor.logout_error' => 'ملف البائع الشخصي غير مكتمل أو لم يتم العثور عليه.\nيرجى التواصل مع الدعم أو إكمال التسجيل للمتابعة.',
			'auth.splash.error.splash_failed' => 'خطأ في المصادقة عند التشغيل',
			'auth.splash.error.auth_failed' => 'فشلت المصادقة. يرجى تسجيل الدخول مرة أخرى.',
			'auth.splash.initializing' => 'جاري التهيئة...',
			'auth.splash.loading' => 'جاري التحميل...',
			'auth.splash.checking_auth' => 'جاري التحقق من المصادقة...',
			'auth.phone_number' => 'رقم الهاتف',
			'auth.password' => 'كلمة المرور',
			'auth.confirm_password' => 'تأكيد كلمة المرور',
			'auth.continue_button' => 'متابعة',
			'auth.get_started' => 'ابدأ',
			'auth.loading' => 'جاري إرسال رمز التحقق...',
			'auth.already_have_account' => 'لديك حساب بالفعل؟ ',
			'auth.login_button' => 'تسجيل الدخول',
			'booking.booking_screen.title' => 'حجز خدمة',
			'booking.booking_screen.service_details' => 'تفاصيل الخدمة',
			'booking.booking_screen.location.title' => 'موقع الخدمة',
			'booking.booking_screen.location.selected' => 'تم الاختيار',
			'booking.booking_screen.location.tap_to_select' => 'اضغط للاختيار',
			'booking.booking_screen.location.tap_to_select_location' => 'اضغط لاختيار الموقع على الخريطة',
			'booking.booking_screen.location.pick' => 'اختيار',
			'booking.booking_screen.location.pick_location' => 'اختيار الموقع',
			'booking.booking_screen.location.additional_details' => 'تفاصيل العنوان الإضافية (اختياري)',
			'booking.booking_screen.location.pickup' => 'موقع الاستلام',
			'booking.booking_screen.location.drop_off' => 'موقع التسليم',
			'booking.booking_screen.location.location_selected' => 'تم اختيار الموقع',
			'booking.booking_screen.location.success' => 'تم الاختيار بنجاح',
			'booking.booking_screen.location.success_location' => 'تم اختيار الموقع بنجاح',
			'booking.booking_screen.location.null_location' => 'يرجى اختيار موقعك',
			'booking.booking_screen.location.null_pickup' => 'يرجى اختيار موقع الاستلام',
			'booking.booking_screen.location.null_drop_off' => 'يرجى اختيار موقع التسليم',
			'booking.booking_screen.scheduling.title' => 'جدولة',
			'booking.booking_screen.scheduling.date' => 'اختر التاريخ',
			'booking.booking_screen.scheduling.jan' => 'يناير',
			'booking.booking_screen.scheduling.feb' => 'فبراير',
			'booking.booking_screen.scheduling.mar' => 'مارس',
			'booking.booking_screen.scheduling.apr' => 'أبريل',
			'booking.booking_screen.scheduling.may' => 'مايو',
			'booking.booking_screen.scheduling.jun' => 'يونيو',
			'booking.booking_screen.scheduling.jul' => 'يوليو',
			'booking.booking_screen.scheduling.aug' => 'أغسطس',
			'booking.booking_screen.scheduling.sep' => 'سبتمبر',
			'booking.booking_screen.scheduling.oct' => 'أكتوبر',
			'booking.booking_screen.scheduling.nov' => 'نوفمبر',
			'booking.booking_screen.scheduling.dec' => 'ديسمبر',
			'booking.booking_screen.scheduling.time' => 'الوقت المتاح',
			'booking.booking_screen.scheduling.clear' => 'مسح',
			'booking.booking_screen.scheduling.null_time' => 'لا توجد أوقات متاحة لهذا التاريخ. يرجى اختيار تاريخ آخر.',
			'booking.booking_screen.scheduling.select_time' => 'يرجى اختيار وقت',
			'booking.booking_screen.scheduling.error_time' => 'لا يوجد وقت متاح',
			'booking.booking_screen.scheduling.next_available' => 'التالي المتاح',
			'booking.booking_screen.scheduling.select_next_available' => 'اختر هذا اليوم',
			'booking.booking_screen.order.title' => 'ملخص الطلب',
			'booking.booking_screen.order.base_amount' => 'المبلغ الأساسي',
			'booking.booking_screen.order.description' => 'سيتم تأكيد المبلغ النهائي من قبل البائع',
			'booking.booking_screen.button.title' => 'تأكيد الحجز',
			'booking.booking_screen.button.error_location' => 'يرجى اختيار موقعك للمتابعة',
			'booking.booking_screen.button.error_pickup' => 'يرجى اختيار موقع الاستلام',
			'booking.booking_screen.button.error_drop_off' => 'يرجى اختيار موقع التسليم',
			'booking.order_confirmation.title' => 'تم إرسال الحجز!',
			'booking.order_confirmation.order' => 'الطلب:',
			'booking.order_confirmation.status.title' => 'تم تأكيد الحجز',
			'booking.order_confirmation.status.description' => 'تم قبول حجزك وتأكيده تلقائيًا بنجاح.',
			'booking.order_confirmation.info.service' => 'الخدمة',
			'booking.order_confirmation.info.vendor' => 'البائع',
			'booking.order_confirmation.info.base_amount' => 'المبلغ الأساسي',
			'booking.order_confirmation.info.scheduled' => 'المجدول',
			'booking.order_confirmation.info.location' => 'الموقع',
			'booking.order_confirmation.button.primary' => 'العودة إلى الرئيسية',
			'booking.order_confirmation.button.secondary' => 'الذهاب إلى طلباتي',
			'home.services_grid.spare_parts' => 'قطع غيار',
			'home.customer.search' => 'البحث عن منتجات',
			'home.customer.active_orders.empty.title' => 'لا توجد طلبات نشطة',
			'home.customer.active_orders.empty.description' => 'ستظهر طلباتك النشطة هنا',
			'home.customer.active_orders.order.title' => 'الطلبات النشطة',
			'home.customer.active_orders.order.more_orders' => 'طلبات إضافية',
			'home.customer.active_orders.order.view_all' => 'عرض جميع الطلبات',
			'home.customer.active_orders.order.order_card.service' => 'الخدمة',
			'home.customer.active_orders.order.order_card.scheduled' => 'المجدول',
			'home.customer.active_orders.order.order_card.asap' => 'في أقرب وقت',
			'home.customer.active_orders.order.order_card.status.pending' => 'معلق',
			'home.customer.active_orders.order.order_card.status.accepted' => 'مقبول',
			'home.customer.active_orders.order.order_card.status.en_route' => 'في الطريق',
			'home.customer.active_orders.order.order_card.status.arrived' => 'وصل',
			'home.customer.active_orders.order.order_card.status.active' => 'نشط',
			'home.customer.premium_banner.title' => 'ترقية إلى بريميوم\nللحصول على مزايا\nحصرية!',
			'home.customer.premium_banner.button' => 'ترقية الآن',
			'home.customer.ad_banner.title' => 'مساعدة الطريق\nبخصم 10% - احجز الآن!',
			'home.customer.services_grid.title' => 'الخدمات المتاحة',
			'home.customer.services_grid.view_all' => 'عرض الكل',
			'home.customer.services_grid.error_category' => 'فشل تحميل فئات الخدمات',
			'home.customer.services_grid.error.title' => 'فشل تحميل الخدمات',
			'home.customer.services_grid.error.retry' => 'إعادة المحاولة',
			'home.customer.services_grid.empty.title' => 'لا توجد خدمات متاحة',
			'home.customer.services_grid.empty.refresh' => 'تحديث',
			'home.customer.buy_sell_card.buy' => 'شراء سيارة',
			'home.customer.buy_sell_card.sell' => 'بيع سيارتك',
			'home.customer.buy_sell_card.tap' => 'اضغط هنا',
			'home.customer.promo_banner.title' => 'وفر حتى 5 د.ك',
			'home.customer.promo_banner.description' => 'عرض محدود على خدمات\nمحددة',
			'home.customer.listing.popular_today' => 'الأكثر شيوعًا اليوم',
			'home.customer.listing.top_vendors' => 'أفضل البائعين',
			'home.customer.listing.new_vendors' => 'بائعون جدد',
			'home.vendor.services_grid.messages' => 'الرسائل',
			'home.vendor.services_grid.support' => 'الدعم',
			'home.vendor.services_grid.requests' => 'الطلبات',
			'home.vendor.services_grid.orders' => 'الطلبات',
			'home.vendor.services_grid.add_services' => 'إضافة خدمات',
			'home.vendor.services_grid.current_services' => 'الخدمات الحالية',
			'home.vendor.stats.today' => 'اليوم',
			'home.vendor.stats.weekly' => 'أسبوعي',
			'home.vendor.stats.monthly' => 'شهري',
			'home.vendor.stats.this_weekly' => 'هذا الأسبوع',
			'home.vendor.stats.this_monthly' => 'هذا الشهر',
			'home.vendor.stats.stats_card.title' => 'الإحصائيات',
			'home.vendor.stats.stats_card.earnings' => 'الأرباح',
			'home.vendor.stats.stats_card.orders' => 'الطلبات',
			'home.vendor.stats.stats_card.rating' => 'التقييم',
			'home.vendor.stats.stats_card.sales' => 'المبيعات',
			'home.vendor.completed_jobs' => 'المهام المنجزة',
			'home.vendor.availability_capacity.title' => 'التوفر والسعة',
			'home.vendor.availability_capacity.availability.title' => 'قبول طلبات جديدة',
			'home.vendor.availability_capacity.availability.available' => 'متاح',
			'home.vendor.availability_capacity.availability.not_available' => 'غير متاح',
			'home.vendor.availability_capacity.status.title' => 'حالة البائع',
			'home.vendor.availability_capacity.status.open' => 'مفتوح',
			'home.vendor.availability_capacity.status.busy' => 'مشغول',
			'home.vendor.availability_capacity.capacity.title' => 'سعة الطلبات',
			'home.vendor.availability_capacity.capacity.description' => 'الحد الأقصى للطلبات المتزامنة',
			'home.vendor.active_orders.title' => 'الطلبات النشطة',
			'home.vendor.active_orders.all' => 'الكل',
			'home.vendor.active_orders.en_route' => 'في الطريق',
			'home.vendor.active_orders.arrived' => 'وصل',
			'home.vendor.active_orders.in_progress' => 'قيد التنفيذ',
			'home.vendor.active_orders.empty' => 'لا توجد طلبات',
			'home.vendor.active_orders.service' => 'الخدمة',
			'home.vendor.active_orders.customer' => 'العميل',
			'home.vendor.active_orders.asap' => 'في أقرب وقت',
			'home.vendor.checkout_orders.title' => 'طلبات المنتجات',
			'home.vendor.checkout_orders.all' => 'الكل',
			'home.vendor.checkout_orders.pending' => 'معلق',
			'home.vendor.checkout_orders.processing' => 'قيد المعالجة',
			'home.vendor.checkout_orders.confirmed' => 'مؤكد',
			'home.vendor.checkout_orders.shipped' => 'تم الشحن',
			'home.vendor.checkout_orders.empty' => 'لا توجد طلبات منتجات',
			'home.vendor.checkout_orders.order_number' => 'طلب #',
			'home.vendor.checkout_orders.items_count' => 'عناصر',
			'home.vendor.checkout_orders.item' => 'عنصر',
			'home.vendor.checkout_orders.payment_method' => 'الدفع: نقدًا عند التسليم',
			'home.vendor.checkout_orders.cancel' => 'إلغاء',
			'home.vendor.checkout_orders.ship' => 'تحديد كمشحون',
			'home.vendor.checkout_orders.deliver' => 'تحديد كمسلم',
			'home.vendor.checkout_orders.product_order' => 'طلب منتج',
			'home.vendor.checkout_orders.placed' => 'تم الطلب',
			'home.vendor.checkout_orders.total' => 'الإجمالي',
			'home.vendor.checkout_orders.status_timeline' => 'الجدول الزمني للحالة',
			'home.vendor.checkout_orders.timeline.pending' => 'معلق',
			'home.vendor.checkout_orders.timeline.pending_sublabel' => 'تم الاستلام',
			'home.vendor.checkout_orders.timeline.processing' => 'قيد المعالجة',
			'home.vendor.checkout_orders.timeline.processing_sublabel' => 'قيد التحضير',
			'home.vendor.checkout_orders.timeline.shipped' => 'تم الشحن',
			'home.vendor.checkout_orders.timeline.shipped_sublabel' => 'في الطريق',
			'home.vendor.checkout_orders.timeline.delivered' => 'تم التسليم',
			'home.vendor.checkout_orders.timeline.delivered_sublabel' => 'تم',
			'home.vendor.checkout_orders.status.pending' => 'معلق',
			'home.vendor.checkout_orders.status.processing' => 'قيد المعالجة',
			'home.vendor.checkout_orders.status.confirmed' => 'مؤكد',
			'home.vendor.checkout_orders.status.shipped' => 'تم الشحن',
			'home.vendor.checkout_orders.status.delivered' => 'تم التسليم',
			'home.vendor.checkout_orders.status.cancelled' => 'ملغى',
			'home.vendor.checkout_orders.customer' => 'العميل',
			'home.vendor.checkout_orders.order_items' => 'عناصر الطلب',
			'home.vendor.checkout_orders.delivery' => 'التوصيل',
			'home.vendor.checkout_orders.delivery_address' => 'عنوان التوصيل',
			'home.vendor.checkout_orders.no_address_provided' => 'لم يتم تقديم عنوان',
			'home.vendor.checkout_orders.payment' => 'الدفع',
			'home.vendor.checkout_orders.payment_status' => 'الحالة',
			'home.vendor.checkout_orders.payment_paid' => 'مدفوع',
			'home.vendor.checkout_orders.payment_pending' => 'معلق',
			'home.vendor.checkout_orders.order_info' => 'معلومات الطلب',
			'home.vendor.checkout_orders.order_id' => 'رقم الطلب',
			'home.vendor.checkout_orders.placed_on' => 'تم الطلب في',
			'home.vendor.checkout_orders.last_updated' => 'آخر تحديث',
			'home.vendor.checkout_orders.est_delivery' => 'التسليم المتوقع',
			'home.vendor.checkout_orders.cancellation' => 'الإلغاء',
			'home.vendor.checkout_orders.cancellation_reason' => 'سبب الإلغاء',
			'home.vendor.checkout_orders.no_reason_provided' => 'لم يتم تقديم سبب',
			'home.vendor.checkout_orders.loading_order' => 'جاري تحميل الطلب...',
			'home.vendor.checkout_orders.failed_to_load' => 'فشل التحميل',
			'home.vendor.checkout_orders.try_again' => 'حاول مرة أخرى',
			'home.vendor.checkout_orders.mark_shipped' => 'تحديد كمشحون',
			'home.vendor.checkout_orders.mark_delivered' => 'تم التسليم',
			'home.vendor.checkout_orders.order_shipped_success' => 'تم شحن الطلب!',
			'home.vendor.checkout_orders.order_delivered_success' => 'تم تسليم الطلب!',
			'home.vendor.checkout_orders.failed' => 'فشل',
			'home.vendor.checkout_orders.not_specified' => 'غير محدد',
			'home.vendor.checkout_orders.cash_on_delivery' => 'الدفع عند التسليم',
			'home.vendor.checkout_orders.credit_debit_card' => 'بطاقة ائتمان/خصم',
			'home.vendor.empty' => 'لم يتم العثور على الملف الشخصي',
			'home.vendor.error' => 'خطأ في تحميل البيانات',
			'home.operator.incoming_requests' => 'الطلبات الواردة',
			'home.operator.accepted_requests' => 'الطلبات المقبولة',
			'home.operator.rides_history' => 'سجل الرحلات',
			'cart.title' => 'سلة التسوق',
			'cart.error_loading' => 'فشل تحميل السلة:',
			'cart.empty.title' => 'سلة التسوق فارغة',
			'cart.empty.subtitle' => 'تصفح خدماتنا واحجز موعدك القادم',
			'cart.empty.browse_button' => 'تصفح الخدمات',
			'cart.delivering_from' => 'التوصيل من',
			'cart.all_items' => 'جميع العناصر',
			'cart.special_request' => 'طلب خاص',
			'cart.special_request_hint' => 'اكتب أي طلب خاص بخصوص الطلب.',
			'cart.price' => 'السعر',
			'cart.items' => 'عناصر',
			'cart.promo_code' => 'رمز الترويجي',
			'cart.total_amount' => 'المبلغ الإجمالي',
			'cart.you_saved' => 'لقد وفرت',
			'cart.order' => 'في هذا الطلب',
			'cart.checkout_button' => 'إتمام الشراء',
			'cart.vendor_subtitle' => 'نحن جاهزون لخدمتك في أي وقت',
			'checkout.title' => 'الدفع',
			'checkout.order_summary' => 'ملخص الطلب',
			'checkout.subtotal' => 'المجموع الفرعي',
			'checkout.delivery_fee' => 'رسوم التوصيل',
			'checkout.voucher_discount' => 'خصم القسيمة',
			'checkout.wallet_used' => 'المحفظة المستخدمة',
			'checkout.total' => 'الإجمالي',
			'checkout.delivery_address' => 'عنوان التوصيل',
			'checkout.add_new_address' => 'إضافة عنوان جديد',
			'checkout.save_address' => 'حفظ العنوان',
			'checkout.voucher_code' => 'رمز القسيمة',
			'checkout.enter_voucher' => 'أدخل رمز القسيمة',
			'checkout.apply' => 'تطبيق',
			'checkout.voucher_applied' => 'تم تطبيق القسيمة بنجاح!',
			'checkout.wallet_balance' => 'رصيد المحفظة',
			'checkout.payment_methods' => 'طرق الدفع',
			'checkout.pay' => 'ادفع',
			'checkout.processing' => 'جاري المعالجة...',
			'checkout.order_confirmed' => 'تم تأكيد الطلب!',
			'checkout.order_placed' => 'تم تقديم طلبك بنجاح.',
			'checkout.total_payment' => 'إجمالي الدفع',
			'checkout.order_number' => 'رقم الطلب #',
			'checkout.payment_time' => 'وقت الدفع',
			'checkout.payment_method' => 'طريقة الدفع',
			'checkout.items' => 'العناصر',
			'checkout.estimated_delivery' => 'التوصيل المتوقع',
			'checkout.track_order' => 'تتبع الطلب',
			'checkout.back_home' => 'العودة إلى الرئيسية',
			'checkout.continue_shopping' => 'مواصلة التسوق',
			'checkout.motiva_wallet' => 'محفظة موتيفا',
			'checkout.balance' => 'الرصيد:',
			'checkout.fill_required_fields' => 'يرجى ملء الحقول المطلوبة',
			'checkout.address_label_hint' => 'التسمية (مثال: المنزل، العمل)',
			'checkout.street' => 'الشارع *',
			'checkout.area' => 'المنطقة *',
			'checkout.block' => 'القطعة *',
			'checkout.building' => 'المبنى',
			'checkout.floor' => 'الدور',
			'checkout.apartment' => 'الشقة',
			'checkout.notes' => 'ملاحظات',
			'checkout.default_address_label' => 'العنوان',
			'checkout.block_label' => 'قطعة',
			'checkout.building_label' => 'مبنى',
			'checkout.floor_label' => 'الدور',
			'checkout.apartment_label' => 'شقة',
			'public_services.category_vendors.description' => 'اعثر على أفضل الخدمات',
			'public_services.category_vendors.search' => 'البحث عن بائعين',
			'public_services.category_vendors.all_vendors' => 'جميع البائعين',
			'public_services.category_vendors.error_vendor' => 'فشل تحميل البائعين',
			'public_services.category_vendors.null_vendor' => 'لم يتم العثور على بائعين',
			'public_services.category_vendors.vendor_card.sub_title' => 'خدمات متاحة',
			'public_services.category_vendors.vendor_card.badge_title' => 'موثق',
			'public_services.vendor_services.services' => 'الخدمات',
			'public_services.vendor_services.reviews' => 'التقييمات',
			'public_services.vendor_services.most_popular' => 'الأكثر شيوعًا',
			'public_services.vendor_services.search' => 'البحث عن خدمة',
			'public_services.vendor_services.error_service' => 'فشل تحميل الخدمات',
			'public_services.vendor_services.null_service' => 'لم يتم العثور على خدمات',
			'public_services.vendor_services.all_services' => 'جميع الخدمات',
			'public_services.vendor_services.service_card.description' => 'خدمة احترافية',
			'public_services.vendor_services.service_card.button' => 'عرض التفاصيل',
			'public_services.services_details.title' => 'عن هذه الخدمة',
			'public_services.services_details.min' => 'دقيقة',
			'public_services.services_details.description.title' => 'الوصف',
			'public_services.services_details.description.dec' => 'خدمة احترافية من',
			'public_services.services_details.service_details' => 'تفاصيل الخدمة',
			'public_services.services_details.provider' => 'مزود الخدمة',
			'public_services.services_details.services' => 'الخدمات',
			'public_services.services_details.reviews' => 'التقييمات',
			'public_services.services_details.working_hours.title' => 'ساعات العمل',
			'public_services.services_details.working_hours.closed' => 'مغلق',
			'public_services.services_details.working_hours.open' => 'مفتوح',
			'public_services.services_details.days.Monday' => 'الإثنين',
			'public_services.services_details.days.Tuesday' => 'الثلاثاء',
			'public_services.services_details.days.Wednesday' => 'الأربعاء',
			'public_services.services_details.days.Thursday' => 'الخميس',
			'public_services.services_details.days.Friday' => 'الجمعة',
			'public_services.services_details.days.Saturday' => 'السبت',
			'public_services.services_details.days.Sunday' => 'الأحد',
			'public_services.services_details.button.title' => 'اطلب الآن',
			'public_services.services_details.button.null_service' => 'جاري تحميل تفاصيل الخدمة...',
			'public_services.services_details.button.error_service' => 'تتطلب هذه الخدمة عرض سعر. يرجى التواصل مع البائع مباشرة.',
			'public_marketplace.category_screen.title_accessories' => 'اكسسوارات',
			'public_marketplace.category_screen.title_spare_parts' => 'قطع غيار',
			'public_marketplace.category_screen.subtitle' => 'اعثر على أفضل الخدمات',
			'public_marketplace.category_screen.search_hint' => 'البحث عن بائع',
			'public_marketplace.category_screen.all_supplies' => 'جميع المنتجات',
			'public_marketplace.category_screen.no_vendors_match_search' => 'لا يوجد بائعون يطابقون بحثك',
			'public_marketplace.category_screen.no_vendors_found' => 'لم يتم العثور على بائعين',
			'public_marketplace.category_screen.label_accessories' => 'اكسسوارات',
			'public_marketplace.category_screen.label_spare_parts' => 'قطع غيار',
			'public_marketplace.category_screen.verified' => 'موثق',
			'public_marketplace.category_screen.error_loading' => 'فشل تحميل البائعين',
			'public_marketplace.details_screen.app_bar_title' => 'عن هذه الخدمة',
			'public_marketplace.details_screen.product_not_found' => 'لم يتم العثور على المنتج',
			'public_marketplace.details_screen.description' => 'الوصف',
			'public_marketplace.details_screen.no_description' => 'لا يوجد وصف متاح.',
			'public_marketplace.details_screen.quantity' => 'الكمية',
			'public_marketplace.details_screen.added_to_cart' => 'تمت الإضافة إلى سلة التسوق',
			'public_marketplace.details_screen.add_to_cart_button' => 'أضف إلى السلة',
			'public_marketplace.details_screen.reviews' => 'التقييمات',
			'public_marketplace.details_screen.load_more_reviews' => 'تحميل المزيد من التقييمات',
			'public_marketplace.details_screen.similar_products' => 'منتجات مماثلة',
			'public_marketplace.details_screen.months_ago' => 'شهر/أشهر مضت',
			'public_marketplace.vendor_details_screen.search_hint' => 'البحث عن خدمة',
			'public_marketplace.vendor_details_screen.most_popular' => 'الأكثر شيوعًا',
			'public_marketplace.vendor_details_screen.all_services' => 'جميع الخدمات',
			'public_marketplace.vendor_details_screen.reviews' => 'التقييمات',
			'public_marketplace.vendor_details_screen.no_services_found' => 'لم يتم العثور على خدمات',
			'public_marketplace.vendor_details_screen.professional_service' => 'خدمة احترافية',
			'public_marketplace.vendor_details_screen.add_to_cart' => 'أضف إلى السلة',
			'public_marketplace.vendor_details_screen.services' => 'خدمات',
			'public_marketplace.vendor_details_screen.reviews_label' => 'تقييمات',
			'public_marketplace.spare_parts.title' => 'قطع غيار',
			'public_marketplace.spare_parts.details_screen.specifications' => 'المواصفات',
			'public_marketplace.spare_parts.details_screen.brand' => 'الماركة',
			'public_marketplace.spare_parts.details_screen.part_number' => 'رقم القطعة',
			'public_marketplace.spare_parts.details_screen.warranty' => 'الضمان',
			'public_marketplace.spare_parts.details_screen.warranty_months_suffix' => '{months} شهر ضمان',
			'public_marketplace.spare_parts.details_screen.compatibility' => 'التوافق',
			'public_marketplace.spare_parts.details_screen.compatibility_empty' => 'لا توجد معلومات توافق',
			'public_marketplace.spare_parts.details_screen.no_value' => '—',
			'public_marketplace.spare_parts.category_screen.title' => 'قطع غيار',
			'public_marketplace.spare_parts.category_screen.filter_button_tooltip' => 'تصفية قطع الغيار',
			'public_marketplace.spare_parts.category_screen.chip_make' => 'الشركة: {value}',
			'public_marketplace.spare_parts.category_screen.chip_model' => 'الطراز: {value}',
			'public_marketplace.spare_parts.category_screen.chip_year_from' => 'السنة {value}+',
			'public_marketplace.spare_parts.category_screen.chip_year_to' => 'إلى {value}',
			'public_marketplace.spare_parts.category_screen.chip_brand' => 'الماركة: {value}',
			'public_marketplace.spare_parts.category_screen.chip_min_price' => 'الحد الأدنى: {value}',
			'public_marketplace.spare_parts.category_screen.chip_max_price' => 'الحد الأقصى: {value}',
			'public_marketplace.spare_parts.category_screen.chip_clear_all' => 'مسح الكل',
			'public_marketplace.spare_parts.filter_sheet.title' => 'تصفية قطع الغيار',
			'public_marketplace.spare_parts.filter_sheet.make_label' => 'الشركة المصنعة',
			'public_marketplace.spare_parts.filter_sheet.model_label' => 'الطراز',
			'public_marketplace.spare_parts.filter_sheet.year_from_label' => 'السنة من',
			'public_marketplace.spare_parts.filter_sheet.year_to_label' => 'السنة إلى',
			'public_marketplace.spare_parts.filter_sheet.brand_label' => 'الماركة',
			'public_marketplace.spare_parts.filter_sheet.min_price_label' => 'السعر الأدنى (د.ك)',
			'public_marketplace.spare_parts.filter_sheet.max_price_label' => 'السعر الأقصى (د.ك)',
			'public_marketplace.spare_parts.filter_sheet.apply' => 'تطبيق',
			'public_marketplace.spare_parts.filter_sheet.reset' => 'إعادة تعيين',
			'public_marketplace.spare_parts.filter_sheet.cancel' => 'إلغاء',
			'services.screen.title' => 'جميع الخدمات',
			'services.screen.search_hint' => 'البحث عن خدمات',
			'services.all_services_grid.error.title' => 'فشل تحميل الخدمات',
			'services.all_services_grid.error.retry' => 'إعادة المحاولة',
			'services.all_services_grid.empty.title' => 'لم يتم العثور على خدمات لبحثك',
			'services.all_services_grid.static.buy_a_car' => 'شراء سيارة',
			'services.all_services_grid.static.sell_your_car' => 'بيع سيارتك',
			'services.all_services_grid.static.car_accessories' => 'اكسسوارات السيارات',
			'services.all_services_grid.static.spare_parts' => 'قطع غيار',
			'buy_a_car.screen.title' => 'شراء سيارات',
			'buy_a_car.screen.subtitle' => 'لدينا عروض بانتظارك',
			'buy_a_car.service_section.good_condition_cars' => 'سيارات بحالة جيدة',
			'buy_a_car.service_section.damaged_cars' => 'سيارات تالفة',
			'buy_a_car.service_section.approved_cars' => 'سيارات معتمدة',
			'buy_a_car.service_section.good_condition_description' => 'تصفح مجموعتنا الواسعة من السيارات بحالة ممتازة.',
			'buy_a_car.service_section.damaged_cars_description' => 'اعثر على سيارات تالفة لقطع الغيار أو مشاريع الإصلاح.',
			'buy_a_car.service_section.approved_cars_description' => 'تسوق سيارات معتمدة ومعتمدة مع تقارير فحص كاملة.',
			'buy_a_car.good_condition_screen.title' => 'استكشف السيارات',
			'buy_a_car.good_condition_screen.search_hint' => 'البحث عن سيارات حسب الماركة والموديل...',
			'buy_a_car.good_condition_screen.all_cars' => 'جميع السيارات',
			'buy_a_car.good_condition_screen.no_cars_found' => 'لم يتم العثور على سيارات مطابقة',
			'buy_a_car.good_condition_screen.no_cars_available' => 'لا توجد سيارات متاحة',
			'buy_a_car.good_condition_screen.failed_to_load' => 'فشل تحميل السيارات',
			'buy_a_car.good_condition_screen.retry' => 'إعادة المحاولة',
			'buy_a_car.approved_cars_screen.title' => 'سيارات معتمدة',
			'buy_a_car.approved_cars_screen.search_hint' => 'البحث عن سيارات معتمدة...',
			'buy_a_car.approved_cars_screen.all_approved_cars' => 'جميع السيارات المعتمدة',
			'buy_a_car.approved_cars_screen.no_cars_found' => 'لم يتم العثور على سيارات مطابقة',
			'buy_a_car.approved_cars_screen.no_approved_cars_available' => 'لا توجد سيارات معتمدة متاحة',
			'buy_a_car.approved_cars_screen.failed_to_load' => 'فشل تحميل السيارات',
			'buy_a_car.approved_cars_screen.retry' => 'إعادة المحاولة',
			'buy_a_car.damaged_cars_screen.title' => 'سيارات تالفة',
			'buy_a_car.damaged_cars_screen.search_hint' => 'البحث عن سيارات تالفة...',
			'buy_a_car.damaged_cars_screen.all_damaged_cars' => 'جميع السيارات التالفة',
			'buy_a_car.damaged_cars_screen.no_cars_found' => 'لم يتم العثور على سيارات مطابقة',
			'buy_a_car.damaged_cars_screen.no_damaged_cars_available' => 'لا توجد سيارات تالفة متاحة',
			'buy_a_car.damaged_cars_screen.failed_to_load' => 'فشل تحميل السيارات',
			'buy_a_car.damaged_cars_screen.retry' => 'إعادة المحاولة',
			'buy_a_car.details_screen.about_this_car' => 'عن هذه السيارة',
			'buy_a_car.details_screen.failed_to_load_listing' => 'فشل تحميل الإعلان',
			'buy_a_car.details_screen.retry' => 'إعادة المحاولة',
			'buy_a_car.details_screen.price_on_request' => 'السعر عند الطلب',
			'buy_a_car.details_screen.car_details' => 'تفاصيل السيارة',
			'buy_a_car.details_screen.location_not_specified' => 'لم يتم تحديد الموقع',
			'buy_a_car.details_screen.featured' => 'مميز',
			'buy_a_car.details_screen.inspected' => 'تم الفحص',
			'buy_a_car.details_screen.view_details' => 'عرض التفاصيل',
			'buy_a_car.details_screen.inspection_report.title' => 'تقرير الفحص',
			'buy_a_car.details_screen.inspection_report.description' => 'قم بتنزيل وعرض\n تقرير الفحص لهذه السيارة.',
			'buy_a_car.details_screen.inspection_report.view_report' => 'عرض تقرير الفحص',
			'buy_a_car.details_screen.specifications' => 'المواصفات',
			'buy_a_car.details_screen.spec_labels.make' => 'الشركة المصنعة',
			'buy_a_car.details_screen.spec_labels.model' => 'الموديل',
			'buy_a_car.details_screen.spec_labels.trim' => 'الفئة',
			'buy_a_car.details_screen.spec_labels.year' => 'السنة',
			'buy_a_car.details_screen.spec_labels.mileage' => 'المسافة المقطوعة',
			'buy_a_car.details_screen.spec_labels.transmission' => 'ناقل الحركة',
			'buy_a_car.details_screen.spec_labels.engine' => 'المحرك',
			'buy_a_car.details_screen.spec_labels.color' => 'اللون',
			'buy_a_car.details_screen.na' => 'غير متاح',
			'buy_a_car.details_screen.description' => 'الوصف',
			'buy_a_car.details_screen.no_description' => 'لا يوجد وصف متاح.',
			'buy_a_car.details_screen.location' => 'الموقع',
			'buy_a_car.details_screen.call_now' => 'اتصل الآن',
			'buy_a_car.details_screen.chat' => 'دردشة',
			'buy_a_car.details_screen.condition.excellent' => 'ممتازة',
			'buy_a_car.details_screen.condition.good' => 'جيدة',
			'buy_a_car.details_screen.condition.fair' => 'مقبولة',
			'buy_a_car.details_screen.condition.poor' => 'ضعيفة',
			'buy_a_car.details_screen.condition.damaged' => 'تالفة',
			'buy_a_car.details_screen.error_open_report' => 'تعذر فتح تقرير الفحص',
			'buy_a_car.car_chat.title' => 'تويوتا لاند كروزر 300',
			'buy_a_car.car_chat.this_message_relates_to' => 'هذه الرسالة تتعلق بـ:',
			'buy_a_car.car_chat.buy_a_car' => 'شراء سيارة',
			'buy_a_car.car_chat.inspection_report_pdf' => 'تقريرالفحص.pdf',
			'buy_a_car.car_chat.size_kb' => '487 كيلوبايت',
			'buy_a_car.car_chat.download' => 'تحميل',
			'buy_a_car.car_chat.inspection_report_message' => 'يرجى الاطلاع على تقرير الفحص هذا.',
			'buy_a_car.car_chat.sender_initial' => 'ر',
			'buy_a_car.car_chat.sender_name' => 'برايم كار كير',
			'buy_a_car.car_chat.you' => 'أنت',
			'buy_a_car.car_chat.type_message' => 'اكتب رسالة',
			'buy_a_car.listing_card.featured' => 'مميز',
			'buy_a_car.listing_card.inspected' => 'تم الفحص',
			'buy_a_car.listing_card.not_inspected' => 'لم يتم الفحص',
			'buy_a_car.filters.clear_all' => 'مسح الكل',
			'buy_a_car.filters.make' => 'الشركة المصنعة',
			'buy_a_car.filters.model' => 'الموديل',
			'buy_a_car.filters.trim' => 'الفئة',
			'buy_a_car.filters.year' => 'السنة',
			'buy_a_car.filters.mileage' => 'المسافة المقطوعة',
			'buy_a_car.filters.transmission' => 'ناقل الحركة',
			'buy_a_car.filters.automatic' => 'أوتوماتيك',
			'buy_a_car.filters.manual' => 'يدوي',
			'buy_a_car.filters.search_makes' => 'البحث عن الشركات المصنعة...',
			'buy_a_car.filters.no_makes_found' => 'لم يتم العثور على شركات مصنعة',
			'buy_a_car.filters.failed_to_load_makes' => 'فشل تحميل الشركات المصنعة',
			'buy_a_car.filters.select_make_first' => 'يرجى اختيار شركة مصنعة أولاً',
			'buy_a_car.filters.search_models' => 'البحث عن الموديلات...',
			'buy_a_car.filters.no_models_found' => 'لم يتم العثور على موديلات',
			'buy_a_car.filters.failed_to_load_models' => 'فشل تحميل الموديلات',
			'buy_a_car.filters.select_model_first' => 'يرجى اختيار موديل أولاً',
			'buy_a_car.filters.search_trims' => 'البحث عن الفئات...',
			'buy_a_car.filters.no_trims_available' => 'لا توجد فئات متاحة',
			'buy_a_car.filters.no_trims_found' => 'لم يتم العثور على فئات',
			'buy_a_car.filters.failed_to_load_trims' => 'فشل تحميل الفئات',
			'buy_a_car.filters.from_year' => 'من سنة',
			_ => null,
		} ?? switch (path) {
			'buy_a_car.filters.to_year' => 'إلى سنة',
			'buy_a_car.filters.select_year' => 'اختر السنة',
			'buy_a_car.filters.any' => 'أي',
			'buy_a_car.filters.failed_to_load_years' => 'فشل تحميل السنوات',
			'buy_a_car.filters.mileage_any' => 'أي',
			'buy_a_car.filters.under_50k' => 'أقل من 50,000 كم',
			'buy_a_car.filters.range_50k_100k' => '50,000 - 100,000 كم',
			'buy_a_car.filters.range_100k_150k' => '100,000 - 150,000 كم',
			'buy_a_car.filters.over_150k' => '150,000+ كم',
			'reviews.screen_title' => 'إرسال تقييم',
			'reviews.rate_service' => 'قيم الخدمة',
			'reviews.your_review' => 'تقييمك',
			'reviews.review_placeholder' => 'شارك تجربتك مع هذه الخدمة...',
			'reviews.character_count' => '/5000',
			'reviews.submit_review' => 'إرسال التقييم',
			'reviews.submitting' => 'جاري الإرسال...',
			'reviews.success_message' => 'تم إرسال التقييم بنجاح!',
			'reviews.error_already_reviewed' => 'لقد قمت بالفعل بتقييم هذا الطلب',
			'reviews.error_validation' => 'يرجى التحقق من إدخالك والمحاولة مرة أخرى',
			'reviews.error_network' => 'خطأ في الشبكة. يرجى المحاولة مرة أخرى',
			'reviews.display.title' => 'التقييمات',
			'reviews.display.review' => 'التقييم',
			'reviews.display.filter_all' => 'الكل',
			'reviews.display.filter_5_stars' => '5★',
			'reviews.display.filter_4_stars' => '4★',
			'reviews.display.filter_3_stars' => '3★',
			'reviews.display.filter_2_stars' => '2★',
			'reviews.display.filter_1_star' => '1★',
			'reviews.display.sort_most_recent' => 'الأحدث',
			'reviews.display.sort_highest' => 'الأعلى',
			'reviews.display.sort_lowest' => 'الأقل',
			'reviews.display.verified_badge' => 'موثق',
			'reviews.display.empty_state_title' => 'لا توجد تقييمات بعد',
			'reviews.display.empty_state_message' => 'كن أول من يترك تقييمًا!',
			'reviews.display.load_more' => 'تحميل المزيد',
			'user_dashboard.profile.greeting' => 'مرحبًا {name}!',
			'user_dashboard.profile.guest' => 'ضيف',
			'user_dashboard.profile.guest_initial' => 'ض',
			'user_dashboard.profile.location' => 'الكويت',
			'user_dashboard.menu.wallet' => 'المحفظة',
			'user_dashboard.menu.orders' => 'الطلبات',
			'user_dashboard.menu.listings' => 'الإعلانات',
			'user_dashboard.menu.loyalty_program' => 'برنامج الولاء',
			'user_dashboard.wallet.screen_title' => 'محفظة موتيفا',
			'user_dashboard.wallet.encrypted' => 'جميع البيانات مشفرة',
			'user_dashboard.wallet.total' => 'الإجمالي (د.ك):',
			'user_dashboard.wallet.use_now' => 'استخدمها الآن',
			'user_dashboard.wallet.history' => 'السجل',
			'user_dashboard.wallet.use_reward_balance' => 'استخدم رصيد المكافآت',
			'user_dashboard.wallet.coming_soon' => 'قريباً',
			'user_dashboard.wallet.coming_soon_message' => 'يمكن استخدام رصيد المحفظة للمدفوعات — قريباً!',
			'user_dashboard.wallet.no_transactions' => 'لا توجد معاملات بعد',
			'user_dashboard.wallet.error_loading' => 'فشل تحميل بيانات المحفظة',
			'user_dashboard.wallet.available_balance' => 'الرصيد المتاح',
			'user_dashboard.wallet.failed_to_load_balance' => 'فشل تحميل الرصيد',
			'user_dashboard.wallet.credit' => 'دائن',
			'user_dashboard.wallet.debit' => 'مدين',
			'user_dashboard.wallet.balance_available' => 'الرصيد المتاح',
			'user_dashboard.wallet.retry' => 'إعادة المحاولة',
			'user_dashboard.wallet.reference_types.order' => 'دفعة الطلب',
			'user_dashboard.wallet.reference_types.refund' => 'استرداد',
			'user_dashboard.wallet.reference_types.voucher' => 'استرداد القسيمة',
			'user_dashboard.wallet.reference_types.adjustment' => 'تعديل',
			'user_dashboard.wallet.reference_types.admin' => 'رصيد إداري',
			'user_dashboard.wallet.reference_types.payout_hold' => 'حجز السحب',
			'user_dashboard.wallet.reference_types.payout_release' => 'إلغاء حجز السحب',
			'user_dashboard.wallet.reference_types.product_order' => 'طلب منتج',
			'user_dashboard.wallet.transaction_details.description' => 'الوصف',
			'user_dashboard.wallet.transaction_details.reference_id' => 'رقم المرجع',
			'user_dashboard.wallet.transaction_details.type' => 'النوع',
			'user_dashboard.wallet.transaction_details.date' => 'التاريخ',
			'user_dashboard.wallet.reward_cards.buy_a_car' => 'شراء سيارة',
			'user_dashboard.wallet.reward_cards.car_accessories' => 'اكسسوارات السيارات',
			'user_dashboard.wallet.reward_cards.spare_parts' => 'قطع الغيار',
			'user_dashboard.wallet.transaction.compensation' => 'تعويض',
			'user_dashboard.wallet.transaction.used' => 'مستخدم',
			'user_dashboard.wallet.months.jan' => 'يناير',
			'user_dashboard.wallet.months.feb' => 'فبراير',
			'user_dashboard.wallet.months.mar' => 'مارس',
			'user_dashboard.wallet.months.apr' => 'أبريل',
			'user_dashboard.wallet.months.may' => 'مايو',
			'user_dashboard.wallet.months.jun' => 'يونيو',
			'user_dashboard.wallet.months.jul' => 'يوليو',
			'user_dashboard.wallet.months.aug' => 'أغسطس',
			'user_dashboard.wallet.months.sep' => 'سبتمبر',
			'user_dashboard.wallet.months.oct' => 'أكتوبر',
			'user_dashboard.wallet.months.nov' => 'نوفمبر',
			'user_dashboard.wallet.months.dec' => 'ديسمبر',
			'user_dashboard.wallet.detail_labels.service_type' => 'نوع الخدمة',
			'user_dashboard.wallet.detail_labels.vendor_name' => 'اسم البائع',
			'user_dashboard.wallet.detail_labels.liters' => 'لترات',
			'user_dashboard.wallet.detail_labels.order_id' => 'رقم الطلب',
			'user_dashboard.wallet.detail_labels.status' => 'الحالة',
			'user_dashboard.orders.screen_title' => 'الطلبات',
			'user_dashboard.orders.search_hint' => 'البحث عن طلبات...',
			'user_dashboard.orders.filter_all' => 'الكل',
			'user_dashboard.orders.filter_service' => 'خدمة',
			'user_dashboard.orders.filter_product' => 'منتج',
			'user_dashboard.orders.tab_all' => 'الكل',
			'user_dashboard.orders.tab_active' => 'نشط',
			'user_dashboard.orders.tab_completed' => 'مكتمل',
			'user_dashboard.orders.service_details' => 'تفاصيل الخدمة متاحة في العرض الكامل',
			'user_dashboard.orders.empty.no_results' => 'لم يتم العثور على نتائج',
			'user_dashboard.orders.empty.no_tab_orders' => 'لا توجد طلبات {tabName}',
			'user_dashboard.orders.empty.adjust_search' => 'حاول تعديل مصطلحات البحث.',
			'user_dashboard.orders.empty.orders_appear_here' => 'ستظهر الطلبات هنا بمجرد توفرها.',
			'user_dashboard.orders.error.title' => 'خطأ في تحميل الطلبات',
			'user_dashboard.orders.error.retry' => 'إعادة المحاولة',
			'user_dashboard.orders.card.service_order' => 'طلب خدمة',
			'user_dashboard.orders.card.product_order' => 'طلب منتج',
			'user_dashboard.orders.card.fallback_service' => 'خدمة',
			'user_dashboard.orders.card.fallback_vendor' => 'بائع',
			'user_dashboard.orders.card.item' => 'عنصر',
			'user_dashboard.orders.card.items' => 'عناصر',
			'user_dashboard.orders.card.reference' => 'المرجع',
			'user_dashboard.orders.card.amount' => 'المبلغ',
			'user_dashboard.orders.card.time' => 'الوقت',
			'user_dashboard.orders.card.order_id' => 'رقم الطلب',
			'user_dashboard.orders.card.date' => 'التاريخ',
			'user_dashboard.orders.card.delivery_address' => 'عنوان التوصيل',
			'user_dashboard.orders.card.order_summary' => 'ملخص الطلب',
			'user_dashboard.orders.card.download_receipt' => 'تحميل الإيصال',
			'user_dashboard.orders.card.subtotal' => 'المجموع الفرعي',
			'user_dashboard.orders.card.total' => 'الإجمالي',
			'user_dashboard.orders.card.payment_method' => 'طريقة الدفع',
			'user_dashboard.orders.card.failed_details' => 'فشل تحميل التفاصيل: {error}',
			'user_dashboard.orders.card.more_items' => '+ {count} إضافي',
			'user_dashboard.orders.card.view_details' => 'عرض التفاصيل',
			'user_dashboard.orders.card.add_review' => 'إضافة تقييم',
			'user_dashboard.orders.status.pending' => 'معلق',
			'user_dashboard.orders.status.accepted' => 'مقبول',
			'user_dashboard.orders.status.on_the_way' => 'في الطريق',
			'user_dashboard.orders.status.arrived' => 'وصل',
			'user_dashboard.orders.status.in_progress' => 'قيد التنفيذ',
			'user_dashboard.orders.status.completed' => 'مكتمل',
			'user_dashboard.orders.status.rejected' => 'مرفوض',
			'user_dashboard.orders.status.cancelled' => 'ملغى',
			'user_dashboard.orders.status.processing' => 'قيد المعالجة',
			'user_dashboard.orders.status.confirmed' => 'مؤكد',
			'user_dashboard.orders.status.shipped' => 'تم الشحن',
			'user_dashboard.orders.status.delivered' => 'تم التسليم',
			'user_dashboard.orders.details.screen_title' => 'تفاصيل الطلب',
			'user_dashboard.orders.details.service_specifications' => 'مواصفات الخدمة',
			'user_dashboard.orders.details.your_details' => 'تفاصيلك',
			'user_dashboard.orders.details.failed_to_load' => 'فشل تحميل الطلب',
			'user_dashboard.orders.details.unknown_service' => 'خدمة غير معروفة',
			'user_dashboard.orders.details.unknown_vendor' => 'بائع غير معروف',
			'user_dashboard.orders.details.order_information' => 'معلومات الطلب',
			'user_dashboard.orders.details.order_reference' => 'الرقم المرجعي',
			'user_dashboard.orders.details.service' => 'الخدمة',
			'user_dashboard.orders.details.vendor' => 'البائع',
			'user_dashboard.orders.details.base_amount' => 'المبلغ الأساسي',
			'user_dashboard.orders.details.total_amount' => 'المبلغ الإجمالي',
			'user_dashboard.orders.details.scheduled_date_time' => 'التاريخ والوقت المجدول',
			'user_dashboard.orders.details.date' => 'التاريخ',
			'user_dashboard.orders.details.time' => 'الوقت',
			'user_dashboard.orders.details.service_location' => 'موقع الخدمة',
			'user_dashboard.orders.details.open_in_maps' => 'فتح في الخرائط',
			'user_dashboard.orders.details.timeline' => 'الجدول الزمني',
			'user_dashboard.orders.details.order_placed' => 'تم تقديم الطلب',
			'user_dashboard.orders.details.vendor_accepted' => 'قبول البائع',
			'user_dashboard.orders.details.service_completed' => 'اكتمال الخدمة',
			'user_dashboard.orders.details.order_cancelled' => 'تم إلغاء الطلب',
			'user_dashboard.orders.details.documents' => 'المستندات',
			'user_dashboard.orders.details.document' => 'مستند',
			'user_dashboard.orders.details.rejection_reason' => 'سبب الرفض',
			'user_dashboard.orders.details.cancellation_reason' => 'سبب الإلغاء',
			'user_dashboard.orders.details.call_vendor' => 'اتصل بالبائع',
			'user_dashboard.orders.details.write_review' => 'كتابة تقييم',
			'user_dashboard.orders.details.book_again' => 'حجز مرة أخرى',
			'user_dashboard.orders.details.phone_not_available' => 'رقم هاتف البائع غير متوفر',
			'user_dashboard.orders.details.could_not_launch_dialer' => 'تعذر فتح برنامج الاتصال',
			'user_dashboard.orders.details.review_coming_soon' => 'ميزة التقييم قريباً',
			'user_dashboard.orders.details.screen_title_product' => 'تفاصيل الطلب',
			'user_dashboard.orders.details.order_date' => 'تاريخ الطلب',
			'user_dashboard.orders.details.order_items' => 'عناصر الطلب',
			'user_dashboard.orders.details.quantity_label' => 'الكمية: {qty}',
			'user_dashboard.orders.details.payment_summary' => 'ملخص الدفع',
			'user_dashboard.orders.details.order_updated' => 'تم تحديث الطلب',
			'user_dashboard.active_orders_preview.empty_title' => 'لا توجد طلبات نشطة',
			'user_dashboard.active_orders_preview.empty_subtitle' => 'ستظهر طلبات الخدمة النشطة هنا.',
			'user_dashboard.active_orders_preview.section_title' => 'طلباتي النشطة',
			'user_dashboard.active_orders_preview.view_all' => 'عرض الكل',
			'user_dashboard.active_orders_preview.unknown_service' => 'خدمة غير معروفة',
			'user_dashboard.active_orders_preview.unknown_vendor' => 'بائع غير معروف',
			'user_dashboard.active_orders_preview.time_ago.just_now' => 'الآن',
			'user_dashboard.active_orders_preview.time_ago.minutes_ago' => '{n}د مضت',
			'user_dashboard.active_orders_preview.time_ago.hours_ago' => '{n}س مضت',
			'user_dashboard.active_orders_preview.time_ago.days_ago' => '{n}ي مضت',
			'user_dashboard.loyalty.screen_title' => 'برنامج الولاء',
			'user_dashboard.loyalty.points_balance' => 'رصيد النقاط',
			'user_dashboard.loyalty.points' => 'نقاط',
			'user_dashboard.loyalty.progress_to_reward' => 'التقدم نحو المكافأة',
			'user_dashboard.loyalty.of_points_to_reward' => '{current} من {total} نقطة للمكافأة التالية',
			'user_dashboard.loyalty.redeem_points' => 'استبدال النقاط',
			'user_dashboard.loyalty.transactions' => 'المعاملات',
			'user_dashboard.loyalty.earn' => 'كسب',
			'user_dashboard.loyalty.redeem' => 'استبدال',
			'user_dashboard.loyalty.expire' => 'انتهاء',
			'user_dashboard.loyalty.adjust' => 'تعديل',
			'user_dashboard.loyalty.empty_title' => 'لا توجد معاملات بعد',
			'user_dashboard.loyalty.empty_subtitle' => 'ستظهر معاملات الولاء هنا.',
			'user_dashboard.loyalty.error_title' => 'فشل التحميل',
			'user_dashboard.loyalty.retry' => 'إعادة المحاولة',
			'user_dashboard.listings.screen_title' => 'الإعلانات',
			'user_dashboard.listings.search_hint' => 'البحث عن سيارة معلنة',
			'user_dashboard.listings.error.failed_to_load' => 'فشل تحميل الإعلانات',
			'user_dashboard.listings.error.retry' => 'إعادة المحاولة',
			'user_dashboard.listings.empty.no_results' => 'لم يتم العثور على نتائج',
			'user_dashboard.listings.empty.no_listings_yet' => 'لا توجد إعلانات بعد',
			'user_dashboard.listings.empty.no_match' => 'لا توجد إعلانات مطابقة.',
			'user_dashboard.listings.empty.appear_here' => 'ستظهر إعلانات سياراتك هنا',
			'user_dashboard.listings.card.featured' => 'مميز',
			'user_dashboard.listings.card.inspected' => 'تم الفحص',
			'user_dashboard.listings.card.not_inspected' => 'لم يتم الفحص',
			'user_dashboard.listing_details.screen_title' => 'عن هذه السيارة',
			'user_dashboard.listing_details.featured' => 'مميز',
			'user_dashboard.listing_details.price_on_request' => 'السعر عند الطلب',
			'user_dashboard.listing_details.inspected' => 'تم الفحص',
			'user_dashboard.listing_details.not_inspected' => 'لم يتم الفحص',
			'user_dashboard.listing_details.view_details' => 'عرض التفاصيل',
			'user_dashboard.listing_details.unknown_location' => 'موقع غير معروف',
			'user_dashboard.listing_details.time_ago.just_now' => 'الآن',
			'user_dashboard.listing_details.time_ago.minutes_ago' => '{n} دقيقة/دقائق مضت',
			'user_dashboard.listing_details.time_ago.hours_ago' => '{n} ساعة/ساعات مضت',
			'user_dashboard.listing_details.time_ago.days_ago' => '{n} يوم/أيام مضت',
			'user_dashboard.listing_details.time_ago.months_ago' => '{n} شهر/أشهر مضت',
			'user_dashboard.listing_details.inspection.title' => 'تقرير الفحص',
			'user_dashboard.listing_details.inspection.has_report_desc' => 'قم بتنزيل وعرض\n تقرير الفحص لهذه السيارة.',
			'user_dashboard.listing_details.inspection.no_report_desc' => 'لا يوجد تقرير فحص\n متاح لهذه السيارة.',
			'user_dashboard.listing_details.inspection.view_report' => 'عرض تقرير الفحص',
			'user_dashboard.listing_details.specifications.title' => 'المواصفات',
			'user_dashboard.listing_details.specifications.edit' => 'تعديل',
			'user_dashboard.listing_details.specifications.labels.make' => 'الشركة المصنعة',
			'user_dashboard.listing_details.specifications.labels.model' => 'الموديل',
			'user_dashboard.listing_details.specifications.labels.trim' => 'الفئة',
			'user_dashboard.listing_details.specifications.labels.year' => 'السنة',
			'user_dashboard.listing_details.specifications.labels.mileage' => 'المسافة المقطوعة',
			'user_dashboard.listing_details.specifications.labels.transmission' => 'ناقل الحركة',
			'user_dashboard.listing_details.specifications.labels.engine' => 'المحرك',
			'user_dashboard.listing_details.specifications.labels.color' => 'اللون',
			'user_dashboard.listing_details.specifications.na' => 'غير متاح',
			'user_dashboard.listing_details.description.title' => 'الوصف',
			'user_dashboard.listing_details.description.no_description' => 'لا يوجد وصف متاح.',
			'user_dashboard.listing_details.description.edit_dialog_title' => 'تعديل الوصف',
			'user_dashboard.listing_details.description.edit_dialog_hint' => 'أدخل وصفًا جديدًا...',
			'user_dashboard.listing_details.description.cancel' => 'إلغاء',
			'user_dashboard.listing_details.description.save' => 'حفظ',
			'user_dashboard.listing_details.save_button' => 'حفظ',
			'user_dashboard.edit_specs.screen_title' => 'تعديل المواصفات',
			'user_dashboard.edit_specs.steps.make' => 'الشركة المصنعة',
			'user_dashboard.edit_specs.steps.model' => 'الموديل',
			'user_dashboard.edit_specs.steps.trim' => 'الفئة',
			'user_dashboard.edit_specs.steps.year' => 'السنة',
			'user_dashboard.edit_specs.steps.mileage' => 'المسافة المقطوعة',
			'user_dashboard.edit_specs.steps.transmission' => 'ناقل الحركة',
			'user_dashboard.edit_specs.steps.color' => 'اللون',
			'user_dashboard.edit_specs.save_button_loading' => 'جاري الحفظ...',
			'user_dashboard.edit_specs.save_button' => 'حفظ التغييرات',
			'user_dashboard.edit_specs.validation.complete_all_fields' => 'يرجى إكمال جميع الحقول',
			'user_dashboard.notifications.screen_title' => 'الإشعارات',
			'user_dashboard.notifications.read_all' => 'قراءة الكل',
			'user_dashboard.notifications.tab_all' => 'الكل',
			'user_dashboard.notifications.tab_orders' => 'الطلبات',
			'user_dashboard.notifications.tab_offers' => 'العروض',
			'user_dashboard.notifications.tab_system' => 'النظام',
			'user_dashboard.notifications.empty.title' => 'ليس هناك جديد!',
			'user_dashboard.notifications.empty.subtitle' => 'لا توجد إشعارات جديدة للعرض.',
			'user_dashboard.settings.screen_title' => 'الإعدادات',
			'user_dashboard.settings.search_hint' => 'البحث في الإعدادات',
			'user_dashboard.settings.not_found' => 'لم يتم العثور على إعدادات',
			'user_dashboard.settings.menu.account_info' => 'معلومات الحساب',
			'user_dashboard.settings.menu.saved_addresses' => 'العناوين المحفوظة',
			'user_dashboard.settings.menu.change_email' => 'تغيير البريد الإلكتروني',
			'user_dashboard.settings.menu.change_password' => 'تغيير كلمة المرور',
			'user_dashboard.settings.menu.country' => 'الدولة',
			'user_dashboard.settings.menu.notifications' => 'الإشعارات',
			'user_dashboard.settings.menu.language' => 'اللغة',
			'user_dashboard.settings.menu.app_mode' => 'وضع التطبيق',
			'user_dashboard.settings.menu.logout' => 'تسجيل الخروج',
			'user_dashboard.settings.menu.delete_account' => 'حذف الحساب',
			'user_dashboard.settings.delete_account_confirm.title' => 'حذف الحساب؟',
			'user_dashboard.settings.delete_account_confirm.message' => 'هل أنت متأكد من أنك تريد حذف حسابك؟ هذا الإجراء دائم ولا يمكن التراجع عنه.',
			'user_dashboard.settings.delete_account_confirm.confirm' => 'حذف',
			'user_dashboard.settings.delete_account_confirm.cancel' => 'إلغاء',
			'user_dashboard.settings.delete_account_confirm.error' => 'فشل حذف الحساب. يرجى المحاولة مرة أخرى.',
			'user_dashboard.settings.account_info.screen_title' => 'معلومات الحساب',
			'user_dashboard.settings.account_info.edit' => 'تعديل',
			'user_dashboard.settings.account_info.fields.first_name' => 'الاسم الأول',
			'user_dashboard.settings.account_info.fields.last_name' => 'اسم العائلة',
			'user_dashboard.settings.account_info.fields.email' => 'البريد الإلكتروني',
			'user_dashboard.settings.account_info.fields.date_of_birth' => 'تاريخ الميلاد',
			'user_dashboard.settings.account_info.fields.phone_number' => 'رقم الهاتف',
			'user_dashboard.settings.account_info.gender.title' => 'الجنس',
			'user_dashboard.settings.account_info.gender.male' => 'ذكر',
			'user_dashboard.settings.account_info.gender.female' => 'أنثى',
			'user_dashboard.settings.account_info.preferences.receive_offers' => 'نعم، أريد تلقي العروض والخصومات',
			'user_dashboard.settings.account_info.preferences.newsletter' => 'الاشتراك في النشرة الإخبارية',
			'user_dashboard.settings.account_info.delete_account' => 'حذف الحساب',
			'user_dashboard.settings.change_email.screen_title' => 'تغيير البريد الإلكتروني',
			'user_dashboard.settings.change_email.field_hint' => 'عنوان البريد الإلكتروني الجديد',
			'user_dashboard.settings.change_email.validation_error' => 'يرجى إدخال عنوان بريد إلكتروني صالح',
			'user_dashboard.settings.change_email.confirm_button_loading' => 'جاري التأكيد...',
			'user_dashboard.settings.change_email.confirm_button' => 'تأكيد',
			'user_dashboard.settings.change_email.success' => 'تم تحديث البريد الإلكتروني بنجاح',
			'user_dashboard.settings.change_email.error' => 'فشل تحديث البريد الإلكتروني. يرجى المحاولة مرة أخرى.',
			'user_dashboard.settings.change_password.screen_title' => 'تغيير كلمة المرور',
			'user_dashboard.settings.change_password.fields.current_password' => 'كلمة المرور الحالية',
			'user_dashboard.settings.change_password.fields.new_password' => 'كلمة المرور الجديدة',
			'user_dashboard.settings.change_password.fields.confirm_password' => 'تأكيد كلمة المرور الجديدة',
			'user_dashboard.settings.change_password.validation.current_required' => 'كلمة المرور الحالية مطلوبة',
			'user_dashboard.settings.change_password.validation.min_length' => 'يجب أن تكون كلمة المرور 8 أحرف على الأقل',
			'user_dashboard.settings.change_password.validation.match' => 'كلمات المرور غير متطابقة',
			'user_dashboard.settings.change_password.button_loading' => 'جاري التغيير...',
			'user_dashboard.settings.change_password.button' => 'تغيير كلمة المرور',
			'user_dashboard.settings.change_password.success' => 'تم تغيير كلمة المرور بنجاح.',
			'user_dashboard.settings.change_password.error' => 'فشل تغيير كلمة المرور. يرجى المحاولة مرة أخرى.',
			'user_dashboard.settings.language.title' => 'اللغة',
			'user_dashboard.settings.language.english' => 'الإنجليزية',
			'user_dashboard.settings.language.arabic' => 'العربية',
			'user_dashboard.settings.app_mode.title' => 'وضع التطبيق',
			'user_dashboard.settings.app_mode.dark' => 'داكن',
			'user_dashboard.settings.app_mode.light' => 'فاتح',
			'user_dashboard.settings.country.title' => 'الدولة',
			'user_dashboard.settings.country.kuwait' => 'الكويت',
			'user_dashboard.settings.country.bahrain' => 'البحرين',
			'user_dashboard.settings.country.uae' => 'الإمارات العربية المتحدة',
			'user_dashboard.settings.country.oman' => 'عمان',
			'user_dashboard.settings.country.qatar' => 'قطر',
			'user_dashboard.settings.country.saudi_arabia' => 'المملكة العربية السعودية',
			'user_dashboard.settings.saved_addresses.screen_title' => 'العناوين',
			'user_dashboard.settings.saved_addresses.add_button' => 'إضافة',
			'user_dashboard.settings.saved_addresses.empty_title' => 'لا توجد عناوين محفوظة',
			'user_dashboard.settings.saved_addresses.add_new_button' => 'إضافة عنوان جديد',
			'user_dashboard.settings.notification_preferences.screen_title' => 'تفضيلات الإشعارات',
			'user_dashboard.settings.notification_preferences.order_updates' => 'تحديثات الطلبات',
			'user_dashboard.settings.notification_preferences.promotions' => 'العروض الترويجية',
			'user_dashboard.settings.verify_email_otp.title' => 'التحقق من البريد الإلكتروني',
			'user_dashboard.settings.verify_email_otp.sent_code' => 'لقد أرسلنا رمزًا إلى ',
			'user_dashboard.settings.verify_email_otp.otp_error' => 'يرجى إدخال رمز التحقق الكامل',
			'user_dashboard.settings.verify_email_otp.verify_button_loading' => 'جاري التحقق...',
			'user_dashboard.settings.verify_email_otp.verify_button' => 'تحقق',
			'user_dashboard.settings.verify_email_otp.success' => 'تم تحديث البريد الإلكتروني بنجاح',
			'user_dashboard.settings.verify_email_otp.error' => 'فشل تحديث البريد الإلكتروني. يرجى المحاولة مرة أخرى.',
			'user_dashboard.settings.verify_email_otp.otp_sent' => 'تم إرسال الرمز بنجاح',
			'user_dashboard.settings.verify_email_otp.resend.did_not_receive' => 'لم تستلم الرمز؟ ',
			'user_dashboard.settings.verify_email_otp.resend.resend_in' => 'إعادة الإرسال خلال {time}',
			'user_dashboard.settings.verify_email_otp.resend.resend_button' => 'إعادة إرسال',
			'user_dashboard.settings.edit_address.edit_title' => 'تعديل العنوان',
			'user_dashboard.settings.edit_address.add_title' => 'إضافة عنوان',
			'user_dashboard.settings.edit_address.delete' => 'حذف',
			'user_dashboard.settings.edit_address.delete_dialog.title' => 'حذف العنوان',
			'user_dashboard.settings.edit_address.delete_dialog.description' => 'هل أنت متأكد أنك تريد حذف هذا العنوان؟',
			'user_dashboard.settings.edit_address.delete_dialog.yes' => 'نعم',
			'user_dashboard.settings.edit_address.delete_dialog.no' => 'لا',
			'user_dashboard.settings.edit_address.validation.required_fields' => 'يرجى ملء الحقول المطلوبة',
			'user_dashboard.settings.edit_address.area.label' => 'المنطقة',
			'user_dashboard.settings.edit_address.area.hint' => 'اضغط تغيير لتحديد المنطقة',
			'user_dashboard.settings.edit_address.area.change_button' => 'تغيير',
			'user_dashboard.settings.edit_address.area.dialog_title' => 'المنطقة',
			'user_dashboard.settings.edit_address.area.dialog_hint' => 'أدخل المنطقة',
			'user_dashboard.settings.edit_address.area.cancel' => 'إلغاء',
			'user_dashboard.settings.edit_address.area.ok' => 'موافق',
			'user_dashboard.settings.edit_address.property_types.apartment' => 'شقة',
			'user_dashboard.settings.edit_address.property_types.house' => 'منزل',
			'user_dashboard.settings.edit_address.property_types.office' => 'مكتب',
			'user_dashboard.settings.edit_address.fields.address_title' => 'عنوان العنوان',
			'user_dashboard.settings.edit_address.fields.building_name' => 'اسم المبنى',
			'user_dashboard.settings.edit_address.fields.apt_number' => 'رقم الشقة',
			'user_dashboard.settings.edit_address.fields.street' => 'الشارع',
			'user_dashboard.settings.edit_address.fields.block' => 'القطعة',
			'user_dashboard.settings.edit_address.fields.avenue_optional' => 'الجادة (اختياري)',
			'user_dashboard.settings.edit_address.fields.directions_optional' => 'اتجاهات إضافية (اختياري)',
			'user_dashboard.settings.edit_address.fields.phone_number' => 'رقم الهاتف',
			'user_dashboard.settings.edit_address.fields.address_label_optional' => 'تسمية العنوان (اختياري)',
			'user_dashboard.settings.edit_address.save_button' => 'حفظ العنوان',
			'user_dashboard.settings.edit_address.default_label' => 'عنوان',
			'user_dashboard.settings.address_tile.block' => 'قطعة {n}',
			'user_dashboard.settings.address_tile.building' => 'مبنى {n}',
			'user_dashboard.settings.address_tile.apt' => 'شقة {n}',
			'user_dashboard.settings.address_tile.mobile_number' => 'رقم الجوال: {n}',
			'bottom_nav.customer.home' => 'الرئيسية',
			'bottom_nav.customer.services' => 'الخدمات',
			'bottom_nav.customer.offers' => 'العروض',
			'bottom_nav.customer.cart' => 'السلة',
			'bottom_nav.customer.profile' => 'الملف الشخصي',
			'bottom_nav.vendor.home' => 'الرئيسية',
			'bottom_nav.vendor.listings' => 'القوائم',
			'bottom_nav.vendor.orders' => 'الطلبات',
			'bottom_nav.vendor.operator' => 'المشغل',
			'bottom_nav.vendor.profile' => 'الملف الشخصي',
			'bottom_nav.operator.home' => 'الرئيسية',
			'bottom_nav.operator.orders' => 'الطلبات',
			'bottom_nav.operator.profile' => 'الملف الشخصي',
			'sell_your_car.screens.condition_car.title' => 'بيع سياراتك',
			'sell_your_car.screens.condition_car.subtitle' => 'لدينا عروض بانتظارك',
			'sell_your_car.screens.sell_a_car.title' => 'بيع سيارة',
			'sell_your_car.screens.sell_a_car.subtitle' => 'لدينا عروض بانتظارك',
			'sell_your_car.screens.sell_or_buy_car.title' => 'بيع أو شراء سياراتك',
			'sell_your_car.screens.sell_or_buy_car.subtitle' => 'بيع وشراء سيارتك بسرعة وسهولة',
			'sell_your_car.screens.fast_track_condition.title' => 'بيع سريع للسيارة',
			'sell_your_car.screens.fast_track_condition.subtitle' => 'لدينا عروض بانتظارك',
			'sell_your_car.screens.fast_track_sale.title' => 'بيع سريع للسيارة',
			'sell_your_car.screens.fast_track_sale.subtitle' => 'لدينا عروض بانتظارك',
			'sell_your_car.screens.fast_track_sale.description_title' => 'الوصف',
			'sell_your_car.screens.fast_track_sale.description' => 'تم تصميم البيع السريع للسيارة لأولئك الذين يحتاجون لبيع سيارتهم بسرعة وكفاءة. من خلال الإدراج بسعر مخفض، يمكن بيع سيارتك في غضون 15 ساعة. بمجرد موافقتك على العرض، سيتولى فريقنا العملية، مما يضمن معاملة سلسة وسهلة. سيتواصل معك أحد الممثلين لإنهاء البيع بعد موافقتك.',
			'sell_your_car.screens.fast_track_sale.terms_title' => 'الشروط والأحكام',
			'sell_your_car.screens.fast_track_sale.terms_intro' => 'باستخدام خدمات إدراج السيارات لدينا، فإنك توافق على الشروط والأحكام التالية:',
			'sell_your_car.screens.fast_track_sale.bullet_1' => 'يجب أن تكون السيارات المدرجة ضمن البيع السريع مخفضة بنسبة 30% عن أقل قيمة سوقية.',
			'sell_your_car.screens.fast_track_sale.bullet_2' => 'رسوم الإدراج غير قابلة للاسترداد.',
			'sell_your_car.screens.fast_track_sale.bullet_3' => 'تخضع المعاملات لرسوم 5% على كل من البائع والمشتري.',
			'sell_your_car.screens.fast_track_sale.bullet_4' => 'يجب على البائع الموافقة على العرض والشروط قبل المتابعة.',
			'sell_your_car.screens.fast_track_sale.bullet_5' => 'تصبح القوائم والعروض سارية فقط بعد موافقة موتيفا.',
			'sell_your_car.screens.fast_track_sale.approve_checkbox' => 'نعم، أوافق على شروط وأحكام موتيفا الخاصة بالبيع السريع للسيارة.',
			'sell_your_car.screens.fast_track_sale.kContinue' => 'متابعة',
			'sell_your_car.screens.open_an_auction.title' => 'افتح مزاد',
			'sell_your_car.screens.open_an_auction.subtitle' => 'بيع سريع من خلال المزاد',
			'sell_your_car.screens.open_an_auction.description_title' => 'الوصف',
			'sell_your_car.screens.open_an_auction.description' => 'أدرج سيارتك للبيع بسهولة باستخدام منصتنا. اختر من بين خيارات العادي، أو المزاد، أو البيع السريع للعثور على مشترين بسرعة وأمان. اختر الإضافات مثل تقرير الفحص لتعزيز مصداقية إدراجك. يضمن البيع السريع بيعًا مضمونًا في غضون 15 ساعة بسعر أقل بنسبة 30% من أقل سعر سوقي.',
			'sell_your_car.screens.open_an_auction.terms_title' => 'الشروط والأحكام',
			'sell_your_car.screens.open_an_auction.terms_intro' => 'باستخدام خدمات إدراج السيارات لدينا، فإنك توافق على الشروط والأحكام التالية:',
			'sell_your_car.screens.open_an_auction.bullet_1' => 'يجب أن تكون جميع تفاصيل السيارة دقيقة ومحدثة.',
			'sell_your_car.screens.open_an_auction.bullet_2' => 'رسوم الإدراج غير قابلة للاسترداد وتختلف حسب نوع الخدمة.',
			'sell_your_car.screens.open_an_auction.bullet_3' => 'تتطلب المبيعات السريعة خصمًا بنسبة 30% على أقل سعر سوقي.',
			'sell_your_car.screens.open_an_auction.bullet_4' => 'تنطبق رسوم معاملة 5% على كل من البائع والمشتري في حالات البيع الناجحة.',
			'sell_your_car.screens.open_an_auction.bullet_5' => 'يجب أن تكون تقارير الفحص صالحة ودقيقة.',
			'sell_your_car.screens.open_an_auction.approve_checkbox' => 'نعم، أوافق على شروط وأحكام موتيفا الخاصة بفتح المزاد.',
			'sell_your_car.screens.open_an_auction.kContinue' => 'متابعة',
			'sell_your_car.screens.car_details.title' => 'تفاصيل السيارة',
			'sell_your_car.screens.car_details.submitting_listing' => 'جاري إرسال إدراجك...',
			'sell_your_car.screens.car_details.submitting_request' => 'جاري إرسال طلبك...',
			'sell_your_car.screens.success_dialog.title' => 'نجاح!',
			'sell_your_car.screens.success_dialog.damaged_car_message' => 'تم إرسال إدراج سيارتك التالفة بنجاح.',
			'sell_your_car.screens.success_dialog.listing_created' => 'تم إنشاء الإدراج بنجاح!',
			'sell_your_car.screens.success_dialog.listing_saved' => 'تم حفظ إدراج سيارتك.',
			'sell_your_car.screens.success_dialog.ok' => 'موافق',
			'sell_your_car.screens.success_dialog.done' => 'تم',
			'sell_your_car.screens.request_received_dialog.title' => 'تم استلام الطلب!',
			'sell_your_car.screens.request_received_dialog.message' => 'تم إرسال الطلب إلى مسؤولي موتيفا — سنتواصل معك بعرض',
			'sell_your_car.screens.error_dialog.title' => 'خطأ',
			'sell_your_car.steps.make' => 'الشركة المصنعة',
			'sell_your_car.steps.model' => 'الموديل',
			'sell_your_car.steps.trim' => 'الفئة',
			'sell_your_car.steps.year' => 'السنة',
			'sell_your_car.steps.mileage' => 'المسافة المقطوعة',
			'sell_your_car.steps.selling_price' => 'سعر البيع',
			'sell_your_car.steps.car_specs' => 'مواصفات السيارة',
			'sell_your_car.steps.car_condition' => 'حالة السيارة',
			'sell_your_car.steps.colors' => 'الألوان',
			'sell_your_car.steps.images' => 'الصور',
			'sell_your_car.steps.location' => 'الموقع',
			'sell_your_car.steps.additional_info' => 'معلومات إضافية',
			'sell_your_car.steps.duration' => 'المدة',
			'sell_your_car.steps.color' => 'اللون',
			'sell_your_car.steps.image' => 'صورة',
			'sell_your_car.make_tab.title' => 'اختر شركة السيارة',
			'sell_your_car.make_tab.search_hint' => 'ابحث عن شركة السيارة',
			'sell_your_car.make_tab.no_available' => 'لا توجد شركات متاحة',
			'sell_your_car.make_tab.no_found' => 'لم يتم العثور على شركات',
			'sell_your_car.make_tab.retry' => 'إعادة المحاولة',
			'sell_your_car.model_tab.title' => 'اختر موديل السيارة',
			'sell_your_car.model_tab.search_hint' => 'ابحث عن موديل السيارة',
			'sell_your_car.model_tab.select_make_first' => 'يرجى اختيار الشركة المصنعة أولاً',
			'sell_your_car.model_tab.no_available' => 'لا توجد موديلات متاحة',
			'sell_your_car.model_tab.no_found' => 'لم يتم العثور على موديلات',
			'sell_your_car.model_tab.retry' => 'إعادة المحاولة',
			'sell_your_car.trim_tab.title' => 'اختر فئة السيارة',
			'sell_your_car.trim_tab.search_hint' => 'ابحث عن فئة السيارة',
			'sell_your_car.trim_tab.select_model_first' => 'يرجى اختيار الموديل أولاً',
			'sell_your_car.trim_tab.no_available' => 'لا توجد فئات متاحة',
			'sell_your_car.trim_tab.no_found' => 'لم يتم العثور على فئات',
			'sell_your_car.trim_tab.retry' => 'إعادة المحاولة',
			'sell_your_car.year_tab.title' => 'أدخل سنة الموديل',
			'sell_your_car.year_tab.error' => 'يرجى إدخال سنة بين 1900 و {year}',
			'sell_your_car.mileage_tab.title' => 'أدخل المسافة المقطوعة',
			'sell_your_car.mileage_tab.unit' => 'كم',
			'sell_your_car.mileage_tab.kContinue' => 'متابعة',
			'sell_your_car.selling_price_tab.title' => 'أدخل سعر البيع',
			'sell_your_car.selling_price_tab.unit' => 'د.ك',
			'sell_your_car.selling_price_tab.kContinue' => 'متابعة',
			'sell_your_car.colors_tab.title' => 'اختر ألوان سيارتك',
			'sell_your_car.colors_tab.exterior_title' => 'اختر لون الهيكل الخارجي',
			'sell_your_car.colors_tab.interior_title' => 'اختر لون المقاعد الداخلي',
			'sell_your_car.colors_tab.view_more' => 'عرض المزيد',
			'sell_your_car.colors_tab.kContinue' => 'متابعة',
			'sell_your_car.car_color.white' => 'أبيض',
			'sell_your_car.car_color.black' => 'أسود',
			'sell_your_car.car_color.orange' => 'برتقالي',
			'sell_your_car.car_color.blue' => 'أزرق',
			'sell_your_car.car_color.red' => 'أحمر',
			'sell_your_car.car_color.green' => 'أخضر',
			'sell_your_car.car_color.purple' => 'بنفسجي',
			'sell_your_car.car_color.yellow' => 'أصفر',
			'sell_your_car.car_color.aqua' => 'أزرق مائي',
			'sell_your_car.car_color.snow' => 'ثلجي',
			'sell_your_car.car_color.beige' => 'بيج',
			'sell_your_car.car_color.dim_gray' => 'رمادي داكن',
			'sell_your_car.images_tab.car_images_title' => 'تحميل صور السيارة',
			'sell_your_car.images_tab.car_images_hint' => 'أضف صور لسيارتك (الخارج، الداخل، المحرك)',
			'sell_your_car.images_tab.damage_images_title' => 'تحميل صور الأضرار',
			'sell_your_car.images_tab.damage_images_hint' => 'أضف صور تبين مناطق الضرر',
			'sell_your_car.images_tab.camera' => 'الكاميرا',
			'sell_your_car.images_tab.gallery' => 'المعرض',
			'sell_your_car.images_tab.add_photo' => 'إضافة صورة',
			'sell_your_car.images_tab.select_source' => 'اختر مصدر الصورة',
			'sell_your_car.images_tab.uploading' => 'جاري رفع الصور...',
			'sell_your_car.images_tab.skip' => 'تخطي',
			'sell_your_car.images_tab.kContinue' => 'متابعة',
			'sell_your_car.images_tab.car_label' => 'سيارة',
			'sell_your_car.images_tab.damage_label' => 'ضرر',
			'sell_your_car.images_tab.image_label' => 'صورة {number}',
			'sell_your_car.location_tab.pick_location' => 'اختر موقعك',
			_ => null,
		} ?? switch (path) {
			'sell_your_car.location_tab.select_location_title' => 'اختر الموقع',
			'sell_your_car.location_tab.select' => 'اختيار',
			'sell_your_car.location_tab.cancel' => 'إلغاء',
			'sell_your_car.location_tab.country' => 'الدولة',
			'sell_your_car.location_tab.city' => 'المدينة',
			'sell_your_car.location_tab.kContinue' => 'متابعة',
			'sell_your_car.location_tab.failed_picker' => 'فشل فتح محدد الموقع',
			'sell_your_car.inspection_report.title' => 'هل لديك تقرير فحص حديث؟',
			'sell_your_car.inspection_report.browse' => 'تصفح ',
			'sell_your_car.inspection_report.your_file' => 'ملفك',
			'sell_your_car.inspection_report.max_size' => 'يسمح بملفات حتى 10 ميجابايت',
			'sell_your_car.inspection_report.file_types' => 'PDF, JPG, PNG',
			'sell_your_car.inspection_report.uploaded_success' => 'تم الرفع بنجاح',
			'sell_your_car.inspection_report.no_report' => 'لا، ليس لدي',
			'sell_your_car.inspection_report.inspect_question' => 'هل تريد منا فحص سيارتك؟',
			'sell_your_car.inspection_report.inspect_description' => 'احصل على فحص احترافي لسيارتك لراحة البال. أضف هذه الخدمة للتحقق الشامل من أنها في أفضل حالة.',
			'sell_your_car.inspection_report.inspect_price' => '20 د.ك   + 3 نجوم',
			'sell_your_car.inspection_report.dialog_title' => 'أدخل رابط تقرير الفحص',
			'sell_your_car.inspection_report.cancel' => 'إلغاء',
			'sell_your_car.inspection_report.upload' => 'رفع',
			'sell_your_car.inspection_report.kContinue' => 'متابعة',
			'sell_your_car.inspection_report.uploading' => 'جاري رفع الملف...',
			'sell_your_car.inspection_report.file_size_error' => 'يجب أن يكون حجم الملف أقل من 10 ميجابايت',
			'sell_your_car.inspection_report.pick_error' => 'خطأ في اختيار الملف: {error}',
			'sell_your_car.inspection_report.upload_error' => 'فشل رفع الملف. يرجى المحاولة مرة أخرى.',
			'sell_your_car.inspection_report.upload_error_generic' => 'خطأ في رفع الملف: {error}',
			'sell_your_car.car_condition.chassis_title' => 'هل هناك أي مشاكل في الهيكل؟',
			'sell_your_car.car_condition.mechanical_title' => 'هل هناك أي مشاكل ميكانيكية في السيارة؟',
			'sell_your_car.car_condition.warning_lights_title' => 'هل هناك أي أضواء تحذيرية مضاءة؟',
			'sell_your_car.car_condition.tires_title' => 'ما هي حالة الإطارات؟',
			'sell_your_car.car_condition.tires_new' => 'جديد',
			'sell_your_car.car_condition.tires_good' => 'جيد',
			'sell_your_car.car_condition.tires_needs_change' => 'يحتاج تغيير',
			'sell_your_car.car_condition.runs_drives_title' => 'هل السيارة تعمل وتسير؟',
			'sell_your_car.car_condition.runs_drives_yes' => 'نعم، تعمل وتسير',
			'sell_your_car.car_condition.runs_drives_no' => 'لا، لا تعمل/تسير',
			'sell_your_car.car_condition.yes' => 'نعم',
			'sell_your_car.car_condition.no' => 'لا',
			'sell_your_car.car_condition.dont_know' => 'لا أعرف',
			'sell_your_car.car_condition.kContinue' => 'متابعة',
			'sell_your_car.description.title' => 'الوصف',
			'sell_your_car.description.hint' => 'اكتب أي تفاصيل إضافية عن سيارتك.',
			'sell_your_car.body_panel_tab.title' => 'هل هناك أي عيوب أو أضرار طفيفة في ألواح الجسم؟',
			'sell_your_car.body_panel_tab.yes' => 'نعم',
			'sell_your_car.body_panel_tab.no' => 'لا',
			'sell_your_car.body_panel_tab.dont_know' => 'لا أعرف',
			'sell_your_car.body_panel_tab.kContinue' => 'متابعة',
			'sell_your_car.paint_condition_tab.title' => 'ما هي حالة الدهان؟',
			'sell_your_car.paint_condition_tab.kContinue' => 'متابعة',
			'sell_your_car.end_tab.proceed_payment' => 'المتابعة إلى الدفع',
			'sell_your_car.engine_tab.title' => 'اختر محرك سيارتك',
			'sell_your_car.engine_tab.other' => 'أخرى',
			'sell_your_car.transmission_tab.title' => 'اختر ناقل حركة سيارتك',
			'sell_your_car.transmission_tab.manual' => 'يدوي',
			'sell_your_car.transmission_tab.automatic' => 'أوتوماتيك',
			'sell_your_car.transmission_tab.kContinue' => 'متابعة',
			'sell_your_car.additional_info.features_title' => 'اختر ميزات سيارتك',
			'sell_your_car.additional_info.feature_your_car' => 'مميزة سيارتك',
			'sell_your_car.additional_info.feature_description' => 'تمييز سيارتك سيسمح لمزيد من الأشخاص برؤيتها وبيعها بسرعة.',
			'sell_your_car.additional_info.one_week' => 'أسبوع واحد',
			'sell_your_car.additional_info.two_weeks' => 'أسبوعان',
			'sell_your_car.additional_info.one_month' => 'شهر واحد',
			'sell_your_car.additional_info.total_price' => 'السعر الإجمالي : ',
			'sell_your_car.additional_info.saving' => 'جاري الحفظ...',
			'sell_your_car.additional_info.submit_listing' => 'إرسال الإدراج',
			'sell_your_car.additional_info.listing_created' => 'تم إنشاء الإدراج بنجاح!',
			'sell_your_car.additional_info.listing_saved' => 'تم حفظ إدراج سيارتك.\nرقم الإدراج: {id}',
			'sell_your_car.additional_info.done' => 'تم',
			'sell_your_car.service_sections.all_services' => 'جميع الخدمات',
			'sell_your_car.service_sections.sell_your_car' => 'بيع سيارتك',
			'sell_your_car.service_sections.sell_a_car' => 'بيع سيارة',
			'sell_your_car.service_sections.buy_a_car' => 'شراء سيارة',
			'sell_your_car.service_sections.good_condition_car' => 'سيارة بحالة جيدة',
			'sell_your_car.service_sections.damaged_car' => 'سيارة تالفة',
			'sell_your_car.service_sections.open_an_auction' => 'افتح مزاد',
			'sell_your_car.service_sections.fast_track_car_sale' => 'بيع سريع للسيارة',
			'sell_your_car.service_sections.lorem_description' => 'لوريم إيبسوم دولور سيت أميت، كونسيكتيتور أديبيسيسينغ إليت، سيد دو إيسيمود تيمبور تيمبور',
			'sell_your_car.duration_tab.title' => 'اختر مدة المزاد',
			'sell_your_car.duration_tab.auction_start' => 'يجب أن يبدأ المزاد من',
			'sell_your_car.duration_tab.starting_price' => 'السعر الابتدائي',
			'sell_your_car.duration_tab.feature_auction' => 'تميز مزادك',
			'sell_your_car.duration_tab.feature_description' => 'تميز مزادك لزيادة الظهور والمزايدة التنافسية!',
			'sell_your_car.duration_tab.total_price' => 'السعر الإجمالي : ',
			'sell_your_car.duration_tab.days_3' => '3 أيام',
			'sell_your_car.duration_tab.days_5' => '5 أيام',
			'sell_your_car.duration_tab.days_7' => '7 أيام',
			'sell_your_car.duration_tab.kContinue' => 'متابعة',
			'sell_your_car.duration_tab.proceed_payment' => 'الاستمرار في الدفع',
			'sell_your_car.ft_duration.title' => 'اختر متى تريد استلام نقودك؟',
			'sell_your_car.ft_duration.hours_label' => 'خلال {hours} ساعة - {discount}% أقل من سعر السوق',
			'sell_your_car.ft_duration.fallback_tooltip' => 'استخدام الخيارات الافتراضية - الخادم غير متاح',
			'sell_your_car.ft_duration.failed_load' => 'فشل تحميل خيارات المدة',
			'sell_your_car.ft_duration.retry' => 'إعادة المحاولة',
			'sell_your_car.ft_duration.submit_request' => 'إرسال الطلب',
			'sell_your_car.ft_duration.total_price' => 'السعر الإجمالي : ',
			'sell_your_car.duration.title' => 'مدة المزاد',
			'sell_your_car.duration.one_day' => 'يوم واحد',
			'sell_your_car.duration.three_days' => '3 أيام',
			'sell_your_car.duration.seven_days' => '7 أيام',
			'sell_your_car.duration.kContinue' => 'متابعة',
			'vendor_dashboard.profile.not_found_title' => 'لم يتم العثور على الملف الشخصي',
			'vendor_dashboard.profile.not_found_description' => 'لم يتم إعداد ملفك الشخصي بعد. يرجى التواصل مع الدعم لإكمال تسجيلك.',
			'vendor_dashboard.profile.error_loading_title' => 'خطأ في تحميل الملف الشخصي',
			'vendor_dashboard.profile.retry' => 'إعادة المحاولة',
			'vendor_dashboard.profile.verified' => 'تم التحقق',
			'vendor_dashboard.profile.reviews' => 'تقييم',
			'vendor_dashboard.profile.vendor_profile' => 'ملف البائع الشخصي',
			'vendor_dashboard.profile.profile_not_set_up' => 'لم يتم إعداد الملف الشخصي',
			'vendor_dashboard.profile.unable_to_load_profile' => 'تعذر تحميل الملف الشخصي',
			'vendor_dashboard.orders.screen_title' => 'جميع الطلبات',
			'vendor_dashboard.orders.tab_title' => 'الطلبات',
			'vendor_dashboard.orders.tab_subtitle' => 'إدارة عملك',
			'vendor_dashboard.orders.live_badge' => '{count} طلب',
			'vendor_dashboard.orders.search_hint' => 'البحث في الطلبات...',
			'vendor_dashboard.orders.filter_all' => 'الكل',
			'vendor_dashboard.orders.filter_services' => 'خدمات',
			'vendor_dashboard.orders.filter_products' => 'منتجات',
			'vendor_dashboard.orders.tab_all' => 'الكل',
			'vendor_dashboard.orders.tab_new' => 'جديد',
			'vendor_dashboard.orders.tab_processing' => 'قيد المعالجة',
			'vendor_dashboard.orders.tab_completed' => 'مكتمل',
			'vendor_dashboard.orders.empty_search_title' => 'لم يتم العثور على نتائج',
			'vendor_dashboard.orders.empty_search_subtitle' => 'حاول تعديل مصطلحات البحث.',
			'vendor_dashboard.orders.empty_tab' => 'لا توجد طلبات {tabName}',
			'vendor_dashboard.orders.empty_tab_subtitle' => 'ستظهر الطلبات هنا بمجرد توفرها.',
			'vendor_dashboard.orders.error_loading' => 'خطأ في تحميل الطلبات',
			'vendor_dashboard.request_details.screen_title' => 'تفاصيل الطلب',
			'vendor_dashboard.request_details.order_accepted' => 'تم قبول الطلب بنجاح',
			'vendor_dashboard.request_details.accept_failed' => 'فشل قبول الطلب: {error}',
			'vendor_dashboard.request_details.status_on_the_way' => 'تم تحديث الحالة: في الطريق',
			'vendor_dashboard.request_details.status_arrived' => 'تم تحديث الحالة: وصل إلى الموقع',
			'vendor_dashboard.request_details.service_started' => 'بدأت الخدمة',
			'vendor_dashboard.request_details.action_failed' => 'فشل: {error}',
			'vendor_dashboard.request_details.error' => 'خطأ: {error}',
			'vendor_dashboard.request_details.service_fallback' => 'خدمة',
			'vendor_dashboard.request_details.order_ref' => 'رقم الطلب',
			'vendor_dashboard.request_details.amount' => 'المبلغ',
			'vendor_dashboard.request_details.created' => 'تم الإنشاء',
			'vendor_dashboard.request_details.scheduled' => 'مجدول',
			'vendor_dashboard.request_details.route' => 'المسار',
			'vendor_dashboard.request_details.location' => 'الموقع',
			'vendor_dashboard.request_details.pickup' => 'الاستلام',
			'vendor_dashboard.request_details.dropoff' => 'التسليم',
			'vendor_dashboard.request_details.address' => 'العنوان',
			'vendor_dashboard.request_details.no_address' => 'لم يتم توفير عنوان',
			'vendor_dashboard.request_details.open_in_maps' => 'فتح في الخرائط',
			'vendor_dashboard.request_details.order_details' => 'تفاصيل الطلب',
			'vendor_dashboard.request_details.base_amount' => 'المبلغ الأساسي',
			'vendor_dashboard.request_details.total' => 'الإجمالي',
			'vendor_dashboard.request_details.service_specifications' => 'مواصفات الخدمة',
			'vendor_dashboard.request_details.customer_information' => 'معلومات العميل',
			'vendor_dashboard.request_details.attributes' => 'السمات',
			'vendor_dashboard.request_details.customer' => 'العميل',
			'vendor_dashboard.request_details.rejection_reason' => 'سبب الرفض',
			'vendor_dashboard.request_details.no_reason' => 'لم يتم تقديم سبب',
			'vendor_dashboard.request_details.cancellation_details' => 'تفاصيل الإلغاء',
			'vendor_dashboard.request_details.cancellation_reason_label' => 'السبب: {reason}',
			'vendor_dashboard.request_details.penalty_fee' => 'رسوم الإلغاء: {fee} د.ك',
			'vendor_dashboard.request_details.documents' => 'المستندات',
			'vendor_dashboard.request_details.document_fallback' => 'مستند',
			'vendor_dashboard.request_details.reject' => 'رفض',
			'vendor_dashboard.request_details.accept' => 'قبول',
			'vendor_dashboard.request_details.assign_operator' => 'تعيين مشغل',
			'vendor_dashboard.request_details.start_travel' => 'بدء التنقل',
			'vendor_dashboard.request_details.mark_arrived' => 'تحديد الوصول',
			'vendor_dashboard.request_details.start_service' => 'بدء الخدمة',
			'vendor_dashboard.request_details.complete' => 'إكمال',
			'vendor_dashboard.schedule.screen_title' => 'الجدول',
			'vendor_dashboard.schedule.error_loading' => 'خطأ في تحميل الطلبات',
			'vendor_dashboard.schedule.no_appointments' => 'لا توجد مواعيد',
			'vendor_dashboard.schedule.no_scheduled_for_date' => 'لا توجد طلبات مجدولة لـ {date}',
			'vendor_dashboard.schedule.appointment_singular' => 'موعد',
			'vendor_dashboard.schedule.appointment_plural' => 'مواعيد',
			'vendor_dashboard.schedule.service_fallback' => 'خدمة',
			'vendor_dashboard.schedule.customer_fallback' => 'عميل',
			'vendor_dashboard.schedule.status_pending' => 'معلق',
			'vendor_dashboard.schedule.status_accepted' => 'مقبول',
			'vendor_dashboard.schedule.status_en_route' => 'في الطريق',
			'vendor_dashboard.schedule.status_arrived' => 'وصل',
			'vendor_dashboard.schedule.status_active' => 'نشط',
			'vendor_dashboard.schedule.status_done' => 'تم',
			'vendor_dashboard.schedule.status_cancelled' => 'ملغى',
			'vendor_dashboard.schedule.status_unknown' => 'غير معروف',
			'vendor_dashboard.support.screen_title' => 'الدعم',
			'vendor_dashboard.support.faq_title' => 'الأسئلة الشائعة',
			'vendor_dashboard.support.contact_us' => 'اتصل بنا',
			'vendor_dashboard.support.contact_description' => 'تواصل معنا عبر الدردشة المباشرة أو البريد الإلكتروني للحصول على مساعدة سريعة.',
			'vendor_dashboard.support.email_us' => 'راسلنا',
			'vendor_dashboard.support.chat' => 'دردشة',
			'vendor_dashboard.support.or' => 'أو',
			'vendor_dashboard.support.submit_ticket' => 'إرسال تذكرة',
			'vendor_dashboard.support.faq_1_question' => '1. كيف يمكنني التسجيل كبائع؟',
			'vendor_dashboard.support.faq_1_answer' => 'للتسجيل، انقر على خيار "التسجيل كبائع"، وأكمل استمارة التسجيل بتفاصيل عملك، وأرسل المستندات المطلوبة للتحقق.',
			'vendor_dashboard.support.faq_2_question' => '2. هل هناك رسوم لإدراج خدماتي؟',
			'vendor_dashboard.support.faq_3_question' => '3. كيف سأتلقى المدفوعات؟',
			'vendor_dashboard.support.faq_4_question' => '4. هل يمكنني تعديل قائمة خدماتي؟',
			'vendor_dashboard.support.faq_5_question' => '5. كيف أتواصل مع دعم العملاء؟',
			'vendor_dashboard.wallet.screen_title' => 'محفظة موتيفا',
			'vendor_dashboard.wallet.total_label' => 'الإجمالي (د.ك):',
			'vendor_dashboard.wallet.withdraw' => 'سحب',
			'vendor_dashboard.wallet.tabs.daily' => 'يومي',
			'vendor_dashboard.wallet.tabs.weekly' => 'أسبوعي',
			'vendor_dashboard.wallet.tabs.monthly' => 'شهري',
			'vendor_dashboard.wallet.completed_jobs' => 'الوظائف المكتملة',
			'vendor_dashboard.wallet.history' => 'السجل',
			'vendor_dashboard.wallet.stats.total_sales' => 'إجمالي المبيعات',
			'vendor_dashboard.wallet.stats.total_earnings' => 'إجمالي الأرباح',
			'vendor_dashboard.wallet.stats.average_rating' => 'متوسط التقييم',
			'vendor_dashboard.wallet.stats.cancellation_rate' => 'معدل الإلغاء',
			'vendor_dashboard.wallet.history_status.in_progress' => 'قيد التنفيذ',
			'vendor_dashboard.wallet.history_status.rejected' => 'مرفوض',
			'vendor_dashboard.wallet.id_label' => 'رقم: {id}',
			'vendor_dashboard.wallet.payout_request.title' => 'سحب الأموال',
			'vendor_dashboard.wallet.payout_request.amount_label' => 'المبلغ (د.ك)',
			'vendor_dashboard.wallet.payout_request.amount_hint' => 'أدخل المبلغ المراد سحبه',
			'vendor_dashboard.wallet.payout_request.bank_details' => 'تفاصيل البنك',
			'vendor_dashboard.wallet.payout_request.bank_name' => 'اسم البنك',
			'vendor_dashboard.wallet.payout_request.account_number' => 'رقم الحساب',
			'vendor_dashboard.wallet.payout_request.account_holder' => 'صاحب الحساب',
			'vendor_dashboard.wallet.payout_request.kuwait_code' => 'رمز الكويت',
			'vendor_dashboard.wallet.payout_request.update_bank_details' => 'تحديث تفاصيل البنك',
			'vendor_dashboard.wallet.payout_request.submit' => 'إرسال طلب السحب',
			'vendor_dashboard.wallet.payout_request.insufficient_balance' => 'رصيد المحفظة غير كافٍ',
			'vendor_dashboard.wallet.payout_request.invalid_amount' => 'يرجى إدخال مبلغ صحيح',
			'vendor_dashboard.wallet.payout_request.success' => 'تم إرسال طلب السحب بنجاح',
			'vendor_dashboard.wallet.payout_request.error' => 'فشل إرسال طلب السحب',
			'vendor_dashboard.wallet.payout_request.no_bank_details' => 'لم يتم العثور على تفاصيل البنك. يرجى إضافة تفاصيل البنك أولاً.',
			'vendor_dashboard.wallet.coming_soon_message' => 'يمكن استخدام رصيد المحفظة للمدفوعات — قريباً!',
			'vendor_dashboard.wallet.no_transactions' => 'لا توجد معاملات بعد',
			'vendor_dashboard.wallet.error_loading' => 'فشل تحميل بيانات المحفظة',
			'vendor_dashboard.wallet.retry' => 'إعادة المحاولة',
			'vendor_dashboard.wallet.payout_status.pending' => 'قيد الانتظار',
			'vendor_dashboard.wallet.payout_status.processed' => 'تمت المعالجة',
			'vendor_dashboard.wallet.payout_status.rejected' => 'مرفوض',
			'vendor_dashboard.wallet.payout_request_card_title' => 'طلب سحب',
			'vendor_dashboard.wallet.available_balance' => 'الرصيد المتاح',
			'vendor_dashboard.wallet.failed_to_load_balance' => 'فشل تحميل الرصيد',
			'vendor_dashboard.wallet.submitting' => 'جارٍ الإرسال...',
			'vendor_dashboard.wallet.months.jan' => 'يناير',
			'vendor_dashboard.wallet.months.feb' => 'فبراير',
			'vendor_dashboard.wallet.months.mar' => 'مارس',
			'vendor_dashboard.wallet.months.apr' => 'أبريل',
			'vendor_dashboard.wallet.months.may' => 'مايو',
			'vendor_dashboard.wallet.months.jun' => 'يونيو',
			'vendor_dashboard.wallet.months.jul' => 'يوليو',
			'vendor_dashboard.wallet.months.aug' => 'أغسطس',
			'vendor_dashboard.wallet.months.sep' => 'سبتمبر',
			'vendor_dashboard.wallet.months.oct' => 'أكتوبر',
			'vendor_dashboard.wallet.months.nov' => 'نوفمبر',
			'vendor_dashboard.wallet.months.dec' => 'ديسمبر',
			'vendor_dashboard.wallet.reference_types.order' => 'دفعة الطلب',
			'vendor_dashboard.wallet.reference_types.refund' => 'استرداد',
			'vendor_dashboard.wallet.reference_types.voucher' => 'استرداد القسيمة',
			'vendor_dashboard.wallet.reference_types.adjustment' => 'تعديل',
			'vendor_dashboard.wallet.reference_types.admin' => 'رصيد إداري',
			'vendor_dashboard.wallet.reference_types.payout_hold' => 'حجز السحب',
			'vendor_dashboard.wallet.reference_types.payout_release' => 'إلغاء حجز السحب',
			'vendor_dashboard.wallet.reference_types.product_order' => 'طلب منتج',
			'vendor_dashboard.operators.screen_title' => 'المشغلون',
			'vendor_dashboard.operators.active' => 'نشط',
			'vendor_dashboard.operators.inactive' => 'غير نشط',
			'vendor_dashboard.operators.empty_title' => 'لا يوجد مشغلون بعد',
			'vendor_dashboard.operators.empty_subtitle' => 'أضف أول مشغل للبدء',
			'vendor_dashboard.operators.error_loading' => 'خطأ في تحميل المشغلين',
			'vendor_dashboard.operators.add_new' => 'إضافة مشغل جديد',
			'vendor_dashboard.add_operator.screen_title' => 'إضافة مشغل جديد',
			'vendor_dashboard.add_operator.success' => 'تمت إضافة المشغل بنجاح',
			'vendor_dashboard.add_operator.email_exists' => 'هذا البريد الإلكتروني مسجل بالفعل',
			'vendor_dashboard.add_operator.phone_exists' => 'رقم الهاتف مسجل بالفعل',
			'vendor_dashboard.add_operator.failed' => 'فشل إضافة المشغل',
			'vendor_dashboard.add_operator.section_title' => 'معلومات المشغل',
			'vendor_dashboard.add_operator.full_name' => 'الاسم الكامل',
			'vendor_dashboard.add_operator.name_error' => 'الرجاء إدخال اسم المشغل',
			'vendor_dashboard.add_operator.phone_number' => 'رقم الهاتف',
			'vendor_dashboard.add_operator.phone_error' => 'الرجاء إدخال رقم هاتف المشغل',
			'vendor_dashboard.add_operator.email_address' => 'عنوان البريد الإلكتروني',
			'vendor_dashboard.add_operator.email_error' => 'الرجاء إدخال البريد الإلكتروني للمشغل',
			'vendor_dashboard.add_operator.password' => 'كلمة المرور',
			'vendor_dashboard.add_operator.password_error' => 'الرجاء إدخال كلمة مرور',
			'vendor_dashboard.add_operator.password_min_error' => 'يجب أن تكون كلمة المرور 8 أحرف على الأقل',
			'vendor_dashboard.add_operator.loading' => 'جاري التحميل',
			'vendor_dashboard.add_operator.add_operator_button' => 'إضافة مشغل',
			'vendor_dashboard.settings.screen_title' => 'الإعدادات',
			'vendor_dashboard.settings.search_hint' => 'البحث في الإعدادات',
			'vendor_dashboard.settings.not_found' => 'لم يتم العثور على إعدادات',
			'vendor_dashboard.settings.menu.uploaded_documents' => 'الوثائق المرفوعة',
			'vendor_dashboard.settings.menu.service_area' => 'منطقة الخدمة',
			'vendor_dashboard.settings.menu.business_logo' => 'شعار النشاط',
			'vendor_dashboard.settings.menu.cover_image' => 'صورة الغلاف',
			'vendor_dashboard.settings.menu.working_hours' => 'ساعات العمل',
			'vendor_dashboard.settings.menu.notifications' => 'الإشعارات',
			'vendor_dashboard.settings.menu.language' => 'اللغة',
			'vendor_dashboard.settings.menu.app_mode' => 'وضع التطبيق',
			'vendor_dashboard.settings.menu.logout' => 'تسجيل الخروج',
			'vendor_dashboard.settings.menu.delete_account' => 'حذف الحساب',
			'vendor_dashboard.settings.delete_account_confirm.title' => 'حذف الحساب؟',
			'vendor_dashboard.settings.delete_account_confirm.message' => 'هل أنت متأكد من أنك تريد حذف حسابك؟ هذا الإجراء دائم ولا يمكن التراجع عنه.',
			'vendor_dashboard.settings.delete_account_confirm.confirm' => 'حذف',
			'vendor_dashboard.settings.delete_account_confirm.cancel' => 'إلغاء',
			'vendor_dashboard.settings.delete_account_confirm.error' => 'فشل حذف الحساب. يرجى المحاولة مرة أخرى.',
			'vendor_dashboard.working_hours.screen_title' => 'ساعات العمل',
			'vendor_dashboard.working_hours.schedule_exceptions' => 'استثناءات الجدول',
			'vendor_dashboard.working_hours.starting_hour' => 'ساعة البدء',
			'vendor_dashboard.working_hours.closing_hour' => 'ساعة الإغلاق',
			'vendor_dashboard.working_hours.off_days' => 'أيام العطلة',
			'vendor_dashboard.working_hours.saving' => 'جاري الحفظ...',
			'vendor_dashboard.working_hours.save' => 'حفظ',
			'vendor_dashboard.working_hours.update_success' => 'تم تحديث ساعات العمل بنجاح',
			'vendor_dashboard.working_hours.update_failed' => 'فشل تحديث ساعات العمل',
			'vendor_dashboard.working_hours.select_off_days' => 'اختر أيام العطلة',
			'vendor_dashboard.working_hours.done' => 'تم',
			'vendor_dashboard.working_hours.error' => 'خطأ: {error}',
			'vendor_dashboard.documents.screen_title' => 'المستندات',
			'vendor_dashboard.documents.commercial_license' => 'السجل التجاري',
			'vendor_dashboard.documents.civil_id' => 'البطاقة المدنية',
			'vendor_dashboard.documents.upload_success' => 'تم الرفع بنجاح',
			'vendor_dashboard.documents.re_upload_note' => 'إعادة الرفع تتطلب موافقة المشرف.',
			'vendor_dashboard.documents.browse' => 'تصفح',
			'vendor_dashboard.documents.your_file' => 'ملفك',
			'vendor_dashboard.documents.max_size' => 'الحد الأقصى 10 ميغابايت',
			'vendor_dashboard.business_logo.screen_title' => 'شعار النشاط',
			'vendor_dashboard.business_logo.instructions_title' => 'تعليمات الرفع العامة',
			'vendor_dashboard.business_logo.instructions_text' => 'عند رفع الشعار، تأكد من أنه يتوافق مع الأبعاد الموصى بها 500×500 بكسل أو أكبر للحصول على أفضل جودة.\nاستخدم صيغ PNG أو JPEG بحد أقصى 2 ميغابايت.\nبالنسبة لملفات PNG، الخلفية الشفافة هي المثلى، بينما يجب أن يكون خلفية JPEG بسيطة.\nتأكد من أن الشعار واضح وخالي من التشويش للحفاظ على مظهر احترافي.',
			'vendor_dashboard.business_logo.logo_updated' => 'تم تحديث الشعار بنجاح',
			'vendor_dashboard.cover_image.screen_title' => 'صورة الغلاف',
			'vendor_dashboard.cover_image.updated_success' => 'تم تحديث صورة الغلاف بنجاح',
			'vendor_dashboard.cover_image.guidelines_title' => 'إرشادات صورة الغلاف',
			'vendor_dashboard.cover_image.guidelines_text' => 'يتم عرض صورة الغلاف أعلى صفحة البائع.\n\nالأبعاد الموصى بها: 1200 × 400 بكسل أو أكبر.\nاستخدم صيغ PNG أو JPEG بحد أقصى 10 ميغابايت.\n\nنصائح:\n• استخدم صورة عالية الجودة تمثل عملك\n• تجنب الصور ذات النص الكثيف لأنها قد يصعب قراءتها على الجوال\n• تأكد من أن الصورة غير مشوشة أو ضبابية',
			'vendor_dashboard.cover_image.delete' => 'حذف',
			'vendor_dashboard.service_area.screen_title' => 'مدن الخدمة',
			'vendor_dashboard.service_area.search_hint' => 'البحث عن مدينة',
			'vendor_dashboard.service_categories.screen_title' => 'فئات الخدمة',
			'vendor_dashboard.service_categories.add_new' => 'إضافة جديدة',
			'vendor_dashboard.service_categories.oil_filters' => 'فلاتر الزيت',
			'vendor_dashboard.service_categories.fix_my_car' => 'أصلح سيارتي',
			'vendor_dashboard.service_categories.car_batteries' => 'بطاريات السيارات',
			'vendor_dashboard.schedule_exceptions.screen_title' => 'استثناءات الجدول',
			'vendor_dashboard.schedule_exceptions.load_failed' => 'فشل تحميل استثناءات الجدول',
			'vendor_dashboard.schedule_exceptions.retry' => 'إعادة المحاولة',
			'vendor_dashboard.schedule_exceptions.empty_title' => 'لا توجد استثناءات',
			'vendor_dashboard.schedule_exceptions.empty_subtitle' => 'أضف استثناءات للعطلات أو الأيام الخاصة',
			'vendor_dashboard.schedule_exceptions.add_button' => 'إضافة استثناء',
			'vendor_dashboard.schedule_exceptions.delete_tooltip' => 'حذف الاستثناء',
			'vendor_dashboard.schedule_exceptions.fully_closed' => 'مغلق بالكامل',
			'vendor_dashboard.schedule_exceptions.modified_hours' => 'ساعات معدلة',
			'vendor_dashboard.schedule_exceptions.hours_label' => 'الساعات: {start} - {end}',
			'vendor_dashboard.schedule_exceptions.reason_label' => 'السبب: {reason}',
			'vendor_dashboard.schedule_exceptions.delete_dialog_title' => 'حذف الاستثناء',
			'vendor_dashboard.schedule_exceptions.delete_dialog_message' => 'هل أنت متأكد أنك تريد حذف هذا الاستثناء؟',
			'vendor_dashboard.schedule_exceptions.cancel' => 'إلغاء',
			'vendor_dashboard.schedule_exceptions.delete' => 'حذف',
			'vendor_dashboard.schedule_exceptions.delete_success' => 'تم حذف الاستثناء بنجاح',
			'vendor_dashboard.schedule_exceptions.delete_failed' => 'فشل حذف الاستثناء',
			'vendor_dashboard.schedule_exceptions.add_dialog_title' => 'إضافة استثناء للجدول',
			'vendor_dashboard.schedule_exceptions.date_label' => 'التاريخ',
			'vendor_dashboard.schedule_exceptions.fully_closed_switch' => 'مغلق بالكامل',
			'vendor_dashboard.schedule_exceptions.start_time' => 'وقت البدء',
			'vendor_dashboard.schedule_exceptions.select_time' => 'اختر',
			'vendor_dashboard.schedule_exceptions.end_time' => 'وقت الانتهاء',
			'vendor_dashboard.schedule_exceptions.reason_optional' => 'السبب (اختياري)',
			'vendor_dashboard.schedule_exceptions.select_times_error' => 'الرجاء اختيار أوقات البدء والانتهاء',
			'vendor_dashboard.schedule_exceptions.add_success' => 'تمت إضافة الاستثناء بنجاح',
			'vendor_dashboard.schedule_exceptions.add_failed' => 'فشل إضافة الاستثناء',
			'vendor_dashboard.schedule_exceptions.add_button_dialog' => 'إضافة',
			'vendor_dashboard.schedule_exceptions.error' => 'خطأ: {error}',
			'vendor_dashboard.recent_completed.title' => 'مكتملة حديثاً',
			'vendor_dashboard.recent_completed.see_all' => 'عرض الكل',
			'vendor_dashboard.recent_completed.empty' => 'لا توجد طلبات مكتملة بعد',
			'vendor_dashboard.recent_completed.service_fallback' => 'خدمة',
			'vendor_dashboard.recent_completed.customer_fallback' => 'عميل',
			'vendor_dashboard.todays_schedule.title' => 'جدول اليوم',
			'vendor_dashboard.todays_schedule.view_calendar' => 'عرض التقويم',
			'vendor_dashboard.todays_schedule.view_full_calendar' => 'عرض التقويم الكامل',
			'vendor_dashboard.todays_schedule.empty' => 'لا توجد مواعيد اليوم',
			'vendor_dashboard.todays_schedule.asap' => 'فوري',
			'vendor_dashboard.todays_schedule.service_fallback' => 'خدمة',
			'vendor_dashboard.request_cards.order_ref' => 'رقم الطلب',
			'vendor_dashboard.request_cards.amount' => 'المبلغ',
			'vendor_dashboard.request_cards.completed' => 'مكتمل',
			'vendor_dashboard.request_cards.time' => 'الوقت',
			'vendor_dashboard.request_cards.status' => 'الحالة',
			'vendor_dashboard.request_cards.view_details' => 'عرض التفاصيل',
			'vendor_dashboard.request_cards.view_details_normal' => 'عرض التفاصيل',
			'vendor_dashboard.request_cards.proceed' => 'متابعة',
			'vendor_dashboard.request_cards.service_fallback' => 'خدمة',
			'vendor_dashboard.request_cards.customer_fallback' => 'عميل',
			'vendor_dashboard.promo_banner.title' => 'وفّر حتى 5 د.ك',
			'vendor_dashboard.promo_banner.description' => 'عرض لفترة محدودة على\nخدمات محددة',
			'vendor_dashboard.profile_menu.all_orders' => 'جميع الطلبات',
			'vendor_dashboard.profile_menu.my_listings' => 'قوائمي',
			'vendor_dashboard.profile_menu.inventory_history' => 'سجل المخزون',
			'vendor_dashboard.profile_menu.wallet' => 'المحفظة',
			'vendor_dashboard.profile_menu.faqs' => 'الأسئلة الشائعة',
			'vendor_dashboard.unified_order_card.service_order' => 'طلب خدمة',
			'vendor_dashboard.unified_order_card.product_order' => 'طلب منتج',
			'vendor_dashboard.unified_order_card.service_fallback' => 'خدمة',
			'vendor_dashboard.unified_order_card.customer_fallback' => 'عميل',
			'vendor_dashboard.unified_order_card.item_singular' => 'عنصر',
			'vendor_dashboard.unified_order_card.item_plural' => 'عناصر',
			'vendor_dashboard.unified_order_card.reference' => 'المرجع',
			'vendor_dashboard.unified_order_card.amount' => 'المبلغ',
			'vendor_dashboard.unified_order_card.time' => 'الوقت',
			'vendor_dashboard.unified_order_card.status' => 'الحالة',
			'vendor_dashboard.unified_order_card.date' => 'التاريخ',
			'vendor_listings.screen_title' => 'قوائمي',
			'vendor_listings.search_hint' => 'البحث في القوائم...',
			'vendor_listings.filter_all' => 'الكل',
			'vendor_listings.filter_product' => 'منتج',
			'vendor_listings.filter_service' => 'خدمة',
			'vendor_listings.snackbar.product_deactivated' => 'تم إلغاء تفعيل المنتج',
			'vendor_listings.snackbar.product_activated' => 'تم تفعيل المنتج',
			'vendor_listings.snackbar.update_status_failed' => 'فشل تحديث حالة المنتج',
			'vendor_listings.snackbar.product_deleted' => 'تم حذف المنتج بنجاح',
			'vendor_listings.snackbar.delete_failed' => 'فشل حذف المنتج',
			'vendor_listings.snackbar.service_archived' => 'تم أرشفة الخدمة بنجاح',
			'vendor_listings.snackbar.archive_failed' => 'فشل أرشفة الخدمة',
			'vendor_listings.snackbar.service_restored' => 'تم استعادة الخدمة بنجاح',
			'vendor_listings.snackbar.restore_failed' => 'فشل استعادة الخدمة',
			'vendor_listings.dialog.delete_product_title' => 'حذف المنتج',
			'vendor_listings.dialog.delete_product_message' => 'هل أنت متأكد أنك تريد حذف "{name}"؟ لا يمكن التراجع عن هذا الإجراء.',
			'vendor_listings.dialog.delete_confirm' => 'حذف',
			'vendor_listings.dialog.archive_service_title' => 'أرشفة الخدمة',
			'vendor_listings.dialog.archive_service_message' => 'هل أنت متأكد أنك تريد أرشفة "{name}"؟ سيتم إخفاؤها عن العملاء.',
			'vendor_listings.dialog.archive_confirm' => 'أرشفة',
			'vendor_listings.empty.no_results' => 'لم يتم العثور على نتائج',
			'vendor_listings.empty.no_products' => 'لا توجد منتجات بعد',
			'vendor_listings.empty.no_services' => 'لا توجد خدمات بعد',
			'vendor_listings.empty.no_listings' => 'لا توجد قوائم بعد',
			'vendor_listings.empty.adjust_search' => 'حاول تعديل مصطلحات البحث.',
			'vendor_listings.empty.create_product_prompt' => 'أنشئ منتجك الأول لبدء البيع.',
			'vendor_listings.empty.create_service_prompt' => 'أنشئ خدمتك الأولى لبدء استقبال الطلبات.',
			'vendor_listings.empty.create_listing_prompt' => 'أنشئ قائمتك الأولى لبدء استقبال الطلبات.',
			'vendor_listings.empty.create_listing_button' => 'إنشاء قائمة',
			'vendor_listings.error.title' => 'خطأ في تحميل القوائم',
			'vendor_listings.error.message' => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.',
			'vendor_listings.error.retry' => 'إعادة المحاولة',
			'vendor_listings.bottom_sheet.title' => 'إنشاء جديد',
			'vendor_listings.bottom_sheet.product_label' => 'منتج',
			'vendor_listings.bottom_sheet.product_description' => 'أضف منتجًا جديدًا إلى كتالوجك',
			'vendor_listings.bottom_sheet.service_label' => 'خدمة',
			'vendor_listings.bottom_sheet.service_description' => 'أضف خدمة جديدة',
			'vendor_listings.card.type_product' => 'منتج',
			'vendor_listings.card.type_service' => 'خدمة',
			'vendor_listings.card.stock_label' => 'المخزون: {count}',
			'vendor_listings.card.status_active' => 'نشط',
			'vendor_listings.card.status_inactive' => 'غير نشط',
			'vendor_listings.card.status_archived' => 'مؤرشف',
			'vendor_listings.card.currency_suffix' => ' د.ك',
			'vendor_listings.tooltip.activate' => 'تفعيل',
			'vendor_listings.tooltip.deactivate' => 'إلغاء التفعيل',
			'vendor_listings.tooltip.archive' => 'أرشفة',
			'vendor_listings.tooltip.restore' => 'استعادة',
			'vendor_listings.tooltip.edit' => 'تعديل',
			'vendor_listings.tooltip.delete' => 'حذف',
			'vendor_listings.category.active' => 'نشط',
			'vendor_listings.category.inactive' => 'غير نشط',
			'vendor_listings.category.services_fallback' => 'خدمات',
			'vendor_listings.category.products_fallback' => 'منتجات',
			'vendor_products.screen_title' => 'منتجاتي',
			'vendor_products.search_hint' => 'البحث في المنتجات...',
			'vendor_products.filter_all' => 'الكل',
			'vendor_products.filter_active' => 'نشط',
			'vendor_products.filter_inactive' => 'غير نشط',
			'vendor_products.empty.no_results' => 'لم يتم العثور على نتائج',
			'vendor_products.empty.no_products' => 'لا توجد منتجات بعد',
			'vendor_products.empty.no_inactive_products' => 'لا توجد منتجات غير نشطة',
			'vendor_products.empty.inactive_subtitle' => 'ستظهر المنتجات غير النشطة هنا.',
			'vendor_products.empty.adjust_search' => 'حاول تعديل مصطلحات البحث.',
			'vendor_products.empty.create_product_prompt' => 'أنشئ منتجك الأول لبدء البيع.',
			'vendor_products.empty.create_product_button' => 'إنشاء منتج',
			'vendor_products.dialog.delete_title' => 'حذف المنتج',
			'vendor_products.dialog.delete_message' => 'هل أنت متأكد أنك تريد حذف "{name}"؟ لا يمكن التراجع عن هذا الإجراء.',
			'vendor_products.dialog.cancel' => 'إلغاء',
			'vendor_products.dialog.delete' => 'حذف',
			'vendor_products.snackbar.product_deleted' => 'تم حذف المنتج بنجاح',
			'vendor_products.snackbar.delete_failed' => 'فشل حذف المنتج',
			'vendor_products.snackbar.product_deactivated' => 'تم إلغاء تفعيل المنتج',
			'vendor_products.snackbar.product_activated' => 'تم تفعيل المنتج',
			'vendor_products.snackbar.update_status_failed' => 'فشل تحديث حالة المنتج',
			'vendor_products.error.title' => 'خطأ في تحميل المنتجات',
			'vendor_products.error.message' => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.',
			'vendor_products.error.retry' => 'إعادة المحاولة',
			'vendor_products.card.inactive' => 'غير نشط',
			'vendor_products.card.stock_label' => 'المخزون: {count}',
			'vendor_products.card.type_accessory' => 'إكسسوار',
			'vendor_products.card.type_spare_part' => 'قطع غيار',
			'vendor_products.tooltip.activate' => 'تفعيل',
			'vendor_products.tooltip.deactivate' => 'إلغاء التفعيل',
			'vendor_products.tooltip.edit' => 'تعديل',
			'vendor_products.tooltip.delete' => 'حذف',
			'vendor_products.create_product.app_bar_new' => 'منتج جديد',
			'vendor_products.create_product.app_bar_edit' => 'تعديل المنتج',
			'vendor_products.create_product.field_name_label' => 'اسم المنتج',
			'vendor_products.create_product.field_name_hint' => 'مثال: فرامل',
			'vendor_products.create_product.field_description_label' => 'الوصف (اختياري)',
			'vendor_products.create_product.field_description_hint' => 'صف منتجك',
			'vendor_products.create_product.field_price_label' => 'السعر (د.ك)',
			'vendor_products.create_product.field_price_hint' => '0.00',
			'vendor_products.create_product.field_stock_label' => 'كمية المخزون',
			'vendor_products.create_product.field_stock_hint' => '10',
			'vendor_products.create_product.product_type_label' => 'نوع المنتج',
			'vendor_products.create_product.product_type_accessory' => 'إكسسوار',
			'vendor_products.create_product.product_type_spare_part' => 'قطع غيار',
			'vendor_products.create_product.images_title' => 'صور المنتج',
			'vendor_products.create_product.images_subtitle' => 'قم بتحميل صور لعرض منتجك',
			'vendor_products.create_product.add_image_button' => 'إضافة',
			'vendor_products.create_product.button_create' => 'إنشاء منتج',
			'vendor_products.create_product.button_save' => 'حفظ التغييرات',
			'vendor_products.create_product.snackbar_created' => 'تم إنشاء المنتج بنجاح',
			'vendor_products.create_product.snackbar_updated' => 'تم تحديث المنتج بنجاح',
			'vendor_products.create_product.snackbar_create_failed' => 'فشل إنشاء المنتج. يرجى التحقق من المدخلات والمحاولة مرة أخرى.',
			'vendor_products.create_product.snackbar_update_failed' => 'فشل تحديث المنتج. يرجى التحقق من المدخلات والمحاولة مرة أخرى.',
			_ => null,
		} ?? switch (path) {
			'vendor_products.create_product.validation_required' => '{field} مطلوب',
			'vendor_products.create_product.validation_valid_number' => 'أدخل {field} صالح',
			'vendor_products.create_product.spare_part_section_title' => 'مواصفات قطعة الغيار',
			'vendor_products.create_product.part_number_label' => 'رقم القطعة',
			'vendor_products.create_product.brand_label' => 'الماركة',
			'vendor_products.create_product.warranty_label' => 'الضمان (بالأشهر)',
			'vendor_products.create_product.compatibility_label' => 'التوافق',
			'vendor_products.create_product.compatibility_empty' => 'لا توجد إدخالات توافق',
			'vendor_products.create_product.compatibility_make' => 'الشركة المصنعة',
			'vendor_products.create_product.compatibility_model' => 'الطراز',
			'vendor_products.create_product.compatibility_year_from' => 'السنة من',
			'vendor_products.create_product.compatibility_year_to' => 'السنة إلى',
			'vendor_products.create_product.compatibility_add' => 'إضافة',
			'inventory.screen_title' => 'سجل المخزون',
			'inventory.filter_all' => 'الكل',
			'inventory.filter_stock_in' => 'إضافة مخزون',
			'inventory.filter_stock_out' => 'سحب مخزون',
			'inventory.filter_adjustment' => 'تسوية',
			'inventory.filter_refund' => 'استرداد',
			'inventory.empty.title' => 'لم يتم العثور على معاملات',
			'inventory.empty.filtered_subtitle' => 'حاول تعديل عوامل التصفية.',
			'inventory.empty.subtitle' => 'ستظهر معاملات المخزون هنا.',
			'inventory.error.title' => 'خطأ في تحميل المعاملات',
			'inventory.error.message' => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.',
			'inventory.error.retry' => 'إعادة المحاولة',
			'inventory.card.before' => 'قبل:',
			'inventory.card.after' => 'بعد:',
			'inventory.card.reason' => 'السبب:',
			'inventory.from_date' => 'من {date}',
			'inventory.until_date' => 'حتى {date}',
			'inventory.transaction_type.sale' => 'سحب مخزون',
			'inventory.transaction_type.restock' => 'إضافة مخزون',
			'inventory.transaction_type.adjustment' => 'تسوية',
			'inventory.transaction_type.refund' => 'استرداد',
			'vendor_services.screen.title' => 'خدماتي',
			'vendor_services.screen.search_hint' => 'ابحث في الخدمات... ',
			'vendor_services.filter.all' => 'الكل',
			'vendor_services.filter.active' => 'نشط',
			'vendor_services.filter.archived' => 'مؤرشف',
			'vendor_services.empty.search.title' => 'لم يتم العثور على نتائج',
			'vendor_services.empty.search.subtitle' => 'حاول تعديل مصطلحات البحث.',
			'vendor_services.empty.archived.title' => 'لا توجد خدمات مؤرشفة',
			'vendor_services.empty.archived.subtitle' => 'ستظهر الخدمات المؤرشفة هنا.',
			'vendor_services.empty.no_services.title' => 'لا توجد خدمات بعد',
			'vendor_services.empty.no_services.subtitle' => 'أنشئ خدمتك الأولى لبدء استلام الطلبات.',
			'vendor_services.empty.no_services.action' => 'إنشاء خدمة',
			'vendor_services.error.title' => 'خطأ في تحميل الخدمات',
			'vendor_services.error.subtitle' => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.',
			'vendor_services.error.retry' => 'إعادة المحاولة',
			'vendor_services.create_screen.app_bar.new_title' => 'خدمة جديدة',
			'vendor_services.create_screen.app_bar.edit' => 'تعديل الخدمة',
			'vendor_services.create_screen.form.service_name.label' => 'اسم الخدمة',
			'vendor_services.create_screen.form.service_name.hint' => 'مثال: غسيل السيارة المتميز',
			'vendor_services.create_screen.form.service_name.required' => '{field} مطلوب',
			'vendor_services.create_screen.form.description.label' => 'الوصف (اختياري)',
			'vendor_services.create_screen.form.description.hint' => 'صف خدمتك',
			'vendor_services.create_screen.form.base_price.label' => 'السعر الأساسي (د.ك)',
			'vendor_services.create_screen.form.base_price.hint' => '0.00',
			'vendor_services.create_screen.form.radius.label' => 'نطاق الخدمة (كم)',
			'vendor_services.create_screen.form.radius.hint' => '20',
			'vendor_services.create_screen.image_upload.title' => 'صورة الخدمة',
			'vendor_services.create_screen.image_upload.subtitle' => 'ارفع صورة لعرض خدمتك',
			'vendor_services.create_screen.image_upload.uploading' => 'جاري الرفع...',
			'vendor_services.create_screen.image_upload.change' => 'تغيير الصورة',
			'vendor_services.create_screen.image_upload.placeholder_title' => 'اضغط لرفع صورة الخدمة',
			'vendor_services.create_screen.image_upload.placeholder_subtitle' => 'مُوصى به: 800x600 بكسل',
			'vendor_services.create_screen.attributes.title' => 'خصائص الخدمة',
			'vendor_services.create_screen.attributes.required_badge' => 'مطلوب',
			'vendor_services.create_screen.attributes.subtitle' => 'املأ التفاصيل الخاصة بنوع هذه الخدمة',
			'vendor_services.create_screen.attributes.hint' => 'أدخل {field}',
			'vendor_services.create_screen.customer_questions.title' => 'أسئلة العملاء',
			'vendor_services.create_screen.customer_questions.subtitle' => 'حدد الأسئلة التي يجب على العملاء الإجابة عليها عند حجز هذه الخدمة.',
			'vendor_services.create_screen.customer_questions.add_button' => 'إضافة سؤال للعميل',
			'vendor_services.create_screen.customer_questions.required_suffix' => ' *',
			'vendor_services.create_screen.button.save' => 'حفظ التغييرات',
			'vendor_services.create_screen.button.create' => 'إنشاء خدمة',
			'vendor_services.create_screen.button.restore' => 'استعادة الخدمة',
			'vendor_services.create_screen.snackbar.create_success' => 'تم إنشاء الخدمة بنجاح',
			'vendor_services.create_screen.snackbar.update_success' => 'تم تحديث الخدمة بنجاح',
			'vendor_services.create_screen.snackbar.create_failed' => 'فشل إنشاء الخدمة. يرجى التحقق من المدخلات والمحاولة مرة أخرى.',
			'vendor_services.create_screen.snackbar.update_failed' => 'فشل تحديث الخدمة. يرجى التحقق من المدخلات والمحاولة مرة أخرى.',
			'vendor_services.create_screen.snackbar.archive_success' => 'تم أرشفة الخدمة بنجاح',
			'vendor_services.create_screen.snackbar.archive_failed' => 'فشل أرشفة الخدمة',
			'vendor_services.create_screen.snackbar.restore_success' => 'تم استعادة الخدمة بنجاح',
			'vendor_services.create_screen.snackbar.restore_failed' => 'فشل استعادة الخدمة',
			'vendor_services.create_screen.snackbar.question_added' => 'تم إضافة سؤال العميل',
			'vendor_services.create_screen.dialog.archive_title' => 'أرشفة الخدمة',
			'vendor_services.create_screen.dialog.archive_message' => 'هل أنت متأكد من أرشفة "{name}"؟ سيتم إخفاؤها عن العملاء.',
			'vendor_services.create_screen.dialog.archive_confirm' => 'أرشفة',
			'vendor_services.create_screen.dialog.add_question_title' => 'إضافة سؤال للعميل',
			'vendor_services.create_screen.dialog.label' => 'التسمية',
			'vendor_services.create_screen.dialog.label_hint' => 'مثال: صورة المركبة',
			'vendor_services.create_screen.dialog.type' => 'النوع',
			'vendor_services.create_screen.dialog.required' => 'مطلوب',
			'vendor_services.create_screen.dialog.options_label' => 'الخيارات (مفصولة بفاصلة)',
			'vendor_services.create_screen.dialog.options_hint' => 'مثال: شامل، ضد الغير، سرقة_حرق',
			'vendor_services.create_screen.dialog.min' => 'الحد الأدنى',
			'vendor_services.create_screen.dialog.max' => 'الحد الأقصى',
			'vendor_services.create_screen.dialog.cancel' => 'إلغاء',
			'vendor_services.create_screen.dialog.add' => 'إضافة',
			'vendor_services.create_screen.error.no_category' => 'لا توجد فئة خدمة متاحة. يرجى التواصل مع الدعم.',
			'vendor_services.create_screen.error.load_category' => 'فشل تحميل مخطط الفئة',
			'vendor_services.select_category.title' => 'اختيار الفئة',
			'vendor_services.select_category.search_hint' => 'ابحث في الفئات...',
			'vendor_services.select_category.empty.title' => 'لا توجد فئات متاحة',
			'vendor_services.select_category.empty.subtitle' => 'لم يتم تكوين فئات الخدمات بعد. يرجى التواصل مع الدعم.',
			'vendor_services.select_category.search_empty.title' => 'لم يتم العثور على فئات',
			'vendor_services.select_category.search_empty.subtitle' => 'جرب مصطلح بحث مختلف.',
			'vendor_services.select_category.error.title' => 'فشل تحميل الفئات',
			'vendor_services.select_category.error.subtitle' => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.',
			'vendor_services.select_category.error.retry' => 'إعادة المحاولة',
			'vendor_services.service_card.archived_badge' => 'مؤرشف',
			'vendor_services.service_card.price_format' => '{price} د.ك',
			'vendor_services.service_card.radius_format' => '{radius} كم',
			'vendor_services.service_card.tooltip.edit' => 'تعديل',
			'vendor_services.service_card.tooltip.archive' => 'أرشفة',
			'vendor_services.service_card.action.restore' => 'استعادة',
			'vendor_services.category_section.fallback_name' => 'الخدمات',
			'vendor_services.category_section.status' => '{active} نشط',
			'vendor_services.category_section.status_with_archived' => '{active} نشط • {archived} مؤرشف',
			'vendor_services.category_section.dialog.archive_title' => 'أرشفة الخدمة',
			'vendor_services.category_section.dialog.archive_message' => 'هل أنت متأكد من أرشفة "{name}"؟ سيتم إخفاؤها عن العملاء.',
			'vendor_services.category_section.dialog.archive_confirm' => 'أرشفة',
			'vendor_services.category_section.dialog.restore_title' => 'استعادة الخدمة',
			'vendor_services.category_section.dialog.restore_message' => 'استعادة "{name}"؟ سيكون مرئياً للعملاء مرة أخرى.',
			'vendor_services.category_section.dialog.restore_confirm' => 'استعادة',
			'vendor_services.category_section.snackbar.archive_success' => 'تم أرشفة الخدمة بنجاح',
			'vendor_services.category_section.snackbar.archive_failed' => 'فشل أرشفة الخدمة',
			'vendor_services.category_section.snackbar.restore_success' => 'تم استعادة الخدمة بنجاح',
			'vendor_services.category_section.snackbar.restore_failed' => 'فشل استعادة الخدمة',
			'vendor_product_analytics.screen_title' => 'التحليلات',
			'vendor_product_analytics.stock' => 'المخزون',
			'vendor_product_analytics.metrics.total_views' => 'إجمالي المشاهدات',
			'vendor_product_analytics.metrics.conversion' => 'معدل التحويل',
			'vendor_product_analytics.metrics.total_orders' => 'إجمالي الطلبات',
			'vendor_product_analytics.time_period.k7d' => '٧ي',
			'vendor_product_analytics.time_period.k30d' => '٣٠ي',
			'vendor_product_analytics.time_period.k90d' => '٩٠ي',
			'vendor_product_analytics.charts.revenue_over_time' => 'الإيرادات عبر الزمن',
			'vendor_product_analytics.charts.top_products' => 'أفضل المنتجات',
			'vendor_product_analytics.charts.sales' => '{count} مبيعات',
			'vendor_product_analytics.empty.no_revenue_data' => 'لا توجد بيانات إيرادات متاحة',
			'vendor_product_analytics.empty.no_product_sales_data' => 'لا توجد بيانات مبيعات منتجات متاحة',
			'vendor_product_analytics.error.title' => 'خطأ في تحميل التحليلات',
			'vendor_product_analytics.error.message' => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.',
			'vendor_product_analytics.error.retry' => 'إعادة المحاولة',
			_ => null,
		};
	}
}
