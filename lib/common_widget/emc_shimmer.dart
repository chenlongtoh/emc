import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EmcShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        enabled: true,
        child: ListView.builder(
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 8.0,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  height: 8.0,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  height: 8.0,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                FractionallySizedBox(
                  widthFactor: 0.85,
                  child: Container(
                    width: double.infinity,
                    height: 8.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          itemCount: 4,
        ),
      ),
    );
  }
}
