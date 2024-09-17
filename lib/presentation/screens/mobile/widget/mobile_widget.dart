import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/core/color/colors.dart';
import 'package:flutter_portfolio/core/constants/constants.dart';
import 'package:flutter_portfolio/core/theme/theme.dart';
import 'package:flutter_portfolio/core/widgets/widget.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/project/project_detail.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/custom_section.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWidgetMobile extends StatelessWidget {
  const HeaderWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 15),
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          fontSize: size.width < 500 ? 12 : 15,
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectWidgetMobile extends StatelessWidget {
  const ProjectWidgetMobile({
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
                child: AnimatedTextKit(
                  totalRepeatCount: 3000,
                  pause: const Duration(milliseconds: 1000),
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'My Own Projects',
                      textStyle: TextStyle(
                          fontSize: size.width < 400 ? 25 : 32,
                          fontWeight: FontWeight.w700,
                          color: colorWhite),
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
          SizedBox(
            height: size.height * 0.5 + 20,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CarouselSlider(
                  items: List.generate(
                      project.length,
                      (index) => InkWell(
                            onTap: () {},
                            child: Stack(
                              children: [
                                Container(
                                  width: size.width * 0.9,
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
                                  bottom: 20,
                                  child: SizedBox(
                                    width: size.width * 0.9,
                                    child: Align(
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        width: size.width * 0.6,
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
                                                fontSize: 14,
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
          )
        ],
      ),
    );
  }
}
