part of 'add_item_bloc.dart';


 class AddItemState extends Equatable {
  const AddItemState({this.addItemStatus=AddItemStatus.initial,this.message=''});
  

  
  final AddItemStatus addItemStatus;
  
  final String message;
 AddItemState copyWith({ String? message, AddItemStatus? addItemStatus}) {
    return AddItemState( message: message ?? this.message, addItemStatus: addItemStatus ?? this.addItemStatus);
  }
  @override
  List<Object> get props => [message,addItemStatus];
}
