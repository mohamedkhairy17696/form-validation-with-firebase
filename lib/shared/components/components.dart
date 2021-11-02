import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 10.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmitted,
  Function onChanged,
  Function onTap,
  @required Function validator,
  @required label,
  @required IconData prefix,
  bool isClickable = true,
  bool isPassword = false,
  IconData suffix,
  Function suffixPressed, String Function(String value) validate, Function onSubmit,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    onFieldSubmitted: onSubmitted,
    onChanged: onChanged,
    onTap: onTap,
    enabled: isClickable,
    validator: validator,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        prefix,
      ),
      suffixIcon: suffix != null
          ? IconButton(
              icon: Icon(suffix),
              onPressed: suffixPressed,
            )
          : null,
      border: OutlineInputBorder(),
    ),
  );
}

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget myDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Divider(
      color: Colors.grey,
      height: 1,
    ),
  );
}

void navigateTo(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );

void showToast({
  @required String text,
  @required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      return color = Colors.green;
      break;
    case ToastStates.ERROR:
      return color = Colors.red;
      break;
    case ToastStates.WARNING:
      return color = Colors.amber;
      break;
  }
  return color;
}