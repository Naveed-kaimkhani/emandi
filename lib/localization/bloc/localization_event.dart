import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object> get props => [];
}

class SetLocale extends LocalizationEvent {
  final Locale locale;

  const SetLocale(this.locale);

  @override
  List<Object> get props => [locale];
}
