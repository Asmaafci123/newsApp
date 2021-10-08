import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/cubit.dart';
import 'package:newsapp/cubit/states.dart';
import 'package:newsapp/modules/search/search_screen.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener:(context,state){} ,
        builder: (context,state){
          var AppCubit=NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('NewsApp'),
              actions: [
                IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) =>SearchScreen())
                      );
                    },
                    icon: Icon(
                      Icons.search,
                      size: 25,)),
                IconButton(
                    onPressed: (){
                      NewsCubit.get(context).changeMode();
                    //  print('asmaa');
                    },
                    icon: Icon(
                      Icons.brightness_4_outlined,
                      size: 25,)),
              ],
            ),
            body: AppCubit.screens[AppCubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: AppCubit.bottomItems,
              onTap: (index)
              {
                AppCubit.change(index);
              },
            ),
          );
        },
    );
  }
}
