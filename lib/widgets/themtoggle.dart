import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/state_management/light-dark-mode.dart';

class ThemeToggle extends StatelessComponent {
  const ThemeToggle();

  @override
  Component build(BuildContext context) {
    final currentMode = context.watch(mode); // watch your Riverpod mode

    return button(
      classes: 'theme-toggle',
      attributes: {
        'type': 'button',
        'title': 'Toggle theme',
        'aria-label': 'Toggle theme',
        'data-theme': currentMode,
      },
      onClick: () {
        final newMode = currentMode == 'light' ? 'dark' : 'light';
        context.read(mode.notifier).state = newMode;
        print('Toggled mode to $newMode');
      },
      [
        svg(
          classes: 'theme-toggle__inner-moon',
          attributes: {
            'xmlns': 'http://www.w3.org/2000/svg',
            'width': '32px',
            'height': '32px',
            'fill': 'currentColor',
            'viewBox': '0 0 32 32',
          },
          [
            path(
              [],
              attributes: {
                'd':
                    'M27.5 11.5v-7h-7L16 0l-4.5 4.5h-7v7L0 16l4.5 4.5v7h7L16 32l4.5-4.5h7v-7L32 16l-4.5-4.5zM16 25.4a9.39 9.39 0 1 1 0-18.8 9.39 9.39 0 1 1 0 18.8z'
              },
            ),
            circle([], attributes: {'cx': '16', 'cy': '16', 'r': '8.1', 'id': 'inner-moon-circle'}),
          ],
        ),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
        css('.theme-toggle', [
          css('&').styles(
            backgroundColor: Colors.transparent,
            border: Border.none,
            cursor: Cursor.pointer,
            padding: Spacing.all(0.px),
            ),
          ]),
        css('.theme-toggle__inner-moon #inner-moon-circle').styles(
          transition: Transition('transform', curve: Curve.cubicBezier(0.5, -0.5, 0.5, 1.5), duration: Duration(milliseconds: 500)),
          transform: Transform.translate(x: 5.px),
        ),
        css('.theme-toggle[data-theme="light"]', [
          css('&').styles(
            color: Colors.black,
          ),
          css('.theme-toggle__inner-moon #inner-moon-circle').styles(
            transform: Transform.translate(x:5.px),
            color: Colors.white,
          ),
        ]),
        css('.theme-toggle[data-theme="dark"]', [
          css('&').styles(
            color: Colors.white,
          ),
          css('.theme-toggle__inner-moon #inner-moon-circle').styles(
            transform: Transform.translate(x: 5.px),
            color: Colors.black,
          ),
        ]),
      ];
}
