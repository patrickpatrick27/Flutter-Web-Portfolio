import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      color: Colors.grey[50],
      child: Column(
        children: [
          const Divider(),
          const SizedBox(height: 20),
          Text(
            "© 2026 Dave. Built with Flutter Web.",
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(icon: const Icon(Icons.code), onPressed: () {}), // GitHub
              IconButton(icon: const Icon(Icons.email), onPressed: () {}), // Email
            ],
          )
        ],
      ),
    );
  }
}