import 'package:e_mandi/domain/entities/item_model.dart';

abstract class CreateBillEvent {}

class AddItemEvent extends CreateBillEvent {
  final ItemModel newItem;

  AddItemEvent(this.newItem);
}

class ResetFieldsEvent extends CreateBillEvent {}

class GenerateBillEvent extends CreateBillEvent {}
