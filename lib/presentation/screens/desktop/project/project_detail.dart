import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_portfolio/core/color/colors.dart';
import 'package:flutter_portfolio/core/constants/constants.dart';
import 'package:flutter_portfolio/core/theme/theme.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/contact_section.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/custom_section.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailScrn extends StatelessWidget {
  const ProjectDetailScrn({super.key, required this.project});
  final List<Map<String, dynamic>> project;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('width :: ${size.width}');

    return Scaffold(
      body: ListView(
        children: [
          CustomSectionContainer(
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kIsWeb
                      ? const Text(
                          'My Own Project',
                          style: bodyLarge,
                        )
                      : AnimatedTextKit(
                          totalRepeatCount: 3000,
                          pause: const Duration(milliseconds: 1000),
                          animatedTexts: [
                              ColorizeAnimatedText('My Own Project',
                                  textStyle: bodyLarge,
                                  colors: [
                                    colorWhite,
                                    lightBlack.withOpacity(0.6)
                                  ])
                            ]),
                  Column(
                    children: List.generate(
                      project.length,
                      (index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizedBox20H,
                          CustomSectionContainer(
                            width: size.width,
                            borderRadius: 20,
                            color: lightBlack.withOpacity(0.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kIsWeb
                                    ? Text(
                                        project[index]['projectName']
                                            .toUpperCase(),
                                        style: bodyMedium,
                                      )
                                    : AnimatedTextKit(
                                        totalRepeatCount: 3000,
                                        pause:
                                            const Duration(milliseconds: 1000),
                                        animatedTexts: [
                                          ColorizeAnimatedText(
                                            project[index]['projectName']
                                                .toUpperCase(),
                                            textStyle: bodyMedium,
                                            colors: [
                                              colorWhite,
                                              lightBlack.withOpacity(0.6),
                                              colorApp.withOpacity(0.6)
                                            ],
                                          )
                                        ],
                                      ),
                                sizedBox25H,
                                size.width > 1150
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: projectDetailWidget(
                                            size: size,
                                            project: project[index]),
                                      )
                                    : Column(
                                        children: projectDetailWidget(
                                            size: size,
                                            project: project[index]))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  projectDetailWidget(
      {required Size size, required Map<String, dynamic> project}) {
    var projectDetailWidget = [
      Column(
        children: [
          Container(
            width: size.width > 1150
                ? ((size.width - (size.width * 0.02) * 4) - 130) / 2
                : null,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colorBlack,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              project['projectDetails'],
              textAlign: TextAlign.justify,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          sizedBox5H,
          Container(
            width: size.width > 1150
                ? ((size.width - (size.width * 0.02) * 4) - 130) / 2
                : null,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: colorBlack,
              borderRadius: BorderRadius.circular(20),
            ),
            child: size.width < 400
                ? Column(
                    children: [
                      MobileTileWidget(
                        firstTitle: 'GitHub',
                        imageUrlFirst: 'assets/images/github.png',
                        onPressFirst: () {
                          project['projectGit'].isNotEmpty
                              ? openUrlChrome(project['projectGit'])
                              : null;
                        },
                      ),
                      MobileTileWidget(
                        firstTitle: 'LinkedIn',
                        imageUrlFirst: 'assets/images/linkedin (1).png',
                        onPressFirst: () {
                          project['projectLinkedIn'].isNotEmpty
                              ? openUrlChrome(project['projectLinkedIn'])
                              : null;
                        },
                      ),
                      MobileTileWidget(
                        firstTitle: 'Play Store / Amazon App Store',
                        imageUrlFirst: 'assets/images/playstore.png',
                        onPressFirst: () {
                          project['projectplayStore'].isNotEmpty
                              ? openUrlChrome(project['projectplayStore'])
                              : print('ddd');
                        },
                      ),
                      MobileTileWidget(
                        firstTitle: 'Google Drive',
                        imageUrlFirst: 'assets/images/google-drive.png',
                        onPressFirst: () {
                          project['projectDrive'].isNotEmpty
                              ? openUrlChrome(project['projectDrive'])
                              : null;
                        },
                      )
                    ],
                  )
                : Column(
                    children: [
                      ProjectSocialMediaWidget(
                        firstTitle: 'GitHub',
                        imageUrlFirst: 'assets/images/github.png',
                        onPressFirst: () {
                          project['projectGit'].isNotEmpty
                              ? openUrlChrome(project['projectGit'])
                              : null;
                        },
                        secondTitle: 'LinkedIn',
                        imageUrlSecond: 'assets/images/linkedin (1).png',
                        onPressSecond: () {
                          project['projectLinkedIn'].isNotEmpty
                              ? openUrlChrome(project['projectLinkedIn'])
                              : null;
                        },
                      ),
                      ProjectSocialMediaWidget(
                        firstTitle: 'Play Store / Amazon App Store',
                        imageUrlFirst: 'assets/images/playstore.png',
                        onPressFirst: () {
                          project['projectplayStore'].isNotEmpty
                              ? openUrlChrome(project['projectplayStore'])
                              : print('ddd');
                        },
                        secondTitle: 'Google Drive',
                        imageUrlSecond: 'assets/images/google-drive.png',
                        onPressSecond: () {
                          project['projectDrive'].isNotEmpty
                              ? openUrlChrome(project['projectDrive'])
                              : null;
                        },
                      )
                    ],
                  ),
          ),
          size.width > 1150 ? Container() : sizedBox5H,
        ],
      ),
      Container(
        width: size.width > 1150
            ? ((size.width - (size.width * 0.02) * 4) - 130) / 2
            : null,
        decoration: BoxDecoration(
          color: colorBlack,
          borderRadius: BorderRadius.circular(20),
        ),
        child: CarouselSlider(
          items: List.generate(project['projectImageUrl'].length,
              (index) => Image.network(project['projectImageUrl'][index])),
          options: CarouselOptions(
              height: size.height * 0.5,
              aspectRatio: 16 / 8,
              viewportFraction: 1,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              enlargeCenterPage: true,
              enlargeFactor: 0.4,
              enableInfiniteScroll: true),
        ),
      )
    ];
    return projectDetailWidget;
  }
}

class MobileTileWidget extends StatelessWidget {
  const MobileTileWidget({
    super.key,
    required this.firstTitle,
    required this.imageUrlFirst,
    this.onPressFirst,
  });
  final String firstTitle;
  final String imageUrlFirst;
  final void Function()? onPressFirst;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SocialMediaBtnWidget(
        imageSrc: imageUrlFirst,
        onTap: () {},
      ),
      title: AnimatedButton.strip(
        animatedOn: AnimatedOn.onHover,
        text: firstTitle,
        textAlignment: AlignmentDirectional.centerStart,
        selectedBackgroundColor: Colors.transparent,
        stripColor: Colors.transparent,
        stripSize: 2,
        isReverse: true,
        selectedTextColor: colorApp,
        textStyle: const TextStyle(fontSize: 12, color: colorWhite),
        backgroundColor: Colors.black,
        onPress: onPressFirst,
      ),
    );
  }
}

class ProjectSocialMediaWidget extends StatelessWidget {
  const ProjectSocialMediaWidget({
    super.key,
    required this.firstTitle,
    required this.imageUrlFirst,
    required this.imageUrlSecond,
    required this.secondTitle,
    this.onPressFirst,
    this.onPressSecond,
  });
  final String firstTitle;
  final String imageUrlFirst;
  final void Function()? onPressFirst;
  final String imageUrlSecond;
  final String secondTitle;

  final void Function()? onPressSecond;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            leading: SocialMediaBtnWidget(
              imageSrc: imageUrlFirst,
              onTap: () {},
            ),
            title: AnimatedButton.strip(
              animatedOn: AnimatedOn.onHover,
              text: firstTitle,
              textAlignment: AlignmentDirectional.centerStart,
              selectedBackgroundColor: Colors.transparent,
              stripColor: Colors.transparent,
              stripSize: 2,
              isReverse: true,
              selectedTextColor: colorApp,
              textStyle: const TextStyle(fontSize: 12, color: colorWhite),
              backgroundColor: Colors.black,
              onPress: onPressFirst,
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            leading:
                SocialMediaBtnWidget(imageSrc: imageUrlSecond, onTap: () {}),
            title: AnimatedButton.strip(
              animatedOn: AnimatedOn.onHover,
              text: secondTitle,
              textAlignment: AlignmentDirectional.centerStart,
              selectedBackgroundColor: Colors.transparent,
              stripColor: Colors.transparent,
              stripSize: 2,
              isReverse: true,
              selectedTextColor: colorApp,
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: colorWhite,
              ),
              backgroundColor: Colors.black,
              onPress: onPressSecond,
            ),
          ),
        )
      ],
    );
  }
}

openUrlChrome(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
