import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/data/local_data/user_reposatory.dart';
import 'package:news_app/core/data/remote_data/news/news_api_servise.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/core/themes/light_theme.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';
import 'package:news_app/features/splash/splash_screen.dart';
import 'core/data/local_data/prefrances_maneger.dart';
import 'features/bookmark/data/bookmark_repository.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManager().init();
  await UserRepository().init();
  await BookmarkRepository().init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 832),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return BlocProvider(
          create: (context) =>
              HomeCubit(NewsRepository(NewsApiService())),
          child: MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'News App',
            theme: lightTheme,
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}
