import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_portfolio/core/color/colors.dart';
import 'package:flutter_portfolio/core/constants/constants.dart';
import 'package:flutter_portfolio/core/theme/theme.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/contact_section.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/custom_section.dart';

class SkillWidget extends StatelessWidget {
  const SkillWidget({
    super.key,
    required this.size,
    required this.skillList,
  });

  final Size size;
  final List<Map<String, dynamic>> skillList;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> proficientSkills = [];
    List<Map<String, dynamic>> familiarSkills = [];

    for (var skill in skillList) {
      if (skill['skillType'] == 'Proficient With') {
        proficientSkills.add(skill);
      } else {
        familiarSkills.add(skill);
      }
    }
    var skillChildren = [
      Container(
        width: size.width > 766
            ? ((size.width - (size.width * 0.02) * 2) - 90) / 2
            : null,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: colorBlack,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SkillContainerWidget(
            skillTitle: 'Proficient With', listTile: proficientSkills),
      ),
      size.width > 766 ? Container() : sizedBox15H,
      Container(
        width: size.width > 766
            ? ((size.width - (size.width * 0.02) * 2) - 90) / 2
            : null,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: colorBlack,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SkillContainerWidget(
            skillTitle: 'Familiar With', listTile: familiarSkills),
      )
    ];
    return CustomSectionContainer(
      width: size.width,
      color: lightBlack.withOpacity(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kIsWeb
              ? const Text(
                  'Skill',
                  style: bodyLarge,
                )
              : AnimatedTextKit(
                  totalRepeatCount: 3000,
                  pause: const Duration(milliseconds: 1000),
                  animatedTexts: [
                    ColorizeAnimatedText('Skill',
                        textStyle: bodyLarge, colors: [colorWhite, lightBlack])
                  ],
                ),
          sizedBox20H,
          size.width > 766
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: skillChildren,
                )
              : Column(
                  children: skillChildren,
                )
        ],
      ),
    );
  }
}

class SkillContainerWidget extends StatelessWidget {
  const SkillContainerWidget({
    super.key,
    required this.skillTitle,
    required this.listTile,
  });
  final String skillTitle;
  final List<Map<String, dynamic>> listTile;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kIsWeb
            ? Text(
                skillTitle,
                style: bodyMedium,
              )
            : AnimatedTextKit(
                totalRepeatCount: 3000,
                pause: const Duration(milliseconds: 1000),
                animatedTexts: [
                  ColorizeAnimatedText(
                    skillTitle,
                    textStyle: bodyMedium,
                    colors: [colorBlack, colorWhite, colorApp.withOpacity(0.3)],
                  )
                ],
              ),
        sizedBox20H,
        Column(
          children: List.generate(
            listTile.length,
            (index) => ListTile(
              leading: SocialMediaBtnWidgetNetwork(
                  imageSrc: listTile[index]['skillImageUrl'], onTap: () {}),
              title: AnimatedButton.strip(
                animatedOn: AnimatedOn.onHover,
                text: listTile[index]['skillName'],
                textAlignment: AlignmentDirectional.centerStart,
                selectedBackgroundColor: Colors.transparent,
                stripColor: Colors.transparent,
                stripSize: 2,
                isReverse: true,
                selectedTextColor: colorApp,
                textStyle: const TextStyle(fontSize: 12, color: colorWhite),
                backgroundColor: Colors.black,
                onPress: () {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}
