import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerGridView extends StatelessWidget {
  const ShimmerGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 20,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 368,
      ),
      itemBuilder: (_, __) {
        return Shimmer.fromColors(
          highlightColor: Colors.red.shade700,
          baseColor: Colors.grey.shade300,
          direction: ShimmerDirection.ttb,
          child: const Card(
            child: SizedBox(
              height: 368,
              width: 200,
            ),
          ),
        );
      },
    );
  }
}
