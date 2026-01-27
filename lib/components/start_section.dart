import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:my_portfolio/constants/theme.dart';

class StartSection extends StatelessComponent{
  @override
  Component build(BuildContext context) {
   return  section(id: 'start', [
        div(classes: 'container', [
          div(classes: 'cta', [
            h1(styles: Styles(color: whiteColor), [.text('mobile app developement!')]),
            p(styles: Styles(color: whiteColor), [.text('flutter developer.')]),
          ]),
        ]),
      ]);
  }
  



  static get styles => [
 
    css('#start' , [
      css('&').styles(
        backgroundAttachment: BackgroundAttachment.scroll
      ),
      css('.container').styles(
        display: Display.flex,
        flexWrap: FlexWrap.wrap,
        alignItems: .center
      ),
    ]),
  
     
  ];

}