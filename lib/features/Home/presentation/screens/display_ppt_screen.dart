import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indian_app_guy/shared/snackbars/general_snackbar.dart';
import 'package:indian_app_guy/core/themes/app_colors.dart';
import 'package:indian_app_guy/core/themes/app_styles.dart';
import 'package:indian_app_guy/features/Auth/presentation/widgets/primary_elevated_button.dart';
import 'package:indian_app_guy/features/Home/presentation/widgets/custom_appbar.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class DisplayPptScreen extends StatefulWidget {
  static const String route = 'displayPptScreen';
  const DisplayPptScreen({super.key, this.url});

  final String? url;

  @override
  State<DisplayPptScreen> createState() => _DisplayPptScreenState();
}

class _DisplayPptScreenState extends State<DisplayPptScreen> {
  @override
  void initState() {
    super.initState();
  }

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'PPT Generated'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              'Your PPT has been generated successfully!',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 20.h),

            Container(
              width: 1.sw,
              height: 200.h,
              decoration: BoxDecoration(
                color: AppColors.cWhite,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(),
                image: DecorationImage(
                  image: AssetImage('assets/images/ppt-1.png'),
                ),
              ),
              alignment: Alignment.center,
              child: Text('Generated PPT', style: AppStyles.ts24W700cBlack),
            ),
            SizedBox(height: 20.h),
            ValueListenableBuilder(
              valueListenable: _isLoading,
              builder: (context, loading, _) {
                return PrimaryElevatedButton(
                  isLoading: loading,
                  color: Colors.green,
                  label: 'Open PPT',
                  onTap: () async => await _openPPT(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _openPPT() async {
    _isLoading.value = true;
    try {
      final url = widget.url ?? "";
      final temp = await getTemporaryDirectory();
      final filePath = '${temp.path}/presentation.pptx';

      await Dio().download(url, filePath);

      OpenFilex.open(filePath);
    } catch (e) {
      if (!mounted) return;
      showGeneralSnackbar(
        context: context,
        errorMessage: 'Something went wrong!',
      );
    } finally {
      _isLoading.value = false;
    }
  }
}
