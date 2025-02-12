part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoaded extends ProductsState {
  final List<ProductModel> products;
  ProductsLoaded({required this.products});
}

final class ProductsError extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsEmpty extends ProductsState {}
