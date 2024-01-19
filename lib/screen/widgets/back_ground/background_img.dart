import 'package:flutter/material.dart';

class BackgroundImg extends StatelessWidget {
  const BackgroundImg({Key? key,
    this.top = 5,
    this.left = 10,
    this.width = 300,
    this.height = 300,

  }) : super(key: key);
  final double top;
  final double left ;
  final double width ;
  final double height;



  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -top,
      left: -left,
      child: SizedBox(
        width: width,
        height: height,
        child: Container(
          child: Image.asset(
            'assets/images/logo_law.png',
             color: Colors.transparent.withOpacity(.04),
          ),
        ),
      ),
    );
  }
}
