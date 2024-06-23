import 'package:bloc/bloc.dart';
import 'package:e_mandi/bloc/billing_bloc/item_events.dart';
import 'package:e_mandi/bloc/billing_bloc/item_states.dart';
import 'package:e_mandi/domain/entities/item_model.dart';
import 'package:e_mandi/domain/repositories/billing_repository.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final BillingRepository billingRepository;

  ItemBloc({required this.billingRepository}) : super(ItemInitial()) {
    on<AddItem>((event, emit) {
      if (state is ItemListUpdated) {
        final updatedItems = List<ItemModel>.from((state as ItemListUpdated).items)..add(event.item);
        emit(ItemListUpdated(updatedItems));
      } else {
        emit(ItemListUpdated([event.item]));
      }
    });

    on<GenerateBill>((event, emit) {
      if (state is ItemListUpdated) {
        emit(BillGenerated((state as ItemListUpdated).items));
      }
    });
  }
}
