import 'package:bloc/bloc.dart';
import 'package:e_mandi/utils/enums.dart';
import 'package:equatable/equatable.dart';

part 'add_item_event.dart';
part 'add_item_state.dart';

class AddItemBloc extends Bloc<AddItemEvent, AddItemState> {
  AddItemBloc() : super(AddItemInitial()) {
    on<AddItemEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
