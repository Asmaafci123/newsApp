// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/network/local/cache_helper.dart';
import 'package:newsapp/network/remote/dio.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'layout/newslayout.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();// ensure that all await is done before runApp
  DioHelper.init();
  await CacheHelper.init();
  bool isDark=CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>NewsCubit()..getBusiness()..changeMode(fromShared: isDark),
      child: BlocConsumer<NewsCubit,NewsStates>(
          listener: (context,state){
          },
          builder: (context,state) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    scaffoldBackgroundColor: Colors.white,
                    primarySwatch: Colors.blue,
                    appBarTheme: const AppBarTheme(
                        backgroundColor: Colors.white,
                        titleTextStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                        elevation: 0.0,
                        actionsIconTheme: IconThemeData(
                            color: Colors.black
                        )
                    ),
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.blue,
                      unselectedItemColor: Colors.grey,
                      backgroundColor: Colors.white,
                    ),
                    textTheme: TextTheme( //make override
                        bodyText1: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        )
                    )
                ),
                darkTheme: ThemeData(
                    scaffoldBackgroundColor: Color(0xFF4A4A4A),
                    primarySwatch: Colors.blue,
                    appBarTheme: const AppBarTheme(
                        backgroundColor: Color(0xFF4A4A4A),
                        titleTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                        elevation: 0.0,
                        actionsIconTheme: IconThemeData(
                            color: Colors.white
                        )
                    ),
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.blue,
                      unselectedItemColor: Colors.grey,
                      backgroundColor: Color(0xFF4A4A4A),
                    ),
                    textTheme: TextTheme(
                        bodyText1: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )
                    )
                ),
                themeMode: NewsCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
                home: NewsLayout()
            );
          }
      ),
    );
  }
}
