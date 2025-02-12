import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:storage/models/product_model.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  List<ProductModel> products = [];

  void getProducts() async {
    products.clear();
    emit(ProductsLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      var productsBox = Hive.box<ProductModel>("products_box");
      products = productsBox.values.toList();
      (products.isEmpty)
          ? emit(ProductsEmpty())
          : emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(ProductsError());
      log(e.toString());
    }
  }

  void getfilteredProducts(String query) async {
    products.clear();
    emit(ProductsLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      var productsBox = Hive.box<ProductModel>("products_box");
      products = productsBox.values.toList();
      products =
          products.where((element) => element.name.contains(query)).toList();
      (products.isEmpty)
          ? emit(ProductsEmpty())
          : emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(ProductsError());
      log(e.toString());
    }
  }
}
