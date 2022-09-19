import 'package:flutter/material.dart';
import 'package:ttranport_01/theme.dart';


class PrimaryButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String TextButton;
  const PrimaryButton(
      {Key? key, required this.onPressed, required this.TextButton})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: MediaQuery.of(context).size.height * 0.08,
          width: double.infinity,
          //width: MediaQuery.of(context).size.width * 0.8,
          //margin: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 20),
          //margin: const EdgeInsets.only(bottom: 20),
          // ignore: deprecated_member_use
          child: RaisedButton(
            elevation: 5,
            color: kPrimaryColor,
            //hoverColor: kDarkGreyColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Text(
              TextButton,
              style: textButton.copyWith(color: kWhiteColor),
            ),
            onPressed: onPressed,
          )),
    );
  }
}