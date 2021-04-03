

import 'package:antonx/core/enums/view_state.dart';
import 'package:antonx/core/models/app_user.dart';
import 'package:antonx/core/models/custom_auth_result.dart';
import 'package:antonx/core/services/auth_services.dart';
import 'package:antonx/core/services/database_services.dart';
import 'package:antonx/core/view_models/base_view_model.dart';

import '../../../locator.dart';

class LoginViewModel extends BaseViewModel{
  AppUser appUser = AppUser();
  final _authService = locator<AuthService>();
  CustomAuthResult authResult;

  ///
  /// Login with Email and Password Functions
  ///

  loginWithEmailPassword() async {
    setState(ViewState.busy);
    authResult = await _authService.loginWithEmailPassword(
        email: appUser.email, password: appUser.password);
    setState(ViewState.idle);
  }

  resetPassword(email) async{
   setState(ViewState.busy);
   try {
     authResult = await _authService.resetPassword(email);
   }catch(e,s){
     print("resetPassword Exception $e");
   }
   setState(ViewState.idle);
  }

}