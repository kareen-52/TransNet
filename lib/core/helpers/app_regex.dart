import 'dart:ui';

import 'package:flutter/material.dart';

class AppRegex {
  static bool isEmailValid(String email) {
    return RegExp(
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
    ).hasMatch(email);
  }

  static bool isNameValid(String name) {
    return RegExp(r"^[a-zA-Z\s\u0600-\u06FF']+$").hasMatch(name);
  }

  // static bool isPasswordValid(String password) {
  //   return RegExp(
  //     r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$",
  //   ).hasMatch(password);
  // }

  static bool isPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^09[345689][0-9]{7}$').hasMatch(phoneNumber);
  }

  static bool hasLowerCase(String password) {
    return RegExp(r'^(?=.*[a-z])').hasMatch(password);
  }

  static bool hasUpperCase(String password) {
    return RegExp(r'^(?=.*[A-Z])').hasMatch(password);
  }

  static bool hasNumber(String password) {
    return RegExp(r'^(?=.*?[0-9])').hasMatch(password);
  }

  static bool hasSpecialCharacter(String password) {
    return RegExp(r'^(?=.*?[#?!@$%^&*-])').hasMatch(password);
  }

  static bool hasMinLength(String password) {
    return RegExp(r'^(?=.{8,})').hasMatch(password);
  }

  
  // static bool hasMinLength(String password) {
  //   return password.length >= 8;
  // }

  // static bool hasLowerCase(String password) {
  //   return RegExp(r'[a-z]').hasMatch(password);
  // }

  // static bool hasUpperCase(String password) {
  //   return RegExp(r'[A-Z]').hasMatch(password);
  // }

  // static bool hasNumber(String password) {
  //   return RegExp(r'\d').hasMatch(password);
  // }

  // static bool hasSpecialCharacter(String password) {

  //   return RegExp(r'[@$!%*?&#]').hasMatch(password);
  // }


  static bool isPasswordValid(String password) {
    return hasMinLength(password) &&
        hasLowerCase(password) &&
        hasUpperCase(password) &&
        hasNumber(password) &&
        hasSpecialCharacter(password);
  }

 
  static List<String> getMissingPasswordRequirements(String password) {
    List<String> missing = [];
    if (!hasMinLength(password)) {
      missing.add('8 أحرف على الأقل');
    }
    if (!hasLowerCase(password)) {
      missing.add('حرف صغير (a-z)');
    }
    if (!hasUpperCase(password)) {
      missing.add('حرف كبير (A-Z)');
    }
    if (!hasNumber(password)) {
      missing.add('رقم (0-9)');
    }
    if (!hasSpecialCharacter(password)) {
      missing.add('رمز خاص مثل @ ! % * ? & #');
    }
    return missing;
  }


  static int getPasswordStrength(String password) {
    if (password.isEmpty) return 0;
    int score = 0;
    if (hasMinLength(password)) score++;
    if (hasLowerCase(password)) score++;
    if (hasUpperCase(password)) score++;
    if (hasNumber(password)) score++;
    if (hasSpecialCharacter(password)) score++;
    return score;
  }


  static PasswordStrengthInfo getPasswordStrengthInfo(String password) {
    int strength = getPasswordStrength(password);
    if (strength == 0) {
      return PasswordStrengthInfo(text: '', color: Colors.grey, percent: 0);
    } else if (strength <= 2) {
      return PasswordStrengthInfo(text: 'ضعيفة', color: Colors.red, percent: 0.3);
    } else if (strength == 3) {
      return PasswordStrengthInfo(text: 'متوسطة', color: Colors.orange, percent: 0.6);
    } else if (strength == 4) {
      return PasswordStrengthInfo(text: 'جيدة', color: Colors.yellow.shade700, percent: 0.8);
    } else {
      return PasswordStrengthInfo(text: 'قوية', color: Colors.green, percent: 1.0);
    }
  }
}

class PasswordStrengthInfo {
  final String text;
  final Color color;
  final double percent; 
  PasswordStrengthInfo({required this.text, required this.color, required this.percent});
}

