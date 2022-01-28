import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final void Function(String?) onSaved;
  final void Function(String) onChanged;
  final String? Function(String?) validator;
  final String? prefixText;
  final String hintText;
  final String? initialValue;
  final bool multiLines;
  final int? maxLines;
  final int maxLength;
  final TextInputType inputType;
  const CustomTextField(
      { Key? key,
        this.multiLines = false,
        required this.maxLength,
        required this.prefixText,
        required this.hintText,
        required this.inputType,
        required this.onSaved,
        required this.validator,
        required this.initialValue,
         required this.onChanged,
        required this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Color(0x00000000), blurRadius: 11)]),
      child: TextFormField(
        inputFormatters: (maxLength == null)
            ? null
            : [
          LengthLimitingTextInputFormatter(maxLength),
        ],
        initialValue: initialValue ?? "",
        onSaved: onSaved,
        onChanged: onChanged,
        validator: validator,
        // selectionHeightStyle: BoxHeightStyle.max,
        showCursor: false,
        style: TextStyle(height: 1.5),
        maxLength: null,
        keyboardType: inputType ?? null,
        maxLines: (multiLines)
            ? (maxLines != null)
            ? maxLines
            : null
            : 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText ?? "",
          prefix: (prefixText != null) ? Text(prefixText!) : null,
          fillColor: Color.fromRGBO(255, 255, 255, 1),
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(16.0, 14.0, 15.0, 13.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 1)),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}