import 'package:automatic_verifcation_otp/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileSelection extends StatefulWidget {
  @override
  State<ProfileSelection> createState() => _ProfileSelectionState();
}

class _ProfileSelectionState extends State<ProfileSelection> {
  int selectedValue = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Please select your profile",
              style: boldHeading,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: RadioListTile<int>(
                selectedTileColor: Theme.of(context).primaryColor,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value!;
                  });
                },
                value: 0,
                groupValue: selectedValue,
                title: ListTile(
                  leading: Image(
                    image: AssetImage(
                      'images/shipper.png',
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Shipper",
                      style: radioTitleStyle,
                    ),
                  ),
                  subtitle: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "Lorem ipsum dolor sit amet,consectetur adipiscing",
                        style: radioSubTitleStyle,
                      )),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: RadioListTile<int>(
                selectedTileColor: Theme.of(context).primaryColor,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value!;
                  });
                },
                value: 1,
                groupValue: selectedValue,
                title: ListTile(
                  leading: Image(
                    image: AssetImage('images/transport.png'),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Transporter",
                      style: radioTitleStyle,
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Lorem ipsum dolor sit amet,consectetur adipiscing",
                      style: radioSubTitleStyle,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "CONTINUE",
                  style: buttonTextStyle,
                ),
                style: CustomButtonStyle.buttonStyle(context),
              ),
            )
          ],
        ),
      )),
    );
  }
}
