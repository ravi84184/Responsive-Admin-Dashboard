import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String btnText;
  final Function onTap;

  const AppButton({Key? key, required this.btnText, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 30,
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          btnText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
