import 'package:automatic_verifcation_otp/constants.dart';
import 'package:automatic_verifcation_otp/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class MobileNumScreen extends StatefulWidget {
  @override
  State<MobileNumScreen> createState() => _MobileNumScreenState();
}

class _MobileNumScreenState extends State<MobileNumScreen> {
  final TextEditingController mobileController = TextEditingController();
  bool isError = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Please enter your mobile number",
                      textAlign: TextAlign.center,
                      style: boldHeading,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "You'll recieve a 6 digit code\n to verify next",
                      textAlign: TextAlign.center,
                      style: subheading,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextField(
                      controller: mobileController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorText: isError
                            ? (mobileController.text.isEmpty
                                ? 'This field cannot be empty'
                                : 'Number should be of 10 digit')
                            : null,
                        border: OutlineInputBorder(),
                        hintText: '\tMobile Number',
                        hintStyle: TextStyle(
                            color: Color(0xff6A6C7B),
                            fontWeight: FontWeight.w400),
                        prefix: Text(
                          "+91\t-\t ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        prefixIcon: Image(
                            width: 18,
                            height: 20,
                            image: AssetImage('images/india 2.png')),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if (mobileController.text.isEmpty ||
                            mobileController.text.length != 10) {
                          setState(() {
                            isError = true;
                            isLoading = false;
                          });
                        } else {
                          setState(() {
                            isError = false;
                          });

                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: '+91' + mobileController.text,
                            verificationCompleted:
                                (PhoneAuthCredential credential) {
                                  
                                },
                            verificationFailed: (FirebaseAuthException e) {
                              setState(() {
                                isLoading = false;
                              });
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(e.toString()),
                                    );
                                  });
                            },
                            codeSent:
                                (String verificationId, int? resendToken) {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return OTPScreen(
                                  mobileNumber: mobileController.text,
                                  verficationId: verificationId,
                                );
                              }));
                            },
                            codeAutoRetrievalTimeout:
                                (String verificationId) {},
                          );
                        }
                      },
                      style: CustomButtonStyle.buttonStyle(context),
                      child: Text(
                        "CONTINUE",
                        style: buttonTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Image(
                    fit: BoxFit.fill,
                    image: AssetImage('images/Wave2.png'),
                    width: MediaQuery.of(context).size.width,
                  ),
                  Image(
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                    image: const AssetImage('images/Wave1.png'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
