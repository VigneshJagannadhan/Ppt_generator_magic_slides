class AppValidators {
  static validateTopic(String? value) {
    if (value == null || value == "") return "Topic can not be empty!";
    return null;
  }

  static validateField(String? value) {
    if (value == null || value == "") return "This field can not be empty!";
    return null;
  }

  static validateSlides(String? value) {
    if (value == null || value == "") return "No of slides can not be empty";
    var i = int.tryParse(value) ?? 0;
    if (i > 50 || i < 1) {
      return "No of slides should be in the range of 1 - 50";
    }
    return null;
  }

  static validateTemplateType(String? value) {
    if (value == null) return "Select a Template type";
    return null;
  }

  static validateLanguage(String? value) {
    if (value == null) return "Select a Language";
    return null;
  }

  static validateGPTModel(String? value) {
    if (value == null) return "Select a Model";
    return null;
  }

  static validateWatermarkPosition(String? value) {
    if (value == null) return "Must select a position";
    return null;
  }

  static validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    }

    final emailRegex = RegExp(r"^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$");
    if (!emailRegex.hasMatch(value.trim())) {
      return "Enter a valid email address";
    }

    return null;
  }

  static validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name cannot be empty";
    }

    final nameRegex = RegExp(r"^[a-zA-Z ]{2,}$");
    if (!nameRegex.hasMatch(value.trim())) {
      return "Enter a valid name";
    }

    return null;
  }

  static validateRegistrationPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }

    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }

    final regex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );

    if (!regex.hasMatch(value)) {
      return "Password must contain uppercase, lowercase, number and special character";
    }

    return null;
  }

  static validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }

    return null;
  }
}
