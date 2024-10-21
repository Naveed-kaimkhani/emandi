import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_mandi/bloc/create_bill_bloc/create_bill_events.dart';
import 'package:e_mandi/bloc/create_bill_bloc/create_bill_states.dart';
import 'package:e_mandi/domain/entities/item_model.dart';
import 'package:e_mandi/domain/repositories/billing_repository.dart';

import '../../presentation/billing/invoice_initial_list.dart';

class CreateBillBloc extends Bloc<CreateBillEvent, CreateBillState> {
  final BillingRepository billingRepository;
  final List<ItemModel> _items = [];

  CreateBillBloc({required this.billingRepository}) : super(BillFormInitial()) {
    on<AddItemEvent>(_onAddItemEvent);
    on<ResetFieldsEvent>(_onResetFieldsEvent);
    on<GenerateBillEvent>(_onGenerateBillEvent);
  }

  void _onAddItemEvent(AddItemEvent event, Emitter<CreateBillState> emit) {
    _items.add(event.newItem);
    emit(BillFormItemsUpdated(_items));
  }

  void _onResetFieldsEvent(ResetFieldsEvent event, Emitter<CreateBillState> emit) {
    _items.clear();
    emit(BillFormInitial());
  }

  void _onGenerateBillEvent(GenerateBillEvent event, Emitter<CreateBillState> emit) async {
    emit(BillFormInProgress());
    try {
      _items.add(event.Item);
      // await billingRepository.addBill(event.Item);
      
      emit(BillFormSuccess(_items));
    } catch (e) {
      emit(BillFormError('Failed to generate bill: $e'));
    }
  }
}
