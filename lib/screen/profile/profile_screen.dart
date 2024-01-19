
import 'package:flutter/material.dart';

import '../legals/legal_header_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LegalHeaderScreen(),
            ),
          );
        }, child: Text('test',),),
      ),
    );
  }
}
