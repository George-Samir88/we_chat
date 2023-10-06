import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/core/function/get_self_info.dart';
import 'package:we_chat/core/global_var.dart';
import 'package:we_chat/features/home/manager/cubit/home_cubit/home_cubit.dart';

import 'package:we_chat/features/home/presentation/widgets/home_view_body.dart';

import '../../user_profile/presentation/user_profile.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  initState() {
    BlocProvider.of<HomeCubit>(context).getChatUsers();
    getSelfInfo(uid: firebaseAuth.currentUser!.uid);
    super.initState();
  }

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    var blocHelper = BlocProvider.of<HomeCubit>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          print(isSearching);
          if (isSearching) {
            setState(() {
              isSearching = !isSearching;
            });
            //false : do nothing
            return Future.value(false);
          }
          //true : perform normal back button task
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(
              CupertinoIcons.home,
              size: screenSize.width * 0.07,
            ),
            title: isSearching
                ? TextField(
                    autofocus: true,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Email, Name,....',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      blocHelper.searchAboutUser(searchItem: value);
                    },
                  )
                : Text('We Chat'),
            actions: [
              IconButton(
                onPressed: () {
                  isSearching = !isSearching;
                  setState(() {});
                },
                icon: isSearching
                    ? Icon(
                        CupertinoIcons.clear_circled_solid,
                        size: screenSize.width * 0.07,
                      )
                    : Icon(
                        Icons.search,
                        size: screenSize.width * 0.07,
                      ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.02,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfile(),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: screenSize.width * 0.05,
                    backgroundImage: CachedNetworkImageProvider(
                      me.image,
                      errorListener: () => IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserProfile(),
                            ),
                          );
                        },
                        icon: Icon(Icons.more_vert),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: screenSize.height * 0.01),
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(
                Icons.add_comment_rounded,
              ),
            ),
          ),
          body: HomeViewBody(),
        ),
      ),
    );
  }
}
