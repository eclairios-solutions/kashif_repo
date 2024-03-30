import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:recepians/auth/utils/AppConst.dart';
import 'package:recepians/posts/posts_screen.dart';
import 'package:http/http.dart'as http;

import '../utils/login_state.dart';

class loginCon extends GetxController{
  final state = loginState();
  Future<void> loginUser(String email, String password) async {
    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2/recepian/login_user.php'),
        body: {
          "email": email,
          "password": password,
        },
      );
      print('..//////....');
      print(response.body);
      print(response.statusCode);
      print(response);
      print('..//////....');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']!=null) {
          print('..//////....');
          print('..*....');
          print('email:'+email.toString());
          print('password:'+password.toString());
          print('..//////....');
          print('..*....');
          appConst.email=email.toString();
          appConst.password=password.toString();
          //appConst.id=int.parse(id);
          print('..//////....');
          print('..*....');
          print('appConst.email:'+email.toString());
          print('appConst.password:'+password.toString());
          print('..//////....');
          print('..*....');
          Get.off(() => const PostsScreen());
          // Get.off(() => userProfile(
          //   email: email,password:password,
          // ));
          // Get.offAll(() => HomePage());
          Get.snackbar('success', 'Log in successfully');
        } else {
          Get.snackbar('Error', 'Incorrect Credentials');
        }
      } else {
        Get.snackbar('Error', 'Failed to connect to server');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print(e.toString());
    }
  }
}