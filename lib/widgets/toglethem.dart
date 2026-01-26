import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

@client
class ToggleTheme extends StatefulComponent {
  const ToggleTheme({super.key});

  @override
  State<StatefulComponent> createState() => _ToggleThemeState();
}

class _ToggleThemeState extends State<ToggleTheme> {
  bool darkMode = true; // state is internal

  @override
  Component build(BuildContext context) {
    return button(
      classes: 'mode-button',
      attributes: {'aria-label': 'Toggle theme'},
      onClick: () {
        print("clicked");
        // setState(() {
        //   darkMode = !darkMode;
        // });
      },
      [
        div(
          styles: Styles(
            width: 40.px,
            height: 40.px,
            backgroundColor: darkMode ? Colors.black : Colors.white,
            display: Display.flex,
            alignItems: .center,
            justifyContent: .center,
            radius: .circular(20.px),
            cursor: Cursor.pointer,
          ),
          [
            img(
              src: 'images/moon1.png',
              alt: 'light/dark mode',
              styles: Styles(
                width: 24.px,
                height: 24.px,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
