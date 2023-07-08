import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerOfListView extends StatelessWidget {
  const ShimmerOfListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Row(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.yellow,
              child: const Card(
                child: SizedBox.square(
                  dimension: 200,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.yellow,
                  child: const Card(
                    child: SizedBox(
                      width: 150,
                      height: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.yellow,
                  child: const Card(
                    child: SizedBox(
                      width: 100,
                      height: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
