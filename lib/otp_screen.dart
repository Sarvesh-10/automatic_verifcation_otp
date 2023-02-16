import 'dart:math';

import 'package:automatic_verifcation_otp/constants.dart';
import 'package:automatic_verifcation_otp/profile_selection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:sms_autofill/sms_autofill.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen({
    required this.mobileNumber,
    required this.verficationId,
  });
  final mobileNumber;
  String verficationId;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? code;
  TextEditingController pinController = TextEditingController();
  String _incomingMsg = "Unknown";
  bool isLoading = false;
  void listenOTP() async {
    String? comingMsg;

    AltSmsAutofill().unregisterListener();
    try {
      comingMsg = await AltSmsAutofill().listenForSms;
    } on PlatformException {
      code = '';
    }
    if (!mounted) return;
    setState(() {
      _incomingMsg = comingMsg!;
      pinController.text = _incomingMsg[0] +
          _incomingMsg[1] +
          _incomingMsg[2] +
          _incomingMsg[3] +
          _incomingMsg[4] +
          _incomingMsg[5];
    });
    code = pinController.text;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenOTP();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    AltSmsAutofill().unregisterListener();
  }

  bool showProgIndic = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Verify Phone",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  "Code is sent to ${widget.mobileNumber}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      fieldHeight: 48,
                      fieldWidth: 48,
                      inactiveFillColor: Color(0xff93D2F3),
                      inactiveColor: Color(0xff93D2F3),
                      selectedColor: Color(0xff93D2F3),
                      selectedFillColor: Color(0xff93D2F3),
                      activeFillColor: Color(0xff93D2F3),
                      activeColor: Color(0xff93D2F3)),
                  cursorColor: Colors.white,
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  controller: pinController,
                  keyboardType: TextInputType.number,
                  boxShadows: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v) async {
                    //do something or move to next screen when code complete
                    code = pinController.text;
                    try {
                      setState(() {
                        showProgIndic = true;
                      });
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: widget.verficationId,
                              smsCode: code!);

                      // Sign the user in (or link) with the credential
                      UserCredential userCredential =
                          await auth.signInWithCredential(credential);

                      setState(() {
                        showProgIndic = false;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProfileSelection();
                      }));
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(e.toString()),
                            );
                          });
                    } finally {
                      setState(() {
                        showProgIndic = false;
                      });
                    }
                  },
                  onChanged: (value) {},
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Didn\'t recieve the code?',
                    style: TextStyle(color: Color(0xff6A6C7B)),
                  ),
                  TextButton(
                      onPressed: () {
                        
                      },
                      child: Text(
                        'Request Again',
                        style: TextStyle(color: Color(0xff061D28)),
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: widget.verficationId,
                            smsCode: pinController.text);

                    // Sign the user in (or link) with the credential
                    try {
                      await auth.signInWithCredential(credential);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProfileSelection();
                      }));
                    } catch (E) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(E.toString()),
                            );
                          });
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  style: CustomButtonStyle.buttonStyle(context),
                  child: showProgIndic
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "VERIFY AND CONTINUE",
                          style: buttonTextStyle,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
