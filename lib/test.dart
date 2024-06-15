// import 'package:e_mandi/data/hive/billing_repository.dart';
// import 'package:e_mandi/domain/entities/item_model.dart';
// import 'package:e_mandi/presentation/initial/container_dropdown.dart';
// import 'package:e_mandi/presentation/widgets/auth_button.dart';
// import 'package:e_mandi/presentation/widgets/input_field.dart';
// import 'package:e_mandi/utils/routes/routes_name.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../style/styling.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class CreateBillFromScratch extends StatefulWidget {
//   final BillingRepository billingRepository;
//   const CreateBillFromScratch({super.key, required this.billingRepository});

//   @override
//   State<CreateBillFromScratch> createState() => _CreateBillFromScratchState();
// }

// class _CreateBillFromScratchState extends State<CreateBillFromScratch> {
//   final _formKey = GlobalKey<FormState>();
//   FocusNode nameFocusNode = FocusNode();
//   FocusNode rateFocusNode = FocusNode();
//   FocusNode fruitFocusNode = FocusNode();
//   FocusNode percentageFocusNode = FocusNode();
//   FocusNode rentFocusNode = FocusNode();

//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _rentController = TextEditingController();
//   final TextEditingController _percentageController = TextEditingController();
//   final TextEditingController _rateController = TextEditingController();

//   String? _selectedItem;
//   String? _selectedContainer;
//   int? _itemCount;

//   List<ItemModel> _items = [];

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _rentController.dispose();
//     _percentageController.dispose();
//     _rateController.dispose();
//     super.dispose();
//   }

//   void _addBilling(List<ItemModel> items) async {
//     await widget.billingRepository.addBill(items);
//   }
  

//   void _submitForm() {
//     if (_formKey.currentState!.validate() &&
//         _selectedItem != null &&
//         _selectedContainer != null &&
//         _itemCount != null) {
//       final newItem = ItemModel(
//         name: _nameController.text,
//         selectedItem: _selectedItem!,
//         selectedContainer: _selectedContainer!,
//         itemCount: _itemCount!,
//         rent: double.parse(_rentController.text),
//       );
//       setState(() {
//         _items.add(newItem);
//       });
//       _resetFields();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Enter All fields")),
//       );
//     }
//   }

//   void _addAnotherItem() {
//     if (_formKey.currentState!.validate() &&
//         _selectedItem != null &&
//         _selectedContainer != null &&
//         _itemCount != null) {
//       final newItem = ItemModel(
//         name: _nameController.text,
//         selectedItem: _selectedItem!,
//         selectedContainer: _selectedContainer!,
//         itemCount: _itemCount!,
//         rent: double.parse(_rentController.text),
//       );
//       setState(() {
//         _items.add(newItem);
//       });
//       _resetFields(excludeName: true);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Enter All fields")),
//       );
//     }
//   }

//   void _resetFields({bool excludeName = false}) {
//     setState(() {
//       if (!excludeName) _nameController.clear();
//       _selectedItem = null;
//       _selectedContainer = null;
//       _itemCount = null;
//       _rateController.clear();
//       _percentageController.clear();
//       _rentController.clear();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusManager.instance.primaryFocus?.unfocus();
//       },
//       child: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Styling.primaryColor,
//             centerTitle: true,
//             title: Text(
//               AppLocalizations.of(context)!.createFromScratch,
//               style: const TextStyle(color: Colors.white),
//             ),
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ),
//           backgroundColor: Styling.backgroundColor,
//           body: Form(
//             key: _formKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 10.h),
//                   InputField(
//                     hint_text: AppLocalizations.of(context)!.enterUserName,
//                     currentNode: nameFocusNode,
//                     focusNode: nameFocusNode,
//                     nextNode: fruitFocusNode,
//                     controller: _nameController,
//                     obsecureText: false,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Enter name";
//                       }
//                       return null;
//                     },
//                   ),
//                   ContainerDropDown<String>(
//                     selectedItem: _selectedItem,
//                     onSelected: (value) {
//                       setState(() {
//                         _selectedItem = value;
//                       });
//                     },
//                     items: [
//                       AppLocalizations.of(context)!.apple,
//                       AppLocalizations.of(context)!.pear,
//                       AppLocalizations.of(context)!.grapes,
//                       AppLocalizations.of(context)!.carrot,
//                       AppLocalizations.of(context)!.potato,
//                       AppLocalizations.of(context)!.onion,
//                     ],
//                     hintText: AppLocalizations.of(context)!.selectItem,
//                     displayText: (value) => value,
//                   ),
//                   ContainerDropDown<String>(
//                     selectedItem: _selectedContainer,
//                     onSelected: (value) {
//                       setState(() {
//                         _selectedContainer = value;
//                       });
//                     },
//                     items: const ['Box', 'Bag', 'Crate'],
//                     hintText: AppLocalizations.of(context)!.selectContainer,
//                     displayText: (value) => value,
//                   ),
//                   ContainerDropDown<int>(
//                     selectedItem: _itemCount,
//                     onSelected: (value) {
//                       setState(() {
//                         _itemCount = value;
//                       });
//                     },
//                     items: const [2, 4, 6, 8, 10],
//                     hintText: AppLocalizations.of(context)!.itemCount,
//                     displayText: (value) => value.toString(),
//                   ),
//                   InputField(
//                     hint_text: AppLocalizations.of(context)!.itemRates,
//                     currentNode: rateFocusNode,
//                     focusNode: rateFocusNode,
//                     nextNode: percentageFocusNode,
//                     controller: _rateController,
//                     obsecureText: false,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Enter item rates";
//                       }
//                       return null;
//                     },
//                   ),
//                   InputField(
//                     hint_text: AppLocalizations.of(context)!.porterages,
//                     currentNode: percentageFocusNode,
//                     focusNode: percentageFocusNode,
//                     nextNode: rentFocusNode,
//                     controller: _percentageController,
//                     obsecureText: false,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Enter percentage";
//                       }
//                       return null;
//                     },
//                   ),
//                   InputField(
//                     hint_text: AppLocalizations.of(context)!.rent,
//                     currentNode: rentFocusNode,
//                     focusNode: rentFocusNode,
//                     nextNode: rentFocusNode,
//                     controller: _rentController,
//                     obsecureText: false,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Enter rent";
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 16.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       AuthButton(
//                         height: 56.h,
//                         fontsize: 20.sp,
//                         widht: 190.w,
//                         text: AppLocalizations.of(context)!.gENERATEBILL,
//                         func: () {
//                           FocusManager.instance.primaryFocus?.unfocus();
//                           _submitForm();
//                         },
//                         color: Styling.primaryColor,
//                       ),
//                       AuthButton(
//                         height: 56.h,
//                         widht: 150.w,
//                         fontsize: 16.sp,
//                         text: AppLocalizations.of(context)!.addAnotherItem,
//                         func: () {
//                           FocusManager.instance.primaryFocus?.unfocus();
//                           _addAnotherItem();
//                         },
//                         color: Styling.primaryColor,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20.h),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
