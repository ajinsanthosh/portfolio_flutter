import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_portfolio/core/color/colors.dart';
import 'package:flutter_portfolio/core/theme/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25),
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Adithyan R'.toUpperCase(),
                style: bodyMedium,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText('Flutter Developer',
                      textStyle: GoogleFonts.aBeeZee(
                          color: colorApp,
                          fontSize: 15,
                          letterSpacing: 0.9,
                          fontWeight: FontWeight.bold),
                      speed: const Duration(milliseconds: 100)),
                ],
                totalRepeatCount: 3000,
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            ],
          ),
          SizedBox(
            width: size.width / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimatedBtnHeaderWidget(
                  title: 'Home',
                  onPress: () {
                    _scrollToIndex(context, 0);
                  },
                ),
                AnimatedBtnHeaderWidget(
                  title: 'About',
                  onPress: () {
                    _scrollToIndex(context, 5);
                  },
                ),
                AnimatedBtnHeaderWidget(
                  title: 'Skills',
                  onPress: () {
                    _scrollToIndex(context, 10);
                  },
                ),
                AnimatedBtnHeaderWidget(
                  title: 'Projects',
                  onPress: () {
                    _scrollToIndex(context, 16);
                  },
                ),
                AnimatedBtnHeaderWidget(
                  title: 'Contact',
                  onPress: () {
                    _scrollToIndex(context, 30);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _scrollToIndex(BuildContext context, int index) {
    final RenderObject? renderObject = context.findRenderObject();
    if (renderObject != null && renderObject is RenderBox) {
      double yOffset = 0;
      for (int i = 0; i < index; i++) {
        yOffset += renderObject.size.height;
      }
      scrollController.animateTo(
        yOffset,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }
}

class AnimatedBtnHeaderWidget extends StatelessWidget {
  const AnimatedBtnHeaderWidget({
    super.key,
    required this.title,
    this.onPress,
  });
  final String title;
  final void Function()? onPress;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: AnimatedButton.strip(
        animatedOn: AnimatedOn.onHover,
        height: 30,
        width: 100,
        text: title,
        selectedBackgroundColor: colorApp,
        stripColor: colorApp.withOpacity(0.3),
        stripSize: 2,
        isReverse: true,
        selectedTextColor: Colors.black,
        textStyle: titleSmall,
        backgroundColor: Colors.black,
        onPress: onPress,
      ),
    );
  }
}
