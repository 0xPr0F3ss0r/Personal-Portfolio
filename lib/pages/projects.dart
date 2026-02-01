import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_riverpod/legacy.dart';
import 'package:my_portfolio/components/animated_projects_card.dart';
import 'package:my_portfolio/components/animated_terminal.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/state_management/light-dark-mode.dart' as theme;

// Project model
class Project {
  final String id;
  final String title;
  final String description;
  final String category;
  final String image;
  final List<String> techStack;

  Project(this.id, this.title, this.description, this.category, this.image, this.techStack);
}

// Unique projects
final projects = [
  Project('1', 'My Flutter App', 'A beautiful mobile app built with Flutter.', 'mobile', 'images/flutter_app.png', ['Flutter', 'Dart']),
  Project('2', 'Portfolio Website', 'My web app portfolio project.', 'web', 'images/web_app.png', ['HTML', 'CSS', 'Dart']),
  Project('3', 'Cyber Tool', 'Cybersecurity project exploring vulnerabilities.', 'cybersecurity', 'images/cyber.png', ['Python', 'Security']),
  Project('4', 'Another Cyber Tool', 'Another cybersecurity project.', 'cybersecurity', 'images/cyber2.png', ['Python', 'Security']),
];

final categories = ['all', 'mobile', 'web', 'cybersecurity'];

// Theme provider
final themeMode = StateProvider<String>((ref) => 'light');

class ProjectsSection extends StatefulComponent {
  final String? id;
  const ProjectsSection({super.key, this.id});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();

  static List<StyleRule> get styles => [];
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String activeCategory = 'all';

  List<Project> get filteredProjects {
    if (activeCategory == 'all') return projects;
    return projects.where((p) => p.category == activeCategory).toList();
  }

  @override
  Component build(BuildContext context) {
    String currentTheme = context.watch(theme.mode);
    Color textColor = currentTheme == 'dark' ? whiteColor : Colors.black;

    return section(
      id: component.id,
      classes: 'project-section',
      styles: Styles(
        display: .flex,
        flexDirection: .column,
        justifyContent: .center,
        alignItems: .center,
        textAlign: .center,
        padding: Spacing.all(20.px), // Add some padding
      ),
      [
        // Header
        TerminalLine(),
        h2(
          styles: Styles(
            color: textColor,
            fontFamily: FontFamily("DynaPuff"),
            fontSize: 36.px,
            fontWeight: FontWeight.bold,
            margin: Spacing.symmetric(vertical: 20.px),
          ),
          [.text('My Projects')],
        ),

        // Category tabs
        div(
          classes: 'category-tabs',
          styles: Styles(
            display: Display.flex,
            justifyContent: JustifyContent.center,
            alignItems: AlignItems.center,
            gap: Gap.all(15.px),
            margin: Spacing.only(bottom: 30.px),
          ),
          [
            for (var category in categories)
              button(
                styles: Styles(
                  display: Display.inlineFlex,
                  padding: Spacing.symmetric(vertical: 6.px, horizontal: 20.px),
                  border: Border.all(color: activeCategory == category ? Colors.blue : Colors.gray),
                  radius: BorderRadius.circular(10.px),
                  cursor: Cursor.pointer,
                  justifyContent: JustifyContent.center,
                  alignItems: AlignItems.center,
                  color: activeCategory == category ? Colors.white : Colors.gray,
                  backgroundColor: activeCategory == category ? Colors.blue : Colors.transparent,
                  raw: {'transition': 'all 0.3s ease'},
                ),
                onClick: () {
                  setState(() {
                    activeCategory = category;
                  });
                },
                [.text(category.toUpperCase())],
              ),
          ],
        ),

        // Projects grid
        div(
          classes: 'projects-grid',
          styles: Styles(
            display: Display.flex,
            flexWrap: FlexWrap.wrap,
            justifyContent: JustifyContent.center,
            gap: Gap.all(30.px),
          ),
          [
            for (var i = 0; i < filteredProjects.length; i++)
              AnimatedProjectCard(
                project: filteredProjects[i],
                index: i,
              ),
          ],
        ),

        // Empty state
        if (filteredProjects.isEmpty)
          div(
            styles: Styles(
              margin: Spacing.only(top: 50.px),
              textAlign: TextAlign.center,
            ),
            [
              p(
                styles: Styles(color: textColor, fontSize: 18.px),
                [.text('No projects found.')],
              ),
            ],
          ),
      ],
    );
  }
}
