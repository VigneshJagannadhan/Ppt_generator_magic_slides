import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indian_app_guy/core/DI/locator.dart';
import 'package:indian_app_guy/core/services/storage_service.dart';
import 'package:indian_app_guy/features/Auth/presentation/widgets/primary_elevated_button.dart';
import 'package:indian_app_guy/features/Home/presentation/widgets/custom_appbar.dart';
import 'package:indian_app_guy/features/Home/presentation/widgets/custom_textform_field.dart';
import 'package:indian_app_guy/shared/snackbars/general_snackbar.dart';

class SetAccessIdScreen extends StatefulWidget {
  static const String route = 'setAccessIdScreen';
  const SetAccessIdScreen({super.key});

  @override
  State<SetAccessIdScreen> createState() => _SetAccessIdScreenState();
}

class _SetAccessIdScreenState extends State<SetAccessIdScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((v) async {
      var storageService = locator<StorageService>();
      var id = await storageService.fetchAccessId();

      _controller.text = id ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Set Access ID'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              controller: _controller,
              label: 'Enter Access ID Here',
            ),
            SizedBox(height: 20.h),
            PrimaryElevatedButton(
              label: 'Save',
              onTap: () async {
                var storageService = locator<StorageService>();
                await storageService.saveAccessId(
                  value: _controller.text.trim(),
                );

                if (!context.mounted) return;
                showGeneralSnackbar(
                  context: context,
                  errorMessage: 'Saved ID',
                  isFailure: false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
