import 'dart:async';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/state_management/light-dark-mode.dart' as state_management;
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
      maxWidth: 900.px,
      flexDirection: FlexDirection.row,
      justifyContent: JustifyContent.start,
      alignItems: AlignItems.center,
      gap: Gap.all(40.px),
      raw: {'margin': '0 auto'},
    ),

    css('.skills-left-column').styles(
      textAlign: TextAlign.left,
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

    css('.skills-left-column h2').styles(
      display: Display.block,
      padding: Spacing.zero,
      margin: Spacing.zero,
      color: whiteColor,
      fontFamily: FontFamily('DynaPuff'),
      textAlign: TextAlign.left,
      fontSize: 3.5.rem,
      raw: {
        'background-image': 'linear-gradient(to right, #0080FF 0%, #0080FF 100%)',
        'background-size': '0% 100%',
        'background-position': 'left center',
        'background-repeat': 'no-repeat',
        'transition': 'background-size 500ms ease-in-out',
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
      fontSize: 22.px,
      lineHeight: Unit.em(1.8),
      maxWidth: 650.px,
      textAlign: TextAlign.left,
      raw: {
        'margin': '15px auto 0',
        'color': 'transparent',
        'background-image': 'linear-gradient(to right, #0080FF 0%, #0080FF 100%)',
        'background-size': '0% 100%',
        'background-repeat': 'no-repeat',
        'background-position': 'left center',
        'transition': 'background-size 800ms ease-in-out',
        '-webkit-background-clip': 'text',
        'background-clip': 'text',
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
      fontFamily: FontFamily('DynaPuff'),
      fontSize: 8.rem, 
      raw: {
        'writing-mode': 'vertical-rl',
        'text-orientation': 'mixed',
        'opacity': '0.7',
      },
    ),
    css.media(MediaQuery.screen(maxWidth: 900.px), [
      css('.skills-wrapper').styles(
        alignItems: AlignItems.center,
      ),
      css('.skills-left-column').styles(
        textAlign: TextAlign.center,
      ),
      css('.skills-left-column p').styles(
        textAlign: TextAlign.center,
        raw: {
          'margin': '30px auto 0',
        },
      ),
      css('.skills-right-column').styles(
        display: Display.block,
        margin: Spacing.only(top: 0.px),
      ),
      css('.skills-right-column h1').styles(
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
        fontSize: 3.5.rem,
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
    final options = web.IntersectionObserverInit(threshold: 0.2.toJS);

    final observer = web.IntersectionObserver(
      (JSArray entries, web.IntersectionObserver obs) {
        for (var entry in entries.toDart) {
          final e = entry as web.IntersectionObserverEntry;
          if (e.isIntersecting) {
            if (mounted) {
              setState(() => filled = true);
              Future.delayed(Duration(seconds: 1), () {
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
    String currentMode = context.watch(state_management.mode);
    Color color = currentMode == 'dark' ? whiteColor : Colors.black;

    return section(id: component.id, classes: 'skills-section', [
      div(classes: 'container', [
        div(classes: 'skills-wrapper', [
          div(classes: 'skills-left-column', [
            h2(
              classes: filled ? 'fill' : '',
              styles: Styles(
                margin: Spacing.only(bottom: 20.px),
                color: color,
              ),
              [ScrambledText('skills')],
            ),
            p(classes: filled ? 'fill' : '', styles: Styles(color: color, lineHeight: Unit.em(1.7)), [
              .text(
                'I have 3 years of experience with Flutter and Dart, building apps and exploring advanced features. '
                'I’ve also worked with C, C++, and Python for system programming, reverse engineering, pentesting, and automation. '
                'I know the basics of HTML, CSS, and JavaScript.',
              ),
            ]),
            p(classes: filled ? 'fill' : '', styles: Styles(color: color, lineHeight: Unit.em(1.7)), [
              .text('I have a solid programming foundation that lets me quickly learn new languages or frameworks.'),
            ]),
            p(classes: filled ? 'fill' : '', styles: Styles(color: color, lineHeight: Unit.em(1.7)), [
              .text(
                'Currently, I’m focusing on advanced Flutter development while exploring low-level programming and cybersecurity concepts related to it.',
              ),
            ]),
          ]),

          div(classes: 'skills-right-column', [
            h1([ScrambledText('мои навыки')]),
          ]),
        ]),
      ]),
    ]);
  }
}
