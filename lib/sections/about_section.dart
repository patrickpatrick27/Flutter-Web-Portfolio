import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/responsive_animation.dart'; 

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        children: [
          const Text(
            "About Me", 
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 30),
          
          FadeSlideTransition(
            delay: const Duration(milliseconds: 200),
            offset: const Offset(0, 0.2), 
            child: ResponsiveLayout(
              mobile: _buildContent(isMobile: true),
              desktop: _buildContent(isMobile: false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent({required bool isMobile}) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 900),
      child: Column(
        children: [
          // Bio: Removed hardware references, added full Campus name
          Text(
            "I am a Senior Computer Engineering student at Cavite State University - Don Severino de las Alas Campus, based in Trece Martires City. "
            "My expertise lies in Mobile Development (Flutter) and Data Analytics, focusing on building intuitive, high-performance applications. "
            "Whether leading student organizations or contributing to open-source projects, I am driven by a single goal: creating software solutions that work.",
            style: const TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
            textAlign: isMobile ? TextAlign.left : TextAlign.center,
          ),
          const SizedBox(height: 20),
          
          // The Impact Story
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "🚀 The 'NAP Finder' Impact", 
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)
                ),
                SizedBox(height: 8),
                Text(
                  "I identify operational bottlenecks and solve them with code. "
                  "During my time at Mountain Top Cable TV Networks, I noticed field technicians struggling to locate connection points using static spreadsheets. "
                  "I developed 'NAP Finder'—a cross-platform Flutter app integrating OpenStreetMap—to map over 3,000+ data points. "
                  "What started as a warehouse problem became a deployed solution that modernized the company's field operations.",
                  style: TextStyle(fontSize: 15, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}