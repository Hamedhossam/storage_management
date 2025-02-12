import 'dart:io';

import 'package:flutter/material.dart';
import 'package:storage/constants.dart';
import 'package:storage/models/product_model.dart';

class ExportProductWidget extends StatelessWidget {
  const ExportProductWidget({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: kLightColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 90,
              width: 170,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: FileImage(
                    File(productModel.image),
                  ),
                ),
              ),
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
            productModel.quantity.toString() == '0'
                ? const Text(
                    'غير متوفر',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  )
                : IconButton(
                    style: ButtonStyle(
                      backgroundColor:
                          const WidgetStatePropertyAll(kLightColor),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18))),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return ExportProductBottomSheet(
                                productModel: productModel);
                          });
                    },
                    icon: Text(
                      'إضافة',
                      style: labelStyle.copyWith(fontSize: 16),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class ExportProductBottomSheet extends StatefulWidget {
  const ExportProductBottomSheet({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;

  @override
  State<ExportProductBottomSheet> createState() =>
      _ExportProductBottomSheetState();
}

class _ExportProductBottomSheetState extends State<ExportProductBottomSheet> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 120,
              width: 180,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fill,
                image: FileImage(File(widget.productModel.image)),
              )),
            ),
            Text(
              widget.productModel.name,
              style: labelStyle.copyWith(fontSize: 20),
            ),
            SizedBox(
              height: 50,
              child: Text(
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                widget.productModel.description,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(children: [
                  IconButton(
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.red,
                      size: 35,
                    ),
                    onPressed: () {
                      setState(() {
                        quantity > 0 ? quantity-- : quantity = 0;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(quantity.toString(),
                        style: labelStyle.copyWith(color: kLightColor)),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.green,
                      size: 35,
                    ),
                    onPressed: () {
                      setState(() {
                        quantity < int.parse(widget.productModel.quantity)
                            ? quantity++
                            : quantity =
                                int.parse(widget.productModel.quantity);
                      });
                    },
                  ),
                ]),
                Text(
                  'حدد الكمية',
                  style: labelStyle.copyWith(fontSize: 16),
                ),
              ],
            ),
            IconButton(
              style: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll(kLightColor),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
              ),
              onPressed: () async {
                widget.productModel.quantity =
                    (int.parse(widget.productModel.quantity) - quantity)
                        .toString();
                await widget.productModel.save();
                Navigator.pop(context);
              },
              icon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'تأكيد',
                  style: labelStyle.copyWith(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
