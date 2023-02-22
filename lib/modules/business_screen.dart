import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/shared_components/component.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener: (BuildContext context, NewsAppStates state) {},
      builder: (BuildContext context, NewsAppStates state) {
        var list = NewsAppCubit.get(context).business;
        return articleBuilder(list);
      },
    );
  }
}
