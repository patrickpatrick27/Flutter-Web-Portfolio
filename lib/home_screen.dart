import 'package:flutter/material.dart';
import 'sections/header_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/footer_section.dart';
// ▼ ADD THIS LINE ▼
import 'widgets/responsive_animation.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: SingleChildScrollView(
        child: Column(
          children: [
            FadeSlideTransition(
              delay: const Duration(milliseconds: 0), 
              child: const HeaderSection()
            ),
            
            const SizedBox(height: 40),
            
            FadeSlideTransition(
              delay: const Duration(milliseconds: 400), 
              child: const SkillsSection()
            ),
            
            const SizedBox(height: 40),
            
            FadeSlideTransition(
              delay: const Duration(milliseconds: 800), 
              child: const ProjectsSection()
            ),
            
            const SizedBox(height: 80),
            
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}