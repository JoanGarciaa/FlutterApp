import 'package:flutter/material.dart';


class CustomRoundedButtonWithIcon extends StatelessWidget {
  final double? radius;
  final Color? splashColor;
  final Color? textColor;
  final Color? buttonColor;
  final String title;
  final Function onPressed;
  final IconData icon;
  final double size;
  const CustomRoundedButtonWithIcon(
      {Key? key,
        this.radius,
        this.splashColor,
        this.textColor,
        this.buttonColor,
        required this.title,
        required this.onPressed,
        required this.icon, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius ?? 50),
      onTap: onPressed as void Function()?,
      splashColor: splashColor ?? Colors.blue,
      child: Ink(
        width: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 50),
            border: Border.all(color: Colors.black),
            color: buttonColor ?? Colors.white,
            boxShadow: const [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.08))]),
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                Icon(
                  icon,
                  color: textColor ?? Colors.black,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(fontFamily: 'Poppins', color: Colors.black)
                ),
              ],
            )),
      ),
    );
  }
}