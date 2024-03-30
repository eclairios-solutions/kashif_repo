
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class signupState {
  final emailCon = TextEditingController();
  final confirmPasswordCon = TextEditingController();
  final passwordCon = TextEditingController();
  final locationCon = TextEditingController();
  final phoneNumberCon = TextEditingController();
  // late LocationData locationData;


  String? currentAddress;
  Position? currentPosition;

}