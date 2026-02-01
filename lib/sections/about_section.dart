import 'package:flutter/material.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/responsive_animation.dart'; // Import animation widget

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        children: [
          const Text("About Me", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          
          // Added Animation directly here
          FadeSlideTransition(
            delay: const Duration(milliseconds: 200),
            // Smaller offset (0.2) fixes the alignment issue by making the movement tighter
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
    // Limits width on desktop for readability
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 900),
      child: Column(
        children: [
          // Bio
          Text(
            "I am a Senior Computer Engineering student at Cavite State University (Don Severino de las Alas Campus), based in Trece Martires City. "
            "Beyond my academic leadership, I have practical experience developing applications for business, family operations, and thesis requirements.",
            style: const TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
            textAlign: isMobile ? TextAlign.left : TextAlign.center,
          ),
          const SizedBox(height: 20),
          
          // Automation Story (Highlight)
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
                Text("💡 The 'Solutions-First' Mindset", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                SizedBox(height: 8),
                Text(
                  "I don't just write code; I fix processes. During my first week at Mountain Top Cable TV Networks (a Converge ICT partner), "
                  "I noticed inefficiencies in data encoding. I immediately built a Google Apps Script to automate the workflow, turning a messy manual task "
                  "into a coherent, one-click process. This portfolio itself is another example of my drive to build tools that work.",
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