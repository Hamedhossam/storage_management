import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:storage/models/product_model.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());

  void addProduct(ProductModel product) async {
    emit(AddProductLoading());
    try {
      var productsBox = Hive.box<ProductModel>("products_box");
      await productsBox.add(product);
      emit(AddProductSuccess());
      log("${product.name} has been added");
      emit(AddProductInitial());
    } on Exception catch (e) {
      emit(AddProductError());
      log(e.toString());
    }
  }
}
