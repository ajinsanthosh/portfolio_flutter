import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/core/color/colors.dart';
import 'package:flutter_portfolio/core/constants/constants.dart';
import 'package:flutter_portfolio/core/theme/theme.dart';
import 'package:flutter_portfolio/core/widgets/widget.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/custom_section.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key, required this.size, required this.resume});
  final Map<String, dynamic> resume;
  final Size size;

  @override
  Widget build(BuildContext context) {
    var elevatedBtnChildren = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedBtnWidget(
              onPressed: () async {
                String pdfUrl = resume['pdfUrl'];
                if (await canLaunchUrlString(pdfUrl)) {
                  await launchUrlString(pdfUrl);
                } else {
                  throw 'Could not launch $pdfUrl';
                }
              },
              title: 'Download CV'.toUpperCase(),
              textColor: colorBlack,
              btnColor: colorApp,
              borderRadius: 30,
              trailing: const CircleAvatar(
                backgroundColor: colorBlack,
                child: Icon(CupertinoIcons.arrow_down_to_line_alt),
              )),
          size.width > 880 ? sizedBox15W : sizedBox15H,
          ElevatedBtnWidget(
            onPressed: () {},
            title: 'More About Me'.toUpperCase(),
            trailing: CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.1),
              child: const Icon(CupertinoIcons.arrow_right),
            ),
          ),
        ],
      )
    ];
    return CustomSectionContainer(
      width: size.width,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Hello, I'm Adithyan", style: titleSmall),
                  Theme.of(context).platform == TargetPlatform.android ||
                          Theme.of(context).platform == TargetPlatform.iOS
                      ? Text(
                          'Flutter Developer',
                          style: TextStyle(
                              color: colorApp,
                              fontSize: size.width > 788
                                  ? 70
                                  : size.width < 500
                                      ? 50
                                      : 65,
                              fontWeight: FontWeight.bold),
                        )
                      : AnimatedTextKit(
                          totalRepeatCount: 3000,
                          pause: const Duration(milliseconds: 1000),
                          animatedTexts: [
                              ColorizeAnimatedText('Flutter Developer',
                                  textStyle: TextStyle(
                                      color: colorApp,
                                      fontSize: size.width > 788
                                          ? 70
                                          : size.width < 500
                                              ? 50
                                              : 65,
                                      fontWeight: FontWeight.bold),
                                  colors: [colorWhite, colorApp])
                            ]),
                  sizedBox25H,
                  size.width > 880 || size.width < 808
                      ? Row(
                          children: elevatedBtnChildren,
                        )
                      : Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: elevatedBtnChildren,
                            ),
                          ],
                        )
                ],
              )),
              size.width < 808
                  ? Container()
                  : Expanded(
                      child: CustomSectionContainer(
                      child: CustomSectionContainer(
                        child: Image.asset(
                          'assets/images/profileNew.png',
                        ),
                      ),
                    )),
            ],
          ),
          size.width < 808
              ? CustomSectionContainer(
                  child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Image.asset('assets/images/profileNew.png'),
                ))
              : Container()
        ],
      ),
    );
  }
}
