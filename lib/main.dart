import 'package:automatic_verifcation_otp/constants.dart';
import 'package:automatic_verifcation_otp/mobile_num_screen.dart';
import 'package:automatic_verifcation_otp/widgets/dropdown.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'AIzaSyCVAnZLMRZwYinAhATYvMnHE3E6cID6OEc',
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. debug provider
    // 2. safety net provider
    // 3. play integrity provider
    androidProvider: AndroidProvider.playIntegrity,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xff2E3B62, {
          50: Color.fromRGBO(4, 131, 184, .1),
          100: Color.fromRGBO(4, 131, 184, .2),
          200: Color.fromRGBO(4, 131, 184, .3),
          300: Color.fromRGBO(4, 131, 184, .4),
          400: Color.fromRGBO(4, 131, 184, .5),
          500: Color.fromRGBO(4, 131, 184, .6),
          600: Color.fromRGBO(4, 131, 184, .7),
          700: Color.fromRGBO(4, 131, 184, .8),
          800: Color.fromRGBO(4, 131, 184, .9),
          900: Color.fromRGBO(4, 131, 184, 1),
        }),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage('images/Gallery.png'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Please select your Language",
                      style: boldHeading,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "You can change the language\n at any time",
                      textAlign: TextAlign.center,
                      style: subheading,
                    ),
                  ),
                  DropDownWidget(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 80),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MobileNumScreen();
                        }));
                      },
                      child: Text(
                        "NEXT",
                        style: buttonTextStyle,
                      ),
                      style: CustomButtonStyle.buttonStyle(context),
                    ),
                  )
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
        ));
  }
}
