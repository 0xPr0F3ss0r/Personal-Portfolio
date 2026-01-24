import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../constants/theme.dart';

class Header extends StatelessComponent {
  const Header({super.key});

  @override
  Component build(BuildContext context) {
    var activePath = context.url;

    return header([
      p(classes: 'name',[.text('/* KEBIR HANI */')]),
      nav([
        for (var route in [
          (label: 'Home', path: '/'),
          (label: 'About', path: '/about'),
          (label: 'projects', path: '/projects'),
          (label: 'contact', path: '/contact'),

        ])
          div(classes: activePath == route.path ? 'active' : null, [
            Link(to: route.path, child: .text(route.label)),
          ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('header', [
      css('&').styles(
        display: .flex,
        position: .relative(),
        padding: .all(1.em),
        justifyContent: .spaceBetween,
        alignItems: .center,
      ),
      
      css('p.name').styles(
      //  fontFamily: 'Courier New, monospace',
        color: greenColor,
        fontSize: 15.px,
      ),

      css('nav', [
        css('&').styles(
          display: .flex,
          height: 3.em,
          radius: .all(.circular(10.px)),
          overflow: .clip,
          justifyContent: .right,
          // backgroundColor: secondColor,
        ),
        css('a', [
          css('&').styles(
            display: .flex,
            height: 100.percent,
           padding: .symmetric(horizontal: 0.5.em),
            alignItems: .center,
            color: greenColor,
            fontWeight: .w700,
            textDecoration: TextDecoration(line: .none),
          ),
          css('&:hover').styles(
            backgroundColor: const Color('#0005'),
          ),
        ]),
        css('div.active', [
          css('&').styles(position: .relative()),
          css('&::before').styles(
            content: '',
            display: .block,
            position: .absolute(bottom: 0.5.em, left: 20.px, right: 20.px),            
            height: 2.px,
            radius: .circular(1.px),
            backgroundColor: greenColor,
          ),
        ])
      ]),
    ]),
  ];
}
