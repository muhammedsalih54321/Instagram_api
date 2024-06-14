import 'package:bloc/bloc.dart';
import 'package:instagram/Repository/Api/instagram/insta_info_api.dart';
import 'package:instagram/Repository/Model/inst_highlight_model.dart';
import 'package:meta/meta.dart';

part 'highlight_event.dart';
part 'highlight_state.dart';

class HighlightBloc extends Bloc<HighlightEvent, HighlightState> {
  late Highlightmodel highlightmodel;
  InstagramApi highlightapi = InstagramApi();
  HighlightBloc() : super(HighlightInitial()) {
    on<FetchHighlightEvent>((event, emit) async{
      emit(Highlightblocloading());
      try {
        highlightmodel = await highlightapi.getHighlight(event.name);
        emit(Highlightblocloaded());
      } catch (e) {
        print(e);
         emit(Highlightblocerror());

      }
  
    });
  }
}
