import 'package:equatable/equatable.dart';
import 'package:e_mandi/domain/entities/item_model.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class AddItem extends ItemEvent {
  final ItemModel item;

  const AddItem(this.item);

  @override
  List<Object> get props => [item];
}

class GenerateBill extends ItemEvent {
  const GenerateBill();
}
