import 'package:flutter/material.dart';

const sizedBox5H = SizedBox(height: 5);
const sizedBox10H = SizedBox(height: 10);
const sizedBox15H = SizedBox(height: 15);
const sizedBox20H = SizedBox(height: 20);
const sizedBox25H = SizedBox(height: 25);
const sizedBox5W = SizedBox(width: 5);
const sizedBox10W = SizedBox(width: 10);
const sizedBox15W = SizedBox(width: 15);
const sizedBox20W = SizedBox(width: 20);
const String failImageUrl =
    'https://ichef.bbci.co.uk/news/1024/branded_news/83B3/production/_115651733_breaking-large-promo-nc.png';
const String about =
    "I am a highly motivated and determined Flutter developer with a passion for crafting high-quality mobile applications. I am currently seeking a challenging and dynamic work environment where I can leverage my skills and experience to develop innovative mobile solutions and contribute to the company's growth and success. I am eager to continue learning and growing as a developer while making a meaningful impact through my work. I am confident that my skills and experience make me an excellent candidate for the Flutter developer role.\nWith a solid background in mobile app development and a strong proficiency in Flutter, as well as expertise in REST API integration and state management using GetX, Bloc, and Provider, I bring a comprehensive skill set to your team. I have successfully developed and deployed Flutter applications in the past, demonstrating my ability to create cross-platform solutions that are both functional and visually appealing. Specifically, I have completed four major projects and three mini-projects that showcase my ability to tackle complex challenges and deliver high-quality solutions.";

void showCustomSnackBar(BuildContext context,
    {required String title, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(content),
            ],
          ),
        ],
      ),
      duration: const Duration(seconds: 3), // Adjust the duration as needed
    ),
  );
}
