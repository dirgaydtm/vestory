import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/onboarding_controller.dart';
import '../../../../shared/presentation/widgets/primary_button.dart';
import '../../../../shared/presentation/widgets/vestory_back_button.dart';
import '../../../../shared/presentation/widgets/vestory_progress_indicator.dart';
import '../widgets/onboarding2_name_step.dart';
import '../widgets/onboarding2_ready_step.dart';
import '../widgets/onboarding2_style_step.dart';

class Onboarding2Page extends ConsumerStatefulWidget {
  const Onboarding2Page({super.key});

  @override
  ConsumerState<Onboarding2Page> createState() => _Onboarding2PageState();
}

class _Onboarding2PageState extends ConsumerState<Onboarding2Page> {
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  int _currentIndex = 0;
  String? _selectedStyle;
  bool _showError = false;
  bool _showNameError = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      if (_showNameError && _nameController.text.trim().isNotEmpty) {
        setState(() {
          _showNameError = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex == 0) {
      if (_nameController.text.trim().isEmpty) {
        setState(() {
          _showNameError = true;
        });
        return;
      }
    } else if (_currentIndex == 1) {
      if (_selectedStyle == null) {
        setState(() {
          _showError = true;
        });
        return;
      }
    }

    if (_currentIndex < 2) {
      _pageController.nextPage(
        duration: .new(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: .new(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.pop();
    }
  }

  Future<void> _finishOnboarding() async {
    final controller = ref.read(onboardingControllerProvider.notifier);
    await controller.finishOnboarding(
      _nameController.text.trim(),
      _selectedStyle!,
    );

    if (mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: .all(24.0),
          child: Column(
            children: [
              Row(
                children: [
                  VestoryBackButton(onTap: _previousPage),
                  SizedBox(width: 16),
                  Expanded(
                    child: VestoryProgressIndicator(
                      totalSteps: 3,
                      currentStep: _currentIndex,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),

              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: .new(),
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                      _showError = false;
                      _showNameError = false;
                    });
                  },
                  children: [
                    Onboarding2NameStep(
                      nameController: _nameController,
                      errorText: _showNameError
                          ? 'Masukkan nama terlebih dahulu!'
                          : null,
                    ),
                    Onboarding2StyleStep(
                      selectedStyle: _selectedStyle,
                      onStyleSelected: (style) {
                        setState(() {
                          _selectedStyle = style;
                          _showError = false;
                        });
                      },
                    ),
                    Onboarding2ReadyStep(),
                  ],
                ),
              ),

              if (_showError && _currentIndex == 1)
                Container(
                  width: .infinity,
                  padding: .symmetric(vertical: 12),
                  margin: .only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: .circular(16),
                  ),
                  child: Text(
                    'Mohon pilih salah satu!',
                    textAlign: .center,
                    style: TextStyle(color: Colors.red, fontWeight: .bold),
                  ),
                ),

              PrimaryButton(
                text: _currentIndex == 2 ? 'Siap!' : 'Lanjut',
                onPressed: _currentIndex == 2 ? _finishOnboarding : _nextPage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
