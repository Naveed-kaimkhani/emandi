// import 'package:e_mandi/domain/repositories/item_repository.dart';
// import 'package:e_mandi/domain/entities/item_model.dart';
// import 'package:e_mandi/presentation/initial/container_dropdown.dart';
// import 'package:e_mandi/presentation/widgets/auth_button.dart';
// import 'package:e_mandi/presentation/widgets/input_field.dart';
// import 'package:e_mandi/utils/Dialogues/item_added_popup.dart';
// import 'package:e_mandi/utils/custom_loader.dart';
// import 'package:e_mandi/utils/routes/routes_name.dart';
// import 'package:e_mandi/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../style/styling.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;

// class InitialScreen extends StatefulWidget {
//   final ItemRepository itemRepository;

//   const InitialScreen({super.key, required this.itemRepository});

//   @override
//   State<InitialScreen> createState() => _InitialScreenState();
// }

// class _InitialScreenState extends State<InitialScreen> {
//   final _formKey = GlobalKey<FormState>();

//   // final stt.SpeechToText _speech = stt.SpeechToText();
//   bool _isListening = false;
//   stt.SpeechToText? _speech;
//   bool _isSpeechInitialized = false;

//   bool _isLoading = false;
//   FocusNode nameFocusNode = FocusNode();
//   FocusNode rentFocusNode = FocusNode();

//   FocusNode itemCountFocusNode = FocusNode();

//   FocusNode portFocusNode = FocusNode();

//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _rentController = TextEditingController();
//   final TextEditingController _itemCountController = TextEditingController();
//   final TextEditingController _portController = TextEditingController();

//   String? _selectedItem;
//   String? _selectedContainer;
//   String? _userName; // Store the user's name

//   void _listen() async {
//     if (!_isListening) {
//       setState(() => _isLoading = true);
//       bool available = await _speech!.initialize(
//         onStatus: (val) => print("Status: $val"),
//         // onError: (val) => print("Error initializing speech recognition"),

//         onError: (val) => print(val.toString()),
//       );
//       setState(() => _isLoading = false);

//       if (available) {
//         setState(() => _isListening = true);
//         _speech!.listen(
//             onResult: (val) => setState(() {
//                   _nameController.text = val.recognizedWords;
//                   // _score = _calculateScore(_recognizedText, widget.targetWord);
//                   print(val.recognizedWords);
//                 }));
//       }
//     } else {
//       setState(() => _isListening = false);
//       _speech!.stop();
//     }
//   }

// // @override
// // void initState() {
// //   super.initState();
// //   if (!_isSpeechInitialized) {
// //     _initializeSpeech();
// //   }
// // }
//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _rentController.dispose();
//     nameFocusNode.dispose();
//     rentFocusNode.dispose();
//     // _speech.stop();
//     super.dispose();
//   }

//   void _addItem() async {
//     if (_formKey.currentState!.validate() &&
//         _selectedItem != null &&
//         _selectedContainer != null) {
//       // Store the user name on the first addition if it's not already stored
//       _userName ??= _nameController.text;

//       final billing = ItemModel(
//         name: _userName!, // Use stored user name
//         selectedItem: _selectedItem!,
//         selectedContainer: _selectedContainer!,
//         itemCount: int.parse(_itemCountController.text),
//         rent: double.parse(_rentController.text),
//         portrages: int.parse(_portController.text),
//       );

//       LoaderOverlay.show(context);
//       await widget.itemRepository.addItem(billing);
//       LoaderOverlay.hide();
//       itemAddedDialog(context, AppLocalizations.of(context)!.itemAddedSucc);
//     } else {
//       utils.flushBarErrorMessage(
//           AppLocalizations.of(context)!.enterAllDetail, context);
//     }
//   }

//   void _resetItemFields() {
//     _rentController.clear();
//     _itemCountController.clear();
//     setState(() {
//       _selectedItem = null;
//       _selectedContainer = null;
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
//               AppLocalizations.of(context)!.iNITIAL,
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
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // SizedBox(height: 60.h),

//                   // Show name input only if no user name is stored yet
//                   if (_userName == null)
//                     InputField(
//                       hint_text: AppLocalizations.of(context)!.enterUserName,
//                       currentNode: nameFocusNode,
//                       focusNode: nameFocusNode,
//                       nextNode: rentFocusNode,
//                       controller: _nameController,
//                       obsecureText: false,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return AppLocalizations.of(context)!.enterUserName;
//                         }
//                         return null;
//                       },
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _isListening ? Icons.mic : Icons.mic_none,
//                           color: _isListening ? Colors.red : Colors.grey,
//                         ),
//                         onPressed: _listen, // Trigger listening
//                       ),
//                     ),

// // ContainerDropDown<String>(
// //   selectedItem: _selectedItem,
// //   onSelected: (value) {
// //     setState(() {
// //       _selectedItem = value;
// //     });
// //   },
// //   items: categorizedItems.entries
// //       .expand((entry) {
// //         return [
// //           // Add a category heading (non-selectable)
// //           DropdownMenuItem<String>(
// //             value: null,
// //             enabled: false,
// //             child: Text(
// //               entry.key, // Category name (e.g., "Fruits" or "Vegetables")
// //               style: TextStyle(
// //                 fontWeight: FontWeight.bold,
// //                 color: Colors.grey,
// //               ),
// //             ),
// //           ),
// //           // Add the items under this category
// //           ...entry.value.map((item) => DropdownMenuItem<String>(
// //                 value: item,
// //                 child: Text(item),
// //               )),
// //         ];
// //       })
// //       .toList(),
// //   hintText: AppLocalizations.of(context)!.itemName,
// //   // displayText: (value) => value,
// // ),

//                   ContainerDropDown<String>(
//                     selectedItem: _selectedContainer,
//                     onSelected: (value) {
//                       setState(() {
//                         _selectedContainer = value;
//                       });
//                     },
//                     items: containers.entries.expand((entry) {
//                       return [
//                         // Add a category heading (non-selectable)
//                         DropdownMenuItem<String>(
//                           value: null,
//                           enabled: false,
//                           child: Text(
//                             entry
//                                 .key, // Category name (e.g., "Fruits" or "Vegetables")
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ),
//                         // Add the items under this category
//                         ...entry.value.map((item) => DropdownMenuItem<String>(
//                               value: item,
//                               child: Text(item),
//                             )),
//                       ];
//                     }).toList(),
//                     hintText: AppLocalizations.of(context)!.itemContainer,
//                     // displayText: (value) => value,
//                   ),

//                   // // Item selection
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
//                     hintText: AppLocalizations.of(context)!.itemName,
//                     displayText: (value) => value,
//                   ),
//                   ContainerDropDown<String>(
//                     selectedItem: _selectedItem,
//                     onSelected: (value) {
//                       setState(() {
//                         _selectedItem = value;
//                       });
//                     },
//                     items: [
//                       AppLocalizations.of(context)!.box,
//                       AppLocalizations.of(context)!.bag,
//                       AppLocalizations.of(context)!.crate,
//                     ],
//                     hintText: AppLocalizations.of(context)!.itemName,
//                     displayText: (value) => value,
//                   ),
//                   // Item count input
//                   InputField(
//                     hint_text: AppLocalizations.of(context)!.itemCount,
//                     currentNode: itemCountFocusNode,
//                     focusNode: itemCountFocusNode,
//                     nextNode: rentFocusNode,
//                     controller: _itemCountController,
//                     keyboardType: TextInputType.number,
//                     obsecureText: false,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return AppLocalizations.of(context)!.itemCount;
//                       } else {
//                         return null;
//                       }
//                     },
//                   ),

//                   // Rent input
//                   InputField(
//                     hint_text: AppLocalizations.of(context)!.rent,
//                     currentNode: rentFocusNode,
//                     focusNode: rentFocusNode,
//                     nextNode: portFocusNode,
//                     controller: _rentController,
//                     keyboardType: TextInputType.number,
//                     obsecureText: false,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return AppLocalizations.of(context)!.enterRent;
//                       } else {
//                         return null;
//                       }
//                     },
//                   ),

//                   // Portrages input
//                   InputField(
//                     hint_text: AppLocalizations.of(context)!.porterages,
//                     currentNode: portFocusNode,
//                     focusNode: portFocusNode,
//                     nextNode: portFocusNode,
//                     controller: _portController,
//                     keyboardType: TextInputType.number,
//                     obsecureText: false,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return AppLocalizations.of(context)!.porterages;
//                       } else {
//                         return null;
//                       }
//                     },
//                   ),

//                   SizedBox(height: 30.h),

//                   // Buttons for submitting and adding new item
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       AuthButton(
//                         height: 56.h,
//                         widht: 110.w,
//                         fontsize: 20.sp,
//                         text: AppLocalizations.of(context)!.submit,
//                         func: () {
//                           FocusManager.instance.primaryFocus?.unfocus();
//                           _addItem();
//                         },
//                         color: Styling.primaryColor,
//                       ),
//                       AuthButton(
//                         fontsize: 20.sp,
//                         height: 56.h,
//                         widht: 110.w,
//                         text: "Add New",
//                         func: () {
//                           FocusManager.instance.primaryFocus?.unfocus();
//                           _addItem();
//                           _resetItemFields(); // Reset fields but keep user name
//                         },
//                         color: Styling.primaryColor,
//                       ),
//                     ],
//                   ),

//                   SizedBox(height: 10.h),

//                   AuthButton(
//                     fontsize: 20.sp,
//                     height: 56.h,
//                     widht: 200.w,
//                     text: AppLocalizations.of(context)!.viewList,
//                     func: () {
//                       Navigator.pushNamed(context, RoutesName.initialList);
//                     },
//                     color: Styling.primaryColor,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:e_mandi/domain/repositories/item_repository.dart';
import 'package:e_mandi/domain/entities/item_model.dart';
import 'package:e_mandi/presentation/initial/container_dropdown.dart';
import 'package:e_mandi/presentation/widgets/add_new_item_button.dart';
import 'package:e_mandi/presentation/widgets/auth_button.dart';
import 'package:e_mandi/presentation/widgets/input_field.dart';
import 'package:e_mandi/presentation/widgets/multi_level_list.dart';
import 'package:e_mandi/utils/Dialogues/item_added_popup.dart';
import 'package:e_mandi/utils/custom_loader.dart';
import 'package:e_mandi/utils/routes/routes_name.dart';
import 'package:e_mandi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_speech/flutter_speech.dart'; // Import flutter_speech

import '../../style/styling.dart';

class InitialScreen extends StatefulWidget {
  final ItemRepository itemRepository;

  const InitialScreen({super.key, required this.itemRepository});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final _formKey = GlobalKey<FormState>();

  FocusNode nameFocusNode = FocusNode();
  FocusNode rentFocusNode = FocusNode();
  FocusNode itemCountFocusNode = FocusNode();
  FocusNode portFocusNode = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rentController = TextEditingController();
  final TextEditingController _itemCountController = TextEditingController();
  final TextEditingController _portController = TextEditingController();

  String? _selectedItem;
  String? _selectedContainer;
  String? _userName; // Store the user's name

  late SpeechRecognition _speechRecognition;
  bool _isListening = false;
  bool _isSpeechAvailable = false;

  @override
  void dispose() {
    _nameController.dispose();
    _rentController.dispose();
    nameFocusNode.dispose();
    rentFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeSpeechRecognizer();
  }

  void _initializeSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();
    _speechRecognition.setAvailabilityHandler((bool result) {
      setState(() {
        _isSpeechAvailable = result;
      });
    });

    _speechRecognition.setRecognitionStartedHandler(() {
      setState(() {
        _isListening = true;
      });
    });

    _speechRecognition.setRecognitionResultHandler((String speech) {
      setState(() {
        _nameController.text = speech;
      });
    });

    _speechRecognition.setRecognitionCompleteHandler((String result) {
  setState(() {
    _isListening = false;
    // Optionally handle the final result if needed
    print("Recognition completed with result: $result");
  });
});

    _speechRecognition.activate('en_US').then((_) {
      setState(() {
        _isSpeechAvailable = true;
      });
    });
  }

  void _startListening() {
    if (_isSpeechAvailable && !_isListening) {
      _speechRecognition.listen().then((_) {
        setState(() {
          _isListening = true;
        });
      });
    }
  }

  void _stopListening() {
    if (_isListening) {
      _speechRecognition.stop().then((_) {
        setState(() {
          _isListening = false;
        });
      });
    }
  }

  void _addItem() async {
    if (_formKey.currentState!.validate() &&
        _selectedItem != null &&
        _selectedContainer != null) {
      _userName ??= _nameController.text;

      final billing = ItemModel(
        name: _userName!,
        selectedItem: _selectedItem!,
        selectedContainer: _selectedContainer!,
        itemCount: int.parse(_itemCountController.text),
        rent: double.parse(_rentController.text),
        portrages: int.parse(_portController.text),
      );

      LoaderOverlay.show(context);
      await widget.itemRepository.addItem(billing);
      LoaderOverlay.hide();
      itemAddedDialog(context, AppLocalizations.of(context)!.itemAddedSucc);
    } else {
      utils.flushBarErrorMessage(
          AppLocalizations.of(context)!.enterAllDetail, context);
    }
  }

  void _resetItemFields() {
    _rentController.clear();
    _itemCountController.clear();
    setState(() {
      _selectedItem = null;
      _selectedContainer = null;
    });
  }

  @override
  Widget build(BuildContext context) {
      Map<String, List<String>> categorizedItems = {
  "fruits": [
    AppLocalizations.of(context)!.apple,
    AppLocalizations.of(context)!.pear,
    AppLocalizations.of(context)!.grapes,
    AppLocalizations.of(context)!.banana,
    AppLocalizations.of(context)!.mango,
    AppLocalizations.of(context)!.orange,
    AppLocalizations.of(context)!.pomegranate,
    AppLocalizations.of(context)!.watermelon,
    AppLocalizations.of(context)!.melon,
    AppLocalizations.of(context)!.guava,
    AppLocalizations.of(context)!.papaya,
    AppLocalizations.of(context)!.peach,
    AppLocalizations.of(context)!.plum,
    AppLocalizations.of(context)!.apricot,
    AppLocalizations.of(context)!.cherry,
    AppLocalizations.of(context)!.strawberry,
    AppLocalizations.of(context)!.fig,
    AppLocalizations.of(context)!.date,
    AppLocalizations.of(context)!.lemon,
    AppLocalizations.of(context)!.lime,
    AppLocalizations.of(context)!.lychee,
    AppLocalizations.of(context)!.mulberry,
    AppLocalizations.of(context)!.pineapple
  ],
  AppLocalizations.of(context)!.vegetables: [
    AppLocalizations.of(context)!.carrot,
    AppLocalizations.of(context)!.potato,
    AppLocalizations.of(context)!.onion,
    AppLocalizations.of(context)!.spinach,
    AppLocalizations.of(context)!.cabbage,
    AppLocalizations.of(context)!.cauliflower,
    AppLocalizations.of(context)!.okra,
    AppLocalizations.of(context)!.eggplant,
    AppLocalizations.of(context)!.peas,
    AppLocalizations.of(context)!.tomato,
    AppLocalizations.of(context)!.radish,
    AppLocalizations.of(context)!.turnip,
    AppLocalizations.of(context)!.bitterGourd,
    AppLocalizations.of(context)!.bottleGourd,
    AppLocalizations.of(context)!.pumpkin,
    AppLocalizations.of(context)!.zucchini,
    AppLocalizations.of(context)!.cucumber,
    AppLocalizations.of(context)!.garlic,
    AppLocalizations.of(context)!.ginger,
    AppLocalizations.of(context)!.bellPepper,
    AppLocalizations.of(context)!.greenChili,
    AppLocalizations.of(context)!.fenugreek,
    AppLocalizations.of(context)!.lettuce
  ]
};
     Map<String, List<String>> containerItems = {
    "container": [
      AppLocalizations.of(context)!.bag,
      AppLocalizations.of(context)!.box,
      AppLocalizations.of(context)!.crate,
    ],
    
  };
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Styling.primaryColor,
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.iNITIAL,
              style: const TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          backgroundColor: Styling.backgroundColor,
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_userName == null)
                    InputField(
                      hint_text: AppLocalizations.of(context)!.enterUserName,
                      currentNode: nameFocusNode,
                      focusNode: nameFocusNode,
                      nextNode: rentFocusNode,
                      controller: _nameController,
                      obsecureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.enterUserName;
                        } else {
                          return null;
                        }
                      },
                      suffixIcon: GestureDetector(
                        onTap: _isListening ? _stopListening : _startListening,
                        child: Icon(
                          _isListening ? Icons.mic : Icons.mic_none,
                          color: _isListening ? Colors.red : Colors.grey,
                        ),
                      ),
                    ),
                  // Additional widgets remain unchanged
                  
MultiLevelList<String>(
  selectedItem: _selectedItem,
  onSelected: (value) {
    setState(() {
      _selectedItem = value;
    });
  },
  items: categorizedItems.entries
      .expand((entry) {
        return [
          // Add a category heading (non-selectable)
          DropdownMenuItem<String>(
            value: null,
            enabled: false,
            child: Text(
              entry.key, // Category name (e.g., "Fruits" or "Vegetables")
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          // Add the items under this category
          ...entry.value.map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              
              )),
        ];
      })
      .toList(),
  hintText: AppLocalizations.of(context)!.itemName,
  // displayText: (value) => value,
),

                  MultiLevelList<String>(
                    selectedItem: _selectedContainer,
                    onSelected: (value) {
                      setState(() {
                        _selectedContainer = value;
                      });
                    },
                    items: containerItems.entries.expand((entry) {
                      return [
                        // Add a category heading (non-selectable)
                        DropdownMenuItem<String>(
                          value: null,
                          enabled: false,
                          child: Text(
                            entry
                                .key, // Category name (e.g., "Fruits" or "Vegetables")
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        // Add the items under this category
                        ...entry.value.map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            )),
                      ];
                    }).toList(),
                    hintText: AppLocalizations.of(context)!.itemContainer,
                    // displayText: (value) => value,
                  ),

                 
                  InputField(
                    hint_text: AppLocalizations.of(context)!.itemCount,
                    currentNode: itemCountFocusNode,
                    focusNode: itemCountFocusNode,
                    nextNode: rentFocusNode,
                    controller: _itemCountController,
                    keyboardType: TextInputType.number,
                    obsecureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.itemCount;
                      } else {
                        return null;
                      }
                    },
                  ),

                  // Rent input
                  InputField(
                    hint_text: AppLocalizations.of(context)!.rent,
                    currentNode: rentFocusNode,
                    focusNode: rentFocusNode,
                    nextNode: portFocusNode,
                    controller: _rentController,
                    keyboardType: TextInputType.number,
                    obsecureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.enterRent;
                      } else {
                        return null;
                      }
                    },
                  ),

                  // Portrages input
                  InputField(
                    hint_text: AppLocalizations.of(context)!.porterages,
                    currentNode: portFocusNode,
                    focusNode: portFocusNode,
                    nextNode: portFocusNode,
                    controller: _portController,
                    keyboardType: TextInputType.number,
                    obsecureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.porterages;
                      } else {
                        return null;
                      }
                    },
                  ),

                  SizedBox(height: 30.h),

                  // Buttons for submitting and adding new item
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AuthButton(
                        height: 56.h,
                        widht: 110.w,
                        fontsize: 20.sp,
                        text: AppLocalizations.of(context)!.submit,
                        func: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          _addItem();
                        },
                        color: Styling.primaryColor,
                      ),
                      AuthButton(
                        fontsize: 20.sp,
                        height: 56.h,
                        widht: 110.w,
                        text: "Add New",
                        func: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          _addItem();
                          _resetItemFields(); // Reset fields but keep user name
                        },
                        color: Styling.primaryColor,
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  AuthButton(
                    fontsize: 20.sp,
                    height: 56.h,
                    widht: 200.w,
                    text: AppLocalizations.of(context)!.viewList,
                    func: () {
                      Navigator.pushNamed(context, RoutesName.initialList);
                    },
                    color: Styling.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContainerDropDown<T> extends StatelessWidget {
  final T? selectedItem;
  final ValueChanged<T?> onSelected;
  final List<DropdownMenuItem<T>> items; // Accept DropdownMenuItems
  final String hintText;

  const ContainerDropDown({
    Key? key,
    required this.selectedItem,
    required this.onSelected,
    required this.items,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: selectedItem,
      onChanged: onSelected,
      items: items,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}