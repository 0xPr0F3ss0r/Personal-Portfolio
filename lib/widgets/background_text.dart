import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:my_portfolio/constants/theme.dart';

class BackgroundText extends StatelessComponent {
  final List<String> words = [
    '开发',
    '编程',
    '网络安全',
    '系统',
    '跨平台',
    '技术',
    '界面',
    '代码',
    '算法',
    '数据',
  ];

  BackgroundText({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'background-text-container',
      [
        div(classes: 'bg-column left', [
          for (var i = 0; i < 5; i++) div(classes: 'bg-word', [Component.text(words[i % words.length])]),
        ]),
        div(classes: 'bg-column right', [
          for (var i = 5; i < 10; i++) div(classes: 'bg-word', [Component.text(words[i % words.length])]),
        ]),
      ],
    );
  }

  static get styles => [
    css('.background-text-container').styles(
      position: .fixed(top: 0.px, left: 0.px),
      width: 100.percent,
      height: 100.vh,
      pointerEvents: PointerEvents.none,
      raw: {'z-index': '0', 'mix-blend-mode': 'screen'},
    ),
    css('.bg-column').styles(
      display: Display.flex,
      position: .absolute(),
      height: 100.percent,
      padding: Spacing.symmetric(vertical: 2.rem),
      opacity: 0.06,
      flexDirection: FlexDirection.column,
      justifyContent: JustifyContent.spaceBetween,
      color: primaryColor,
      fontSize: 7.rem,
      fontWeight: FontWeight.bold,
      whiteSpace: WhiteSpace.noWrap,
      raw: {
        'writing-mode': 'vertical-rl',
        'text-orientation': 'upright',
        'letter-spacing': '-0.35rem',
        'user-select': 'none',
        'transform': 'rotate(12deg)',
      },
    ),
    css('.bg-column.left').styles(
      position: .absolute(left: (-0.2).rem, top: (-1).rem),
    ),
    css('.bg-column.right').styles(
      position: .absolute(right: (-0.4).rem, bottom: (-1).rem),
    ),
    css('.bg-word').styles(
      margin: Spacing.symmetric(vertical: 1.rem),
    ),
    css.media(MediaQuery.screen(maxWidth: 768.px), [
      css('.bg-column').styles(
        opacity: 0.03,
        fontSize: 4.rem,
      ),
      css('.bg-column.left').styles(position: .absolute(left: 0.2.rem)),
      css('.bg-column.right').styles(position: .absolute(right: 0.2.rem)),
    ]),
  ];
}
