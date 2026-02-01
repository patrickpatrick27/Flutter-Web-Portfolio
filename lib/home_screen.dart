import 'package:flutter/material.dart';
import 'sections/header_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/about_section.dart';
import 'sections/footer_section.dart';
import 'widgets/responsive_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Header
            const FadeSlideTransition(
              delay: Duration(milliseconds: 0),
              offset: Offset(0, 0.5),
              child: HeaderSection(),
            ),

            const SizedBox(height: 30),

            // 2. Sliding Toggle Button
            FadeSlideTransition(
              delay: const Duration(milliseconds: 300),
              offset: const Offset(0, 0.5),
              child: _SlidingTabBar(
                selectedIndex: _selectedIndex,
                onTap: (index) => setState(() => _selectedIndex = index),
              ),
            ),

            const SizedBox(height: 30),

            // 3. Switcher (FIXED ALIGNMENT)
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              switchInCurve: Curves.easeOutBack,
              switchOutCurve: Curves.easeIn,
              
              // CRITICAL FIX: Forces content to stay anchored to the top
              layoutBuilder: (currentChild, previousChildren) {
                return Stack(
                  alignment: Alignment.topCenter, // <--- STOPS THE JITTER
                  children: <Widget>[
                    ...previousChildren,
                    if (currentChild != null) currentChild,
                  ],
                );
              },
              
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 0.1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: _selectedIndex == 0
                  ? const _ProjectsView(key: ValueKey("projects"))
                  : const _AboutView(key: ValueKey("about")),
            ),

            const SizedBox(height: 80),
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}

// --- SUB VIEWS ---
class _ProjectsView extends StatelessWidget {
  const _ProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProjectsSection(key: ValueKey("ProjectsSection"));
  }
}

class _AboutView extends StatelessWidget {
  const _AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey("AboutColumn"),
      children: [
        const AboutSection(),
        const SizedBox(height: 20),
        Divider(indent: 100, endIndent: 100, color: Colors.grey[300]),
        const SkillsSection(),
      ],
    );
  }
}

// --- SLIDING TAB BAR ---
class _SlidingTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const _SlidingTabBar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: selectedIndex == 0 ? Alignment.centerLeft : Alignment.centerRight,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            child: Container(
              width: 150,
              height: 42,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(21),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onTap(0),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: Text(
                      "Projects",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selectedIndex == 0 ? theme.primaryColor : Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => onTap(1),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: Text(
                      "About Me",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selectedIndex == 1 ? theme.primaryColor : Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}