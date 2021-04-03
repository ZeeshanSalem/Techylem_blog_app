import 'dart:async';

import 'package:antonx/core/enums/view_state.dart';
import 'package:antonx/core/models/blog.dart';
import 'package:antonx/core/services/auth_services.dart';
import 'package:antonx/core/services/database_services.dart';
import 'package:antonx/core/view_models/base_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../locator.dart';

class DashboardViewModel extends BaseViewModel{
  List<Blog> allBlogs = [];
  final _dbServices = DatabaseService();
  StreamSubscription streamSubscription;
  final authService = locator<AuthService>();
  String myUid;

  DashboardViewModel(){
    myUid = authService.appUser.id;
    getAllBlog();
  }


  ///
  /// getAll Blogs
  ///
  getAllBlog(){
    setState(ViewState.busy);
    try {
      Stream<QuerySnapshot> myStream = _dbServices.getAllBlog();
      streamSubscription = myStream.listen((event) {
        if (event.docs.length < 1){
          allBlogs = [];
          print("No Blog is Uploaded right Now");
          return;
        }
        allBlogs = [];
        for(int i = 0 ; i < event.docs.length; i++){
          allBlogs.add(Blog.fromJson(event.docs[i].data(), event.docs[i].id));
          notifyListeners();
        }
      });
    } catch(e,s){
      print("@DashboardViewModel getAllBlog() Exception $e");
      print(s);
    }
    setState(ViewState.idle);

  }

  ///
  /// Logout
  ///
  logout() async{
    setState(ViewState.busy);
//    myUid = authService.appUser.id;
    await authService.logout();
    setState(ViewState.idle);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    streamSubscription.cancel();
    super.dispose();
  }

}