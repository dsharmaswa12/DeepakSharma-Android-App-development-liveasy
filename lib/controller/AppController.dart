import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';

class AppController extends GetxController {
  var dropdownValue = 'English'.obs;

  void updateLanguage(String newValue) {
    dropdownValue.value = newValue;
  }



  var mobileNumber = ''.obs;
  var isCodeSent = false.obs;

  FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController mobileNumberController = TextEditingController();


  void clearMobileNumber() {
    mobileNumberController.clear();
    mobileNumber.value = '';
  }


  void updateMobileNumber(String value) {
    mobileNumber.value = value;
  }

  @override
  void onClose() {
    mobileNumberController.dispose();
    super.onClose();
  }


  var otp = ''.obs;


  void updateOtpValue(String value) {
    otp.value = value;
  }


  void clearFields() {
    otp.value = '';
  }


  var isVerifying = false.obs;
  var selectedType = 'shipper'.obs;

  void selectType(String type) {
    selectedType.value = type;
  }

  void CheckOTP(BuildContext context,String VerificationId) async {
    isVerifying.value = true;
    try{
      PhoneAuthCredential credential =await PhoneAuthProvider.credential(
          verificationId: VerificationId, smsCode: otp.value);
      _auth.signInWithCredential(credential)
          .catchError((e) {
        isVerifying.value = false;
        Get.snackbar(
          'Invalid OTP',
          '$e',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(10),
        );
      })
      .then((value) {
        isVerifying.value = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text('OTP verified successfully',textAlign: TextAlign.center),
          ),
        );
        return  Get.offAll( Home());
      }
      );

    }catch(e){
      isVerifying.value = false;
      Get.snackbar(
        'Failed to send OTP',
        '$e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
      );
    }

  }
  void verifyPhoneNumber() async {
    isCodeSent.value = true;

    try{
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91${mobileNumber.value}",
      timeout: Duration(seconds: 60),
      verificationCompleted: (
          PhoneAuthCredential credential) async{
    await _auth.signInWithCredential(credential);
    Get.snackbar('Success', 'Phone number automatically verified.',
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(10),);
      },
      verificationFailed: (FirebaseAuthException e) {isCodeSent.value = false;

      Get.snackbar('Error', e.message ?? 'Verification failed.', backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),);
      },
      codeSent: (String verificationId, int? resendToken) {
      isCodeSent.value = false;
      Get.snackbar('OTP Sent', 'OTP has been sent to your phone.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
      Get.to(VerifyOTP(VerificationId: verificationId));
      },
       codeAutoRetrievalTimeout: (String verificationId) {isCodeSent.value = false;},
    );
    }catch(e){
      Get.snackbar('Error', 'Failed to send OTP', backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),);
    }
  }
}
