// ignore_for_file: constant_identifier_names
import 'package:intl/intl.dart';

const EMPTY_EMAIL = "Debes ingresar un correo electronico";
const EMPTY_PASSWORD = "Debes ingresar una contraseña";
const EMPTY_NAME = "Debes ingresar un nombre";
const EMPTY_LASTNAME = "Debes ingresar un nombre y apellido";
const INVALID_NAME = "Debes ingresar un nombre valido";
const INVALID_LASTNAME = "Debes ingresar un apellido valido";
const EMPTY_SEX = "Debes ingresar un sexo";
const EMPTY_DOB = "Debes elegir una fecha de nacimiento";
const INVALID_DOB = "La fecha no es valida";
const PASSWORDS_DONT_MATCH = 'Las contraseñas deben ser iguales';
const EMPTY_PASSWORD_CONFIRMATION = 'Debes confirmar tu contraseña';

mixin Validation {
  String validateName(String text) {
    if (isEmptyOrNull(text)) {
      return EMPTY_NAME;
    }

    if (text.trim().split(" ").length < 2) {
      return EMPTY_LASTNAME;
    }

    if (text.trim().split(" ")[0].length < 3) {
      return INVALID_NAME;
    }

    if (text.trim().split(" ")[1].length < 3) {
      return INVALID_LASTNAME;
    }

    return "";
  }

  String validateSex(String sex) {
    if (isEmptyOrNull(sex)) {
      return EMPTY_SEX;
    }

    return "";
  }

  String validateDOB(DateTime? dob) {
    if (dob == null) return EMPTY_DOB;
    return '';
  }

  String validateDate(String? value) {
    if (value == null || value.isNotEmpty == false) {
      return EMPTY_DOB;
    } else if (value.length < 10) {
      return INVALID_DOB;
    } else {
      try {
        var parts = value.split('/');
        final newDate = DateTime.parse("${parts[2]}${parts[1]}${parts[0]}");
        if (newDate.isBefore(DateTime(1940, 1, 1)) ||
            newDate.isAfter(DateTime(2016, 12, 30))) {
          return INVALID_DOB;
        }

        String formatted = DateFormat('dd-MM-yyyy').format(newDate);

        var partsFormatted = formatted.split('-');

        if (partsFormatted[0] != parts[0] ||
            partsFormatted[1] != parts[1] ||
            partsFormatted[2] != parts[2]) {
          return INVALID_DOB;
        }
        return "";
      } catch (e) {
        return INVALID_DOB;
      }
    }
  }

  bool isEmptyOrNull(String? text) {
    if (text == null) return true;

    return text.isEmpty;
  }

  String validateEmail(String email) {
    if (email.isEmpty) {
      return EMPTY_EMAIL;
    }
    return '';
  }

  String validatePassword(String password) {
    if (password.isEmpty) {
      return EMPTY_PASSWORD;
    }
    return '';
  }

  String validateConfirmPassword(String password, String passwordConfirmation) {
    if (passwordConfirmation.isEmpty) {
      return EMPTY_PASSWORD_CONFIRMATION;
    }
    if (password != passwordConfirmation) {
      return PASSWORDS_DONT_MATCH;
    }
    return '';
  }
}
