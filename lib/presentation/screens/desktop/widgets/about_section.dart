import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_portfolio/core/color/colors.dart';
import 'package:flutter_portfolio/core/constants/constants.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/custom_section.dart';

class AboutWidget extends StatelessWidget {
  const AboutWidget({
    super.key,
    required this.size,
    required this.about,
  });

  final Size size;
  final String about;
  @override
  Widget build(BuildContext context) {
    return CustomSectionContainer(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kIsWeb
              ? Text(
                  'About Me',
                  style: TextStyle(
                      fontSize: size.width < 400 ? 25 : 32,
                      fontWeight: FontWeight.w700,
                      color: colorWhite),
                )
              : AnimatedTextKit(
                  totalRepeatCount: 3000,
                  pause: const Duration(milliseconds: 1000),
                  animatedTexts: [
                      ColorizeAnimatedText('About Me',
                          textStyle: TextStyle(
                              fontSize: size.width < 400 ? 25 : 32,
                              fontWeight: FontWeight.w700,
                              color: colorWhite),
                          colors: [colorWhite, lightBlack.withOpacity(0.6)])
                    ]),
          sizedBox20H,
          Text(about, textAlign: TextAlign.justify)
        ],
      ),
    );
  }
}
