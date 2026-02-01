import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobile: _HeaderMobile(),
      desktop: _HeaderDesktop(),
    );
  }
}

// --- Desktop Layout ---
class _HeaderDesktop extends StatelessWidget {
  const _HeaderDesktop();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 80),
      color: Colors.blueGrey[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Profile Picture Placeholder
          Container(
            width: 160,
            height: 160,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white10,
            ),
            child: const Icon(Icons.person, size: 80, color: Colors.white),
          ),
          const SizedBox(width: 60),
          // Text Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Hi, I'm Dave.",
                style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                "Flutter Developer | Mobile & Web",
                style: TextStyle(fontSize: 28, color: Colors.white70),
              ),
              SizedBox(height: 30),
              // Example Call to Action
              Chip(
                  label: Text("Available for projects"),
                  backgroundColor: Colors.greenAccent)
            ],
          ),
        ],
      ),
    );
  }
}

// --- Mobile Layout ---
class _HeaderMobile extends StatelessWidget {
  const _HeaderMobile();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      color: Colors.blueGrey[900],
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white10,
            ),
            child: const Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 30),
          const Text(
            "Hi, I'm Dave.",
            style: TextStyle(
                fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            "Flutter Developer | Mobile & Web",
            style: TextStyle(fontSize: 18, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}