import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage/constants.dart';
import 'package:storage/logic/products/products_cubit.dart';
import 'package:storage/models/product_model.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 4,
          shadowColor: kLightColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.file(File(productModel.image)),
                ),
                Text(
                  productModel.name,
                  style: labelStyle.copyWith(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 50,
                  child: Text(
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    productModel.description,
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      productModel.quantity.toString() == '0'
                          ? 'غير متوفر'
                          : productModel.quantity.toString(),
                      style: TextStyle(
                          fontSize: 18,
                          color: productModel.quantity.toString() == '0'
                              ? Colors.red
                              : kLightColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      ' : الكمية',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 8,
          top: 8,
          child: Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit, color: kLightColor),
              ),
              IconButton(
                onPressed: () async {
                  await productModel.delete();
                  BlocProvider.of<ProductsCubit>(context).getProducts();
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
