import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/cubit.dart';
import 'package:newsapp/cubit/states.dart';
import 'package:newsapp/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){
      },
      builder: (context,state)
      {
        var list=NewsCubit.get(context).searchList;
        return Scaffold(
          appBar: AppBar(),
          body:  Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  onChanged: (value)
                  {
                    String searchText=NewsCubit.get(context).searchController.text.toString();
                    NewsCubit.get(context).search(searchText);
                  },
                  decoration: InputDecoration(
                      labelText: 'search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:BorderRadius.circular(10.0)
                      )
                  ),
                  keyboardType: TextInputType.text,
                  controller:NewsCubit.get(context).searchController,
                ),
              ),
              Expanded(flex:1,child: articleBuilder(list,context))
            ],
          ),
        );
      },
    );
  }
}
