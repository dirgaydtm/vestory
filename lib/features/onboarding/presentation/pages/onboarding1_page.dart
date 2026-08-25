import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/vestory_back_button.dart';
import '../../../../shared/widgets/vestory_page_indicator.dart';

class Onboarding1Page extends StatefulWidget {
  const Onboarding1Page({super.key});

  @override
  State<Onboarding1Page> createState() => _Onboarding1PageState();
}

class _Onboarding1PageState extends State<Onboarding1Page> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'image': 'assets/images/onboarding/ilustration-1.webp',
      'title': 'Simulasi Pasar Nyata',
      'subtitle':
          'Belajar mengambil keputusan tanpa\nmempertaruhkan uang sungguhan.',
    },
    {
      'image': 'assets/images/onboarding/ilustration-2.webp',
      'title': 'Selesaikan Misi Seru',
      'subtitle':
          'Jalani learning missions bertahap untuk\nmemahami konsep investasi!',
    },
    {
      'image': 'assets/images/onboarding/ilustration-3.webp',
      'title': 'Bangun Portofoliomu',
      'subtitle':
          'Beli aset pilihanmu dan pantau terus\nkinerjanya di portofolio.',
    },
  ];

  void _nextPage() {
    if (_currentIndex < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.push('/onboarding2');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baseWhite,
      body: SafeArea(
        child: Padding(
          padding: .all(24.0),
          child: Column(
            children: [
              SizedBox(
                height: 48,
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    if (_currentIndex > 0)
                      VestoryBackButton(
                        onTap: () {
                          _pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      )
                    else
                      SizedBox(width: 48),
                    // Skip button
                    TextButton(
                      onPressed: () {
                        context.push('/onboarding2');
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: AppColors.greenNormal,
                          fontWeight: .w600,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              // Dots
              VestoryPageIndicator(
                itemCount: _onboardingData.length,
                currentIndex: _currentIndex,
              ),
              SizedBox(height: 32),
              // PageView
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: _onboardingData.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Image.asset(
                            _onboardingData[index]['image']!,
                            fit: .contain,
                          ),
                        ),
                        SizedBox(height: 48),
                        Text(
                          _onboardingData[index]['title']!,
                          textAlign: .center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: .bold,
                            color: AppColors.textHeading,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          _onboardingData[index]['subtitle']!,
                          textAlign: .center,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                        Spacer(flex: 2),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              // Button Lanjut
              PrimaryButton(text: 'Lanjut', onPressed: _nextPage),
            ],
          ),
        ),
      ),
    );
  }
}
