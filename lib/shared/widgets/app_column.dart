import 'package:flutter/material.dart';

class AppColumn extends StatelessWidget {
  final bool isScrollable;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;
  final List<Widget> children;

  const AppColumn({
    super.key,
    this.isScrollable = false,
    required this.children,
    this.isLoading = false,
    this.padding,
  });

  void removeFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        removeFocus(context);
      },
      child: Stack(
        children: [
          // Main content
          isScrollable
              ? SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: padding ??
                        const EdgeInsets.symmetric(horizontal: 20)
                            .copyWith(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: children,
                    ),
                  ),
                )
              : SafeArea(
                  child: Padding(
                    padding: padding ??
                        const EdgeInsets.symmetric(horizontal: 20)
                            .copyWith(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: children,
                    ),
                  ),
                ),
          // Loading indicator overlay
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
