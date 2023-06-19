import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/datasources/product_datasource.dart';
import '../../data/models/response/product_response_model.dart';

part 'product_state.dart';
part 'product_cubit.freezed.dart';

class ProductCubit extends Cubit<ProductState> {
   final ProductDataSource dataSource;
  ProductCubit(
    this.dataSource
  ) : super(ProductState.initial());

  void getProduct() async{
      emit(_Loading());
      final result =
          await dataSource.getPaginationProduct(offset: 0, limit: 50);
      result.fold(
        (error) => emit(_Error( message: error)),
        (result) {
          bool isNext = result.length == 50;
          emit(_Loaded(data: result,isNext: isNext));
        },
      );
  }

  void nextProduct()async{
     final currentState = state as _Loaded;
      final result = await dataSource.getPaginationProduct(
          offset: currentState.offset + 50, limit: 50);
      result.fold(
        (error) => emit(_Error(message: error)),
        (result) {
          bool isNext = result.length == 50;
          // emit(ProductsLoaded(
          //     data: [...currentState.data, ...result],
          //     offset: currentState.offset + 50,
          //     isNext: isNext));
          emit(currentState.copyWith(
              data: [...currentState.data, ...result],
              offset: currentState.offset + 50,
              isNext: isNext));
        },
      );
  }
void addSingleProduct(ProductResponseModel model) async{

   final currentState = state as _Loaded;

      emit(currentState.copyWith(
        data: [...currentState.data, model],
      ));
}
void clearProduct()async{
  emit(_Initial());
}

}
