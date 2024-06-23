
import 'package:e_mandi/bloc/item_bloc/add_item_bloc.dart';
import 'package:e_mandi/domain/entities/item_model.dart';
import 'package:e_mandi/presentation/widgets/auth_button.dart';
import 'package:e_mandi/style/images.dart';
import 'package:e_mandi/style/styling.dart';
import 'package:e_mandi/utils/custom_loader.dart';
import 'package:e_mandi/utils/enums.dart';
import 'package:e_mandi/utils/routes/routes_name.dart';
import 'package:e_mandi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/login_bloc/login_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A widget representing the submit button for the login form.
class AddNewItemButton extends StatelessWidget {
  final String? text;
  final double rent;
  final _formKey = GlobalKey<FormState>();

final   String? selectedItem;
final  String? selectedContainer;
final  int? itemCount;
  final ItemModel item;
  final BuildContext contextt;

   AddNewItemButton({
    super.key,
    required this.text,
    required this.rent,
    required this.item,
    required this.contextt, this.selectedItem, this.selectedContainer, this.itemCount,
});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddItemBloc, AddItemState>(
      listenWhen: (current, previous) =>
          current.addItemStatus != previous.addItemStatus,
      listener: (context, state) async {
        if (state.addItemStatus == AddItemStatus.loading) {
          LoaderOverlay.show(contextt);
        } else if (state.addItemStatus == AddItemStatus.error) {
          LoaderOverlay.hide();
          utils.flushBarErrorMessage(state.message, contextt);
        } else if (state.addItemStatus == AddItemStatus.success) {
          LoaderOverlay.hide();
          utils.flushBarErrorMessage(state.message, contextt);
        }
      },
      child: BlocBuilder<AddItemBloc, AddItemState>(
        buildWhen: (current, previous) =>
            current.addItemStatus != previous.addItemStatus,
        builder: (context, state) {
          return InkWell(
            onTap: () {
              
    if (_formKey.currentState!.validate() &&
        selectedItem != null &&
        selectedContainer != null &&
        itemCount != null) {
      final item = ItemModel(
        name:text??"",
        selectedItem: selectedItem!,
        selectedContainer: selectedContainer!,
        itemCount: itemCount!,
        rent:rent,
      );
              context.read<AddItemBloc>().add(AddNewItem(item: item));
    } else {
      utils.flushBarErrorMessage(
          AppLocalizations.of(context)!.enterAllDetail, context);
    }
            },
            child: AuthButton(
                          height: 56.h,
                          widht: 110.w,
                          fontsize: 20.sp,
                          text: AppLocalizations.of(context)!.submit,
                          func: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            // _addItem();
                          },
                          color: Styling.primaryColor),
          );
        },
      ),
    );
  }
}
