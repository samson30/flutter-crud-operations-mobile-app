import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// although you may not see waiting shimmers in the current app as I used local database. I have used this to maintain standards.
class EnrollEmployeeShimmer extends StatelessWidget {
  const EnrollEmployeeShimmer({super.key});

  Widget _shimmerBox({double height = 48, double width = double.infinity}) {
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _shimmerBox(),
            _shimmerBox(),
            _shimmerBox(),
            _shimmerBox(height: 100),
            _shimmerBox(),
          ],
        ),
      ),
    );
  }
}
