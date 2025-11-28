import 'package:flutter/widgets.dart';
import 'package:indian_app_guy/features/Home/presentation/widgets/custom_loading_widget.dart';

extension ScreenStateExtension on Widget {
  Widget withLoading({required bool isLoading, String? text, String? lottie}) {
    if (isLoading) {
      return CustomLoadingWidget(text: text, lottie: lottie);
    }

    return this;
  }
}
