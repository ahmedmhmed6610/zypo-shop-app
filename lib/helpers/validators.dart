class Validators {
  static bool isArabic(String text) {
    RegExp arabic = RegExp(r'[\u0600-\u06FF]');
    var result = arabic.hasMatch(text);
    return result;
  }

  static bool validateEmptyField(String field) {
    return field.isEmpty || field == '';
  }

  static String? validatePhoneNumber(String field) {
    RegExp phoneRegex = isArabic(field)
        ? RegExp(r'^[\u0660-\u0669]{11}$')
        : RegExp(r'^01[0125][0-9]{8}$');

    if (validateEmptyField(field)) {
      return 'fieldRequired';
    }

    if (!phoneRegex.hasMatch(field)) {
      return 'phoneValidation';
    }

    return null;
  }

  static String? validatePinCode(String field) {
    RegExp pinRegex = RegExp(r'^[0-9]{4}$');

    if (validateEmptyField(field)) {
      return 'fieldRequired';
    }

    if (!pinRegex.hasMatch(field)) {
      return 'pinCodeValidation';
    }

    return null;
  }
}
