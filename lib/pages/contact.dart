// ignore_for_file: avoid_print
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/state_management/light_dark_mode.dart' as state_management;
import 'package:my_portfolio/widgets/scrambled_text.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

class Contact extends StatefulComponent {
  final String id;
  const Contact({super.key, required this.id});

  @override
  State<Contact> createState() => _ContactState();

  @css
  static List<StyleRule> get styles => [
    css('.contact-section').styles(
      padding: Spacing.symmetric(vertical: 5.rem),
      raw: {
        'scroll-margin-top': '140px',
      },
    ),
    css('.contact-wrapper').styles(
      display: Display.flex,
      width: 100.percent,
      maxWidth: 1040.px,
      flexDirection: FlexDirection.column,
      flexWrap: FlexWrap.wrap,
      justifyContent: JustifyContent.center,
      alignItems: AlignItems.center,
      gap: Gap.all(40.px),
      raw: {'margin': '0 auto'},
    ),
    css('.contact-content').styles(
      maxWidth: 560.px,
      flex: Flex.none,
      textAlign: TextAlign.center,
      raw: {'margin-top': '-20px'},
    ),
    css('.contact-content h2').styles(
      fontFamily: displayFont,
      fontSize: 1.3.rem,
      raw: {
        'text-transform': 'uppercase',
        'letter-spacing': '0.2em',
      },
    ),
    css('.contact-content h3').styles(
      margin: Spacing.only(bottom: 15.px),
      fontFamily: displayFont,
      fontSize: 3.rem,
    ),
    css('.contact-content p').styles(
      margin: Spacing.only(top: 15.px),
      fontSize: 1.1.rem,
      fontFamily: bodyFont,
      lineHeight: Unit.em(1.8),
      raw: {
        'text-wrap': 'balance',
      },
    ),
    css('.contact-meta').styles(
      display: Display.flex,
      gap: Gap.all(16.px),
      margin: Spacing.only(top: 32.px),
      flexWrap: FlexWrap.wrap,
      justifyContent: JustifyContent.center,
    ),
    css('.contact-meta .meta-card').styles(
      padding: Spacing.all(18.px),
      radius: BorderRadius.circular(16.px),
      border: Border.all(color: Colors.white.withOpacity(0.12)),
      backgroundColor: Color.rgba(255, 255, 255, 0.03),
      fontFamily: bodyFont,
      minWidth: 220.px,
    ),
    css('.contact-meta .meta-card span').styles(
      display: Display.block,
      fontSize: 0.85.rem,
      color: BlueColor,
      raw: {
        'text-transform': 'uppercase',
        'letter-spacing': '0.1em',
      },
    ),
    css('.contact-meta .meta-card strong').styles(
      display: Display.block,
      margin: Spacing.only(top: 6.px),
      fontFamily: displayFont,
      fontSize: 1.1.rem,
    ),
    css('.contact-links').styles(
      display: Display.flex,
      minWidth: 240.px,
      flexDirection: FlexDirection.row,
      justifyContent: JustifyContent.center,
      flexWrap: FlexWrap.wrap,
      gap: Gap.all(20.px),
    ),
    css('.contact-card').styles(
      display: Display.flex,
      padding: Spacing.symmetric(vertical: 12.px, horizontal: 18.px),
      border: Border.all(color: Color.rgba(255, 255, 255, 0.12)),
      radius: BorderRadius.circular(18.px),
      cursor: Cursor.pointer,
      transition: const Transition(
        'all',
        curve: Curve.easeInOut,
        duration: Duration(milliseconds: 250),
      ),
      alignItems: AlignItems.center,
      textDecoration: TextDecoration.none,
      gap: Gap.all(16.px),
      backgroundColor: Color.rgba(255, 255, 255, 0.03),
      raw: {
        'clip-path': 'polygon(0 0, 100% 0, 100% 86%, 90% 100%, 0 100%)',
      },
    ),
    css('.contact-card img').styles(
      width: 40.px,
      height: 40.px,
      radius: BorderRadius.circular(50.px),
      raw: {
        'objectFit': 'cover',
      },
    ),
    css('.contact-card:hover').styles(
      transform: Transform.translate(y: (-3).px),
      color: Colors.white,
      backgroundColor: Color.rgba(70, 167, 255, 0.16),
    ),
    css('.contact-section h3').styles(
      display: Display.inlineBlock,
      padding: Spacing.symmetric(vertical: 0.25.em),
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
    css('.contact-section h3.fill').styles(
      raw: {
        'background-size': '100% 100%',
      },
    ),
    css.media(MediaQuery.screen(maxWidth: 900.px), [
      css('.contact-wrapper').styles(
        flexDirection: FlexDirection.column,
        alignItems: AlignItems.center,
        textAlign: TextAlign.center,
        gap: Gap.all(32.px),
      ),
      css('.contact-content').styles(
        width: 100.percent,
        maxWidth: 100.percent,
      ),
      css('.contact-content h2').styles(
        fontSize: 1.1.rem,
      ),
      css('.contact-section h3').styles(
        fontSize: 2.8.rem,
        raw: {
          'line-height': '1.1',
        },
      ),
      css('.contact-content p').styles(
        fontSize: 1.rem,
        lineHeight: Unit.em(1.6),
      ),
      css('.contact-links').styles(
        width: 100.percent,
        minWidth: Unit.auto,
        justifyContent: JustifyContent.center,
        flexWrap: FlexWrap.wrap,
      ),
    ]),
    css.media(MediaQuery.screen(maxWidth: 480.px), [
      css('.contact-section h3').styles(
        fontSize: 2.rem,
      ),
      css('.contact-card p').styles(
        fontSize: 0.9.rem,
      ),
      css('.contact-card img').styles(
        width: 30.px,
        height: 30.px,
      ),
      css('.contact-card span').styles(
        fontSize: 16.px,
      ),
    ]),
  ];
}

class _ContactState extends State<Contact> {
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
    String currentMode = context.watch(state_management.mode);
    Color color = currentMode == 'dark' ? Colors.white : Colors.black;
    final meta = const [
      {'label': 'Response time', 'value': '< 24h globally'},
      {'label': 'Focus', 'value': 'Flutter · Security · Tooling'},
    ];

    return section(id: component.id, classes: 'contact-section', [
      div(classes: 'container', [
        div(classes: 'contact-wrapper section-shell', [
          div(classes: 'contact-content', [
            h3(classes: filled ? 'fill' : '', styles: Styles(fontSize: 60.px), [
              ScrambledText('связаться со мной'),
            ]),
            h2(styles: Styles(color: color), [ScrambledText('get in touch')]),

            p(
              styles: Styles(color: color, lineHeight: Unit.em(1.7)),
              [
                .text("I’m available for "),
                span(
                  styles: Styles(
                    color: BlueColor,
                    fontWeight: FontWeight.bold,
                  ),
                  [.text('freelance')],
                ),
                .text(" and "),
                span(
                  styles: Styles(
                    color: BlueColor,
                    fontWeight: FontWeight.bold,
                  ),
                  [.text('contract')],
                ),
                .text(
                  " opportunities, especially where product ambition and visual distinctiveness matter. Reach out if you want something that feels authored rather than assembled.",
                ),
              ],
            ),
            div(
              classes: 'contact-meta',
              [
                for (final item in meta)
                  div(
                    classes: 'meta-card',
                    [
                      span([
                        .text(item['label'] ?? ''),
                      ]),
                      strong([
                        .text(item['value'] ?? ''),
                      ]),
                    ],
                  ),
              ],
            ),
          ]),

          /// RIGHT SIDE (social links with images)
          div(classes: 'contact-links', [
            _socialLink('LinkedIn', 'https://linkedin.com/in/kebir-hani', 'images/linkedin.png', color, currentMode),
            _socialLink('GitHub', 'https://github.com/0xPr0F3ss0r', 'images/github12.png', color, currentMode),
            _socialLink('Twitter', 'https://twitter.com/Hani_Dev_', 'images/twitter.png', color, currentMode),
          ]),
        ]),
      ]),
    ]);
  }

  /// Component for social link with image
  Component _socialLink(String title, String url, String imgPath, Color color, String currentColor) {
    return a(
      href: url,
      target: Target.blank,
      classes: 'contact-card',
      [
        img(
          src: imgPath,
          alt: title,
          styles: Styles(
            width: 52.px,
            height: 52.px,
            radius: BorderRadius.circular(999.px),
            filter: currentColor == "dark" ? Filter.invert(1) : Filter.invert(0),
          ),
        ),
        span(
          styles: Styles(
            margin: Spacing.only(left: 12.px),
            color: color,
            fontSize: 18.px,
            fontWeight: FontWeight.bold,
          ),
          [.text(title)],
        ),
      ],
    );
  }
}
