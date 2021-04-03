import 'package:antonx/ui/screens/registration_auth/login/login_view_model.dart';
import 'package:flutter/material.dart';

import '../input_text_form_field.dart';
import '../rectanguler_button.dart';

class EmailDialog extends StatefulWidget {


  @override
  _EmailDialogState createState() => _EmailDialogState();
}

class _EmailDialogState extends State<EmailDialog> {
  final _formKey = GlobalKey<FormState>();
   String email;
   TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        height: 200,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputTextFormField(
                hintText: "Email",
                controller: emailController,
                validation: (String val) {
                  if (val == null )
                    return 'Please Enter Your Email';
                  else
                    return null;
                },
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });

                },
              ),

              SizedBox(height: 20,),

              Align(
                alignment: Alignment.centerRight,
                child: RectangularButton(
                  text: "Confirm",
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      Navigator.pop(context,email);
                    }

                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
