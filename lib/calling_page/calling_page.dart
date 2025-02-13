import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:demo_agora/calling_page/calling_controller/calling_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallingPage extends StatelessWidget {
  CallingPage({super.key});

  final CallingController controller = Get.put(CallingController());

  @override
  Widget build(BuildContext context) {
    // return GetBuilder<CallingController>(builder: (controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Video Call'),
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(child: Obx(() {
                debugPrint("checkVideoController:- ${controller.localUserJoined.value}");
                return controller.localUserJoined.value
                    ? AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: controller.engine!,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      )
                    : const SizedBox();
              })),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 70,
            child: GestureDetector(
              onTap: (){
                controller.joinChannel();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(100)),
                padding: EdgeInsets.all(7),
                child: Icon(
                  Icons.call,
                  color: Colors.white,
                  size: 48,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 70,
            child: GestureDetector(
              onTap: (){
                controller.leaveChannel();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100)),
                padding: EdgeInsets.all(7),
                child: Icon(
                  Icons.call_end,
                  color: Colors.white,
                  size: 48,
                ),
              ),
            ),
          )
        ],
      ),
    );
    // });
  }

  // Widget to display remote video
  Widget _remoteVideo() {
    return Obx(() {
      final remoteUid = controller.remoteUid.value; // capture the observable

      debugPrint("remoteUidOBX-> ${remoteUid}");
      if (controller.engine != null && controller.remoteUid.value != 0 && controller.remoteUid.value!=null) {
        return AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine: controller.engine!,
            canvas: VideoCanvas(uid: controller.remoteUid.value),
            connection: RtcConnection(channelId: controller.channel),
          ),
        );
      } else {
        return Text(
          'Please wait for remote user to join (remoteUid: $remoteUid)',
          textAlign: TextAlign.center,
        );
      }
    });

    // GetBuilder<CallingController>(
    //   builder: (controller) {
    //
    //   },
    // );
  }
}
