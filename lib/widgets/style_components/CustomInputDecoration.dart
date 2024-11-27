import 'package:flutter/material.dart';

class Custominputdecoration {
  static InputDecoration build({
    Text? label,
    IconButton? suffixIcon,
  }) {
    return InputDecoration(
      label: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: label,
      ),
      labelStyle: const TextStyle(
        color: Color(0xffEBB400),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xffEBB400),
        ),
      ),
      suffixIcon: suffixIcon,
    );
  }
}
