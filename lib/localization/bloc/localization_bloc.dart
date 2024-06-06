import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'localization_event.dart';
import 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(LocalizationState(locale: Locale('en'))) {
    on<SetLocale>((event, emit) {
      emit(LocalizationState(locale: event.locale));
    });
  }
}
