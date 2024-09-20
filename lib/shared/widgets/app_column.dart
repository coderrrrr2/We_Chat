import 'package:flutter/material.dart';
import 'package:practice_chat_app/shared/utils/app_color.dart';

class AppColumn extends StatefulWidget {
  final bool isScrollable;
  final bool resizeToAvoidBottomInset;

  final bool isLoading;
  final EdgeInsetsGeometry? padding;
  final List<Widget> children;

  const AppColumn({
    super.key,
    this.isScrollable = false,
    required this.children,
    this.isLoading = false,
    this.resizeToAvoidBottomInset = true,
    this.padding,
  });

  @override
  State<AppColumn> createState() => _AppColumnState();
}

class _AppColumnState extends State<AppColumn> {
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
          widget.isScrollable
              ? Scaffold(
                  resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
                  body: SafeArea(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: widget.padding ??
                          const EdgeInsets.symmetric(horizontal: 20)
                              .copyWith(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.children,
                      ),
                    ),
                  ),
                )
              : Scaffold(
                  resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
                  body: SafeArea(
                    child: Padding(
                      padding: widget.padding ??
                          const EdgeInsets.symmetric(horizontal: 20)
                              .copyWith(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.children,
                      ),
                    ),
                  ),
                ),
          // Loading indicator overlay
          if (widget.isLoading)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: const Center(
                child: CircularProgressIndicator(
                  color: whiteColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
