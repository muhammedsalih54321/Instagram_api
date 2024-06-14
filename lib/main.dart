import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram/Bloc/Followers/followers_bloc.dart';
import 'package:instagram/Bloc/Following/following_bloc.dart';
import 'package:instagram/Bloc/Highlight/highlight_bloc.dart';
import 'package:instagram/Bloc/Info/info_bloc.dart';
import 'package:instagram/Bloc/Post/post_bloc.dart';
import 'package:instagram/Ui/Screens/Profilescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (BuildContext context, Widget? child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => InfoBloc(),
              ),
              BlocProvider(
                create: (context) => HighlightBloc(),
              ),
              BlocProvider(
                create: (context) => PostBloc(),
              ),
               BlocProvider(
                create: (context) => FollowersBloc(),
              ),
               BlocProvider(
                create: (context) => FollowingBloc(),
              )
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: Profile(),
            ),
          );
        });
  }
}
