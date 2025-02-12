import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  final String date;
  @HiveField(2)
  String description;
  @HiveField(3)
  String image;
  @HiveField(4)
  String quantity;

  ProductModel({
    required this.name,
    required this.date,
    required this.description,
    required this.image,
    required this.quantity,
  });
}
