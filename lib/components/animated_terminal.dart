// Terminal line with blinking cursor
import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/state_management/light-dark-mode.dart' as theme;

class TerminalLine extends StatefulComponent {
  const TerminalLine({super.key});

  @override
  State<TerminalLine> createState() => _TerminalLineState();
}

class _TerminalLineState extends State<TerminalLine> {
  bool showCursor = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if(kIsWeb){
    _timer = Timer.periodic(Duration(milliseconds: 500), (_) {
      setState(() {
        showCursor = !showCursor;
      });
    });
    }
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Component build(BuildContext context) {
    String currentTheme = context.watch(theme.mode);
    Color textColor = currentTheme == 'dark' ? whiteColor : Colors.black;

    return p(
      styles: Styles(
        opacity: 0.75,
        color: textColor,
        fontFamily: FontFamily('monospace'),
        fontSize: 20.px,
      ),
      [
        span(styles: Styles(
          color: BlueColor
        ),[.text('root')]),
        span([.text('@0xPr0F3ss0r:~# cd ')]),
        span(
          styles: Styles(
            color: BlueColor,
            fontWeight: FontWeight.bold,
          ),
          [.text('проекты')],
        ),
        span([.text(' && ls')]),
       span(styles: Styles(color: showCursor ? textColor : Colors.transparent), [.text(showCursor ? '▮' : '▮')])

      ],
    );
  }
}
