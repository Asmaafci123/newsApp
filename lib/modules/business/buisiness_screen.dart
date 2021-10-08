import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/cubit.dart';
import 'package:newsapp/cubit/states.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:newsapp/shared/components/components.dart';
class Business extends StatelessWidget {
  const Business({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        builder: (context,state)
        {
          List list=NewsCubit.get(context).business;
          return articleBuilder(list,context);

        },
        listener: (context,state){});
  }
}
//business