import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indian_app_guy/core/constants/app_constants.dart';
import 'package:indian_app_guy/core/constants/temp_data.dart';
import 'package:indian_app_guy/core/extensions/screen_state_extension.dart';
import 'package:indian_app_guy/core/utils/app_validators.dart';
import 'package:indian_app_guy/core/utils/common_utils.dart';
import 'package:indian_app_guy/features/Auth/presentation/widgets/primary_elevated_button.dart';
import 'package:indian_app_guy/features/Home/presentation/providers/home_provider.dart';
import 'package:indian_app_guy/features/Home/presentation/widgets/custom_appbar.dart';
import 'package:indian_app_guy/features/Home/presentation/widgets/custom_dropdown.dart';
import 'package:indian_app_guy/features/Home/presentation/widgets/custom_switch_with_label.dart';
import 'package:indian_app_guy/features/Home/presentation/widgets/custom_textform_field.dart';
import 'package:provider/provider.dart';

class CreatePPTScreen extends StatefulWidget {
  static const String route = '/createFormScreen';
  const CreatePPTScreen({super.key});

  @override
  State<CreatePPTScreen> createState() => _CreatePPTScreenState();
}

class _CreatePPTScreenState extends State<CreatePPTScreen> {
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _slidesController = TextEditingController();
  final TextEditingController _prForController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();
  final TextEditingController _waterWController = TextEditingController();
  final TextEditingController _waterHController = TextEditingController();
  final TextEditingController _waterUrlController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _generatePPT(HomeProvider home) async {
    var slides = int.parse(_slidesController.text.trim());
    var topic = _topicController.text.trim();
    var prFor = _prForController.text.trim();
    var info = _infoController.text.trim();

    await home.generatePPT(
      topic: topic,
      info: info,
      slides: slides,
      presentationFor: prFor,
      context: context,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((v) {
      context.read<HomeProvider>().reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, home, _) {
        return PopScope(
          onPopInvokedWithResult: (didPop, result) => home.reset(),
          child: Scaffold(
            appBar: CustomAppbar(title: 'Create new PPT'),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  children: [
                    CustomTextFormField(
                      controller: _topicController,
                      label: 'Topic',
                      validator: (value) => AppValidators.validateTopic(value),
                    ),
                    SizedBox(height: 10.h),
                    CustomDropdown<String?>(
                      label: 'Template Type',
                      value: home.templateType,
                      dropdownList: getDropdownItems(templateTypes),
                      validator:
                          (value) => AppValidators.validateTemplateType(value),
                      onChanged: (value) {
                        home.template = null;
                        home.templateType = value;
                      },
                    ),
                    SizedBox(height: 10.h),
                    if (home.templateType != null)
                      CustomDropdown<String?>(
                        label: 'Select a template',
                        value: home.template,
                        dropdownList: getDropdownItems(
                          home.templateType == 'Default Template'
                              ? defaultTemplates
                              : editableTemplates,
                        ),
                        validator:
                            (value) =>
                                AppValidators.validateTemplateType(value),
                        onChanged: (value) => home.template = value,
                      ),
                    if (home.templateType != null) SizedBox(height: 10.h),
                    CustomTextFormField(
                      controller: _slidesController,
                      validator: (value) => AppValidators.validateSlides(value),
                      label: 'No of Slides',
                    ),
                    SizedBox(height: 10.h),
                    CustomDropdown<String?>(
                      label: 'Language',
                      value: home.language,
                      dropdownList: getDropdownItems(langauges),
                      validator:
                          (value) => AppValidators.validateLanguage(value),
                      onChanged: (value) => home.language = value,
                    ),
                    SizedBox(height: 10.h),
                    CustomSwitchWithLabel(
                      label: 'AI Images',
                      value: home.aiImages,
                      onChanged: (v) => home.aiImages = v,
                    ),
                    SizedBox(height: 10.h),
                    CustomSwitchWithLabel(
                      label: 'Image on each slide',
                      value: home.imageOnEachSlide,
                      onChanged: (v) => home.imageOnEachSlide = v,
                    ),
                    SizedBox(height: 10.h),
                    CustomSwitchWithLabel(
                      label: 'Google Images',
                      value: home.googleImages,
                      onChanged: (v) => home.googleImages = v,
                    ),
                    SizedBox(height: 10.h),
                    CustomSwitchWithLabel(
                      label: 'Google Text',
                      value: home.googleText,
                      onChanged: (v) => home.googleText = v,
                    ),
                    SizedBox(height: 10.h),
                    CustomTextFormField(
                      controller: _prForController,
                      label: 'Presentation for',
                    ),
                    SizedBox(height: 10.h),
                    CustomDropdown<String?>(
                      label: 'GPT Model',
                      value: home.gptModel,
                      dropdownList: getDropdownItems(gptModels),
                      validator:
                          (value) => AppValidators.validateGPTModel(value),
                      onChanged: (value) => home.gptModel = value,
                    ),

                    SizedBox(height: 10.h),
                    CustomSwitchWithLabel(
                      label: 'Add Watermark?',
                      value: home.addWaterMark,
                      onChanged: (v) => home.addWaterMark = v,
                    ),
                    SizedBox(height: 10.h),
                    if (home.addWaterMark)
                      Column(
                        children: [
                          CustomTextFormField(
                            controller: _waterWController,
                            label: 'Watermark width',
                            validator:
                                (value) => AppValidators.validateField(value),
                          ),
                          SizedBox(height: 10.h),
                          CustomTextFormField(
                            controller: _waterHController,
                            validator:
                                (value) => AppValidators.validateField(value),
                            label: 'Watermark height',
                          ),
                          SizedBox(height: 10.h),
                          CustomTextFormField(
                            controller: _waterUrlController,
                            validator:
                                (value) => AppValidators.validateField(value),
                            label: 'Watermark Url',
                          ),
                          SizedBox(height: 10.h),
                          CustomDropdown<String?>(
                            label: 'Watermark Position',
                            value: home.watermarkPosition,
                            dropdownList: getDropdownItems(positions),
                            validator:
                                (value) =>
                                    AppValidators.validateWatermarkPosition(
                                      value,
                                    ),
                            onChanged:
                                (value) => home.watermarkPosition = value,
                          ),

                          SizedBox(height: 10.h),
                        ],
                      ),
                    PrimaryElevatedButton(
                      label: 'Generate',
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await _generatePPT(home);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ).withLoading(
              isLoading: home.isLoading,
              text: 'Generating PPT',
              lottie: AppConstants.generateLottie,
            ),
          ),
        );
      },
    );
  }
}
