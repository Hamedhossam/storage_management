import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:storage/constants.dart';
import 'package:storage/models/product_model.dart';
import 'package:storage/widgets/custom_button.dart';
import 'package:storage/widgets/custom_text_form_field.dart';

class ImportsScreen extends StatefulWidget {
  const ImportsScreen({super.key});

  @override
  State<ImportsScreen> createState() => _ImportsScreenState();
}

class _ImportsScreenState extends State<ImportsScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  String? _imagePath;
  bool isLoading = false;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _imagePath =
            result.files.single.path; // Get the path of the selected image
      });
    }
  }

  void addProduct(ProductModel product, BuildContext context) async {
    try {
      var productsBox = Hive.box<ProductModel>("products_box");
      await productsBox.add(product);
      log("${product.name} has been added");
      await showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => const AlertDialog(
          icon: Icon(Icons.check, color: kLightColor, size: 30),
          content: Text('تمت اضافة العنصر بنجاح', style: labelStyle),
        ),
      );
      resetFields();
    } on Exception catch (e) {
      await showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => const AlertDialog(
          icon: Icon(Icons.error, color: Colors.red, size: 30),
          content: Text('حدث خطأ في اضافة العنصر', style: labelStyle),
        ),
      );
      log(e.toString());
    }
  }

  void resetFields() {
    setState(() {
      isLoading = false; // Reset loading state
      nameController.clear(); // Clear name field
      dateController.text =
          getFormattedDateTime(); // Reset date field to current date
      descriptionController.clear(); // Clear description field
      quantityController.clear(); // Clear quantity field
      _imagePath = null; // Reset image path
      formKey.currentState?.reset(); // Reset the form state
    });
  }

  String getFormattedDateTime() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd HH:mm a');
    return formatter.format(now);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateController.text = getFormattedDateTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          buildAppBar(context, 'الواردات', 'assets/images/imports.png', true),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 400,
              height: 450,
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text('إضافة عنصر جديد', style: labelStyle),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        hintText: 'اسم الوارد',
                        textInputType: TextInputType.text,
                        suffixIcon: const Icon(Icons.edit),
                        controller: nameController,
                        onSaved: (value) {},
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        hintText: 'التاريخ',
                        textInputType: TextInputType.text,
                        controller: dateController,
                        suffixIcon: const Icon(Icons.calendar_month),
                        onSaved: (value) {},
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        hintText: 'الوصف',
                        textInputType: TextInputType.text,
                        controller: descriptionController,
                        suffixIcon: const Icon(Icons.description),
                        onSaved: (value) {},
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        hintText: 'الكمية',
                        textInputType: TextInputType.number,
                        controller: quantityController,
                        suffixIcon: const Icon(Icons.numbers_sharp),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly, // Only accept digits
                        ],
                        onSaved: (value) {},
                      ),
                      const SizedBox(height: 10),
                      CustomizedButtonWithBorder(
                        tittle: 'حفظ',
                        isLoading: isLoading,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            setState(() {
                              isLoading = true;
                            });
                            addProduct(
                              ProductModel(
                                name: nameController.text,
                                date: dateController.text,
                                description: descriptionController.text,
                                image: _imagePath ??
                                    "D:/Programing/flutter/storage/assets/images/storage.png",
                                quantity: quantityController.text,
                              ),
                              context,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 400,
              width: 400,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: kLightColor, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Center(
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        _pickImage();
                      },
                      hoverColor: kLightColor,
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 270,
                          width: 270,
                          child: _imagePath != null
                              ? Image.file(File(_imagePath!))
                              : const Icon(Icons.upload, size: 200),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'رفع صورة',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
