import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatefulWidget {
  final String name;
  final Color color;
  const Button({super.key, required this.name, required this.color});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
                  height: 40.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.grey),
                      color: widget.color),
                  child: Center(
                    child: Text(widget.name,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.05,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                );
  }
}