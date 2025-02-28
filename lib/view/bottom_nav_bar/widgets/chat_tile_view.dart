import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';

class ChatTileView extends StatelessWidget {
  const ChatTileView({super.key, required this.data});
  final data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      leading: CircleAvatar(
        radius: 35,
        backgroundImage: NetworkImage(data['image']),
      ),
      title: Text(
        data['name'],
        style: AppFontStyle.heading4.copyWith(fontSize: 18),
      ),
      subtitle: Row(children: [
        Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
          child: Text(
            "${data['msg']}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppFontStyle.blackRegular14pt,
          ),
        ),
        Expanded(
          child: Container(
              child: Text(
            " • 27m",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppFontStyle.blackRegular14pt,
          )),
        ),
      ]),
    );
  }
}
