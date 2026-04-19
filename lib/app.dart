import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/pages/contact.dart';
import 'components/header.dart';
import 'pages/about.dart';
import 'pages/home.dart';
import 'pages/projects.dart';
import 'pages/skills.dart';
// The main component of your application.
//
// By using multi-page routing, this component will only be built on the server during pre-rendering and
// **not** executed on the client. Instead only the nested [Home] and [About] components will be mounted on the client.

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    // This method is rerun every time the component is rebuilt.

    // Renders a <div class="main"> html element with children.
    return div(classes: 'main', [
      link(
        href:
            'https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500;600&display=swap',
        rel: 'stylesheet',
      ),
      Header(),
      Home(),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('html, body').styles(
      width: 100.percent,
      minHeight: 100.vh,
      margin: Spacing.zero,
      padding: Spacing.zero,
      color: textColor,
      fontFamily: bodyFont,
      backgroundColor: backgroundColor,
      raw: {
        'overflow-x': 'hidden',
        'font-kerning': 'normal',
        'font-feature-settings': '"ss01" 1, "liga" 1',
        'background-color': '#0a192f',
      },
    ),
    css('body').styles(
      raw: {
        'line-height': '1.55',
        'letter-spacing': '-0.01em',
        'text-rendering': 'optimizeLegibility',
      },
    ),
    css('*').styles(
      raw: {
        'box-sizing': 'border-box',
      },
    ),
    css('.main', [
      css('&').styles(
        minHeight: 100.vh,
        flexDirection: .column,
        flexWrap: .wrap,
        raw: {
          'position': 'relative',
          'isolation': 'isolate',
          'background-image':
              'linear-gradient(135deg, transparent 0 35%, rgba(245,235,221,0.03) 35% 36%, transparent 36% 100%)',
        },
      ),
      css('&::before').styles(
        raw: {
          'content': '""',
          'position': 'fixed',
          'inset': '0',
          'pointer-events': 'none',
          'z-index': '-1',
        },
      ),
      css('&::after').styles(
        raw: {
          'content': '""',
          'position': 'fixed',
          'right': '4vw',
          'top': '18vh',
          'width': '180px',
          'height': '180px',
          'border': '1px solid rgba(245,234,218,0.15)',
          'transform': 'rotate(45deg)',
          'pointer-events': 'none',
          'z-index': '-1',
        },
      ),
      css('.section').styles(
        flexDirection: .column,
        justifyContent: .center,
        alignItems: .center,
        flex: Flex(grow: 1),
      ),
      css('.section-shell').styles(
        padding: Spacing.symmetric(vertical: 0.px, horizontal: 0.px),
        raw: {
          // Transparent, open-canvas section
        },
      ),
      css('.section-shell:hover').styles(
        raw: {},
      ),
    ]),
    ...Header.styles,
    ...Home.styles,
    ...About.styles,
    ...ProjectsSection.styles,
    ...Contact.styles,
    ...Myskills.styles,
  ];
  // Defines the css styles for elements of this component.
  //
  // By using the @css annotation, these will be rendered automatically to css inside the <head> of your page.
  // Must be a variable or getter of type [List<StyleRule>].
}
