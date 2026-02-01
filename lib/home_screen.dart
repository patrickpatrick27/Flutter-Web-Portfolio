import 'package:flutter/material.dart';
import 'sections/header_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'widgets/responsive_animation.dart'; // Import our animation

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            FadeSlideTransition(
              delay: Duration(milliseconds: 0), 
              child: HeaderSection()
            ),
            SizedBox(height: 60),
            FadeSlideTransition(
              delay: Duration(milliseconds: 300), 
              child: SkillsSection()
            ),
            SizedBox(height: 60),
            FadeSlideTransition(
              delay: Duration(milliseconds: 600), 
              child: ProjectsSection()
            ),
            SizedBox(height: 60),
            // Footer usually doesn't need animation, but you can add it if you like
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("© 2026 Dave Portfolio", style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}