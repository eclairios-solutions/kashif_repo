import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'package:recepians/auth/utils/AppConst.dart';
class UserProfile extends StatefulWidget {
  const UserProfile({super.key,required this.email,required this.password});
  final String email;
  final String password;


  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }
  Future<void> fetchUserDetails() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2/recepian/fetch_user.php'),
      body: {
        'id': appConst.id.toString()
        //'password': widget.password,
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        userData = json.decode(response.body);
      });
    } else {
      print('Failed to fetch user details');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            IgnorePointer(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Padding(
                    padding:  EdgeInsets.only(top:10,left: 10,right: 10),
                    child: FaIcon(FontAwesomeIcons.idCard,size: 27,),
                  ),
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black54),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black26),
                  ),
                  labelStyle: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  contentPadding: const EdgeInsets.only(
                    top: 10,
                    left: 20,

                  ),
                  label: Text('id: ${userData!['id']}'),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            IgnorePointer(
              child: TextField(
                decoration: InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black54),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black26),
                  ),
                  labelStyle: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  prefixIcon: const Padding(
                    padding:  EdgeInsets.only(top:10,left: 10,right: 10),
                    child: FaIcon(FontAwesomeIcons.envelope,size: 27,),
                  ),
                  contentPadding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                  ),
                  label: Text('Email: ${userData!['email']}'),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                //con.numberAlertBox(context, userData!['email']);
              },
              child: IgnorePointer(
                child: TextField(
                  decoration: InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black54),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black26),
                    ),
                    labelStyle: GoogleFonts.openSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    prefixIcon: const Padding(
                      padding:  EdgeInsets.only(top:10,left: 10,right: 10),
                      child: FaIcon(FontAwesomeIcons.mobileScreen,size: 27,),
                    ),
                    contentPadding:const EdgeInsets.only(
                      top: 10,
                      left: 20,
                    ),
                    label: Text('Number: ${userData!['phoneNumber']}'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                //con.passwordAlertBox(context, userData!['id']);
              },
              child: IgnorePointer(
                child: TextField(
                  decoration: InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black26),
                    ),
                    labelStyle: GoogleFonts.openSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top:10,left: 10,right: 10),
                      child: FaIcon(FontAwesomeIcons.lock,size: 27,),
                    ),
                    contentPadding: EdgeInsets.only(
                      top: 10,
                      left: 20,
                    ),
                    label: Text('password: ${userData!['password']}'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            IgnorePointer(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(top:10,left: 10,right: 10),
                    child: FaIcon(FontAwesomeIcons.locationCrosshairs,size: 27,),
                  ),
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black54),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black26),
                  ),
                  labelStyle: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  contentPadding: EdgeInsets.only(
                    top: 10,
                    left: 20,

                  ),
                  label: Text('Latitude: ${userData!['locationLatitude']}'),
                ),
              ),
            ),
            SizedBox(height: 20,),
            IgnorePointer(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(top:10,left: 10,right: 10),
                    child: FaIcon(FontAwesomeIcons.locationCrosshairs,size: 27,),
                  ),
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black54),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black26),
                  ),
                  labelStyle: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  contentPadding: EdgeInsets.only(
                    top: 10,
                    left: 20,
                  ),
                  label: Text('Longitude: ${userData!['locationLongitude']}'),
                ),
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
