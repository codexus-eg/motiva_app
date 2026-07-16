import 'dart:async';

import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AdBanners extends StatefulWidget {
  const AdBanners({super.key});

  @override
  State<AdBanners> createState() => _AdBannersState();
}

class _AdBannersState extends State<AdBanners> {
  late final PageController _pageController;
  late final Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_pageController.hasClients) {
        final nextPage = (_currentPage + 1) % 2;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        setState(() => _currentPage = nextPage);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 142,
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentPage = index),
        children: [_buildBanner(), _buildBanner()],
      ),
    );
  }

  Widget _buildBanner() {
    final theme = Theme.of(context);
    final t = Translations.of(context).home.customer.ad_banner;
    return Container(
      width: 347,
      height: 142,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              top: 0,
              left: 84,
              child: SvgPicture.asset(
                'assets/images/ad_bg_1.svg',
                width: 262.5,
                height: 86.6,
              ),
            ),
            Positioned(
              left: 264,
              top: 80,
              child: Transform.rotate(
                angle: 3.14159,
                child: SvgPicture.asset(
                  'assets/images/ad_bg_2.svg',
                  width: 263,
                  height: 60,
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: 22,
              child: SizedBox(
                width: 156,
                child: Text(
                  t.title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                    height: 1.3,
                  ),
                ),
              ),
            ),
            Positioned(
              right: -50,
              top: 30,
              child: SizedBox(
                width: 260,
                // height: 150,
                child: Image.asset(
                  'assets/images/ad_car.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
