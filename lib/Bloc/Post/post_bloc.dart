import 'package:bloc/bloc.dart';
import 'package:instagram/Repository/Api/instagram/insta_info_api.dart';
import 'package:instagram/Repository/Model/insta_post_model.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  late Postmodel postmodel;
  InstagramApi postapi=InstagramApi();
  PostBloc() : super(PostInitial()) {
    on<Fetchpostevent>((event, emit)async {
    emit(Postblocloading());
    try {
       
       postmodel= await postapi.getpost(event.name);
       emit(Postblocloaded());
    } catch (e) {
      print(e);
      emit(Postblocerror());
    }
    });
  }
}
