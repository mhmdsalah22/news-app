import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';
import '../shared/shared_components/component.dart';

class SportScreen extends StatelessWidget {
  const SportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener: (BuildContext context, NewsAppStates state) {},
      builder: (BuildContext context, NewsAppStates state) {
        var list = NewsAppCubit.get(context).sport;
        return articleBuilder(list);
      },
    );
  }
}
