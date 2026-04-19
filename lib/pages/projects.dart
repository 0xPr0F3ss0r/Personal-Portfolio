// ignore_for_file: avoid_print
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/components/animated_terminal.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/state_management/light_dark_mode.dart' as state_management;
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
    css('.project-section').styles(
      padding: Spacing.symmetric(vertical: 5.rem),
      raw: {
        'scroll-margin-top': '140px',
      },
    ),
    css('.project-section h2').styles(
      display: Display.inlineBlock,
      padding: Spacing.symmetric(horizontal: 0.5.em, vertical: 0.25.em),
      margin: Spacing.zero,
      color: Color.rgba(255, 255, 255, 0.12),
      fontFamily: displayFont,
      fontSize: 4.rem,
      raw: {
        'background-image': 'linear-gradient(120deg, #64ffda 0%, #ccd6f6 100%)',
        'background-size': '0% 100%',
        'background-position': 'left center',
        'background-repeat': 'no-repeat',
        '-webkit-background-clip': 'text',
        'background-clip': 'text',
        'transition': 'background-size 800ms ease-in-out',
      },
    ),
    css('.project-section h2.fill').styles(
      raw: {
        'background-size': '100% 100%',
      },
    ),
    css('.projects-lead').styles(
      margin: Spacing.only(top: 16.px, bottom: 32.px),
      fontSize: 1.1.rem,
      maxWidth: 640.px,
      color: textColor,
      fontFamily: bodyFont,
      raw: {
        'margin-left': 'auto',
        'margin-right': 'auto',
        'text-align': 'center',
        'text-wrap': 'balance',
      },
    ),
    css('.projects-shell').styles(
      maxWidth: 1200.px,
      margin: Spacing.only(left: Unit.auto, right: Unit.auto),
    ),
    css('.projects-grid').styles(
      display: Display.grid,
      raw: {
        'grid-template-columns': 'repeat(auto-fit, minmax(380px, 1fr))',
        'gap': '40px',
        'margin-top': '40px',
        'padding': '0 20px',
      },
    ),
    css.media(MediaQuery.screen(maxWidth: 768.px), [
      css('.project-section h2').styles(
        fontSize: 2.5.rem,
      ),
      css('.category-tabs').styles(
        flexDirection: FlexDirection.row,
        flexWrap: FlexWrap.wrap,
        justifyContent: JustifyContent.center,
        gap: Gap.all(10.px),
      ),
      css('.projects-grid').styles(
        raw: {
          'grid-template-columns': '1fr',
          'gap': '30px',
        },
      ),
    ]),
    css.media(MediaQuery.screen(maxWidth: 480.px), [
      css('.project-section h2').styles(
        fontSize: 1.8.rem,
      ),
      css('.projects-lead').styles(
        fontSize: 0.95.rem,
      ),
    ]),
  ];
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String activeCategory = 'all';
  bool filled = false;

  List<Project> get filteredProjects {
    if (activeCategory == 'all') return projects;
    return projects.where((project) => project.category == activeCategory).toList();
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
    final options = web.IntersectionObserverInit(threshold: 0.1.toJS);

    final observer = web.IntersectionObserver(
      (JSArray entries, web.IntersectionObserver obs) {
        for (var entry in entries.toDart) {
          final e = entry as web.IntersectionObserverEntry;
          if (e.isIntersecting) {
            if (mounted) setState(() => filled = true);
          } else {
            if (mounted) setState(() => filled = false);
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
          div(classes: 'projects-shell section-shell', [
            // Header
            h2(
              classes: filled ? 'fill' : '',
              styles: Styles(
                margin: Spacing.symmetric(vertical: 20.px),
              ),
              [ScrambledText('Selected Projects')],
            ),
            p(
              classes: 'projects-lead',
              styles: Styles(
                fontFamily: bodyFont,
              ),
              [
                .text(
                  'A curated rotation of product, Flutter, and security-oriented work presented with more editorial focus than a standard gallery.',
                ),
              ],
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
                      border: Border.all(color: activeCategory == category ? accent : Colors.white.withOpacity(0.18)),
                      radius: BorderRadius.circular(999.px),
                      cursor: Cursor.pointer,
                      justifyContent: JustifyContent.center,
                      alignItems: AlignItems.center,
                      color: activeCategory == category ? Colors.white : textColor,
                      backgroundColor: activeCategory == category ? accent : Color.rgba(255, 255, 255, 0.03),
                      fontFamily: displayFont,
                      raw: {
                        'transition': 'all 0.3s ease',
                        'letter-spacing': '0.14em',
                        'text-transform': 'uppercase',
                      },
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

            if (hasProjects)
              div(
                classes: 'projects-grid',
                [
                  for (var i = 0; i < projectList.length; i++)
                    AnimatedProjectCard(
                      project: projectList[i],
                      index: i,
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
                  h2(styles: Styles(color: textColor), [ScrambledText('/ projects')]),
                ],
              ),
          ]),
        ]),
      ],
    );
  }
}
