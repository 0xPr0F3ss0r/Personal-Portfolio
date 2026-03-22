import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/components/animated_terminal.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/state_management/light-dark-mode.dart' as state_management;
import 'package:my_portfolio/components/animated_projects_card.dart';
import 'package:my_portfolio/model/projects_model.dart';
import 'package:my_portfolio/widgets/scrambled_text.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;
// Project model

// Unique projects
final projects = [
  Project(
    '1',
    'Restaurant App',
    'Modern Restaurant app project.',
    'mobile',
    'images/restaurant.jpg',
    ['Flutter', 'Dart', 'Bloc State mangement'],
    'https://github.com/0xPr0F3ss0r',
  ),
  Project(
    '2',
    'Portfolio Website',
    'My web app portfolio project.',
    'web',
    'images/pott2.jpg',
    ['HTML', 'CSS', 'Dart'],
    'https://github.com/0xPr0F3ss0r/kebir-hani.github.io',
  ),
  Project(
    '3',
    'Network scanner',
    'Cybersecurity project scan ports and  exploring vulnerabilities.',
    'cybersecurity',
    'images/tool21.jpg',
    ['Python', 'Socket'],
    'https://github.com/0xPr0F3ss0r/Network-Scanner',
  ),
  Project(
    '4',
    'weather App',
    'Weather forecasting mobile application.',
    'mobile',
    'images/weather.jpg',
    ['Flutter', 'Dart', 'Weather Api'],
    'https://github.com/0xPr0F3ss0r/weather_app',
  ),
];

final categories = ['all', 'mobile', 'web', 'cybersecurity'];

// Theme provider

class ProjectsSection extends StatefulComponent {
  final String id;
  const ProjectsSection({super.key, required this.id});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();

  static List<StyleRule> get styles => [
    css('.project-section h2').styles(
      display: Display.inlineBlock,
      padding: Spacing.symmetric(horizontal: 0.5.em, vertical: 0.25.em),
      margin: Spacing.zero,
      color: whiteColor,
      fontSize: 5.rem,
      raw: {
        'background-image': 'linear-gradient(to right, #0080FF 0%, #0080FF 100%)',
        'background-size': '0% 100%',
        'background-position': 'left center',
        'background-repeat': 'no-repeat',
        'transition': 'background-size 500ms ease-in-out',
      },
    ),
    css('.project-section h2.fill').styles(
      raw: {
        'background-size': '100% 100%',
      },
    ),
    css.media(MediaQuery.screen(maxWidth: 768.px), [
      css('.project-section h2').styles(
        fontSize: 2.rem,
      ),
      css('.category-tabs').styles(
        flexDirection: FlexDirection.column,
        gap: Gap.all(10.px),
      ),
    ]),
  ];
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String activeCategory = 'all';
  bool filled = false;
  int currentProjectIndex = 0;
  bool isTransitioning = false;
  int animationDirection = 1;

  List<Project> get filteredProjects {
    if (activeCategory == 'all') return projects;
    return projects.where((project) => project.category == activeCategory).toList();
  }

  int _wrapIndex(int value, int length) {
    if (length == 0) return 0;
    var index = value % length;
    if (index < 0) index += length;
    return index;
  }

  void _navigateProjects(int direction) {
    final listLength = filteredProjects.length;
    if (listLength <= 1 || isTransitioning) return;

    final nextIndex = _wrapIndex(currentProjectIndex + direction, listLength);

    setState(() {
      isTransitioning = true;
      animationDirection = direction >= 0 ? 1 : -1;
    });

    Future.delayed(const Duration(milliseconds: 220), () {
      if (!mounted) return;
      setState(() {
        currentProjectIndex = nextIndex;
      });
      Future.delayed(const Duration(milliseconds: 140), () {
        if (!mounted) return;
        setState(() {
          isTransitioning = false;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      Future.microtask(() => _startObserving());
    } else {
      print('no');
    }
  }

  void _startObserving() {
    final options = web.IntersectionObserverInit(threshold: 0.2.toJS);

    final observer = web.IntersectionObserver(
      (JSArray entries, web.IntersectionObserver obs) {
        for (var entry in entries.toDart) {
          final e = entry as web.IntersectionObserverEntry;
          if (e.isIntersecting) {
            if (mounted) {
              setState(() => filled = true);
              Future.delayed(Duration(seconds: 3), () {
                if (mounted) setState(() => filled = false);
              });
            } else {
              if (mounted) setState(() => filled = false);
            }
          }
        }
      }.toJS,
      options,
    );

    final element = web.document.getElementById(component.id);
    if (element != null) {
      observer.observe(element);
    } else {
      print('⚠️ Element with id ${component.id} not found');
    }
  }

  @override
  Component build(BuildContext context) {
    String currentTheme = context.watch(state_management.mode);
    Color textColor = currentTheme == 'dark' ? whiteColor : Colors.black;
    final accent = BlueColor;
    final projectList = filteredProjects;
    final hasProjects = projectList.isNotEmpty;
    final displayIndex = hasProjects ? _wrapIndex(currentProjectIndex, projectList.length) : 0;
    final currentProject = hasProjects ? projectList[displayIndex] : null;
    final canNavigate = projectList.length > 1;

    return section(
      id: component.id,
      classes: 'project-section',
      styles: Styles(
        display: .flex,
        minHeight: 100.vh,
        flexDirection: .column,
        justifyContent: .center,
        alignItems: .center,
        textAlign: .center,
      ),
      [
        div(classes: 'container', [
          // Header
          h2(
            classes: filled ? 'fill' : '',
            styles: Styles(
              margin: Spacing.symmetric(vertical: 20.px),
              color: textColor,
              fontFamily: FontFamily("DynaPuff"),
              fontSize: 36.px,
              fontWeight: FontWeight.bold,
            ),
            [.text('Part of My Projects')],
          ),
          TerminalLine(),

          // Category tabs
          div(
            classes: 'category-tabs',
            styles: Styles(
              display: Display.flex,
              margin: Spacing.only(bottom: 30.px, top: 20.px),
              justifyContent: JustifyContent.center,
              alignItems: AlignItems.center,
              gap: Gap.all(15.px),
            ),
            [
              for (var category in categories)
                button(
                  styles: Styles(
                    display: Display.inlineFlex,
                    padding: Spacing.symmetric(vertical: 6.px, horizontal: 20.px),
                    border: Border.all(color: activeCategory == category ? accent : Colors.gray),
                    radius: BorderRadius.circular(10.px),
                    cursor: Cursor.pointer,
                    justifyContent: JustifyContent.center,
                    alignItems: AlignItems.center,
                    color: activeCategory == category ? Colors.white : Colors.gray,
                    backgroundColor: activeCategory == category ? accent : Colors.transparent,
                    raw: {'transition': 'all 0.3s ease'},
                  ),
                  onClick: () {
                    setState(() {
                      activeCategory = category;
                      currentProjectIndex = 0;
                      isTransitioning = false;
                      animationDirection = 1;
                    });
                  },
                  [.text(category.toUpperCase())],
                ),
            ],
          ),

          if (currentProject != null)
            div(
              classes: 'project-slider',
              styles: Styles(
                display: Display.flex,
                alignItems: AlignItems.center,
                justifyContent: JustifyContent.center,
                gap: Gap.all(24.px),
                margin: Spacing.only(top: 30.px),
                flexWrap: FlexWrap.wrap,
              ),
              [
                button(
                  styles: Styles(
                    padding: Spacing.all(14.px),
                    radius: BorderRadius.circular(999.px),
                    border: Border.all(color: accent),
                    backgroundColor: Colors.transparent,
                    color: textColor,
                    cursor: canNavigate ? Cursor.pointer : Cursor.notAllowed,
                    raw: {
                      'opacity': canNavigate ? '1' : '0.3',
                      'transition': 'opacity 0.3s ease',
                    },
                  ),
                  onClick: canNavigate ? () => _navigateProjects(-1) : null,
                  [.text('←')],
                ),
                div(
                  styles: Styles(
                    raw: {
                      'width': 'min(900px, 95vw)',
                      'display': 'flex',
                      'justify-content': 'center',
                      'transition': 'transform 0.5s cubic-bezier(0.4, 0, 0.2, 1), opacity 0.45s ease',
                      'transform': isTransitioning
                          ? 'translateX(${animationDirection > 0 ? '-60px' : '60px'}) scale(0.95)'
                          : 'translateX(0) scale(1)',
                      'opacity': isTransitioning ? '0' : '1',
                    },
                  ),
                  [
                    AnimatedProjectCard(
                      project: currentProject,
                      index: displayIndex,
                    ),
                  ],
                ),
                button(
                  styles: Styles(
                    padding: Spacing.all(14.px),
                    radius: BorderRadius.circular(999.px),
                    border: Border.all(color: accent),
                    backgroundColor: Colors.transparent,
                    color: textColor,
                    cursor: canNavigate ? Cursor.pointer : Cursor.notAllowed,
                    raw: {
                      'opacity': canNavigate ? '1' : '0.3',
                      'transition': 'opacity 0.3s ease',
                    },
                  ),
                  onClick: canNavigate ? () => _navigateProjects(1) : null,
                  [.text('→')],
                ),
              ],
            ),

          // Empty state
          if (!hasProjects)
            div(
              styles: Styles(
                margin: Spacing.only(top: 50.px),
                textAlign: TextAlign.center,
              ),
              [
                h3(classes: filled ? 'fill' : '', styles: Styles(color: accent, fontSize: 60.px), [
                  ScrambledText('мои проекты'),
                ]),
                h2(styles: Styles(color: textColor), [ScrambledText('projects')]),
              ],
            ),
        ]),
      ],
    );
  }
}
