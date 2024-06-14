import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram/Bloc/Followers/followers_bloc.dart';
import 'package:instagram/Bloc/Following/following_bloc.dart';
import 'package:instagram/Repository/Model/Insta_follower_model.dart';
import 'package:instagram/Repository/Model/insta_following_model.dart';
import 'package:instagram/Repository/Model/insta_info_model.dart';
import 'package:instagram/Ui/Screens/followerprofile.dart';

class Followerscreen extends StatefulWidget {
  final Infomodel model;
  final int index;
  const Followerscreen({super.key, required this.model, required this.index});

  @override
  State<Followerscreen> createState() => _FollowerscreenState();
}

class _FollowerscreenState extends State<Followerscreen> {
  late Followersmodel followers;
  late Followingmodel following;

  @override
  void initState() {
    BlocProvider.of<FollowersBloc>(context)
        .add(FetchFollowerEvent(name: widget.model.data!.username.toString()));

    BlocProvider.of<FollowingBloc>(context)
        .add(FetchFollowingEvent(name: widget.model.data!.username.toString()));
    super.initState();
  }

  String k_m_b_generator(num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} B";
    } else {
      return num.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.index,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            SafeArea(
                child: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              title: Text(widget.model.data!.username.toString(),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  )),
            )),
            SizedBox(
              height: 40.h,
              child: TabBar(
                tabs: [
                  Text(
                    '${k_m_b_generator(widget.model.data!.followerCount!.toDouble())} followers',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.20.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '${k_m_b_generator(widget.model.data!.followingCount!.toDouble())} following',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.20.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
                indicatorColor: Colors.white,
                dividerColor: Colors.grey,
              ),
            ),
            Expanded(
                child: TabBarView(children: [
              Container(
                child: BlocBuilder<FollowersBloc, FollowersState>(
                  builder: (context, state) {
                    if (state is Followersblocloading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is Followersblocerror) {
                      return RefreshIndicator(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * .9,
                            child: const Center(
                                child: Text('Oops something went wrong')),
                          ),
                        ),
                        onRefresh: () async {
                          return BlocProvider.of<FollowersBloc>(context).add(
                              FetchFollowerEvent(
                                  name:
                                      widget.model.data!.username.toString()));
                        },
                      );
                    }
                    if (state is Followersblocloaded) {
                      followers = BlocProvider.of<FollowersBloc>(context)
                          .followersmodel;
                      return ListView.builder(
                        itemCount: followers.data!.items!.length,
                        itemBuilder: (BuildContext context, int index) {
                          BlocProvider.of<FollowersBloc>(context)
                              .followersmodel;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Followerprofilescreen(
                                          model: followers, index: index))),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 30.r,
                                  backgroundImage: NetworkImage(followers
                                      .data!.items![index].profilePicUrl
                                      .toString()),
                                ),
                                title: Text(
                                  followers.data!.items![index].username
                                      .toString(),
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 17.20.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                subtitle: Text(
                                  followers.data!.items![index].fullName
                                      .toString(),
                                  style: GoogleFonts.inter(
                                    color: Colors.grey,
                                    fontSize: 15.20.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                trailing: Container(
                                  height: 40.h,
                                  width: 130.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: Color(0xFF4192EF)),
                                  child: Center(
                                    child: Text('Follow',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 15.05,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
              Container(
                child: BlocBuilder<FollowingBloc, FollowingState>(
                  builder: (context, state) {
                    if (state is Followingblocloading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is Followingblocerror) {
                      return RefreshIndicator(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * .9,
                            child: const Center(
                                child: Text('Oops something went wrong')),
                          ),
                        ),
                        onRefresh: () async {
                          return BlocProvider.of<FollowingBloc>(context)
        .add(FetchFollowingEvent(name: widget.model.data!.username.toString()));
                        },
                      );
                    }
                    if (state is Followingblocloaded) {
                      following =BlocProvider.of<FollowingBloc>(context).followingmodel;
                      return ListView.builder(
                        itemCount: following.data!.items!.length,
                        itemBuilder: (BuildContext context, int index) {
                        
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Followerprofilescreen(
                                          model: followers, index: index))),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 30.r,
                                  backgroundImage: NetworkImage(
                                    following.data!.items![index].profilePicUrl.toString()
                                      ),
                                ),
                                title: Text(
                                  following.data!.items![index].username.toString(),
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 17.20.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                subtitle: Text(
                                  following.data!.items![index].fullName.toString(),
                                  style: GoogleFonts.inter(
                                    color: Colors.grey,
                                    fontSize: 15.20.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                trailing: Container(
                                  height: 40.h,
                                  width: 130.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: Color(0xFF4192EF)),
                                  child: Center(
                                    child: Text('Follow',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 15.05,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            ]))
          ],
        ),
      ),
    );
  }
}
