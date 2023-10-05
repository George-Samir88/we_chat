import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/features/home/manager/cubit/home_cubit/home_cubit.dart';
import 'package:we_chat/features/home/manager/cubit/home_cubit/home_state.dart';

import 'chat_users_list_view.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import 'no_users_widget.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is HomeGetUserSuccessState) {
          if (state.users.isNotEmpty) {
            print('------------------------------' + state.users[0].name + '---------------------------------');
            return ChatUsersListView(
              users: state.users,
            );
          } else {
            return NoUsersWidget();
          }
        } else if (state is HomeSearchSuccessState) {
          if (state.chatUserSearchList.isNotEmpty) {
            return ChatUsersListView(
              users: state.chatUserSearchList,
            );
          } else {
            return NoUsersWidget();
          }
        } else if (state is HomeGetUserErrorState) {
          return CustomErrorWidget(
            error: state.error,
          );
        } else if (state is HomeSearchErrorState) {
          return CustomErrorWidget(
            error: state.error,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
