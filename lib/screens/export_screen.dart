import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage/constants.dart';
import 'package:storage/logic/products/products_cubit.dart';
import 'package:storage/models/product_model.dart';
import 'package:storage/widgets/custom_text_form_field.dart';
import 'package:storage/widgets/export_product_widget.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  late List<ProductModel> products;

  late List<ProductModel> filteredProducts;
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProductsCubit>(context).getProducts();
    products = BlocProvider.of<ProductsCubit>(context).products;
    filteredProducts = products;
    // Adding listener
    searchController.addListener(filterProducts);
  }

  // @override
  // void dispose() {
  //   // Removing listener before disposing the controller
  //   searchController.removeListener(filterProducts);
  //   searchController.dispose();
  //   super.dispose();
  // }

  void filterProducts() {
    final query = searchController.text;

    if (mounted) {
      BlocProvider.of<ProductsCubit>(context).getfilteredProducts(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          buildAppBar(context, 'الصادرات', 'assets/images/exports.png', true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 3,
                    child: CustomTextFormField(
                      hintText: 'قم بالبحث عن اسم المنتج',
                      textInputType: TextInputType.text,
                      suffixIcon: const Icon(Icons.search),
                      controller: searchController,
                      onSaved: (value) {},
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoading) {
                    return Center(
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width / 3,
                        child:
                            const LinearProgressIndicator(color: kLightColor),
                      ),
                    );
                  } else if (state is ProductsEmpty) {
                    return Center(
                      child: Text(
                        'لا يوجد منتجات',
                        style: labelStyle.copyWith(color: kLightColor),
                      ),
                    );
                  } else if (state is ProductsLoaded) {
                    filteredProducts = state.products;
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) => ExportProductWidget(
                          productModel: filteredProducts[index]),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'حدث خطأ في تحميل المنتجات',
                        style: labelStyle.copyWith(color: Colors.red),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
