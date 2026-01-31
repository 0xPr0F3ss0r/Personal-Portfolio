import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/state_management/light-dark-mode.dart'
    as state_management;

class Myskills extends StatelessComponent {
  const Myskills({super.key});

  @override
  Component build(BuildContext context) {
    String currentMode = context.watch(state_management.mode);
    Color color = currentMode == 'dark' ? Colors.white : Colors.black;

    return section(classes: 'skills-section', [
      div(classes: 'container', [
        div(classes: 'skills-wrapper', [
          div(classes: 'skills-content', [
            h1(
              styles: Styles(color: BlueColor, fontSize: 50.px),
              [.text('что я знаю')],
            ),
            // First paragraph
            p(
              styles: Styles(color: color, lineHeight: Unit.em(1.7)),
              [
                .text(
                  'I have 3 years of experience with Flutter and Dart, building apps and exploring advanced features. I’ve also worked with C, C++, and Python for system programming, reverse engineering, and automation. I know the basics of HTML, CSS, and JavaScript.'
                )
              ],
            ),
            // Second paragraph
            p(
              styles: Styles(color: color, lineHeight: Unit.em(1.7)),
              [
                .text(
                  'I have a solid programming foundation that lets me quickly learn new languages or frameworks.'
                )
              ],
            ),
            // Third paragraph
            p(
              styles: Styles(color: color, lineHeight: Unit.em(1.7)),
              [
                .text(
                  'Currently, I’m diving into 3D Flutter development and expanding my cybersecurity skills.'
                )
              ],
            ),
          ]),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
        css('.skills-section').styles(
          display: Display.flex,
          minHeight: 100.vh,
          padding: Spacing.symmetric(horizontal: 350.px), 
          flexDirection: FlexDirection.column,         
          justifyContent: JustifyContent.center,                   
          alignItems: AlignItems.center,
          textAlign: TextAlign.center, 
        ),

        css('.skills-wrapper').styles(
          display: Display.flex,
          width: 100.percent,
          maxWidth: 900.px,
          flexDirection: FlexDirection.column,
          justifyContent: JustifyContent.center,
          alignItems: AlignItems.center,
          gap: Gap.all(20.px), 
        ),

        css('.skills-content').styles(
          maxWidth: 700.px,
        ),

        css('.skills-content h1').styles(
          margin: Spacing.only(bottom: 25.px),
          fontFamily: FontFamily('DynaPuff'),
        ),

        css('.skills-content p').styles(
          margin: Spacing.only(top: 15.px),
          fontSize: 22.px,
          lineHeight: Unit.em(1.8),
        ),
      ];
}
