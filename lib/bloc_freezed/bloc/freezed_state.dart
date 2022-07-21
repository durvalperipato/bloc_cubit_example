part of 'freezed_bloc.dart';

@freezed
class FreezedState with _$FreezedState {
  factory FreezedState.initial() = _FreezedStateInitial;
  factory FreezedState.data({required List<String> names}) = _FreezedStateData;
  factory FreezedState.loading() = _FreezedStateLoading;
  factory FreezedState.showBanner(
      {required List<String> names,
      required String message}) = _FreezedStateShowBanner;
}
