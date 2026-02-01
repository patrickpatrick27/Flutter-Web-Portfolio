import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: Colors.blueGrey[900],
      width: double.infinity,
      child: Column(
        children: const [
          Text(
            "Hi, I'm Dave.",
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            "Flutter Developer | Mobile & Web",
            style: TextStyle(fontSize: 24, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}