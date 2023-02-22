import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/shared_network/local/cache_helper.dart';
import 'package:news_app/shared/shared_network/remote/dio_helper.dart';
import 'layout/news_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark ?? false));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  const MyApp(this.isDark, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsAppCubit()
        ..getBusinessData()
        ..changeMode(fromShared: isDark),
      child: BlocConsumer<NewsAppCubit, NewsAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsAppCubit.get(context);
          return MaterialApp(
            title: 'News App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                titleSpacing: 20,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                color: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                elevation: 20,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                titleSpacing: 20,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
                color: HexColor('333739'),
                elevation: 0.0,
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                elevation: 20,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                backgroundColor: HexColor('333739'),
                unselectedItemColor: Colors.grey,
              ),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: const NewsApp(),
          );
        },
      ),
    );
  }
}
