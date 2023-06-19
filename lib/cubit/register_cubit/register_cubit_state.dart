part of 'register_cubit_cubit.dart';

@freezed
class RegisterCubitState with _$RegisterCubitState {
  const factory RegisterCubitState.initial() = _Initial;
  const factory RegisterCubitState.loading() = _Loading;
  const factory RegisterCubitState.loaded(RegisterResponseModel model) = _Loaded;
  const factory RegisterCubitState.error( String message) = _Error;
}
