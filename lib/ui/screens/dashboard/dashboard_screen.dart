import 'package:antonx/core/constant/colors.dart';
import 'package:antonx/core/constant/strings.dart';
import 'package:antonx/core/constant/text_style.dart';
import 'package:antonx/core/enums/view_state.dart';
import 'package:antonx/ui/custom_widget/blog_tile.dart';
import 'package:antonx/ui/screens/blog/add_edit_blog_screen.dart';
import 'package:antonx/ui/screens/dashboard/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            
            body: model.state == ViewState.busy ? Center(child: CircularProgressIndicator()) :
            model.allBlogs.length < 1 ?
                _messageTile()
                :ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10,),
              shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 90),
                itemCount: model.allBlogs.length,
                itemBuilder: (context, index) => BlogTile(blog: model.allBlogs[index],)),
            
            floatingActionButton: FloatingActionButton(
              onPressed: () => Get.to(()=> AddOrEditBlogScreen()),
              tooltip: "Add Blog",
              backgroundColor: primaryColor,
              child: Icon(Icons.add, color: Colors.white,size: 25,),
            ),
          ),
        ),
      ),
    );
  }

  Widget _messageTile(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text("Ops, Blog found Kindly Add Your own Blog",
        style: subHeadingTextStyle1.copyWith(color: redColor),
      ),
    );
  }
}

