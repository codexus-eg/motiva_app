import 'package:app/core/navigation/navigation_service.dart';
import 'package:app/core/network/auth_interceptor.dart';
// import 'package:app/core/services/notification_service.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/core/theme/theme_provider.dart';
import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:app/features/auth/presentation/screens/splash/auth_splash_screen.dart';
// import 'package:app/firebase_options.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/status_bar/status_bar.dart';
import 'package:device_preview/device_preview.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await NotificationService.init();

  final prefs = await SharedPreferences.getInstance();
  final saved = prefs.getString('selected_locale') ?? 'en';
  LocaleSettings.setLocale(
    AppLocale.values.firstWhere(
      (l) => l.languageCode == saved,
      orElse: () => AppLocale.en,
    ),
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );

  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => TranslationProvider(child: const MyApp()),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dioClient = ref.watch(dioClientProvider);
    final authInterceptor = ref.watch(authInterceptorProvider);

    if (!dioClient.dio.interceptors.any((i) => i is AuthInterceptor)) {
      dioClient.addInterceptor(authInterceptor);
    }

    final themeMode = ref.watch(themeProvider);

    final t = Translations.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: t.general.app_name,
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      builder: (context, child) {
        return SystemUiWrapper(child: child!);
      },
      navigatorKey: NavigationService.navigatorKey,
      home: const AuthSplashScreen(),
    );
  }
}
