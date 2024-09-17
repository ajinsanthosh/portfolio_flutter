import 'package:flutter/material.dart';
import 'package:flutter_portfolio/core/color/colors.dart';
import 'package:flutter_portfolio/firebase/db.dart';
import 'package:flutter_portfolio/presentation/form/model/model.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/about_section.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/contact_section.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/edu_exper_section.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/header_widget.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/profile_section.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/project_section.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/widgets/skill_section.dart';
import 'package:lottie/lottie.dart';

class LargeScreenLayout extends StatelessWidget {
  LargeScreenLayout({super.key});
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('width :: ${size.width}');

    return FutureBuilder<FormModel>(
        future: FirebaseDatabase().getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                color: Colors.black,
                child:
                    LottieBuilder.asset('assets/animations/2MzHzXuVH1.json'));
          } else {
            return Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size(size.width, 120),
                  child: HeaderWidget(
                    scrollController: _scrollController,
                  )),
              body: SizedBox(
                width: size.width,
                child: ListView(
                  controller: _scrollController,
                  children: [
                    ProfileWidget(size: size, resume: snapshot.data!.resume),
                    AboutWidget(size: size, about: snapshot.data!.about),
                    EducationAndExperenceWidget(
                        size: size,
                        educationList: snapshot.data!.education,
                        professionalList: snapshot.data!.professional),
                    SkillWidget(size: size, skillList: snapshot.data!.skill),
                    const Divider(color: colorApp, thickness: 9),
                    ProjectWidget(size: size, project: snapshot.data!.project),
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
            );
          }
        });
  }
}
