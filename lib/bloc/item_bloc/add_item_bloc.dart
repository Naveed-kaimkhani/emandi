import 'package:bloc/bloc.dart';
import 'package:e_mandi/data/hive/hive_item_repository.dart';
import 'package:e_mandi/domain/entities/item_model.dart';
import 'package:e_mandi/utils/enums.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
part 'add_item_event.dart';
part 'add_item_state.dart';

class AddItemBloc extends Bloc<AddItemEvent, AddItemState> {
  HiveItemRepository hiveItemRepository;
  AddItemBloc({required this.hiveItemRepository}) : super(AddItemState()) {
    on<AddNewItem>(_onAddItem); 
  }
 Future<void> _onAddItem(AddNewItem event, Emitter<AddItemState> emit) async {
    emit(state.copyWith(
      addItemStatus: AddItemStatus.loading,
    ));
    try {
      await hiveItemRepository.addItem(event.item);
      emit(state.copyWith(
        addItemStatus: AddItemStatus.success,
        message: "Item Added Successfully",
      ));
    } catch (error) {
      emit(state.copyWith(
        addItemStatus: AddItemStatus.error,
        message: error.toString(),
      ));
    }

  }
}

