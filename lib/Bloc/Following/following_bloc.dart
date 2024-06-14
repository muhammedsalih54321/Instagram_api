import 'package:bloc/bloc.dart';
import 'package:instagram/Repository/Api/instagram/insta_info_api.dart';
import 'package:instagram/Repository/Model/insta_following_model.dart';
import 'package:meta/meta.dart';

part 'following_event.dart';
part 'following_state.dart';

class FollowingBloc extends Bloc<FollowingEvent, FollowingState> {
  late Followingmodel followingmodel;
  InstagramApi followingapi=InstagramApi();
  FollowingBloc() : super(FollowingInitial()) {
    on<FetchFollowingEvent>((event, emit)async {
    emit(Followingblocloading());
      try {
       followingmodel=await followingapi.getFollowing(event.name);
        emit(Followingblocloaded());
      } catch (e) {
        print(e);
        emit(Followingblocerror());
      }
    
    });
  }
}
