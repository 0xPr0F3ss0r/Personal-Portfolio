import 'dart:async';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/model/projects_model.dart';
import 'package:my_portfolio/state_management/light-dark-mode.dart' as themeMode;

class AnimatedProjectCard extends StatefulComponent {
  final Project project;
  final int index;

  const AnimatedProjectCard({super.key, required this.project, required this.index});

  @override
  State<AnimatedProjectCard> createState() => _AnimatedProjectCardState();
}

class _AnimatedProjectCardState extends State<AnimatedProjectCard> {
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      Timer(Duration(milliseconds: component.index * 150), () {
        setState(() {
          isVisible = true;
        });
      });
    }
  }

  @override
  Component build(BuildContext context) {
    String currentTheme = context.watch(themeMode.mode);
    Color textColor = currentTheme == 'dark' ? Colors.white : Colors.black;
    Color secondaryText =
        currentTheme == 'dark' ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.6);
    Color cardColor = currentTheme == 'dark' ? Color('#0B0F17') : Colors.white;
    Color borderColor = currentTheme == 'dark' ? Color('#1E2433') : Color('#E5E7EB');
    Color badgeBg = currentTheme == 'dark' ? Color('#121826') : Color('#F3F4F6');
    bool isMobileProject = component.project.category.toLowerCase() == 'mobile';

    return a(
      href: component.project.link,
      target: Target.blank,
      styles: Styles(
        textDecoration: TextDecoration(line: TextDecorationLine.none),
        color: textColor,
      ),
      [
        div(
          styles: Styles(
            width: 520.px,
            maxWidth: 95.percent,
            padding: Spacing.all(24.px),
            radius: BorderRadius.circular(30.px),
            backgroundColor: cardColor,
            border: Border.all(color: borderColor),
            opacity: isVisible ? 1 : 0,
            shadow: BoxShadow(
              offsetX: 0.px,
              offsetY: isVisible ? 20.px : 12.px,
              blur: isVisible ? 46.px : 28.px,
              spread: 0.px,
              color: currentTheme == 'dark'
                  ? Colors.black.withOpacity(0.45)
                  : Colors.black.withOpacity(0.08),
            ),
            cursor: Cursor.pointer,
            transition: Transition(
              'transform',
              duration: Duration(milliseconds: 600),
              delay: Duration(milliseconds: component.index * 150),
            ),
            transform: Transform.combine([
              Transform.translate(
                x: 0.px,
                y: isVisible ? 0.px : 22.px,
              ),
              Transform.scale(
                isVisible ? 1.0 : 0.97,
              ),
            ]),
          ),
          [
            div(
              styles: Styles(
                width: 100.percent,
                height: 220.px,
                radius: BorderRadius.circular(20.px),
                overflow: Overflow.hidden,
                margin: Spacing.only(bottom: 18.px),
                raw: {
                  'background-image': isMobileProject
                      ? 'linear-gradient(135deg, rgba(15,23,42,0.65), rgba(0,128,255,0.2))'
                      : 'url(${component.project.image})',
                  'background-size': 'cover',
                  'background-position': 'center',
                  'position': 'relative',
                },
              ),
              [
                if (isMobileProject)
                  div(
                    styles: Styles(
                      raw: {
                        'position': 'absolute',
                        'inset': '0',
                        'display': 'flex',
                        'align-items': 'center',
                        'justify-content': 'center',
                      },
                    ),
                    [
                      div(
                        styles: Styles(
                          width: 120.px,
                          height: 220.px,
                          radius: BorderRadius.circular(26.px),
                          border: Border.all(color: Colors.white.withOpacity(0.25), width: 2.px),
                          overflow: Overflow.hidden,
                          raw: {
                            'background-image': 'url(${component.project.image})',
                            'background-size': 'cover',
                            'background-position': 'center',
                            'box-shadow': '0 12px 25px rgba(0,0,0,0.45)'
                          },
                        ),
                        [],
                      ),
                    ],
                  )
              ],
            ),

            div(
              styles: Styles(
                display: Display.flex,
                flexDirection: FlexDirection.column,
                gap: Gap.all(16.px),
              ),
              [
                h3(
                  styles: Styles(
                    color: textColor,
                    fontSize: 24.px,
                    fontWeight: FontWeight.w600,
                    margin: Spacing.zero,
                  ),
                  [.text(component.project.title)],
                ),
                p(
                  styles: Styles(
                    color: secondaryText,
                    fontSize: 14.px,
                    lineHeight: Unit.em(1.5),
                  ),
                  [.text(component.project.description)],
                ),

                div(
                  styles: Styles(
                    display: Display.flex,
                    flexWrap: FlexWrap.wrap,
                    gap: Gap.all(8.px),
                  ),
                  [
                    for (var tech in component.project.techStack)
                      span(
                        styles: Styles(
                          padding: Spacing.symmetric(vertical: 4.px, horizontal: 8.px),
                          radius: BorderRadius.circular(10.px),
                          color: secondaryText,
                          fontSize: 12.px,
                          backgroundColor: badgeBg,
                          border: Border.all(color: borderColor.withOpacity(0.4)),
                        ),
                        [.text(tech)],
                      ),
                  ],
                ),
                span(
                  styles: Styles(
                    color: currentTheme == 'dark' ? Colors.white : Colors.black,
                    fontSize: 12.px,
                    fontFamily: FontFamily('Space Mono'),
                    raw: {
                      'letter-spacing': '0.3em',
                      'text-transform': 'uppercase',
                    },
                  ),
                  [.text('View project ↗')],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
