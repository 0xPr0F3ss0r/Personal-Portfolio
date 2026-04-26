import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:my_portfolio/components/video_background.dart';
import 'package:my_portfolio/constants/theme.dart';

class StartSection extends StatefulComponent {
  @override
  State<StartSection> createState() => _StartSectionState();

  static get styles => [
    css('#start').styles(
      display: Display.flex,
      position: Position.relative(),
      minHeight: 100.vh,
      margin: Spacing.zero,
      overflow: Overflow.hidden,
      flexDirection: FlexDirection.column,
      justifyContent: JustifyContent.center,
      alignItems: AlignItems.start,
      color: whiteColor,
      textAlign: TextAlign.start,
      padding: Spacing.only(top: 8.rem, bottom: 3.rem),
      raw: {
        'background-image':
            'linear-gradient(145deg, rgba(70,167,255,0.16) 0 14%, transparent 14% 100%), radial-gradient(circle at 75% 18%, rgba(128,192,255,0.18), transparent 30%)',
      },
    ),
    css('#start .container').styles(
      position: Position.relative(),
      width: 100.percent,
      maxWidth: 1200.px,
      padding: Spacing.only(left: 2.5.rem, right: 2.5.rem, top: 6.rem, bottom: 6.rem),
      margin: Spacing.zero,
      display: Display.grid,
      raw: {
        'z-index': '2',
        'grid-template-columns': 'minmax(0, 1.25fr) minmax(280px, 0.75fr)',
        'gap': '32px',
      },
    ),
    css('.cta', [
      css('&').styles(
        display: Display.flex,
        flexDirection: FlexDirection.column,
        gap: Gap.all(18.px),
        maxWidth: 860.px,
      ),
      css('.hero-kicker').styles(
        margin: Spacing.zero,
        color: bluelight,
        fontFamily: codeFont,
        fontSize: 0.82.rem,
        raw: {
          'letter-spacing': '0.34em',
          'text-transform': 'uppercase',
        },
      ),
      css('h1').styles(
        fontSize: 5.4.rem,
        lineHeight: 0.98.em,
        margin: Spacing.zero,
        raw: {
          'letter-spacing': '-0.02em',
          'max-width': '9ch',
        },
      ),
      css('p.hero-loop').styles(
        display: Display.inlineBlock,
        padding: Spacing.symmetric(horizontal: 0.55.em, vertical: 0.18.em),
        margin: Spacing.zero,
        color: whiteColor,
        fontSize: 2.2.rem,
        raw: {
          'transition': 'color 500ms ease-in-out',
          'transition': 'background-size 500ms ease-in-out',
          'text-transform': 'uppercase',
          'letter-spacing': '0.16em',
        },
      ),
      css('p.hero-loop.fill').styles(
        raw: {
          'background-size': '100% 100%',
        },
      ),

      css('.hero-actions').styles(
        display: Display.flex,
        flexWrap: FlexWrap.wrap,
        gap: Gap.all(14.px),
        margin: Spacing.only(top: 10.px),
      ),
      css('.hero-button').styles(
        display: Display.inlineFlex,
        alignItems: AlignItems.center,
        justifyContent: JustifyContent.center,
        padding: Spacing.symmetric(horizontal: 22.px, vertical: 14.px),
        radius: BorderRadius.circular(999.px),
        border: Border.all(color: Colors.white.withOpacity(0.16)),
        color: whiteColor,
        textDecoration: TextDecoration.none,
        fontFamily: displayFont,
        fontWeight: FontWeight.w600,
        raw: {
          'letter-spacing': '0.08em',
          'text-transform': 'uppercase',
          'transition': 'transform 0.25s ease, background-color 0.25s ease',
        },
      ),
      css('.hero-button.primary').styles(
        backgroundColor: primaryColor,
        raw: {
          'box-shadow': '0 16px 36px rgba(0,128,255,0.28)',
        },
      ),
      css('.hero-button.secondary').styles(
        backgroundColor: Color.rgba(245, 234, 218, 0.05),
      ),
      css('.hero-badges').styles(
        display: Display.flex,
        flexWrap: FlexWrap.wrap,
        gap: Gap.all(12.px),
      ),
      css('.hero-badge').styles(
        padding: Spacing.symmetric(horizontal: 18.px, vertical: 10.px),
        radius: BorderRadius.circular(999.px),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
        backgroundColor: Color.rgba(4, 6, 17, 0.35),
        fontSize: 0.85.rem,
        raw: {
          'text-transform': 'uppercase',
          'letter-spacing': '0.12em',
        },
      ),
      css('.hero-manifesto').styles(
        padding: Spacing.all(28.px),
        radius: BorderRadius.circular(28.px),
        border: Border.all(color: Color.rgba(245, 234, 218, 0.10)),
        backgroundColor: Color.rgba(4, 6, 17, 0.75),
        alignSelf: AlignSelf.end,
        raw: {
          'backdrop-filter': 'blur(18px)',
          'box-shadow': '0 24px 55px rgba(0,0,0,0.28)',
        },
      ),
      css('.hero-manifesto p').styles(
        margin: Spacing.zero,
        fontFamily: codeFont,
        color: bluelight,
        fontSize: 0.78.rem,
        raw: {
          'letter-spacing': '0.24em',
          'text-transform': 'uppercase',
        },
      ),
      css('.hero-manifesto h2').styles(
        margin: Spacing.only(top: 12.px, bottom: 16.px),
        fontFamily: displayFont,
        fontSize: 2.3.rem,
        lineHeight: Unit.em(1.05),
        color: whiteColor,
      ),
      css('.hero-manifesto ul').styles(
        margin: Spacing.zero,
        padding: Spacing.zero,
        listStyle: ListStyle.none,
        raw: {
          'display': 'grid',
          'gap': '14px',
        },
      ),
      css('.hero-manifesto li').styles(
        padding: Spacing.only(left: 18.px),
        fontFamily: bodyFont,
        color: textColor,
        raw: {
          'position': 'relative',
        },
      ),
      css('.hero-manifesto li::before').styles(
        raw: {
          'content': '"/"',
          'position': 'absolute',
          'left': '0',
          'top': '0',
          'color': '#0080FF',
          'font-weight': '700',
        },
      ),
      css.media(MediaQuery.screen(maxWidth: 768.px), [
        css('#start .container').styles(
          padding: Spacing.only(left: 1.2.rem, right: 1.2.rem, top: 4.rem, bottom: 4.rem),
          raw: {
            'grid-template-columns': '1fr',
          },
        ),
        css('h1').styles(
          fontSize: 3.2.rem,
          raw: {'max-width': '100%'},
        ),
        css('p.hero-loop').styles(
          fontSize: 1.15.rem,
          padding: Spacing.symmetric(horizontal: 0.4.em, vertical: 0.15.em),
        ),
        css('.hero-manifesto').styles(
          alignSelf: AlignSelf.center,
          width: 100.percent,
          maxWidth: 450.px,
          padding: Spacing.all(20.px),
        ),

      ]),
      css.media(MediaQuery.screen(maxWidth: 480.px), [
        css('h1').styles(
          fontSize: 2.5.rem,
        ),
        css('p.hero-loop').styles(
          fontSize: 1.rem,
        ),
      ]),
    ]),
    ...VideoBackground.styles,
  ];
}

class _StartSectionState extends State<StartSection> {
  final List<String> texts = [
    "flutter developer",
    "cyber security enthusiast",
  ];
  final List<String> badges = const [
    'Based in Algeria',
    'Flutter + security',
    'Open for ambitious work',
  ];
  int index = 0;
  bool filled = false;
  bool showChinese = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() => filled = true);
      });

      // Start Chinese text animation
      Future.delayed(const Duration(milliseconds: 1600), () {
        if (mounted) {
          setState(() => showChinese = true);
        }
      });
      // Switch to English text immediately after Chinese animation
      Future.delayed(const Duration(milliseconds: 1600), () {
        if (mounted) {
          setState(() => showChinese = false);
        }
      });

      // Paragraph cycling
      _timer = Timer.periodic(const Duration(seconds: 4), (_) async {
        setState(() => filled = false);
        await Future.delayed(const Duration(milliseconds: 500));
        index = (index + 1) % texts.length;
        setState(() {});
        await Future.delayed(const Duration(milliseconds: 50));
        setState(() => filled = true);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Component build(BuildContext context) {
    return section(
      id: 'start',
      styles: Styles(position: Position.relative()),
      [
        const VideoBackground(),
        div(classes: 'container', [
          div(classes: 'cta', [
            p(classes: 'hero-kicker', []),
            h1(
              classes: showChinese ? 'chinese show' : 'english',
              styles: Styles(
                color: Colors.white,
                fontFamily: displayFont,
                raw: {
                  'letter-spacing': '-0.02em',
                  'text-transform': 'uppercase',
                },
              ),
              [.text(showChinese ? '哈尼' : 'Kebir Hani')],
            ),
            p(
              classes: filled ? 'hero-loop fill' : 'hero-loop',
              styles: Styles(
                color: Colors.white,
                fontFamily: displayFont,
              ),
              [.text(texts[index])],
            ),

            div(classes: 'hero-actions', [
              a(classes: 'hero-button primary', href: '#section-projects', [.text('View Projects')]),
              a(classes: 'hero-button secondary', href: '#section-contact', [.text('Start a Conversation')]),
            ]),
            div(
              classes: 'hero-badges',
              [
                for (final badge in badges)
                  span(
                    classes: 'hero-badge',
                    styles: Styles(
                      fontFamily: displayFont,
                    ),
                    [.text(badge)],
                  ),
              ],
            ),
          ]),

        ]),
      ],
    );
  }
}
