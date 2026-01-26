import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:my_portfolio/widgets/toglethem.dart';
import '../constants/theme.dart';
@client
class Header extends StatefulComponent {
    
    Header({super.key});

  @override
  State<Header> createState() => HeaderState();
}

class HeaderState extends State<Header> {

  @override
  Component build(BuildContext context) {
    var activePath = context.url;

    return header(
      
      [
      ToggleTheme(),

            
             
      // button(
      //   classes: 'mode-button',
      //   attributes: {'aria-label': 'Toggle Menu'},
      //   onClick: () => {},
      //   [
      //     img(src: 'images/moon1.png', alt: 'light/dark mode'),
      //   ],
      // ),
      
      Link(
        to: '/',
        child: img(
          classes: 'header-logo',
          src: 'images/Dinosor.png',
          alt: 'Logo',
          height: 150,
          width: 150,
        ),
      ),
      nav([
        for (var route in [
          (label: 'Home', path: '/'),
          (label: 'About', path: '/about'),
          (label: 'projects', path: '/projects'),
          (label: 'contact', path: '/contact'),
        ])
          div(
            classes: activePath == route.path ? 'active' : '',
            styles: Styles(color: whiteColor),
            [
              Link(
                to: route.path,
                child: span([text(route.label)]),
              ),
            ],
          ),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.name', [
      css('&').styles(
        color: Colors.red,
        margin: .zero,
        padding: .zero,
      ),
    ]),
    css('header', [
      css('&').styles(
        display: .flex,
        position: .relative(),
        padding: .all(1.em),
        // justifyContent: .spaceBetween,
        alignItems: .center,
      ),
      css('img.header-logo').styles(
        radius: .circular(20.px),
        raw: {
          'transition': 'filter 0.5s ease-in 0.05s',
        },
      ),

      css('img.header-logo:hover').styles(
        raw: {'filter': ' invert(50%) sepia(100%) saturate(1000%) hue-rotate(90deg) brightness(100%) contrast(100%)'},
      ),

      css('p.name').styles(
        justifyContent: .right,

        color: greenColor,

        fontFamily: FontFamily("DynaPuff"),

        fontSize: 15.px,
      ),
      css('.mode-button').styles(
        position: .absolute(top: 10.px, right: 10.px),
        width: 40.px,
        height: 40.px,
        padding: .zero,
        border: .none,
        backgroundColor: .currentColor,
        cursor: .pointer,
        zIndex: ZIndex(9999),
      ),

      css('nav', [
        css('&').styles(
          display: .flex,
          padding: Spacing.all(10.px),
          radius: .all(.circular(10.px)),
          overflow: .clip,
          flexDirection: .row,
          gap: Gap.all(30.px),
        ),
        css('a', [
          css('&').styles(
            display: .flex,
            height: 100.percent,
            padding: .symmetric(horizontal: 0.5.em),
            alignItems: .center,
            color: greenColor,
            fontFamily: FontFamily("DynaPuff"),
            fontWeight: .w700,
            textDecoration: TextDecoration(line: .none),
          ),
          css('&:hover', [
            css('&::after').styles(
              content: '',
              display: .block,
              position: .absolute(top: 50.percent, left: (-10).px),
              width: 120.percent,
              height: 4.px,
              transform: Transform.translate(y: (-50).percent),
              backgroundColor: whiteColor,
            ),
          ]).styles(
            display: .inlineBlock,
            position: .relative(),
          ),
        ]),

        css('div.active span', [
          css('&').styles(
            display: .inlineBlock,
            position: .relative(),
          ),
          css('&::after').styles(
            content: '',
            display: .block,
            position: .absolute(top: 50.percent, left: (-10).px),
            width: 150.percent,
            height: 4.px,
            transform: Transform.translate(y: (-50).percent),
            backgroundColor: whiteColor,
          ),
        ]),
      ]),
    ]),
  ];
}
