import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({super.key});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  final languages = ['English', 'Hindi', 'Marathi'];
  String? value = 'English';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 79),
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black38, width: 2)),
        child: Padding(
          padding: const EdgeInsets.all(2.8),
          child: DropdownButton<String>(
            value: value,
            hint: Text("English"),
            borderRadius: BorderRadius.circular(15),
            items: languages.map(buildMenuItem).toList(),
            underline: SizedBox(),
            isExpanded: true,
            onChanged: (value) {
              setState(() {
                this.value = value;
              });
            },
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(item),
    );
  }
}
