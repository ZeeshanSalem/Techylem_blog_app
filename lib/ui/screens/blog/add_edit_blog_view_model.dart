import 'dart:io';
import 'package:antonx/core/enums/view_state.dart';
import 'package:antonx/core/models/blog.dart';
import 'package:antonx/core/services/auth_services.dart';
import 'package:antonx/core/services/database_services.dart';
import 'package:antonx/core/services/storage_services.dart';
import 'package:antonx/core/view_models/base_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import '../../locator.dart';

class AddEditBlogViewModel extends BaseViewModel{
  Blog blog;
  final _dbStorage = DatabaseStorageServices();
  final _dbServices = DatabaseService();
  final _authService = locator<AuthService>();


  AddEditBlogViewModel({Blog blg}){
    if(blg == null){
      blog = Blog();
    } else{
      blog = blg;
    }
  }


  getImageFromGallery() async{
    setState(ViewState.busy);
    try{
      final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
      if(pickedImage != null){
        blog.imagePath = File(pickedImage.path);
      }
    }catch(e,s){
      print("@AddEditBlogViewModel getImageFromGallery() Exception $e");
      print(s);
    }
    setState(ViewState.idle);
  }

  removeImage(){
    setState(ViewState.busy);
    blog.imagePath = null;
    blog.imageUrl = null;
    setState(ViewState.idle);
  }

  uploadBlog() async{
    setState(ViewState.busy);
    try{
      if(blog.imageUrl == null && blog.imagePath != null){
        blog.imageUrl = await _dbStorage.uploadImage(blog.imagePath);
      }
      blog.publisherId = _authService.appUser.id ?? "";
      blog.publishedBy = _authService.appUser.name ?? "";
      blog.publishedOn = Timestamp.now();
      await _dbServices.addBlog(blog);
    }catch(e,s){
      print("AddEditBlogViewModel uploadBlog Exception $e");
      print(s);
    }
    setState(ViewState.idle);
  }

  updateBlog() async{
    setState(ViewState.busy);
    try{
      if(blog.imagePath != null){
        blog.imageUrl = await _dbStorage.uploadImage(blog.imagePath);
      }
      blog.publisherId = _authService.appUser.id ?? "";
      blog.publishedBy = _authService.appUser.name ?? "";
      blog.publishedOn = Timestamp.now();
      await _dbServices.updateBlog(blog);
    }catch(e,s){
      print("AddEditBlogViewModel updateBlog Exception $e");
      print(s);
    }
    setState(ViewState.idle);
  }

  deleteBlog() async{
    setState(ViewState.busy);
    try{
      await _dbServices.deleteBlog(blog.blogId);
    }catch(e,s){
      print("AddEditBlogViewModel deleteBlog Exception $e");
      print(s);
    }
    setState(ViewState.idle);
  }
}