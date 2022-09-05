import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget divisorListMain() => const Divider(height: 1, color: Colors.black54);

Widget buildSvgIcon(String imagePath) =>
    SvgPicture.asset(imagePath, width: 48, height: 48);
