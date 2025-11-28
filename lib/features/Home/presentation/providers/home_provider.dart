import 'package:flutter/material.dart';
import 'package:indian_app_guy/shared/providers/base_provider.dart';
import 'package:indian_app_guy/shared/snackbars/general_snackbar.dart';
import 'package:indian_app_guy/core/DI/locator.dart';
import 'package:indian_app_guy/core/constants/temp_data.dart';
import 'package:indian_app_guy/core/helpers/navigation_helper.dart';
import 'package:indian_app_guy/core/services/storage_service.dart';
import 'package:indian_app_guy/features/Home/domain/entities/generated_response.dart';
import 'package:indian_app_guy/features/Home/domain/repositories/home_repository.dart';
import 'package:indian_app_guy/features/Home/presentation/screens/display_ppt_screen.dart';

class HomeProvider extends BaseProvider {
  HomeRepository homeRepository;
  HomeProvider({required this.homeRepository});

  @override
  reset() {
    _templateType = null;
    _template = null;
    _language = null;
    _aiImages = false;
    _imageOnEachSlide = false;
    _googleImages = false;
    _googleText = false;
    _addWaterMark = false;
    _gptModel = null;
    _watermarkPosition = null;
    _generatedResponse = null;
    notifyListeners();
  }

  GeneratedResponse? _generatedResponse;
  GeneratedResponse? get generatedResponse => _generatedResponse;
  setGeneratedResponse(value) {
    _generatedResponse = value;
  }

  String? _templateType;
  String? get templateType => _templateType;
  set templateType(value) {
    _templateType = value;
    notifyListeners();
  }

  String? _template;
  String? get template => _template;
  set template(value) {
    _template = value;
    notifyListeners();
  }

  String? _language;
  String? get language => _language;
  set language(value) {
    _language = value;
    notifyListeners();
  }

  bool _aiImages = false;
  bool get aiImages => _aiImages;
  set aiImages(value) {
    _aiImages = value;
    notifyListeners();
  }

  bool _imageOnEachSlide = false;
  bool get imageOnEachSlide => _imageOnEachSlide;
  set imageOnEachSlide(value) {
    _imageOnEachSlide = value;
    notifyListeners();
  }

  bool _googleImages = false;
  bool get googleImages => _googleImages;
  set googleImages(value) {
    _googleImages = value;
    notifyListeners();
  }

  bool _googleText = false;
  bool get googleText => _googleText;
  set googleText(value) {
    _googleText = value;
    notifyListeners();
  }

  bool _addWaterMark = false;
  bool get addWaterMark => _addWaterMark;
  set addWaterMark(value) {
    _addWaterMark = value;
    notifyListeners();
  }

  String? _gptModel;
  String? get gptModel => _gptModel;
  set gptModel(value) {
    _gptModel = value;
    notifyListeners();
  }

  String? _watermarkPosition;
  String? get watermarkPosition => _watermarkPosition;
  set watermarkPosition(value) {
    _watermarkPosition = value;
    notifyListeners();
  }

  convertLanguage(value) {
    switch (value?.toLowerCase()) {
      case 'english':
        return 'en';
      case 'spanish':
        return 'es';
    }
  }

  generatePPT({
    required String topic,
    required String info,
    required int slides,
    int? width,
    int? height,
    String? url,
    required String presentationFor,
    required BuildContext context,
  }) async {
    setLoading(true);
    var storageService = locator<StorageService>();
    var email = await storageService.fetchUserEmail();
    // var accessid = dotenv.env['ACCESS_ID'];
    var accessid = await storageService.fetchAccessId();

    if (accessid == null) {
      if (!context.mounted) return;
      showGeneralSnackbar(
        context: context,
        errorMessage: 'Please add your access Id from the settings to continue',
      );
      setLoading(false);
      return;
    }

    var data = {
      "topic": topic,
      "extraInfoSource": info,
      "email": email,
      "accessId": accessid,
      "template": _template,
      "language": convertLanguage(_language),
      "slideCount": slides,
      "aiImages": _aiImages,
      "imageForEachSlide": _imageOnEachSlide,
      "googleImage": _googleImages,
      "googleText": _googleText,
      "model": _gptModel,
      "presentationFor": presentationFor,
      if (_addWaterMark)
        "watermark": {
          "width": width,
          "height": height,
          "brandURL": url,
          "position": _watermarkPosition,
        },
    };

    var result = await homeRepository.generatePPT(data);

    result.fold(
      (error) =>
          showGeneralSnackbar(context: context, errorMessage: error.message),
      (response) {
        setGeneratedResponse(response);
        NavigationHelper.pushReplacement(
          context: context,
          route: DisplayPptScreen(url: response.data?.url ?? tempPptUrl),
        );
      },
    );

    setLoading(false);
  }
}
