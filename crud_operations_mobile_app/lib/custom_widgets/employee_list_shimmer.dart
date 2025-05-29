import 'package:crud_operations_mobile_app/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// although you may not see waiting shimmers in the current app as I used local database. I have used this to maintain standards.
class EmployeeListShimmer extends StatelessWidget {
  const EmployeeListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: AppColors.disabledColor,
        highlightColor: AppColors.disabledColor,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.disabledColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.background,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: double.infinity,
                      color: AppColors.background,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 14,
                      width: 100,
                      color: AppColors.background,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
