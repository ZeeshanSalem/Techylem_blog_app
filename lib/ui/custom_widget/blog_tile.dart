import 'package:antonx/core/constant/colors.dart';
import 'package:antonx/core/constant/strings.dart';
import 'package:antonx/core/constant/text_style.dart';
import 'package:antonx/core/models/blog.dart';
import 'package:antonx/core/services/auth_services.dart';
import 'package:antonx/core/services/time_handler.dart';
import 'package:antonx/ui/locator.dart';
import 'package:antonx/ui/screens/blog/add_edit_blog_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogTile extends StatefulWidget {
  final Blog blog;
  BlogTile({this.blog});

  @override
  _BlogTileState createState() => _BlogTileState();
}

class _BlogTileState extends State<BlogTile> {
   String halfText;
   bool isReadFullContent = false;
   bool isEqual;
   final myUid = locator<AuthService>().appUser.id ?? "";

   @override
  void initState() {
    // TODO: implement initState
     if(widget.blog.content.length == 150){
       isEqual = true;
       halfText = widget.blog.content.substring(0, 150);
     } else if(widget.blog.content.length > 150){
       isEqual = false;
       halfText = widget.blog.content.substring(0, 150);
     }

      super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              widget.blog.imageUrl == null ?
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: FadeInImage(
                  height: 200,
                  width: double.infinity,
                  placeholder: AssetImage("${assetPath}google_icon.png"),
                  image: AssetImage("${assetPath}google_icon.png"),
                  fit: BoxFit.cover,
                ),
              ): ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: FadeInImage(
                  height: 200,
                  width: double.infinity,
                  placeholder: AssetImage("${assetPath}google_icon.png"),
                  image: NetworkImage(widget.blog.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),

              ///
              /// This padding used For Remain Widget
              ///
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ///
                  /// Row Container Publisher Name And Published Date
                  ///
                  Text("Published By: ${widget.blog.publishedBy ?? ""}", style: subHeadingTextStyle.copyWith(fontSize: 12),),
                  SizedBox(height: 5,),
                  Text("Published On: ${handleTime(widget.blog.publishedOn) ?? ""}", style: subHeadingTextStyle.copyWith(fontSize: 12),),

                  SizedBox(height: 10,),

                  Text("${widget.blog.heading ?? ""}", style: headingTextStyle.copyWith(fontSize: 14),),
                  SizedBox(height: 10,),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isReadFullContent ? Expanded(child: Text("${widget.blog.content ?? ""}",style: subHeadingTextStyle.copyWith(fontSize: 12),))
                          : Expanded(child: Text("${halfText ?? ""}",style: subHeadingTextStyle.copyWith(fontSize: 12),)),


                    ],
                  ),
                  isEqual ? Container() :
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          isReadFullContent =! isReadFullContent;
                        });
                      },
                      child: isReadFullContent ? Text(" Show Less",style: subHeadingTextStyle.copyWith(color: primaryColor, fontSize: 12),)
                          : Text(" Show More",style: subHeadingTextStyle.copyWith(color: primaryColor, fontSize: 12),),
                    ),
                  ),

                ],
              ),
              ),

            ],
          ),


         ///
          /// This is will be Render only on my blog
          ///
         Align(
           alignment: Alignment.topRight,
           child:  myUid == widget.blog.publisherId ?
           IconButton(
               icon: Container(
                 height: 40,
                   width: 40,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(50),
                     color: primaryColor,
                   ),
                   child: Center(child: Icon(Icons.edit, color: Colors.white, size: 20,))),
               onPressed: () => Get.to(() =>AddOrEditBlogScreen(
                 blog: widget.blog,
                 isEdit: true,
               ),),) :
           Container(),
         ),

        ],
      ),
    );
  }
}
