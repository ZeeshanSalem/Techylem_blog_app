import 'dart:io';

import 'package:antonx/core/services/auth_services.dart';
import 'package:antonx/ui/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  String imageUrl;
  String heading;
  String content;
  String creatorId;
  String blogId;
  File imagePath;
  Timestamp publishedOn;

  Blog({this.imageUrl, this.content, this.creatorId, this.publishedOn, this.heading, this.blogId, this.imagePath}){
   this.publishedOn = Timestamp.now();
   this.creatorId = locator<AuthService>().appUser.id ?? "";
  }

  Blog.fromJson(Map<String, dynamic> json, id) {
    imageUrl = json['imageUrl'];
    heading = json['heading'];
    content = json['content'];
    creatorId = json['creatorId'];
    publishedOn = json['publishedOn'];
    this.blogId = id;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['heading'] = this.heading;
    data['content'] = this.content;
    data['creatorId'] = this.creatorId;
    data['publishedOn'] = this.publishedOn;
    return data;
  }
}
