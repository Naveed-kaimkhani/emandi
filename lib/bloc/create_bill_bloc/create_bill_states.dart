import 'package:e_mandi/domain/entities/item_model.dart';

abstract class CreateBillState {}

class BillFormInitial extends CreateBillState {}

class BillFormInProgress extends CreateBillState {}

class BillFormSuccess extends CreateBillState {
  final List<ItemModel> items;

  BillFormSuccess(this.items);
}

class BillFormError extends CreateBillState {
  final String errorMessage;

  BillFormError(this.errorMessage);
}

class BillFormItemsUpdated extends CreateBillState {
  final List<ItemModel> items;

  BillFormItemsUpdated(this.items);
}
