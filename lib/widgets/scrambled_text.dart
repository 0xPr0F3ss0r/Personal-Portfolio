import 'dart:async';
import 'dart:math';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class ScrambledText extends StatefulComponent {
  final String text;
  final Styles? styles;
  final String? classes;

  const ScrambledText(this.text, {this.styles, this.classes, super.key});

  @override
  State<ScrambledText> createState() => _ScrambledTextState();
}

class _ScrambledTextState extends State<ScrambledText> {
  String _displayTarget = "";
  String _currentText = "";
  Timer? _timer;
  final String _chars = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()";

  @override
  void initState() {
    super.initState();
    _displayTarget = component.text;
    _currentText = _displayTarget;
    if (kIsWeb) {
      _startScrambling();
    }
  }

  @override
  void didUpdateComponent(ScrambledText oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (oldComponent.text != component.text) {
      _displayTarget = component.text;
      if (kIsWeb) {
        _startScrambling();
      } else {
        _currentText = _displayTarget;
      }
    }
  }

  void _startScrambling() {
    _timer?.cancel();
    int iteration = 0;
    const int maxIterations = 10;

    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        _currentText = _displayTarget
            .split('')
            .map((char) {
              if (char == ' ') return ' ';
              return _chars[Random().nextInt(_chars.length)];
            })
            .join('');
      });

      iteration++;
      if (iteration >= maxIterations) {
        timer.cancel();
        setState(() {
          _currentText = _displayTarget;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Component build(BuildContext context) {
    return span(
      classes: component.classes,
      styles: component.styles,
      [Component.text(_currentText)],
    );
  }
}
