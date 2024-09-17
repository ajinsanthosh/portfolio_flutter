import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/core/color/colors.dart';
import 'package:flutter_portfolio/core/constants/constants.dart';
import 'package:flutter_portfolio/core/theme/theme.dart';
import 'package:flutter_portfolio/core/widgets/widget.dart';
import 'package:flutter_portfolio/firebase/db.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/project/project_detail.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/custom_section.dart';
import 'package:flutter_portfolio/presentation/screens/users/users_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactWidget extends StatelessWidget {
  ContactWidget({
    super.key,
    required this.size,
    required this.linkedIn,
    required this.gitHub,
    required this.whatsApp,
    required this.instagram,
    required this.facebook,
    required this.twitter,
  });
  final String linkedIn;
  final String gitHub;
  final String whatsApp;
  final String instagram;
  final String facebook;
  final String twitter;
  final Size size;
  TextEditingController yname = TextEditingController();
  TextEditingController yemail = TextEditingController();
  TextEditingController ysub = TextEditingController();
  TextEditingController ymessage = TextEditingController();
  final GlobalKey<FormState> userFormkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var contactItems = [
      Container(
        width: size.width > 876
            ? ((size.width - (size.width * 0.02) * 2) - 70) / 2
            : null,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            ContainerContactWidget(
              icon: Icons.share_outlined,
              title: 'Social Profiles',
              child: Padding(
                padding: EdgeInsets.all(size.width < 500 ? 0 : 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialMediaBtnWidget(
                      icon: FontAwesomeIcons.whatsapp,
                      onTap: () {
                        openUrlChrome(whatsApp);
                      },
                    ),
                    SocialMediaBtnWidget(
                      icon: FontAwesomeIcons.linkedin,
                      onTap: () {
                        openUrlChrome(linkedIn);
                      },
                    ),
                    SocialMediaBtnWidget(
                      icon: FontAwesomeIcons.instagram,
                      onTap: () {
                        openUrlChrome(instagram);
                      },
                    ),
                    SocialMediaBtnWidget(
                      icon: FontAwesomeIcons.facebook,
                      onTap: () {
                        openUrlChrome(facebook);
                      },
                    ),
                    SocialMediaBtnWidget(
                      icon: FontAwesomeIcons.xTwitter,
                      onTap: () {
                        openUrlChrome(twitter);
                      },
                    ),
                    SocialMediaBtnWidget(
                      icon: FontAwesomeIcons.github,
                      onTap: () {
                        openUrlChrome(gitHub);
                      },
                    ),
                  ],
                ),
              ),
            ),
            sizedBox15H,
            const Row(
              children: [
                Expanded(
                    child: ContainerContactWidget(
                  title: 'Email Me',
                  icon: Icons.email_outlined,
                  child: Text(
                    'unniadithyan81@gmail.com',
                    style: TextStyle(color: colorGrey, fontSize: 10),
                  ),
                )),
                sizedBox15W,
                Expanded(
                    child: ContainerContactWidget(
                  title: 'Call Me',
                  icon: Icons.phone_outlined,
                  child: Text(
                    '+91 9605493733',
                    style: TextStyle(color: colorGrey, fontSize: 10),
                  ),
                ))
              ],
            )
          ],
        ),
      ),
      size.width > 876 ? Container() : sizedBox20H,
      Container(
        width: size.width > 876
            ? ((size.width - (size.width * 0.02) * 2) - 70) / 2
            : null,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: colorBlack,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Form(
          key: userFormkey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormWidget(
                      controller: yname,
                      label: 'Your Name',
                      icon: Icons.person_rounded,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter Your Name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  sizedBox10W,
                  Expanded(
                    child: TextFormWidget(
                      controller: yemail,
                      label: 'Your E-mail',
                      icon: CupertinoIcons.mail_solid,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Enter Your E-mail";
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return "Enter a valid E-mail";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
              sizedBox10H,
              TextFormWidget(
                controller: ysub,
                label: 'Subject',
                icon: Icons.subject_rounded,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Enter the Subject";
                  } else {
                    return null;
                  }
                },
              ),
              sizedBox10H,
              TextFormWidget(
                controller: ymessage,
                label: 'Message',
                icon: Icons.message_rounded,
                maxLines: 7,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Enter the Message";
                  } else {
                    return null;
                  }
                },
              ),
              sizedBox10H,
              ElevatedBtnWidget(
                onPressed: () {
                  submit(context);
                },
                title: 'Submit',
                btnColor: colorApp,
              )
            ],
          ),
        ),
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
                  'Get In Touch',
                  style: bodyLarge,
                )
              : AnimatedTextKit(
                  totalRepeatCount: 3000,
                  pause: const Duration(milliseconds: 1000),
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'Get In Touch',
                      textStyle: bodyLarge,
                      colors: [colorWhite, lightBlack.withOpacity(0.6)],
                    )
                  ],
                ),
          sizedBox20H,
          size.width > 876
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: contactItems)
              : Column(children: contactItems)
        ],
      ),
    );
  }

  void submit(BuildContext context) async {
    if (userFormkey.currentState!.validate()) {
      final userModel = Usersmodels(
          userName: yname.text.trim(),
          userEmail: yemail.text.trim(),
          subject: ysub.text.trim(),
          message: ymessage.text.trim());
      await FirebaseDatabase().setUserMessage(userModel, context);
      yemail.clear();
      ymessage.clear();
      yname.clear();
      ysub.clear();
    }
  }
}

class ContainerContactWidget extends StatelessWidget {
  const ContainerContactWidget({
    super.key,
    required this.child,
    required this.title,
    required this.icon,
  });
  final Widget child;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(size.width < 500 ? 10 : 23),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colorBlack.withOpacity(0.7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: colorApp.withOpacity(0.3),
                ),
                child: Icon(icon),
              ),
            ],
          ),
          sizedBox10H,
          Text(
            title,
            style: GoogleFonts.oswald(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: colorWhite.withOpacity(0.8)),
          ),
          child
        ],
      ),
    );
  }
}

class SocialMediaBtnWidget extends StatelessWidget {
  const SocialMediaBtnWidget({
    super.key,
    this.imageSrc,
    this.onTap,
    this.icon,
  });
  final String? imageSrc;
  final void Function()? onTap;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: colorApp.withOpacity(0.3),
        ),
        child: icon == null
            ? Image.asset(imageSrc!, width: 30)
            : Center(
                child: FaIcon(
                icon,
                color: colorWhite,
              )),
      ),
    );
  }
}

class SocialMediaBtnWidgetNetwork extends StatelessWidget {
  const SocialMediaBtnWidgetNetwork({
    super.key,
    this.imageSrc,
    this.onTap,
  });
  final String? imageSrc;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: colorApp.withOpacity(0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: CachedNetworkImage(
            imageUrl: imageSrc!,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
