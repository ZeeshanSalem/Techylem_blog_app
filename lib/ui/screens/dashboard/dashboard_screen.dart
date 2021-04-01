import 'package:antonx/core/constant/colors.dart';
import 'package:antonx/core/constant/strings.dart';
import 'package:antonx/core/constant/text_style.dart';
import 'package:antonx/ui/screens/dashboard/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardViewModel(),
      child: Consumer<DashboardViewModel>(
        builder: (context, model, child) =>
        SafeArea(
          child: Scaffold(
            backgroundColor: backgroundColor,
            
            body: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10,),
              shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                itemCount: 20,
                itemBuilder: (context, index) => BlogTile()),
            
            floatingActionButton: FloatingActionButton(
              onPressed: (){},
              tooltip: "Add Blog",
              backgroundColor: primaryColor,
              child: Icon(Icons.add, color: Colors.white,size: 25,),
            ),
          ),
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          FadeInImage(
              height: 100,
              width: double.infinity,
              placeholder: AssetImage("${assetPath}google_icon.png"),
              image: AssetImage("${assetPath}blog.jpg"),
          ),

          //          ? FadeInImage(
//                                          width: double.infinity,
//                                          height: 200,
//                                          placeholder: AssetImage(
//                                              "assets/static_assets/geans.png"),
//                                          image: AssetImage(
//                                              "assets/static_assets/geans.png"),
//                                          fit: BoxFit.cover,
//                                        )
//                                      : FadeInImage(
//                                          width: double.infinity,
//                                          height: 200,
//                                          placeholder: AssetImage(
//                                              "assets/static_assets/geans.png"),
//                                          image: NetworkImage(
//                                              model.product.imageUrl),
//                                          fit: BoxFit.cover,
//

          SizedBox(height: 20,),

          Text("Blog Heading", style: headingTextStyle.copyWith(fontSize: 14),),
          SizedBox(height: 10,),

          Text("I am Assala kbciasc ac98 ,msnciuabmc scn8 3333 iudcamc yam cksncoisac asd,cnoiasdca"
              "vaksjcadsjbciaskm cksanciaskcmn asc"
              "cnsdakjcnkadsncasdjckasdvbuydfvbsv iaosu asmcasdic asd da asd isa as".substring(0, 100) + "...",
            
            style: subHeadingTextStyle.copyWith(fontSize: 12),),

        ],
      ),
    );
  }
}
