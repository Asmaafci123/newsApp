import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/states.dart';
import 'package:newsapp/modules/business/buisiness_screen.dart';
import 'package:newsapp/modules/science/science.dart';
import 'package:newsapp/modules/sports/sports.dart';
import 'package:newsapp/network/local/cache_helper.dart';
import 'package:newsapp/network/remote/dio.dart';
import 'package:newsapp/settings/settings_screen.dart';
class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<BottomNavigationBarItem> bottomItems=
  [
     BottomNavigationBarItem(
        icon: Icon(Icons.business),
    label: 'Business'),
     BottomNavigationBarItem(
        icon: Icon(Icons.sports),
        label: 'Sports'),
     BottomNavigationBarItem(
        icon: Icon(Icons.science),
        label: 'Science'),

  ];
  List<Widget>screens=
  [
    const Business(),
    const Sports(),
    const Science(),
    const Settings()
  ];
  void change(int index)
  {
    currentIndex=index;
     if(currentIndex==1)
      {
        getSports();
      }
    else if(currentIndex==2)
      {
        getScience();
      }
    emit(NewsBottomNavigationState());
  }


  List<dynamic>business=[];
  void getBusiness()
  {
    emit(NewsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query:  {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'f56819055d654660870a8a077651d889',
      },).
    then((value) {
      business=value.data['articles'];
      print(business.length);
      emit(NewsGetBusinessSuccessState());
    }).
    catchError((error){
      print(error.toString());
      emit(NewsGetBusinessFailedState(error.toString()));
    });
  }


  List<dynamic>sports=[];
  void getSports()
  {
    emit(NewsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query:  {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'f56819055d654660870a8a077651d889',
      },).
    then((value) {
      sports=value.data['articles'];
      print(sports.length);
      emit(NewsGetSportsSuccessState());
    }).
    catchError((error){
      print(error.toString());
      emit(NewsGetSportsFailedState(error.toString()));
    });
  }

  List<dynamic>science=[];
  void getScience()
  {
    emit(NewsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query:  {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'f56819055d654660870a8a077651d889',
      },).
    then((value) {
      science=value.data['articles'];
      print(science.length);
      emit(NewsGetSportsSuccessState());
    }).
    catchError((error){
      print(error.toString());
      emit(NewsGetScienceFailedState(error.toString()));
    });
  }
  var searchController=TextEditingController();
  List<dynamic>searchList=[];
  void search(String value)
  {
    emit(NewsLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query:  {
        'q': value,
        'apiKey': 'f56819055d654660870a8a077651d889',
      },).
    then((value) {
      searchList=value.data['articles'];
      print(searchList.length);
      emit(NewsGetSearchSuccessState());
    }).
    catchError((error){
      print(error.toString());
      emit(NewsGetSearchFailedState(error.toString()));
    });
  }
  bool isDark=false;
  void changeMode({bool? fromShared})
  {
    if(fromShared!=null)
      {
        isDark=fromShared;
        emit(NewsChangeModeState());
      }
    else
      {
        isDark=!isDark;
        CacheHelper.putBoolean(key: 'isDark', value: isDark).
        then((value){
          emit(NewsChangeModeState());
        });// cache from button change
      }



    print(isDark);
  }
}