import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/core/global_var.dart';
import 'package:we_chat/features/home/manager/cubit/home_cubit.dart';
import 'package:we_chat/features/home/manager/cubit/home_state.dart';
import 'package:we_chat/features/home/presentation/widgets/chat_user_card.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is HomeGetUserSuccessState) {
          if (state.users.isNotEmpty) {
            return Padding(
              padding: EdgeInsets.only(
                  top: screenSize.height * 0.008,
                  bottom: screenSize.height * 0.008),
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ChatUserCard(
                      user: state.users[index],
                    );
                  },
                  itemCount: state.users.length),
            );
          } else {
            return Center(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(24)),
                child: Text(
                  'No information',
                  style: TextStyle(
                    fontSize: 22.0,
                  ),
                ),
              ),
            );
          }
        } else if (state is HomeGetUserErrorState) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(24)),
              child: Text(
                'No Connections Found!',
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
