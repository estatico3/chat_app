import 'package:flutter/material.dart';

class AuthorizationTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIconData;
  final TextInputType keyboardType;
  final Function(String) validator;
  final bool isObscure;

  const AuthorizationTextField({
    Key key,
    @required this.controller,
    @required this.labelText,
    @required this.prefixIconData,
    @required this.keyboardType,
    @required this.validator,
    this.isObscure = false,
  })  : assert(controller != null),
        assert(validator != null),
        assert(keyboardType != null),
        assert(prefixIconData != null),
        assert(labelText != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white, fontSize: 18),
          border:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          errorBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusColor: Colors.white,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              prefixIconData,
              color: Colors.white,
              size: 40,
            ),
          ),
          contentPadding: EdgeInsets.all(8.0),
          errorStyle: TextStyle(fontSize: 16, color: Colors.redAccent)),
      obscureText: isObscure,
      validator: validator,
      cursorColor: Colors.white,
      cursorHeight: 24,
      style: TextStyle(color: Colors.white, fontSize: 24),
      autocorrect: false,
      keyboardType: keyboardType,
    );
  }
}
