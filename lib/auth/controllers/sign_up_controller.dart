import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart'as http;
import 'package:recepians/auth/utils/AppConst.dart';
import 'package:recepians/posts/posts_screen.dart';

import '../utils/sign_up_state.dart';
class signupCon extends GetxController {
  final state = signupState();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentPosition();
  }
  Future createUser(String id) async {
    var res = await http.post(Uri.parse('http://10.0.2.2/recepian/create_user.php'),
        body: {
          'id' :id,
          "email": state.emailCon.text.toString(),
          "password": state.passwordCon.text.toString(),
          "phoneNumber": state.phoneNumberCon.text.toString(),
          "locationLatitude": state.currentPosition!.latitude.toStringAsFixed(6),
          "locationLongitude": state.currentPosition!.longitude.toStringAsFixed(6)
        });
    if(res.statusCode == 200) {
      log('body:'+res.body.toString());
      var data = jsonDecode(res.body);
      print(data.toString());
      if(data['error'] == null) {
        print('..//////....');
        print('..//////....');
        print('..//////....');
        print('..//////....');
        print('..//////....');
        appConst.email=state.emailCon.text.toString();
        appConst.password=state.passwordCon.text.toString();
        appConst.id=int.parse(id);

        //appConst.id = int.parse(data['id']);
        //print(appConst.id=int.parse(data['id']));
        Get.off(() => PostsScreen());

        print('.....******......');
        print(state.currentPosition!.latitude);
        print(state.currentPosition!.longitude);
        print('.....******......');
        log('success');
        Get.snackbar('success', 'Sign Up successfully');
      }else {
        log('already exist');
        Get.snackbar('Error', 'already exist');
      }
    }
  }
  void onConfirm(context) async {
    String id = DateTime.now().microsecond.toString();
    try{
      await getCurrentPosition().then((value) async{
        await createUser(id);
      });
    }catch(e){
      print("Exception "+ e.toString());
    }

  }
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error', 'Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error', 'Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Error', 'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }
  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      state.currentPosition = position;
    }).catchError((e) {
      debugPrint(e);
    });
  }
}