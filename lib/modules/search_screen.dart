import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/shared_components/component.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController search = TextEditingController();
  var formKey = GlobalKey<FormState>();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: search,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Search must not be empty';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      if (formKey.currentState!.validate()) {
                        cubit.searchData(value: value);
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                      labelStyle: TextStyle(
                        color: cubit.isDark ? Colors.white : Colors.black,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: cubit.isDark ? Colors.white : Colors.black,
                      ),
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.deepOrange,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(child: articleBuilder(cubit.search, isSearch: true)),
              ],
            ),
          ),
        );
      },
    );
  }
}
