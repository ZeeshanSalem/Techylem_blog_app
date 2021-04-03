import 'dart:io';

import 'package:antonx/core/services/auth_services.dart';
import 'package:antonx/ui/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  String imageUrl;
  String heading;
  String content;
  String publisherId;
  String blogId;
  File imagePath;
  Timestamp publishedOn;
  String publishedBy;

  Blog({this.imageUrl, this.content, this.publisherId, this.publishedOn, this.heading, this.blogId, this.imagePath});

  Blog.fromJson(Map<String, dynamic> json, id) {
    imageUrl = json['imageUrl'];
    heading = json['heading'];
    content = json['content'];
    publisherId = json['publisherId'];
    publishedOn = json['publishedOn'];
    publishedBy = json['publishedBy'];
    this.blogId = id;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['heading'] = this.heading;
    data['content'] = this.content;
    data['publisherId'] = this.publisherId;
    data['publishedOn'] = this.publishedOn;
    data['publishedBy'] = this.publishedBy;
    return data;
  }
}
