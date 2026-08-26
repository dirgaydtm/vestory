import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/presentation/providers/user_provider.dart';
import '../../../../shared/presentation/widgets/vestory_text_field.dart';
import '../providers/settings_controller.dart';
import 'section_title.dart';

class ProfileSection extends ConsumerStatefulWidget {
  const ProfileSection({super.key});

  @override
  ConsumerState<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends ConsumerState<ProfileSection> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _playStyleController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _playStyleFocusNode = FocusNode();

  bool _isNameEditing = false;
  bool _isPlayStyleEditing = false;
  bool _isProfileInitialized = false;

  @override
  void initState() {
    super.initState();
    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus) {
        setState(() => _isNameEditing = false);
      }
    });
    _playStyleFocusNode.addListener(() {
      if (!_playStyleFocusNode.hasFocus) {
        setState(() => _isPlayStyleEditing = false);
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _playStyleController.dispose();
    _nameFocusNode.dispose();
    _playStyleFocusNode.dispose();
    super.dispose();
  }

  void _onProfileChanged() {
    ref
        .read(settingsControllerProvider)
        .updateProfileDebounced(
          name: _nameController.text.trim(),
          playStyle: _playStyleController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProfileProvider);

    if (!_isProfileInitialized && userAsync.value != null) {
      _nameController.text = userAsync.value!.name;
      _playStyleController.text = userAsync.value!.playStyle;
      _isProfileInitialized = true;
    }

    return Column(
      crossAxisAlignment: .start,
      children: [
        SectionTitle('Profil'),
        SizedBox(height: 16),
        VestoryTextField(
          label: 'Nama',
          hintText: 'Masukkan nama kamu',
          controller: _nameController,
          readOnly: !_isNameEditing,
          focusNode: _nameFocusNode,
          onChanged: (_) => _onProfileChanged(),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.edit_outlined,
              color: _isNameEditing
                  ? AppColors.greenNormal
                  : AppColors.textPrimary,
              size: 20,
            ),
            onPressed: () {
              setState(() => _isNameEditing = true);
              _nameFocusNode.requestFocus();
            },
          ),
        ),
        SizedBox(height: 16),
        VestoryTextField(
          label: 'Gaya Bermain',
          hintText: 'Misal: Agresif, Konservatif',
          controller: _playStyleController,
          readOnly: !_isPlayStyleEditing,
          focusNode: _playStyleFocusNode,
          onChanged: (_) => _onProfileChanged(),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.edit_outlined,
              color: _isPlayStyleEditing
                  ? AppColors.greenNormal
                  : AppColors.textPrimary,
              size: 20,
            ),
            onPressed: () {
              setState(() => _isPlayStyleEditing = true);
              _playStyleFocusNode.requestFocus();
            },
          ),
        ),
      ],
    );
  }
}
