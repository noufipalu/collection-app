import 'package:collection_app/helper/responsive_helper.dart';
import 'package:collection_app/models/collectionModel.dart';
import 'package:collection_app/models/productModel.dart';
import 'package:collection_app/pages/collection_card.dart';
import 'package:flutter/material.dart';

class ProductCollectionsScreen extends StatefulWidget {
  const ProductCollectionsScreen({super.key});

  @override
  State<ProductCollectionsScreen> createState() =>
      _ProductCollectionsScreenState();
}

class _ProductCollectionsScreenState extends State<ProductCollectionsScreen> {
  int? expandedIndex;

  final List<CollectionModel> collections = [
    CollectionModel(
      id: 1,
      title: 'Collection 1',
      products: List.generate(
        8,
        (index) => ProductModel(
          id: index,
          imageUrl: 'https://picsum.photos/200/200?random=$index',
        ),
      ),
    ),
    CollectionModel(
      id: 2,
      title: 'Collection 2',
      products: List.generate(
        6,
        (index) => ProductModel(
          id: index + 10,
          imageUrl: 'https://picsum.photos/200/200?random=${index + 10}',
        ),
      ),
    ),
    CollectionModel(
      id: 3,
      title: 'Collection 3',
      products: List.generate(
        10,
        (index) => ProductModel(
          id: index + 20,
          imageUrl: 'https://picsum.photos/200/200?random=${index + 20}',
        ),
      ),
    ),
    CollectionModel(
      id: 4,
      title: 'Collection 4',
      products: List.generate(
        5,
        (index) => ProductModel(
          id: index + 30,
          imageUrl: 'https://picsum.photos/200/200?random=${index + 30}',
        ),
      ),
    ),
    CollectionModel(
      id: 5,
      title: 'Collection 5',
      products: List.generate(
        12,
        (index) => ProductModel(
          id: index + 40,
          imageUrl: 'https://picsum.photos/200/200?random=${index + 40}',
        ),
      ),
    ),
  ];

  void toggleExpand(int index) {
    setState(() {
      if (expandedIndex == index) {
        expandedIndex = null;
      } else {
        expandedIndex = index;
      }
    });
  }

  void isClicked() {
    print("Back Button CLicked..");
  }

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveHelper.getResponsivePadding(context);
    final isDesktopOrTablet = !ResponsiveHelper.isMobile(context);
    final columns = ResponsiveHelper.getListColumns(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          onPressed: isClicked,
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'Collections',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (columns == 1) {
            return ListView.builder(
              padding: EdgeInsets.all(padding),
              itemCount: collections.length,
              itemBuilder: (context, index) {
                final collection = collections[index];
                final isExpanded = expandedIndex == index;

                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: ResponsiveHelper.getCardMaxWidth(context),
                    ),
                    child: CollectionCard(
                      collection: collection,
                      isExpanded: isExpanded,
                      onTap: () => toggleExpand(index),
                    ),
                  ),
                );
              },
            );
          } else {
            return GridView.builder(
              padding: EdgeInsets.all(padding),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: padding,
                mainAxisSpacing: padding,
                childAspectRatio: 3.5,
              ),
              itemCount: collections.length,
              itemBuilder: (context, index) {
                final collection = collections[index];
                final isExpanded = expandedIndex == index;

                return CollectionCard(
                  collection: collection,
                  isExpanded: isExpanded,
                  onTap: () => toggleExpand(index),
                );
              },
            );
          }
        },
      ),
    );
  }
}
