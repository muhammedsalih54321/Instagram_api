import 'package:bloc/bloc.dart';
import 'package:instagram/Repository/Api/instagram/insta_info_api.dart';
import 'package:instagram/Repository/Model/Insta_follower_model.dart';
import 'package:meta/meta.dart';

part 'followers_event.dart';
part 'followers_state.dart';

class FollowersBloc extends Bloc<FollowersEvent, FollowersState> {
  late Followersmodel followersmodel;
  InstagramApi folloerapi = InstagramApi();
  FollowersBloc() : super(FollowersInitial()) {
    on<FetchFollowerEvent>((event, emit) async {
      emit(Followersblocloading());
      try {
        followersmodel = await folloerapi.getFollower(event.name);
        emit(Followersblocloaded());
      } catch (e) {
        print(e);
        emit(Followersblocerror());
      }
    });
  }
}
