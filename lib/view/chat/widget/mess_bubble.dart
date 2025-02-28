import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:intl/intl.dart';

class MessBubble extends StatefulWidget {
  const MessBubble(
      {super.key,
      this.isDeleted = false,
      this.isNotLast = true,
      this.isPaymentGreen = false,
      this.isSend = true,
      this.isTransparent = false,
      required this.child});
  final bool isSend;
  final bool isTransparent;
  final bool isPaymentGreen;
  final bool isNotLast;
  final bool isDeleted;
  final Widget child;

  @override
  State<MessBubble> createState() => _MessBubbleState();
}

class _MessBubbleState extends State<MessBubble> {
  String getDateByTimeStamp(timestamp) {
    final nowDate = DateTime.now();

    // final dateTime = timestamp == null
    //     ? nowDate
    //     : DateTime.fromMillisecondsSinceEpoch(timestamp);
    var time = DateFormat.jm().format(nowDate);
    return time.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment:
            widget.isSend ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.isTransparent
                  ? Colors.transparent
                  : widget.isPaymentGreen
                      ? AppColors.paymentGreen
                      : widget.isSend
                          ? AppColors.lightPink
                          : AppColors.greyCardBorder,
              borderRadius: widget.isNotLast
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )
                  : widget.isSend
                      ? const BorderRadius.only(
                          topLeft: const Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        )
                      : const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
            ),
            child: Column(
              children: [
                widget.isDeleted
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          widget.isSend
                              ? "You deleted this message"
                              : "This message was deleted",
                          style: AppFontStyle.blackRegular16pt
                              .copyWith(fontStyle: FontStyle.italic),
                        ),
                      )
                    : widget.child
              ],
            ),
          ),
          widget.isNotLast
              ? const SizedBox()
              : Text(
                  getDateByTimeStamp(DateTime.now()),
                  style: AppFontStyle.greyRegular12pt,
                )
        ],
      ),
    );
  }
}
