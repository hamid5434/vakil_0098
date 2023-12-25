
import 'package:flutter/material.dart';

class LowScreen extends StatefulWidget {
  const LowScreen({super.key});

  @override
  State<LowScreen> createState() => _LowScreenState();
}

class _LowScreenState extends State<LowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Law'),
      ),
    );
  }
}
