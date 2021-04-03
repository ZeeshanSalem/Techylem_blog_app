import 'package:antonx/core/constant/colors.dart';
import 'package:antonx/core/constant/text_style.dart';
import 'package:flutter/material.dart';

import 'asset_container.dart';

class UploadFileContainer extends StatelessWidget {
  final Function onPressed;

  UploadFileContainer({this.onPressed,});

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 58,vertical: 32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: backgroundColor,
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            ///
            /// Upload Icon
            ///
            AssetContainer(
              width: 45,
              height: 31,
              assets: "assets/static_assets/upload_Icon.png",
            ),

            SizedBox(height: 20,),

            ///
            /// Wrap Contain Text, and bluE tEXT
            ///
            RichText(
              textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Upload image for blog.",
                    style: subHeadingTextStyle,
                    children: [
                      TextSpan(
                        text: "Browse gallery",
                        style: subHeadingTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor.withOpacity(0.8)
                        ),
                      ),
                    ]
                )),




          ],
        ),
      ),
    );
  }


}



