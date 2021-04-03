import 'package:antonx/core/models/app_user.dart';
import 'package:antonx/core/models/blog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final _db = FirebaseFirestore.instance;
  static final DatabaseService _singleton = DatabaseService._internal();

  factory DatabaseService() {
    return _singleton;
  }

  DatabaseService._internal();

  ///
  /// Register User
  ///
  registerUser(AppUser user) async {
    print(user.id + "ID is-------");
    try {
      await _db
          .collection('reg_users')
          .doc(user.id)
          .set(user.toJson());
    } catch (e, s) {
      print('Exception @DatabaseService/registerPatient $e');
//      print(s);
    }
  }

  ///
  /// Get User
  ///
  Future<AppUser> getUser(id) async {
    print('@getUser: id: $id');
    try {
      final snapshot = await _db.collection('reg_users').doc(id).get();
      print('User Data: ${snapshot.data()}');
      return AppUser.fromJson(snapshot.data(), snapshot.id);
    } catch (e, s) {
      print('Exception @DatabaseService/getUser $e');
//      print(s);
      return null;
    }
  }

  ///
  /// Update User Profile
  updateUserProfile(AppUser appUser) async {
    print('@updateUserProfile: ${appUser.id}');
    await _db
        .collection('reg_users')
        .doc(appUser.id)
        .update(appUser.toJson());
  }

  ///
  /// Add blog to firestore
  ///
  addBlog(Blog blog) async{
    try{
      await _db.collection("blogs").add(blog.toJson());
    }catch(e,s){
      print("@DatabaseService addBlog Exception $e");
      print(s);
    }
  }

  ///
  /// Update blog in firestore
  ///
  updateBlog(Blog blog) async{
    try{
      await _db.collection("blogs").doc(blog.blogId).update(blog.toJson());
    }catch(e,s){
      print("@DatabaseService updateBlog Exception $e");
      print(s);
    }
  }

  ///
  /// Delete blog in firestore
  ///
  deleteBlog(blogId) async{
    try{
      await _db.collection("blogs").doc(blogId).delete();
    }catch(e,s){
      print("@DatabaseService deleteBlog Exception $e");
      print(s);
    }
  }

  ///
  /// Get All Blog
  ///
  Stream<QuerySnapshot> getAllBlog(){
    Stream<QuerySnapshot> snapshot;
    try{
       snapshot = _db.collection("blogs").snapshots();

    }catch(e, s){
      print("@DatabaseService getAllBlog Exception $e");
      print(s);
    }
    return snapshot;
  }

}