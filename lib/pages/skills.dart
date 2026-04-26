// ignore_for_file: styles_ordering, avoid_print
import 'dart:async';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/state_management/light_dark_mode.dart' as state_management;
import 'package:my_portfolio/widgets/scrambled_text.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

class Myskills extends StatefulComponent {
  final String id;
  const Myskills({super.key, required this.id});

  @override
  State<Myskills> createState() => _MyskillsState();

  @css
  static List<StyleRule> get styles => [
    css('.skills-section').styles(
      display: Display.flex,
      minHeight: 100.vh,
      flexDirection: FlexDirection.column,
      justifyContent: JustifyContent.center,
      alignItems: AlignItems.center,
      textAlign: TextAlign.center,
      raw: {'position': 'relative'},
    ),

    css('.skills-wrapper').styles(
      display: Display.flex,
      width: 100.percent,
      maxWidth: 1080.px,
      flexDirection: FlexDirection.row,
      justifyContent: JustifyContent.center,
      alignItems: AlignItems.center,
      gap: Gap.all(48.px),
      raw: {'margin': '0 auto'},
    ),

    css('.skills-left-column').styles(
      textAlign: TextAlign.center,
      raw: {
        'flex': '0 1 auto',
        'min-width': '0',
        'width': '100%',
        'max-width': '560px',
      },
    ),

    css('.skills-right-column').styles(
      margin: Spacing.zero,
      padding: Spacing.zero,
      display: Display.flex,
      justifyContent: JustifyContent.center,
      alignItems: AlignItems.center,
      minWidth: 150.px,
    ),

    css('.skills-right-column h1').styles(
      margin: Spacing.zero,
      color: primaryColor,
      fontFamily: displayFont,
      fontSize: 7.rem,
      raw: {
        'writing-mode': 'vertical-rl',
        'text-orientation': 'mixed',
        'opacity': '0.7',
        'letter-spacing': '0.12em',
      },
    ),


    css('.skills-left-column h2').styles(
      display: Display.block,
      padding: Spacing.zero,
      margin: Spacing.zero,
      color: Color.rgba(255, 255, 255, 0.12),
      fontFamily: displayFont,
      textAlign: TextAlign.center,
      fontSize: 3.8.rem,
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

    css('.skills-left-column h2.fill').styles(
      raw: {
        'background-size': '100% 100%',
      },
    ),

    // Paragraph gradient fill animation
    css('.skills-left-column p').styles(
      margin: Spacing.only(top: 15.px),
      fontSize: 1.1.rem,
      lineHeight: Unit.em(1.8),
      maxWidth: 650.px,
      textAlign: TextAlign.center,
      raw: {
        'margin': '15px auto 0',
        'text-wrap': 'balance',
        'text-wrap': 'balance',
      },
    ),

    css('.skills-left-column p.fill').styles(
      raw: {
        'background-size': '100% 100%',
      },
    ),


    css('.skills-right-column h1').styles(
      margin: Spacing.zero,
      color: primaryColor,
      fontFamily: displayFont,
      fontSize: 7.rem,
      raw: {
        'writing-mode': 'vertical-rl',
        'text-orientation': 'mixed',
        'opacity': '0.7',
        'letter-spacing': '0.12em',
      },
    ),
    css.media(MediaQuery.screen(maxWidth: 900.px), [
      css('.skills-wrapper').styles(
        flexDirection: FlexDirection.row,
        alignItems: AlignItems.center,
        justifyContent: JustifyContent.spaceBetween,
        gap: Gap.all(12.px),
        padding: Spacing.symmetric(horizontal: 10.px),
      ),
      css('.skills-left-column').styles(
        maxWidth: 100.percent,
        flex: Flex.grow(1),
      ),
      css('.skills-left-column h2').styles(
        fontSize: 2.5.rem,
      ),
      css('.skills-left-column p').styles(
        fontSize: 0.95.rem,
      ),
      css('.skills-right-column').styles(
        minWidth: 40.px,
      ),
      css('.skills-right-column h1').styles(
        fontSize: 3.5.rem,
        raw: {
          'writing-mode': 'vertical-rl',
          'text-orientation': 'mixed',
          'opacity': '0.7',
          'text-align': 'right',
          'width': 'auto',
          'margin-top': '0',
        },
      ),
    ]),
    css.media(MediaQuery.screen(maxWidth: 480.px), [
      css('.skills-left-column h2').styles(
        fontSize: 2.rem,
      ),

      css('.skills-right-column h1').styles(
        fontSize: 2.2.rem,
      ),
    ]),
    css.media(MediaQuery.screen(maxWidth: 768.px), [
      css('.skills-section').styles(
        // padding: Spacing.symmetric(horizontal: 10.px),
      ),
      css('.skills-left-column h2').styles(
        fontSize: 3.rem,
      ),
      css('.skills-left-column p').styles(
        fontSize: 1.rem,
      ),
      css('.skills-right-column h1').styles(
        fontSize: 4.rem,
      ),
    ]),
  ];
}

class _MyskillsState extends State<Myskills> {
  bool filled = false;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      Future.microtask(() => _startObserving());
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
    String currentMode = context.watch(state_management.mode);
    Color color = currentMode == 'dark' ? whiteColor : Colors.black;


    return section(id: component.id, classes: 'skills-section', [
      div(classes: 'container', [
        div(classes: 'skills-wrapper section-shell', [
          div(classes: 'skills-left-column', [
            h2(
              classes: filled ? 'fill' : '',
              styles: Styles(
                margin: Spacing.only(bottom: 20.px),
              ),
              [ScrambledText('/ 我的技能')],
            ),
            p(classes: filled ? 'fill' : '', styles: Styles(color: color, lineHeight: Unit.em(1.7)), [
              .text(
                'My core stack is Flutter and Dart, where I focus on responsive layouts, strong visual hierarchy, and production-minded implementation. '
                'Alongside that, I use C, C++, and Python when the work leans toward systems programming, reverse engineering, automation, or security research.',
              ),
            ]),
            p(classes: filled ? 'fill' : '', styles: Styles(color: color, lineHeight: Unit.em(1.7)), [
              .text(
                'That cross-disciplinary base makes it easy for me to move from interface detail to lower-level reasoning without losing clarity.',
              ),
            ]),
            p(classes: filled ? 'fill' : '', styles: Styles(color: color, lineHeight: Unit.em(1.7)), [
              .text(
                'Right now I am pushing deeper into advanced Flutter work while continuing to explore the edge where app quality, performance, and security meet.',
              ),
            ]),

          ]),

          div(classes: 'skills-right-column', [
            h1([ScrambledText('/ my skills')]),
          ]),
        ]),
      ]),
    ]);
  }
}
