import 'package:flutter/material.dart';
import 'app_colors.dart';

// used common page for common used styles in the app
class AppTextStyles {
  static const TextStyle button = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle mediumBody = TextStyle(
    fontSize: 20,
    color: AppColors.textSecondary,
  );
  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static const TextStyle secondaryHeading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle heading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle body = TextStyle(fontSize: 14, color: Colors.black87);

  static const TextStyle label = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const TextStyle lightLabel = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static const TextStyle toast = TextStyle(fontSize: 14, color: Colors.white);
}
