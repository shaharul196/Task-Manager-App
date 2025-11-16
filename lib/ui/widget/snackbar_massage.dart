import 'package:flutter/material.dart';

void showSnackBarMassage(BuildContext context, String massage){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(massage)));

}