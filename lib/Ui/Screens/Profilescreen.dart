import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram/Bloc/Highlight/highlight_bloc.dart';
import 'package:instagram/Bloc/Info/info_bloc.dart';
import 'package:instagram/Bloc/Post/post_bloc.dart';
import 'package:instagram/Repository/Model/inst_highlight_model.dart';
import 'package:instagram/Repository/Model/insta_info_model.dart';
import 'package:instagram/Repository/Model/insta_post_model.dart';
import 'package:instagram/Ui/Screens/followerscreen.dart';
import 'package:instagram/Ui/components/button.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Infomodel info;
  late Highlightmodel highlight;
  late Postmodel post;

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

  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                  child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(color: Colors.white)),
                child: TextFormField(
                  onChanged: (value) {
                    if (controller.text.isEmpty) {
                      BlocProvider.of<InfoBloc>(context)
                          .add(FetchinfoEvent(name: ''));
                    }
                  },
                  controller: controller,
                  onFieldSubmitted: (value) {
                    BlocProvider.of<InfoBloc>(context)
                        .add(FetchinfoEvent(name: controller.text));
                    BlocProvider.of<HighlightBloc>(context)
                        .add(FetchHighlightEvent(name: controller.text));
                    BlocProvider.of<PostBloc>(context)
                        .add(Fetchpostevent(name: controller.text));
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: 'Serch here',
                      hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 15.sp)),
                ),
              )),
              BlocBuilder<InfoBloc, InfoState>(
                builder: (context, state) {
                  if (state is Infoblocloading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is Infoblocerror) {
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
                        return BlocProvider.of<InfoBloc>(context)
                            .add(FetchinfoEvent(name: ''));
                      },
                    );
                  }
                  if (state is Infoblocloaded) {
                    info = BlocProvider.of<InfoBloc>(context).infomodel;
                    String followers =
                        k_m_b_generator(info.data!.followerCount!.toDouble());
                    String following =
                        k_m_b_generator(info.data!.followingCount!.toDouble());
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30.h,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 45.r,
                                  backgroundImage: NetworkImage(
                                    info.data!.profilePicUrl.toString(),
                                  ),
                                ),
                                SizedBox(
                                  width: 30.w,
                                ),
                                Column(
                                  children: [
                                    Text(info.data!.mediaCount.toString(),
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                        )),
                                    Text('Posts',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 15.20.sp,
                                          fontWeight: FontWeight.w400,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(context,MaterialPageRoute(builder: (_)=>Followerscreen(model: info, index: 0,))),
                                  child: Column(
                                    children: [
                                      Text(followers,
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      Text('Followers',
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 15.20.sp,
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(context,MaterialPageRoute(builder: (_)=>Followerscreen(model: info, index: 1,))),
                                  child: Column(
                                    children: [
                                      Text(following,
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      Text('Following',
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 15.20.sp,
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Text(info.data!.fullName.toString(),
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                )),
                            SizedBox(
                              height: 0.h,
                            ),
                            Text(info.data!.biography.toString(),
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                )),
                            Row(
                              children: [
                                Icon(
                                  Icons.link,
                                  color: Colors.white,
                                ),
                                Text(info.data!.externalUrl.toString(),
                                    style: GoogleFonts.inter(
                                      color: Color(0xFFD4E0ED),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Button(
                                    name: 'Follow', color: Color(0xFF4192EF)),
                                Button(
                                    name: 'Message', color: Colors.transparent),
                                Container(
                                  height: 40.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Center(
                                      child: Icon(
                                    Icons.person_add_outlined,
                                    color: Colors.white,
                                  )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              height: 95.h,
                              child: BlocBuilder<HighlightBloc, HighlightState>(
                                builder: (context, state) {
                                  if (state is Infoblocloading) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (state is Infoblocerror) {
                                    return RefreshIndicator(
                                      child: SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .9,
                                          child: const Center(
                                              child: Text(
                                                  'Oops something went wrong')),
                                        ),
                                      ),
                                      onRefresh: () async {
                                        return BlocProvider.of<HighlightBloc>(
                                                context)
                                            .add(FetchHighlightEvent(name: ''));
                                      },
                                    );
                                  }
                                  if (state is Highlightblocloaded) {
                                    highlight =
                                        BlocProvider.of<HighlightBloc>(context)
                                            .highlightmodel;
                                    return Container(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            highlight.data!.items!.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Container(
                                              width: 80.w,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Positioned(
                                                        left: -5,
                                                        top: -3.5,
                                                        child: Container(
                                                          height: 73.h,
                                                          width: 73.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.r),
                                                          ),
                                                        ),
                                                      ),
                                                      CircleAvatar(
                                                        radius: 33.r,
                                                        backgroundImage:
                                                            NetworkImage(highlight
                                                                .data!
                                                                .items![index]
                                                                .coverMedia!
                                                                .croppedImageVersion!
                                                                .url
                                                                .toString()),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 7.h,
                                                  ),
                                                  SizedBox(
                                                    height: 15.h,
                                                    width: 90.w,
                                                    child: Text(
                                                        highlight.data!
                                                            .items![index].title
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.inter(
                                                          color: Colors.white,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            TabBar(
                              tabs: [
                                Tab(
                                  icon: Icon(
                                    Icons.view_module_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                Tab(
                                  icon: Icon(
                                    Icons.ondemand_video_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                Tab(
                                  icon: Icon(
                                    Icons.co_present_outlined,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                              dividerColor: Colors.transparent,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorColor: Colors.white,
                            ),
                            Container(
                              width: double.infinity,
                              height: 200.h,
                              child: TabBarView(children: [
                                Container(
                                    child: Column(
                                  children: [
                                    Expanded(
                                      child: BlocBuilder<PostBloc, PostState>(
                                        builder: (context, state) {
                                          if (state is Postblocloading) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          if (state is Postblocerror) {
                                            return RefreshIndicator(
                                              child: SingleChildScrollView(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                child: SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .9,
                                                  child: const Center(
                                                      child: Text(
                                                          'Oops something went wrong')),
                                                ),
                                              ),
                                              onRefresh: () async {
                                                return BlocProvider.of<
                                                        PostBloc>(context)
                                                    .add(Fetchpostevent(
                                                        name: ''));
                                              },
                                            );
                                          }
                                          if (state is Postblocloaded) {
                                            post = BlocProvider.of<PostBloc>(
                                                    context)
                                                .postmodel;
                                                print("he"+post.data!.items!.length.toString());
                                            return GridView.builder(
                                              itemCount:
                                                  post.data!.items!.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      childAspectRatio:
                                                          290 / 400,
                                                      crossAxisSpacing: 5,
                                                      mainAxisSpacing: 5),
                                              itemBuilder: (context, index) {
                                                print('hi =${post
                                                      .data!
                                                      .items![index]
                                                      .thumbnailUrl
                                                      .toString()}');
                                                return Container(
                                                 
                                                  child: Image.network(post
                                                      .data!
                                                      .items![index]
                                                      .thumbnailUrl
                                                      .toString(),fit: BoxFit.cover,),
                                                );
                                              },
                                            );
                                          } else {
                                            return SizedBox();
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                                Container(
                                  child: Text(
                                    'screen2',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'screen3',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ]),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
