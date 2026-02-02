import 'package:collection_app/helper/responsive_helper.dart';
import 'package:collection_app/models/collectionModel.dart';
import 'package:flutter/material.dart';

class CollectionCard extends StatefulWidget {
  final CollectionModel collection;
  final bool isExpanded;
  final VoidCallback onTap;

  const CollectionCard({
    super.key,
    required this.collection,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  State<CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends State<CollectionCard> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final fontSize = isMobile ? 18.0 : 20.0;
    final imageHeight = isMobile ? 80.0 : 100.0;
    final visibleImages = 4;
    final remainingCount =
        widget.collection.products.length - _currentPage - visibleImages;
    final showRemainingCount = remainingCount > 0;

    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 16 : 0),
      child: Column(
        children: [
          // Main Header Card
          Material(
            color: const Color.fromARGB(170, 230, 229, 229),
            borderRadius: BorderRadius.circular(16),
            elevation: 2,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 16 : 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.collection.title,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      turns: widget.isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                        size: isMobile ? 28 : 32,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Expanded Content
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: widget.isExpanded
                ? GestureDetector(
                    onTap: widget.onTap, // Collapse on tap anywhere
                    child: Container(
                      margin: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(170, 230, 229, 229),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          // Scrollable Image List
                          NotificationListener<ScrollNotification>(
                            onNotification: (notification) {
                              if (notification is ScrollUpdateNotification) {
                                final scrollOffset =
                                    notification.metrics.pixels;
                                final imageSize = isMobile ? 100.0 : 120.0;
                                final spacing = 12.0;
                                final itemWidth = imageSize + spacing;
                                final currentIndex = (scrollOffset / itemWidth)
                                    .floor();
                                if (currentIndex != _currentPage &&
                                    currentIndex >= 0 &&
                                    currentIndex <
                                        widget.collection.products.length) {
                                  setState(() {
                                    _currentPage = currentIndex;
                                  });
                                }
                              }
                              return false;
                            },
                            child: Container(
                              height: isMobile ? 120 : 140,
                              padding: EdgeInsets.all(isMobile ? 12 : 16),
                              child: ListView.builder(
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.collection.products.length,
                                itemBuilder: (context, index) {
                                  final product =
                                      widget.collection.products[index];
                                  final imageSize = isMobile ? 100.0 : 120.0;
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      right:
                                          index <
                                              widget
                                                      .collection
                                                      .products
                                                      .length -
                                                  1
                                          ? 12
                                          : 0,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        product.imageUrl,
                                        fit: BoxFit.cover,
                                        width: imageSize,
                                        height: imageSize,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Container(
                                                width: imageSize,
                                                height: imageSize,
                                                color: Colors.grey[300],
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.image,
                                                    color: Colors.grey,
                                                    size: 48,
                                                  ),
                                                ),
                                              );
                                            },
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Container(
                                            width: imageSize,
                                            height: imageSize,
                                            color: const Color.fromARGB(
                                              170,
                                              230,
                                              229,
                                              229,
                                            ),
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                value:
                                                    loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                    : null,
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          // Remaining count badge - RIGHT CENTER with RECTANGULAR shape
                          if (showRemainingCount)
                            Positioned(
                              right: 12,
                              top: 0,
                              bottom: 0,
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      212,
                                      19,
                                      19,
                                      19,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      8,
                                    ), // Rectangular with slight rounding
                                  ),
                                  child: Text(
                                    '+$remainingCount',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
