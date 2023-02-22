import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/modules/science_screen.dart';
import 'package:news_app/modules/sport_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/shared_network/local/cache_helper.dart';
import 'package:news_app/shared/shared_network/remote/dio_helper.dart';

class NewsAppCubit extends Cubit<NewsAppStates> {
  NewsAppCubit() : super(InitialState());

  static NewsAppCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'BUSINESS'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sports_baseball), label: 'SPORT'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'SCIENCE'),
  ];
  List<Widget> screens = [
    const BusinessScreen(),
    const SportScreen(),
    const ScienceScreen(),
  ];

  int currentIndex = 0;

  void changeBottomNavigationBar(int index) {
    currentIndex = index;
    if (index == 1) {
      getSportData();
    } else if (index == 2) {
      getScienceData();
    }
    emit(ChangeBottomNavigationBarState());
  }

  List<dynamic> business = [];

  void getBusinessData() {
    emit(LoadingGetBusinessState());
    DioHelper.getDatabase(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '1ebafb80150c4fbaacc730b18a5c84f5',
      },
    ).then((value) {
      business = value.data['articles'];
      print(value.data['articles'][0]);
      emit(SuccessGetBusinessState());
    }).catchError((error) {
      emit(ErrorGetBusinessState());
      print(error.toString());
    });
  }

  List<dynamic> sport = [];

  void getSportData() {
    emit(LoadingGetSportState());
    DioHelper.getDatabase(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'sport',
        'apiKey': '1ebafb80150c4fbaacc730b18a5c84f5',
      },
    ).then((value) {
      sport = value.data['articles'];
      print(value.data['articles'][0]);
      emit(SuccessGetSportState());
    }).catchError((error) {
      emit(ErrorGetSportState());
      print(error.toString());
    });
  }

  List<dynamic> science = [];

  void getScienceData() {
    emit(LoadingGetScienceState());
    if (science.isEmpty) {
      DioHelper.getDatabase(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '1ebafb80150c4fbaacc730b18a5c84f5',
        },
      ).then((value) {
        science = value.data['articles'];
        print(value.data['articles'][0]);
        emit(SuccessGetScienceState());
      }).catchError((error) {
        emit(ErrorGetScienceState());
        print(error.toString());
      });
    }else{
      emit(SuccessGetScienceState());
    }
  }

  bool isDark = false;
  void changeMode({bool? fromShared}){
    if(fromShared != null){
      isDark = fromShared;
      emit(ChangeBrightnessModeState());
    }else {
      isDark = !isDark;
      CacheHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
        emit(ChangeBrightnessModeState());
      });
    }
  }

  List<dynamic> search = [];

  void searchData({
  required String value,
}) {
    emit(LoadingGetSearchState());
    DioHelper.getDatabase(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': '1ebafb80150c4fbaacc730b18a5c84f5',
      },
    ).then((value) {
      search = value.data['articles'];
      print(value.data['articles'][0]);
      emit(SuccessGetSearchState());
    }).catchError((error) {
      emit(ErrorGetSearchState());
      print(error.toString());
    });
  }
}
