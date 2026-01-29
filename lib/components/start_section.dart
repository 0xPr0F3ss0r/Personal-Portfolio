// ...existing code...
import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:my_portfolio/constants/theme.dart';

class StartSection extends StatefulComponent {
  @override
  State<StartSection> createState() => _StartSectionState();

  static get styles => [
    css('#start').styles(
      display: Display.flex,
      height: 100.vh,
      margin: Spacing.only(left: 250.px),
      flexDirection: FlexDirection.column,
      justifyContent: JustifyContent.start,
      alignItems: AlignItems.start,
      color: whiteColor,
      textAlign: TextAlign.start,
    ),
    css('#start h1').styles(
      margin: Spacing.zero,
      fontSize: 1.5.rem,
      raw: {
        'transition': 'opacity 500ms ease-in-out',
      },
    ),
    css('#start h1.fade-out').styles(
      raw: {
        'opacity': '0',
      },
    ),
    css('#start p').styles(
      display: Display.inlineBlock,
      padding: Spacing.symmetric(horizontal: 0.5.em, vertical: 0.25.em),
      margin: Spacing.zero,
      color: whiteColor,
      fontSize: 5.rem,
      raw: {
        // initial: no fill
        'background-image': 'linear-gradient(to right, blue 0%, blue 100%)',
        'background-size': '0% 100%',
        'background-position': 'left center',
        'background-repeat': 'no-repeat',
        'transition': 'background-size 500ms ease-in-out',
      },
    ),
    // class applied to trigger the left->right fill
    css('#start p.fill').styles(
      raw: {
        'background-size': '100% 100%',
      },
    ),
  ];
}

class _StartSectionState extends State<StartSection> {
  final List<String> texts = [
    "flutter developer.",
    "cybersecurity enthusiast.",
  ];
  int index = 0;
  bool filled = false;
  bool showCyrillic = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Show Cyrillic first, then animate to KEBIR HANI
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() => filled = true);
    });

    // After 2 seconds, fade out Cyrillic and show KEBIR HANI
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => showCyrillic = false);
      }
    });

    if (kIsWeb) {
      _timer = Timer.periodic(const Duration(seconds: 4), (_) async {
        // Remove the fill to animate out
        setState(() => filled = false);

        // Wait for the animation out
        await Future.delayed(const Duration(milliseconds: 500));

        // Change to next text
        index = (index + 1) % texts.length;
        setState(() {});

        // Trigger fill animation
        await Future.delayed(const Duration(milliseconds: 50));
        setState(() => filled = true);
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
    return section(id: 'start', [
      div(classes: 'container', [
        div(classes: 'cta', [
          h1(classes: showCyrillic ? '' : 'fade-out', styles: Styles(opacity: 0.8, color: lightWhite, fontFamily: FontFamily('Fira Code, monospace'), fontSize: 40.px), [.text(showCyrillic ? 'Кебир Хани' : 'KEBIR HANI!')]),
          p(
            classes: filled ? 'fill' : '',
            styles: Styles(color: whiteColor, fontFamily: FontFamily('DynaPuff')),
            [.text(texts[index])],
          ),
        ]),
      ]),
    ]);
  }
}