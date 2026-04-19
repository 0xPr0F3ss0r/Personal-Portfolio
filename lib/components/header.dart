import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/widgets/themtoggle.dart';
import 'package:my_portfolio/state_management/light_dark_mode.dart' as state_management;
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/widgets/scrambled_text.dart';

@client
class Header extends StatelessComponent {
  const Header({super.key});

  @override
  Component build(BuildContext context) {
    var activePath = context.url;
    String currentMode = context.watch(state_management.mode);
    return header(
      styles: Styles(
        backgroundColor: currentMode == 'dark' ? Color.rgba(4, 6, 17, 0.82) : Color.rgba(252, 253, 255, 0.92),
        shadow: BoxShadow(
          offsetX: 0.px,
          offsetY: 18.px,
          blur: 40.px,
          color: Colors.black.withOpacity(0.25),
        ),
        raw: {
          'backdrop-filter': 'blur(18px) saturate(135%)',
          'border-bottom': currentMode == 'dark' ? '1px solid rgba(255,255,255,0.08)' : '1px solid rgba(3,7,18,0.08)',
        },
      ),
      [
        div(classes: 'header-left', styles: Styles(display: Display.flex, alignItems: .center, gap: Gap.all(16.px)), [
          a(
            href: '/',
            [
              div(classes: 'header-mark', [
                div(classes: 'header-brand', [
                  img(
                    src: 'images/Dinosor.png',
                    styles: Styles(height: 48.px),
                  ),
                ]),
              ]),
            ],
          ),

          nav(
            classes: 'site-nav',
            styles: Styles(
              color: currentMode == 'dark' ? whiteColor : Colors.black,
              fontFamily: displayFont,
            ),
            [
              for (var route in [
                (label: 'Home', path: '/'),
                (label: 'About', path: '#section-about'),
                (label: 'Skills', path: '#section-skills'),
                (label: 'Projects', path: '#section-projects'),
                (label: 'Contact', path: '#section-contact'),
              ])
                div(classes: activePath == route.path ? 'active' : null, [
                  a(href: route.path, [.text(route.label.toUpperCase())]),
                ]),
            ],
          ),
        ]),

        ThemeToggle(),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('header').styles(
      display: .flex,
      position: .fixed(top: 0.px, left: 0.px),
      zIndex: ZIndex(9999),
      width: 100.percent,
      padding: .symmetric(horizontal: 32.px, vertical: 14.px),
      justifyContent: .spaceBetween,
      alignItems: .center,
      raw: {
        'transition': 'background-color 0.3s ease, border-color 0.3s ease',
      },
    ),
    css('header .header-left').styles(
      display: Display.flex,
      alignItems: AlignItems.center,
      gap: Gap.all(24.px),
    ),
    css('header .header-mark').styles(
      display: Display.flex,
      alignItems: AlignItems.center,
      gap: Gap.all(14.px),
      color: whiteColor,
      raw: {
        'text-decoration': 'none',
      },
    ),
    css('header .header-mark__red').styles(
      width: 18.px,
      height: 54.px,
      backgroundColor: primaryColor,
      raw: {
        'clip-path': 'polygon(0 0, 100% 0, 100% 72%, 0 100%)',
      },
    ),
    css('header .header-brand p').styles(
      margin: Spacing.zero,
      fontFamily: codeFont,
      fontSize: 0.72.rem,
      color: bluelight,
      raw: {
        'letter-spacing': '0.26em',
        'text-transform': 'uppercase',
      },
    ),
    css('header .header-brand strong').styles(
      display: Display.block,
      fontFamily: displayFont,
      fontSize: 1.05.rem,
      color: whiteColor,
      raw: {
        'letter-spacing': '0.04em',
      },
    ),
    css('nav a').styles(
      color: .currentColor,
    ),

    css('nav.site-nav', [
      css('&').styles(
        display: .flex,
        padding: Spacing.symmetric(horizontal: 16.px, vertical: 8.px),
        radius: .all(.circular(999.px)),
        overflow: .visible,
        flexDirection: .row,
        gap: Gap.all(18.px),
        raw: {
          'background': 'rgba(255,255,255,0.03)',
          'border': '1px solid rgba(255,255,255,0.08)',
        },
      ),

      css('a', [
        css('&').styles(
          display: .flex,
          height: 100.percent,
          padding: .symmetric(horizontal: 0.75.em, vertical: 0.4.em),
          alignItems: .center,
          fontFamily: displayFont,
          fontSize: 0.85.em,
          fontWeight: .w600,
          textDecoration: TextDecoration(line: .none),
          raw: {
            'position': 'relative',
            'transition': 'color 0.25s ease',
            'text-transform': 'uppercase',
            'letter-spacing': '0.18em',
          },
        ),
        css('&::after').styles(
          content: '',
          display: .block,
          position: .absolute(bottom: (-6).px, left: 0.px),
          width: 100.percent,
          height: 2.px,
          backgroundColor: bluelight,
          raw: {
            'transform': 'scaleX(0)',
            'transform-origin': 'left center',
            'transition': 'transform 0.3s ease',
          },
        ),
        css('&:hover::after').styles(
          raw: {
            'transform': 'scaleX(1)',
          },
        ),
      ]),

      css('div.active a').styles(
        color: primaryColor,
      ),
      css('div.active a::after').styles(
        raw: {
          'transform': 'scaleX(1)',
        },
      ),
    ]),
    css.media(MediaQuery.screen(maxWidth: 768.px), [
      css('header').styles(
        padding: .symmetric(horizontal: 16.px, vertical: 12.px),
        flexDirection: FlexDirection.row,
        alignItems: AlignItems.center,
        justifyContent: JustifyContent.spaceBetween,
        gap: Gap.all(4.px),
      ),
      css('header .header-left').styles(
        display: Display.flex,
        flex: Flex.grow(1),
        justifyContent: JustifyContent.spaceBetween,
        alignItems: AlignItems.center,
        flexDirection: FlexDirection.row,
        gap: Gap.all(8.px),
        margin: Spacing.only(right: 12.px),
      ),
      css('nav.site-nav').styles(
        padding: .symmetric(horizontal: 4.px, vertical: 2.px),
        gap: .all(3.px),
        width: .auto,
      ),
      css('nav.site-nav a').styles(
        fontSize: 0.5.rem,
        padding: .symmetric(horizontal: 0.3.em, vertical: 0.1.em),
        raw: {
          'letter-spacing': '0.04.em',
        },
      ),
      css('.theme-toggle').styles(
        position: .relative(),
      ),
    ]),
  ];
}
