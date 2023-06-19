part of 'product_cubit.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = _Initial;
  const factory ProductState.loading() = _Loading;
  const factory ProductState.loaded({
    required List<ProductResponseModel> data,
    @Default(0) int offset,
    @Default(50) int limit,
    @Default(false) bool isNext,
  }) = _Loaded;
  const factory ProductState.error({String? message}) = _Error;
}