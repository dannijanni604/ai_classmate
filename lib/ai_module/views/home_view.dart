import 'package:ai_classmate/ai_module/components/category_button.dart';
import 'package:ai_classmate/ai_module/views/about_us_view.dart';
import 'package:ai_classmate/ai_module/views/code_generator_view.dart';
import 'package:ai_classmate/ai_module/views/image_views/image_generator_view.dart';
import 'package:ai_classmate/ai_module/views/text_generator_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/app_navigator.dart';
import '../controllers/chat/chat_bindings.dart';
import '../controllers/image/image_bindings.dart';

class AIHomeView extends StatelessWidget {
  const AIHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top header
          Container(
            height: 170.h,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(194, 0, 39, 1),
                  Color.fromRGBO(10, 35, 104, 1),
                ],
                begin: Alignment.topLeft,
              ),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(80)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "AI Helper",
                  style: TextStyle(color: Colors.white, fontSize: 26),
                ),
                Text(
                  "Assistive AI for Students and Teachers",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),

          Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Define a max width for the grid (adjust if needed)
                final maxGridWidth = 1000.0;

                return Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth > maxGridWidth
                          ? maxGridWidth
                          : constraints.maxWidth,
                    ),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 250,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            childAspectRatio: 1,
                          ),
                      itemCount: _gridItems.length,
                      itemBuilder: (context, index) {
                        final item = _gridItems[index];
                        return CategoryButton(
                          onTap: item.onTap,
                          label: item.label,
                          imageUrl: item.imageUrl,
                          colors: item.colors,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom footer
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(10, 35, 104, 1),
                  Color.fromRGBO(134, 0, 27, 1),
                ],
                begin: Alignment.centerLeft,
              ),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: const Text(
                "Project Created as a Final Year Project \nAll Rights Reserved",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 📦 Grid item model class
class _GridItemData {
  final String label;
  final String imageUrl;
  final List<Color> colors;
  final VoidCallback onTap;

  _GridItemData({
    required this.label,
    required this.imageUrl,
    required this.colors,
    required this.onTap,
  });
}

// 🧠 Grid buttons list
final List<_GridItemData> _gridItems = [
  _GridItemData(
    label: "Text Generator",
    imageUrl: "assets/icons/textn.png",
    colors: const [
      Color.fromRGBO(47, 71, 79, 1),
      Color.fromRGBO(159, 188, 198, 1),
    ],
    onTap: () {
      Get.to(const TextGeneratorView(), binding: ChatTextBinding());
    },
  ),
  _GridItemData(
    label: "Image Generator",
    imageUrl: "assets/icons/image.png",
    colors: const [Color.fromRGBO(0, 194, 162, 1), Color.fromRGBO(0, 0, 2, 1)],
    onTap: () {
      Get.to(const ImageGeneratorView(), binding: ChatImageBinding());
    },
  ),
  _GridItemData(
    label: "Code Generator",
    imageUrl: "assets/icons/code.png",
    colors: const [
      Color.fromRGBO(85, 228, 224, 1),
      Color.fromRGBO(29, 19, 218, 0.737),
    ],
    onTap: () {
      Get.to(const CodeGeneratorView());
    },
  ),
  _GridItemData(
    label: "About Us",
    imageUrl: "assets/icons/more.png",
    colors: const [
      Color.fromRGBO(230, 162, 16, 1),
      Color.fromRGBO(248, 161, 190, 1),
    ],
    onTap: () {
      appNavPush(Get.context!, const AboutUsView());
    },
  ),
];
