part of 'add_product_cubit.dart';

@freezed
class AddProductState with _$AddProductState {
  const factory AddProductState.initial() = _Initial;
  const factory AddProductState.loading() = _Loading;
  const factory AddProductState.loaded(ProductResponseModel model) = _Loaded;
  const factory AddProductState.error(String message) = _error;
}
