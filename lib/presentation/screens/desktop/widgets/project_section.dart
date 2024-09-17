// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/core/color/colors.dart';
import 'package:flutter_portfolio/core/constants/constants.dart';
import 'package:flutter_portfolio/core/theme/theme.dart';
import 'package:flutter_portfolio/core/widgets/widget.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/project/project_detail.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/custom_section.dart';

class ProjectWidget extends StatelessWidget {
  const ProjectWidget({
    super.key,
    required this.size,
    required this.project,
  });
  final List<Map<String, dynamic>> project;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return CustomSectionContainer(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: kIsWeb
                    ? Text(
                        'My Own Projects',
                        style: bodyLarge,
                      )
                    : AnimatedTextKit(
                        totalRepeatCount: 3000,
                        pause: const Duration(milliseconds: 1000),
                        animatedTexts: [
                          ColorizeAnimatedText(
                            'My Own Projects',
                            textStyle: bodyLarge,
                            colors: [colorWhite, lightBlack.withOpacity(0.6)],
                          )
                        ],
                      ),
              ),
              ElevatedBtnWidget(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProjectDetailScrn(project: project),
                      ));
                },
                title: 'Click More',
                btnColor: colorApp,
              )
            ],
          ),
          sizedBox20H,
          CustomSectionContainer(
            child: SizedBox(
              height: size.height * 0.5 + 20,
              child: ListView(
                children: [
                  CarouselSlider(
                    items: List.generate(
                        project.length,
                        (index) => InkWell(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    width: size.width * 0.9 / 1.5,
                                    height: size.height * 0.5,
                                    decoration: BoxDecoration(
                                        color: lightBlack,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: NetworkImage(project[index]
                                                ['projectImageUrl'][0]),
                                            fit: BoxFit.fill)),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 15,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: colorGrey.shade800,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.share)),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: SizedBox(
                                      width: size.width * 0.9 / 1.5,
                                      child: Align(
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          width: size.width * 0.8 / 2,
                                          height: size.height * 0.1,
                                          decoration: BoxDecoration(
                                            color: colorGrey.shade800,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Text(
                                              project[index]['projectName'],
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.fade,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                    options: CarouselOptions(
                        height: size.height * 0.5,
                        aspectRatio: 16 / 8,
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 4),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 1000),
                        enlargeCenterPage: true,
                        enlargeFactor: 0.4,
                        enableInfiniteScroll: true),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
