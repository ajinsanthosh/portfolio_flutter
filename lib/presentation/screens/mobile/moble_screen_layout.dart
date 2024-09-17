import 'package:flutter/material.dart';
import 'package:flutter_portfolio/core/color/colors.dart';
import 'package:flutter_portfolio/firebase/db.dart';
import 'package:flutter_portfolio/presentation/form/model/model.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/about_section.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/contact_section.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/edu_exper_section.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/profile_section.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/skill_section.dart';
import 'package:flutter_portfolio/presentation/screens/mobile/widget/mobile_widget.dart';
import 'package:lottie/lottie.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(size.width);
    return FutureBuilder<FormModel>(
      future: FirebaseDatabase().getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              color: Colors.black,
              child: LottieBuilder.asset('assets/animations/2MzHzXuVH1.json'));
        } else {
          return SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size(size.width, size.width < 500 ? 80 : 120),
                  child: const HeaderWidgetMobile()),
              body: SizedBox(
                width: size.width,
                child: ListView(
                  children: [
                    ProfileWidget(size: size, resume: snapshot.data!.resume),
                    AboutWidget(size: size, about: snapshot.data!.about),
                    EducationAndExperenceWidget(
                        size: size,
                        educationList: snapshot.data!.education,
                        professionalList: snapshot.data!.professional),
                    SkillWidget(size: size, skillList: snapshot.data!.skill),
                    const Divider(color: colorApp, thickness: 9),
                    ProjectWidgetMobile(
                        size: size, project: snapshot.data!.project),
                    ContactWidget(
                        size: size,
                        facebook: snapshot.data!.facebook,
                        gitHub: snapshot.data!.gitHub,
                        instagram: snapshot.data!.instagram,
                        linkedIn: snapshot.data!.linkedIn,
                        twitter: snapshot.data!.twitter,
                        whatsApp: snapshot.data!.whatsApp),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
