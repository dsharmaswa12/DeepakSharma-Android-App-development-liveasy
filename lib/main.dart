import 'package:firebase_core/firebase_core.dart'
    show Firebase, FirebaseOptions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'CustomWidget/CustomWidget.dart';
import 'color.dart';
import 'controller/AppController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDjwDYCk8vy4mkuusyA0itr1aZOAcwv0eM",
        appId: "1:753182271388:android:11299a45923b571ea80a59",
        messagingSenderId: "753182271388",
        projectId: "deepakandroidappaevelopment",
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: _buildTheme(Brightness.light),
      home: SelectLanguage(),
    );
  }

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
    );
  }

}


class SelectLanguage extends StatefulWidget {
  @override
  _SelectLanguageState createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  final otpController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    otpController.clearMobileNumber();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(15.0),
                width: 100,
                height: 100,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child:
                SvgPicture.asset(
                  'assets/images/image.svg', 
                  height: 100.0, 
                  width: 100.0, 
                ),

              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Please select your Language',
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 0.07,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                width: 250,
                child: const Text(
                  'You can change the language at any time.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 0.07,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              Container(
                width: 216,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: DropdownButtonHideUnderline(
                  child: Obx(
                        () =>
                        DropdownButton<String>(
                          value: otpController.dropdownValue.value,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? newValue) {
                            otpController.updateLanguage(newValue!);
                          },
                          items: <String>[
                            'English',
                            'Hindi',
                            'Spanish',
                            'French',
                            'German'
                          ]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextButton(
                  onPressed: () {
                    Get.to(
                        GenrateOTP()); 
                  },
                  child: Container(
                    width: 216,
                    height: 56,
                    decoration: const BoxDecoration(color: AppColors.primaryColor),
                    padding: const EdgeInsets.all(10),
                    child: const Center(
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: AppColors.buttonTextColor,
                          fontSize: 16,
                          letterSpacing: 0.07,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Stack(
                children: [
                  
                  Positioned.fill(
                    child: SvgPicture.asset(
                      'assets/images/vector.svg', 
                      fit: BoxFit.fill, 
                    ),
                  ),
                  Positioned.fill(
                    child: SvgPicture.asset(
                      'assets/images/vector2.svg', 
                      fit: BoxFit.fill, 
                    ),
                  ),
                  
                  SizedBox(
                    width: Get.width,
                    height: Get.height * 0.1,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GenrateOTP extends StatelessWidget {
  GenrateOTP({super.key});

  final otpController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 40, color: Colors.black),
                    onPressed: () {
                      Get.back(); 
                    },
                  ),
                ),
              ),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.1),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Please enter your mobile number',
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 0.07,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                width: 250,
                child: const Text(
                  'You’ll receive a 6 digit code to verify next.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 0.07,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25.0),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 5),
                    SvgPicture.asset(
                      'assets/images/india.svg', 
                      height: 40.0, 
                      width: 40.0, 
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      "+91",
                      style: TextStyle(
                        color: AppColors.e0xFF2F3037,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text("-", style: TextStyle(
                      color: AppColors.e0xFF2F3037,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: otpController.mobileNumberController,
                        autofocus: true,

                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        autofillHints: [AutofillHints.telephoneNumberDevice],
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) =>
                            otpController.updateMobileNumber(value),

                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          counterText: '',
                          border: InputBorder.none,
                          hintText: 'Mobile Number',
                          hintStyle: TextStyle(
                            color: AppColors.e0xFF2F3037,
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Obx(
                      () =>
                      otpController.isCodeSent.value==true?
                        const CircularProgressIndicator( color: AppColors.primaryColor,)
                          :
                 Container(
                margin: const EdgeInsets.symmetric(horizontal: 13.0),
                child: TextButton(

                  onPressed: () async {
                    if (otpController.mobileNumber.value.length == 10) {
                      otpController.verifyPhoneNumber();
                    } else {
                      Get.snackbar(
                        'Invalid Number',
                        'Please enter a valid 10-digit mobile number.',
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        margin: const EdgeInsets.all(10),
                      );
                    }
                  },
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                        color: otpController.mobileNumber.value.length == 10
                            ? AppColors.primaryColor
                            : Colors.grey[400],),
                    child: const Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: AppColors.buttonTextColor,
                          fontSize: 16,
                          letterSpacing: 0.07,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              )
      ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class VerifyOTP extends StatefulWidget {
  String VerificationId;

  VerifyOTP({super.key, required this.VerificationId});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> with CodeAutoFill{
  
  final otpController = Get.put(AppController());

  @override
  void codeUpdated() {
    otpController.updateOtpValue(code ?? "");
  }

  @override
  void initState() {
    super.initState();
    otpController.clearFields();
    listenForCode();
  }

  @override
  void dispose() {
    cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(

          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(10),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, size: 40, color: Colors.black),
                  onPressed: () {},
                ),
              ),
            ),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.1),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Verify Phone',
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 0.07,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              width: 250,
              child: Text(
                'Code is sent to ${otpController.mobileNumber.value}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  letterSpacing: 0.07,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColor, 
                ),
              ),
            ),
            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: PinFieldAutoFill(
                autoFocus: true,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                textInputAction: TextInputAction.done,
                currentCode: otpController.otp.value,
                codeLength: 6,
                decoration:BoxLooseDecoration(
                  strokeColorBuilder: const FixedColorBuilder(AppColors.e0xFF93D2F3),
                  bgColorBuilder: const FixedColorBuilder(AppColors.e0xFF93D2F3),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  radius: const Radius.circular(0),
                ),
                onCodeChanged: (code) {
                  otpController.updateOtpValue(code ?? "");
                },
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Didn’t receive the code? ',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 0.07,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor,
                      ),
                    ),
                    TextSpan(
                      text: 'Request Again',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 0.07,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF061D28),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Obx(() =>otpController.isVerifying.value==true?
            const CircularProgressIndicator( color: AppColors.primaryColor,):Container(
              margin: const EdgeInsets.symmetric(horizontal: 13.0),
              child: TextButton(
                onPressed: () async {
                  if(otpController.otp.value.length == 6) {
                    otpController.CheckOTP(context, widget.VerificationId);
                  }
                },
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: otpController.otp.value.length == 6 ? AppColors.primaryColor
                        : Colors.grey[400]
                   ),
                  child: const Center(
                    child: Text(
                      'VERIFY AND CONTINUE',
                      style: TextStyle(
                        color: AppColors.buttonTextColor,
                        fontSize: 16,
                        letterSpacing: 0.07,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              )
            ),
            const Spacer(),

          ],
        ),
      ),
    );
  }
}


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () {
         showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Confirm Exit",textAlign: TextAlign.center),
                content: const Text("Are you sure you want to exit app?"),
                actions: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
                        textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white))
                    ),

                  child: const Text("Exit"),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),

                    ),
                    child: const Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
        );
        return Future.value(true);
      },
      child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.1),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Please select your profile',
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 0.07,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),


                  GestureDetector(
                    onTap: () {
                      controller.selectType('shipper');
                    },
                    child: Obx(() =>
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25.0),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              CustomRadio(isSelected: controller.selectedType
                                  .value == 'shipper'),
                              const SizedBox(width: 30),
                              SvgPicture.asset(
                                'assets/images/group.svg',
                                height: 50.0,
                                width: 100.0,

                              ),

                              const SizedBox(width: 10),
                              const Expanded(
                                child: ListTile(
                                  title: Text(
                                    'Shipper',
                                    style: TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 0.07,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.e0xFF2F3037,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing',
                                    style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 0.07,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),

                  const SizedBox(height: 20),


                  GestureDetector(
                    onTap: () {
                      controller.selectType('transport');
                    },
                    child: Obx(() =>
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25.0),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              CustomRadio(isSelected: controller.selectedType
                                  .value == 'transport'),
                              const SizedBox(width: 30),

                              SvgPicture.asset(
                                'assets/images/group2.svg',
                                height: 35.0,
                                width: 50.0,
                              ),

                              const SizedBox(width: 10),
                              const Expanded(
                                child: ListTile(
                                  title: Text(
                                    'Transporter',
                                    style: TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 0.07,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.e0xFF2F3037,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing',
                                    style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 0.07,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),

                  const SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: TextButton(
                      onPressed: () {
                        Get.offAll(SelectLanguage());
                      },
                      child: Container(
                        height: 56,
                        decoration: const BoxDecoration(color: AppColors.primaryColor),
                        child: const Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: AppColors.buttonTextColor,
                              fontSize: 16,
                              letterSpacing: 0.07,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
    );
  }
}