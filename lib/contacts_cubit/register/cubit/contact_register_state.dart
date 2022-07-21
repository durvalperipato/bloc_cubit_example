part of 'contact_register_cubit.dart';

@freezed
class ContactRegisterCubitState with _$ContactRegisterCubitState {
  factory ContactRegisterCubitState.initial() = _Initial;
  factory ContactRegisterCubitState.loading() = _Loading;
  factory ContactRegisterCubitState.success() = _Success;
  factory ContactRegisterCubitState.create(
      {required String name, required String email}) = _Create;
  factory ContactRegisterCubitState.error({required String message}) = _Error;
}
