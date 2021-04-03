import 'package:antonx/core/models/app_user.dart';
import 'package:antonx/core/models/custom_auth_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_exceptions_services.dart';
import 'database_services.dart';

class AuthService {
  final _dbService = DatabaseService();
  final _auth = FirebaseAuth.instance;
  CustomAuthResult customAuthResult = CustomAuthResult();
  User user;
  bool isLogin;
  AppUser appUser;

  AuthService() {
    init();
  }

  init() async {
    user = _auth.currentUser;
    if (user != null) {
      isLogin = true;
      appUser = await _dbService.getUser(user.uid);
    } else {
      isLogin = false;
    }
  }

  updateUserProfile(AppUser user) {
    _dbService.updateUserProfile(user);
  }

  Future<CustomAuthResult> signUpWithEmailPassword(AppUser user) async {
    print('@services/singUpWithEmailPassword');
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      /// If user login fails without any exception and error code
      if (credentials.user == null) {
        customAuthResult.status = false;
        customAuthResult.errorMessage = 'An undefined Error happened.';
        return customAuthResult;
      }

      if (credentials.user != null) {
        customAuthResult.status = true;
        customAuthResult.user = credentials.user;
        user.id = credentials.user.uid;

        await _dbService.registerUser(user);
        this.appUser = user;

      }
    } catch (e) {
      print('Exception @sighupWithEmailPassword: $e');
      customAuthResult.status = false;
      customAuthResult.errorMessage =
          AuthExceptionsService.generateExceptionMessage(e);
    }
    return customAuthResult;
  }

  Future<CustomAuthResult> loginWithEmailPassword({email, password}) async {
    try {
      final credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credentials.user == null) {
        customAuthResult.status = false;
        customAuthResult.errorMessage = 'An undefined Error happened.';
      }

      ///
      /// If firebase auth is successful:
      ///
      /// Check if there is a user account associated with
      /// this uid in the database.
      /// If yes, then proceed to the auth success otherwise
      /// logout the user and generate an error for the user.
      ///
      if (credentials.user != null) {
//        final user = await _dbService.getVendorData(credentials.user.uid);
//        if (user == null) {
//          customAuthResult.status = false;
//          await logout();
//          customAuthResult.errorMessage =
//              "You don't have a Vendor account. Please create one and then proceed to login.";
//          return customAuthResult;
//        }
        this.appUser = await _dbService.getUser(credentials.user.uid);
        customAuthResult.status = true;
        customAuthResult.user = credentials.user;
      }
    } catch (e) {
      customAuthResult.status = false;
      customAuthResult.errorMessage =
          AuthExceptionsService.generateExceptionMessage(e);
    }
    return customAuthResult;
  }







  Future<void> logout() async {
    await _auth.signOut();
    this.isLogin = false;
    this.appUser = null;
    this.user = null;
  }

//  @override
   Future<CustomAuthResult> resetPassword(String email) async{
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      customAuthResult.status = false;
      customAuthResult.errorMessage = "Incorrect Email/ User may be deleted/ Badly Formatted ";
      print('Exception @FirebaseAuthService/resetPassword: $e');
    }
    return customAuthResult;
  }
}
