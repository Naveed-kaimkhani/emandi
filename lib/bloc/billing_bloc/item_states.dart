import 'package:equatable/equatable.dart';
import 'package:e_mandi/domain/entities/item_model.dart';

abstract class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object> get props => [];
}

class ItemInitial extends ItemState {}

class ItemListUpdated extends ItemState {
  final List<ItemModel> items;

  const ItemListUpdated(this.items);

  @override
  List<Object> get props => [items];
}

class BillGenerated extends ItemState {
  final List<ItemModel> items;

  const BillGenerated(this.items);

  @override
  List<Object> get props => [items];
}
