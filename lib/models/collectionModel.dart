import 'productModel.dart';

class CollectionModel {
  final int id;
  final String title;
  final List<ProductModel> products;

  CollectionModel({
    required this.id,
    required this.title,
    required this.products,
  });
}
