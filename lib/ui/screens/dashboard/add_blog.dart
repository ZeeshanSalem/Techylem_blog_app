import 'package:antonx/core/models/blog.dart';
import 'package:flutter/material.dart';

class AddBlog extends StatefulWidget {
  final Blog blog;
  AddBlog({this.blog});
  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController heading;
  TextEditingController content;

  @override
  void initState() {
    // TODO: implement initState
    heading = TextEditingController(text: widget?.blog?.heading ?? "");
    heading = TextEditingController(text: widget?.blog?.content ?? "");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(

        ),);
  }
}
