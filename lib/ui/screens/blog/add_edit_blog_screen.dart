import 'dart:io';

import 'package:antonx/core/constant/colors.dart';
import 'package:antonx/core/enums/view_state.dart';
import 'package:antonx/core/models/blog.dart';
import 'package:antonx/ui/custom_widget/input_text_form_field.dart';
import 'package:antonx/ui/custom_widget/rectanguler_button.dart';
import 'package:antonx/ui/custom_widget/upload_file_container.dart';
import 'package:antonx/ui/screens/blog/add_edit_blog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class AddOrEditBlogScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Blog blog;
  final bool isEdit;
  AddOrEditBlogScreen({this.blog, this.isEdit = false});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddEditBlogViewModel(blg: blog),
      child: Consumer<AddEditBlogViewModel>(
        builder: (context, model, child) => ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        icon: Icon(
                          Icons.cancel,
                          size: 25,
                          color: primaryColor,
                        ),
                        onPressed: () => Get.back(),
                      ),

                      ///
                      /// Image File
                      ///
                      model.blog.imagePath == null && model.blog.imageUrl == null
                          ? UploadFileContainer(
                              onPressed: () async{
                               await model.getImageFromGallery();
                              },
                            )
                          : _imageTile(
                              path: model.blog.imagePath,
                              imageUrl: model.blog.imageUrl,
                        onCancel: ()=> model.removeImage(),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      ///
                      /// Heading of Blog
                      ///

                      InputTextFormField(
                        hintText: "Enter Your Blog Heading",
                        validation: (String val) {
                          if (val == null || val.length < 1)
                            return 'Please enter your Blog Heading';
                          else
                            return null;
                        },
                        controller:
                            TextEditingController(text: model.blog.heading),
                        onChanged: (val) {
                          model.blog.heading = val;
                        },
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      InputTextFormField(
                        maxLength: 1000,
                        maxLine: 10,
                        hintText: "Enter Your Blog Content",
                        validation: (String val) {
                          if (val == null || val.length < 1)
                            return 'Please enter your Blog content';
                          else
                            return null;
                        },
                        controller:
                            TextEditingController(text: model.blog.content),
                        onChanged: (val) {
                          model.blog.content = val;
                        },
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      isEdit
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RectangularButton(
                                    text: "Delete", onPressed: () async{
                                     await  model.deleteBlog();
                                     Get.back();

                                }),
                                RectangularButton(
                                    text: "Update", onPressed: () async{
                                      await model.updateBlog();
                                      Get.back();
                                }),
                              ],
                            )
                          : RectangularButton(text: "Save", onPressed: () async{
                           await  model.uploadBlog();
                            Get.back();
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageTile({File path, String imageUrl, Function onCancel}) {
    return Stack(
      children: [
        path == null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  width: double.infinity,
                  height: 100,
                  placeholder:
                      AssetImage("assets/static_assets/upload_icon.png"),
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              )
            : Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: FileImage(path),
                      fit: BoxFit.cover,
                    )),
              ),

        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15,),
            child: IconButton(
              icon: Icon(Icons.cancel, size: 30, color: Colors.white,),
              onPressed: onCancel,
            ),
          ),
        ),
      ],
    );
  }
}
