import 'package:flutter/material.dart';

class AssetContainer extends StatelessWidget {
  final double height;
  final double width;
  final String assets;

  AssetContainer({this.height, this.width, this.assets});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      width: this.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(this.assets),
        )
      ),
    );
  }
}
