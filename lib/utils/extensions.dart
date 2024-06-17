import 'package:flutter/material.dart';

extension SizedBoxExtension on int {
  SizedBox get height => SizedBox(height: toDouble());

  SizedBox get width => SizedBox(width: toDouble());
}

String formatCardNumber(String number) {
  // Ensure the input is a string of digits
  if (!RegExp(r'^\d+$').hasMatch(number)) {
    throw const FormatException('Input must be a string of digits');
  }

  // Split the input into chunks of 4 digits
  var buffer = StringBuffer();
  for (int i = 0; i < number.length; i += 4) {
    if (i != 0) {
      buffer.write(' ');
    }
    buffer.write(
      number.substring(
        i,
        i + 4 > number.length ? number.length : i + 4,
      ),
    );
  }

  return buffer.toString();
}
