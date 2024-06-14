import 'package:bloc/bloc.dart';
import 'package:instagram/Repository/Api/instagram/insta_info_api.dart';
import 'package:instagram/Repository/Model/insta_info_model.dart';
import 'package:meta/meta.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  late Infomodel infomodel;
  InstagramApi infoapi = InstagramApi();
  InfoBloc() : super(InfoInitial()) {
    on<FetchinfoEvent>((event, emit)async {
     emit(Infoblocloading());
     try {
       infomodel =await infoapi.getInfo(event.name);
       emit (Infoblocloaded());
     } catch (e) {
      print(e);
      emit(Infoblocerror()); 
     }
    });
  }
}
