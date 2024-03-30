import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:recepians/auth/signup_view.dart';
import 'package:recepians/auth/widgets/reusable_text.dart';

import 'controllers/login_controllers.dart';
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(loginCon());
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 350,),
                ReuseableTextField(
                    contr: controller.state.emailCon,
                    label: 'enter your email',
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.email,
                    useEmailValidation: true,
                    keyboardType: TextInputType.emailAddress,
                    obsecure: false),
                SizedBox(height: 20,),
                ReuseableTextField(
                    contr: controller.state.passwordCon,
                    label: 'enter your password',
                    prefixIcon: Icons.lock,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    obsecure: false),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: (){
                      controller.loginUser(controller.state.emailCon.text,controller.state.passwordCon.text);
                    }, child: const Text('log in ',style: TextStyle(
                        color: Colors.black
                    ),)),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){
                      Get.to(()=>const SignUpView());
                    }, child: const Text('sign up',style: TextStyle(
                        color: Colors.black)))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
