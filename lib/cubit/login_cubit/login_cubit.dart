import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/datasources/auth_datasource.dart';
import '../../data/models/request/login_request_model.dart';
import '../../data/models/response/login_response_model.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
   final AuthDatasource datasource;
  LoginCubit
  (
    this.datasource
  ) : super(LoginState.initial());

  void login(LoginRequestModel model)async{
     emit(_Loading());
      final result = await datasource.login(model);
      result.fold(
        (error) => emit(_Error( error)),
        (data) => emit(_Loaded( data)),
      );
  }
}
