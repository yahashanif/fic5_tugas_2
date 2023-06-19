import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/datasources/auth_datasource.dart';
import '../../data/models/request/register_request_model.dart';
import '../../data/models/response/register_response_model.dart';

part 'register_cubit_state.dart';
part 'register_cubit_cubit.freezed.dart';

class RegisterCubitCubit extends Cubit<RegisterCubitState> {
  final AuthDatasource datasource;
  RegisterCubitCubit(
    this.datasource
  ) : super(RegisterCubitState.initial());

  void register( RegisterRequestModel model) async{
      emit(_Loading());
      //kirim register request model -> data source, menunggu response
      final result = await datasource.register(model);
      result.fold(
        (error) {
          emit(_Error( error));
        },
        (data) {
          emit(_Loaded( data));
        },
      );
  }
}
