// ignore_for_file: avoid_print
import 'dart:async';
import 'package:universal_web/web.dart' as web;
import 'package:universal_web/js_interop.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/state_management/light_dark_mode.dart' as state_management;
import 'package:my_portfolio/widgets/scrambled_text.dart';

class About extends StatefulComponent {
  final String id;
  const About({super.key, required this.id});

  @override
  State<About> createState() => _AboutState();

  @css
  static List<StyleRule> get styles => [
    css('.about-section').styles(
      padding: Spacing.symmetric(vertical: 6.rem),
      raw: {
        'position': 'relative',
        'scroll-margin-top': '140px',
      },
    ),
    css('.about-wrapper').styles(
      display: Display.flex,
      width: 100.percent,
      maxWidth: 1040.px,
      flexDirection: FlexDirection.row,
      flexWrap: FlexWrap.wrap,
      justifyContent: JustifyContent.start,
      alignItems: AlignItems.center,
      gap: Gap.all(48.px),
      raw: {'margin': '0 auto'},
    ),
    css('.about-content').styles(
      maxWidth: 600.px,
      flex: Flex.none,
    ),
    css('.about-content h2').styles(
      fontFamily: displayFont,
      fontSize: 1.4.rem,
      color: BlueColor,
      raw: {
        'text-transform': 'uppercase',
        'letter-spacing': '0.2em',
      },
    ),
    css('.about-content h3').styles(
      margin: Spacing.only(bottom: 15.px),
      fontFamily: displayFont,
      fontSize: 3.4.rem,
      lineHeight: 1.2.em,
    ),
    css('.about-content p').styles(
      margin: Spacing.only(top: 15.px),
      fontSize: 1.1.rem,
      lineHeight: Unit.em(1.8),
      fontFamily: bodyFont,
      color: textColor,
      raw: {
        'text-wrap': 'balance',
      },
    ),
    css('.about-highlights').styles(
      display: Display.flex,
      flexWrap: FlexWrap.wrap,
      gap: Gap.all(12.px),
      margin: Spacing.only(top: 24.px),
    ),
    css('.about-pill').styles(
      padding: Spacing.symmetric(horizontal: 18.px, vertical: 10.px),
      radius: BorderRadius.circular(999.px),
      backgroundColor: Color.rgba(255, 255, 255, 0.05),
      border: Border.all(color: Colors.white.withOpacity(0.15)),
      fontSize: 0.85.rem,
      fontFamily: displayFont,
      raw: {
        'text-transform': 'uppercase',
        'letter-spacing': '0.08em',
      },
    ),

    css('.about-image-wrapper').styles(
      position: Position.relative(),
      display: Display.inlineBlock,
      flex: Flex.shrink(0),
      opacity: 0,
      raw: {
        'transform': 'translateY(30px)',
        'transition': 'all 0.8s ease-out',
      },
    ),
    css('.about-image-wrapper.show').styles(
      opacity: 1,
      raw: {
        'transform': 'translateY(0)',
      },
    ),
    css('.image-frame').styles(
      position: Position.absolute(top: 20.px, left: 20.px),
      zIndex: ZIndex(-1),
      width: 100.percent,
      height: 100.percent,
      border: Border.all(color: BlueColor, width: 2.px),
      radius: BorderRadius.circular(10.px),
      raw: {
        'transition': 'transform 0.3s ease-in-out',
        'clip-path': 'polygon(0 0, 100% 0, 100% 78%, 82% 100%, 0 100%)',
      },
    ),
    css('.about-image-wrapper:hover .image-frame').styles(
      raw: {'transform': 'translate(-10px, -10px)'},
    ),
    css('.about-image').styles(
      display: Display.block,
      width: 290.px,
      height: Unit.auto,
      border: Border.all(color: Color.rgba(245, 234, 218, 0.16), width: 1.5.px),
      radius: BorderRadius.circular(10.px),
      shadow: BoxShadow(
        offsetX: 0.px,
        offsetY: 20.px,
        blur: 40.px,
        color: Color.rgba(0, 0, 0, 0.35),
      ),
      raw: {
        'clip-path': 'polygon(0 0, 100% 0, 100% 84%, 86% 100%, 0 100%)',
      },
    ),

    css.media(MediaQuery.screen(maxWidth: 900.px), [
      css('.about-section').styles(
        padding: Spacing.symmetric(vertical: 4.rem),
      ),
      css('.about-wrapper').styles(
        flexDirection: FlexDirection.column,
        alignItems: AlignItems.center,
        textAlign: TextAlign.center,
        gap: Gap.all(32.px),
      ),
      css('.about-image-wrapper').styles(
        width: 100.percent,
        maxWidth: 320.px,
        margin: Spacing.only(bottom: 20.px),
      ),
      css('.about-image').styles(
        width: 100.percent,
      ),
      css('.about-content h3').styles(
        fontSize: 2.8.rem,
        raw: {
          'line-height': '1.1',
        },
      ),
      css('.about-content h2').styles(
        fontSize: 1.rem,
        margin: Spacing.only(bottom: 15.px),
      ),
      css('.about-content p').styles(
        fontSize: 0.95.rem,
        lineHeight: Unit.em(1.65),
      ),
      css('.about-highlights').styles(
        justifyContent: JustifyContent.center,
      ),
    ]),

    css('.about-section h3').styles(
      display: Display.inlineBlock,
      padding: Spacing.symmetric(horizontal: 0.px, vertical: 0.25.em),
      margin: Spacing.zero,
      color: Colors.transparent,
      fontSize: 5.rem,
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
    css('.about-section h3.fill').styles(
      raw: {
        'background-size': '100% 100%',
      },
    ),
  ];
}

class _AboutState extends State<About> {
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
    // Watch the current mode from state management
    String currentMode = context.watch(state_management.mode);
    Color color = currentMode == 'dark' ? whiteColor : Colors.black;
    final highlights = [
      'Systems mindset',
      'Security literate',
      'Detail obsessed',
    ];

    return section(id: component.id, classes: 'about-section', [
      div(classes: 'container', [
        div(classes: 'about-wrapper section-shell', [
          div(classes: 'about-content', [
            h3(classes: filled ? 'fill' : '', styles: Styles(fontSize: 60.px), [
              ScrambledText('我是谁？'),
            ]),
            h2(styles: Styles(color: bluelight.withOpacity(0.8)), [ScrambledText('/ who am i?')]),
            p(styles: Styles(color: color, lineHeight: Unit.em(1.7)), [
              .text('I’m Hani, a '),
              span(
                styles: Styles(
                  color: BlueColor,
                  fontWeight: FontWeight.bold,
                ),
                [.text('Flutter developer')],
              ),
              .text(
                ' building bold digital products with a focus on clean systems, expressive interfaces, and resilient engineering. I’m also deeply interested in ',
              ),
              span(
                styles: Styles(
                  fontWeight: FontWeight.bold,
                ),
                [.text('low-level programming')],
              ),
              .text(', '),
              span(
                styles: Styles(
                  fontWeight: FontWeight.bold,
                ),
                [.text('systems')],
              ),
              .text(', and '),
              span(
                styles: Styles(
                  color: BlueColor,
                  fontWeight: FontWeight.bold,
                ),
                [.text('cybersecurity')],
              ),
              .text('. My approach is equal parts craft, architecture, and visual storytelling.'),
            ]),
            div(
              classes: 'about-highlights',
              [
                for (final item in highlights)
                  span(
                    classes: 'about-pill',
                    [.text(item)],
                  ),
              ],
            ),
          ]),
          div(classes: 'about-image-wrapper ${filled ? 'show' : ''}', [
            div(classes: 'image-frame', []),
            img(
              classes: 'about-image',
              src: 'images/personal.jpg',
              alt: 'About Image',
            ),
          ]),
        ]),
      ]),
    ]);
  }
}
