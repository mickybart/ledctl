import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Waiting extends StatelessWidget {
  final double dimension;

  const Waiting({super.key, this.dimension = 16.0});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8.0,
      children: [
        SizedBox.square(
          dimension: dimension,
          child: CircularProgressIndicator(strokeWidth: 2.0),
        ),
        Text('wait'.tr)
      ],
    );
  }
}
