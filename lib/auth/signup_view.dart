import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:recepians/auth/widgets/reusable_text.dart';

import 'controllers/sign_up_controller.dart';
class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(signupCon());
    return   Scaffold(
      appBar: AppBar(
        title: Text('SignUp Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: 40,),
              ReuseableTextField(
                  contr: controller.state.emailCon,
                  label: 'enter your email',
                  textInputAction: TextInputAction.next,
                  prefixIcon: FontAwesomeIcons.mailchimp,
                  useEmailValidation: true,
                  keyboardType: TextInputType.emailAddress,
                  obsecure: false),
              SizedBox(height: 20,),
              ReuseableTextField(
                  contr: controller.state.passwordCon,
                  label: 'enter your password',
                  prefixIcon: FontAwesomeIcons.lock,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  obsecure: false),
              SizedBox(height: 20,),
              ReuseableTextField(
                  contr: controller.state.confirmPasswordCon,
                  label: 'confirm your password',
                  prefixIcon: FontAwesomeIcons.lock,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  obsecure: false),
              SizedBox(height: 20,),
              ReuseableTextField(
                  contr: controller.state.phoneNumberCon,
                  label: 'enter your phoneNumber',
                  prefixIcon: FontAwesomeIcons.mobile,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                  obsecure: false),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                if(controller.state.emailCon.text.isNotEmpty && controller.state.passwordCon.text.isNotEmpty && controller.state.confirmPasswordCon.text.isNotEmpty && controller.state.phoneNumberCon.text.isNotEmpty){
                  if(controller.state.passwordCon.text == controller.state.confirmPasswordCon.text){
                    controller.onConfirm(context);
                  }else{
                    Get.snackbar('Error', 'Password does not match');
                  }
                }else{
                  Get.snackbar('something missing', 'All fields must be filled');

                }

              }, child: const Text('create User',style: TextStyle(
                  color: Colors.black)))

            ],
          ),
        ),
      ),
    );
  }
}
