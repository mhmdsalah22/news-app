import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search_screen.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener: (BuildContext context, NewsAppStates state) {},
      builder: (BuildContext context, NewsAppStates state) {
        var cubit = NewsAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('NEWS APP'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchScreen()),
                    );
                  },
                  icon: const Icon(
                    Icons.search,
                  )),
              IconButton(
                  onPressed: () {
                    cubit.changeMode();
                  },
                  icon: const Icon(
                    Icons.brightness_4,
                  ))
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.items,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavigationBar(index);
            },
          ),
        );
      },
    );
  }
}
