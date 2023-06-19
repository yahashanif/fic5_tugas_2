import 'package:bloc/bloc.dart';
import 'package:flutter_ecatalog/data/models/request/product_request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/datasources/product_datasource.dart';
import '../../data/models/response/product_response_model.dart';

part 'add_product_state.dart';
part 'add_product_cubit.freezed.dart';

class AddProductCubit extends Cubit<AddProductState> {
   final ProductDataSource dataSource;
  AddProductCubit(
     this.dataSource,
  ) : super(AddProductState.initial());
void addProduct(ProductRequestModel model) async{
    emit(_Loading());
      final result = await dataSource.createProduct(model);
      result.fold(
        (error) => emit(_error( error)),
        (data) => emit(_Loaded( data)),
      );
}
}
