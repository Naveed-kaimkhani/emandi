part of 'add_item_bloc.dart';

sealed class AddItemEvent extends Equatable {
  const AddItemEvent();

  @override
  List<Object> get props => [];
}
class AddNewItem extends AddItemEvent {
  final ItemModel item;
  AddNewItem({required this.item});
  @override
  List<Object> get props => [item];
}
