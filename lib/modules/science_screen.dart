import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';
import '../shared/shared_components/component.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener: (BuildContext context, NewsAppStates state) {},
      builder: (BuildContext context, NewsAppStates state) {
        var list = NewsAppCubit.get(context).science;
        return articleBuilder(list);
      },
    );
  }
}
