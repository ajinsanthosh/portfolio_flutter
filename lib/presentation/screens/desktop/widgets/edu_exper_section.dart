import 'package:flutter/material.dart';
import 'package:flutter_portfolio/core/color/colors.dart';
import 'package:flutter_portfolio/core/constants/constants.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/custom_section.dart';

class EducationAndExperenceWidget extends StatelessWidget {
  const EducationAndExperenceWidget({
    super.key,
    required this.size,
    required this.educationList,
    required this.professionalList,
  });

  final Size size;
  final List<Map<String, String>> educationList;
  final List<Map<String, String>> professionalList;
  @override
  Widget build(BuildContext context) {
    var educationAndExperence = [
      DivisionEduSkillWidget(
        title: 'Education',
        titleList: educationList.map((map) {
          String value = map['educationName'] ?? '';
          return value;
        }).toList(),
        subtitleList: educationList.map((map) {
          String value = map['passYear'] ?? '';
          return value;
        }).toList(),
      ),
      size.width > 766 ? Container() : sizedBox25H,
      DivisionEduSkillWidget(
        title: 'Professional Expereince',
        titleList: professionalList.map((map) {
          String value = map['professionalName'] ?? '';
          return value;
        }).toList(),
        subtitleList: professionalList.map((map) {
          String value = map['professionalYear'] ?? '';
          return value;
        }).toList(),
      ),
      size.width > 766 ? Container() : sizedBox25H,
    ];
    return CustomSectionContainer(
      width: size.width,
      child: size.width > 766
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: educationAndExperence)
          : Column(children: educationAndExperence),
    );
  }
}

class DivisionEduSkillWidget extends StatelessWidget {
  const DivisionEduSkillWidget(
      {super.key,
      required this.title,
      required this.titleList,
      required this.subtitleList});
  final String title;
  final List<String> titleList;
  final List<String> subtitleList;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width > 766
            ? ((size.width - (size.width * 0.02) * 2) - 60) / 2
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: size.width < 400 ? 25 : 32,
                  fontWeight: FontWeight.w700,
                  color: colorWhite),
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: titleList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return FractionallySizedBox(
                  widthFactor: size.width > 766 ? 0.85 : null,
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Card(
                        elevation: 4,
                        color: lightBlack.withOpacity(0.5),
                        child: Center(
                          child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  color: colorApp,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Icon(Icons.circle,
                                  color: lightBlack.withOpacity(0.9)),
                            ),
                            title: Text(titleList[index],
                                style: TextStyle(
                                    fontSize: size.width < 400 ? 14 : 17,
                                    fontWeight: FontWeight.normal,
                                    color: colorWhite)),
                            subtitle: Text(
                              subtitleList[index],
                              style: size.width < 400
                                  ? const TextStyle(fontSize: 10)
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => sizedBox5H,
            ),
          ],
        ));
  }
}
