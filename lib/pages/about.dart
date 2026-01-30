import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/state_management/light-dark-mode.dart' as state_management;

class About extends StatelessComponent {
  const About({super.key});

  @override
  Component build(BuildContext context) {
    String currentMode = context.watch(state_management.mode);
    Color color = currentMode == 'dark' ? Colors.white : Colors.black;

    return section(classes: 'about-section', [
      div(classes: 'container', [
        div(classes: 'about-wrapper', [
          // Left: Text
          div(classes: 'about-content', [
            h2(styles: Styles(color: color), [.text('who am i ?')]),
            p(styles: Styles(color: color), [
              .text(
                'I am a passionate Flutter developer with experience in building beautiful and functional applications. I love creating seamless user experiences and writing clean, maintainable code and low-level code explorer and cybersecurity enthusiast.',
              ),
            ]),
          ]),
          // Right: Image
          img(
            classes: 'about-image',
            src: 'images/personal.jpg',
            alt: 'About Image',
            styles: Styles(width: 500.px, height: .auto),
          ),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    // css('.about-section').styles(
    //   padding: Spacing.symmetric(vertical: 50.px, horizontal: 70.px),
    //   justifyContent: JustifyContent.center,
    //   alignItems: AlignItems.center,
    // ),
    css('.about-wrapper').styles(
      display: Display.flex,
      flexDirection: FlexDirection.row,
      alignItems: AlignItems.center,
      justifyContent: JustifyContent.center,
      gap: Gap.all(40.px),
      flexWrap: FlexWrap.wrap,
    ),
    css('.about-content').
    styles(
      maxWidth: 450.px, 
      flex: Flex.none
      ),
    css('.about-content h2').styles(
      fontFamily: FontFamily('DynaPuff'),
      // textAlign: TextAlign.center,
      // justifyContent: JustifyContent.center,
      // alignItems: AlignItems.center
      //    marginBottom: 20.px,
    ),
    css('.about-content p').styles(
      fontSize: 18.px,
      lineHeight: Unit.em(1.7),
      margin: Spacing.only(top: 15.px),
    ),
    css('.about-image').styles(
      flex: Flex.shrink(0),
      //width: 300.px,
      height: .auto,
      radius: BorderRadius.circular(10.px),
    ),
  ];
}
