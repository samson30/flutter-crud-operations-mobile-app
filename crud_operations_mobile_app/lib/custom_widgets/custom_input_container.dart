import 'package:crud_operations_mobile_app/common/app_colors.dart';
import 'package:flutter/material.dart';

// Made use of it in the list page for textformfields design
class CustomInputContainer extends StatelessWidget {
  final Widget child;
  final bool isEnabled;

  const CustomInputContainer({
    super.key,
    required this.child,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(top: 10, bottom: 10),
      child: Container(
        padding: EdgeInsets.only(right: 10, left: 10),
        decoration: BoxDecoration(
          color: isEnabled ? AppColors.background : AppColors.disabledColor,

          borderRadius: BorderRadius.circular(20),
          border: BoxBorder.all(color: AppColors.inputBoxBorderColor),
        ),
        child: child,
      ),
    );
  }
}
