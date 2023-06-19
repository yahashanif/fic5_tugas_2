part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.loaded(LoginResponseModel model) = _Loaded;
  const factory LoginState.error( String message) = _Error;
}
