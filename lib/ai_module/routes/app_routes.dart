import 'package:get/get.dart';

import '../controllers/chat/chat_bindings.dart';
import '../controllers/home/home_bindings.dart';
import '../controllers/image/image_bindings.dart';
import '../views/about_us_view.dart';
import '../views/code_generator_view.dart';
import '../views/home_view.dart';
import '../views/image_views/image_generator_view.dart';
import '../views/text_generator_view.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const AIHomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.imageGenerator,
      page: () => const ImageGeneratorView(),
      binding: ChatImageBinding(),
    ),
    GetPage(
      name: _Paths.textGenerator,
      page: () => const TextGeneratorView(),
      binding: ChatTextBinding(),
    ),
    GetPage(name: _Paths.moreView, page: () => const AboutUsView()),
    GetPage(name: _Paths.codeGenerator, page: () => const CodeGeneratorView()),
  ];
}

abstract class Routes {
  Routes._();
  static const home = _Paths.home;
  static const imageGenerator = _Paths.imageGenerator;
  static const textGenerator = _Paths.textGenerator;
  static const codeGenerator = _Paths.codeGenerator;
  static const moreView = _Paths.moreView;
}

abstract class _Paths {
  _Paths._();
  static const home = '/home';
  static const imageGenerator = '/image-generator';
  static const textGenerator = '/text-generator';
  static const codeGenerator = '/code-generator';
  static const moreView = '/more-view';
}
