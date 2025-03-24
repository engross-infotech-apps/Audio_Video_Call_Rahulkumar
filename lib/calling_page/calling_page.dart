import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:demo_agora/calling_page/calling_controller/calling_controller.dart';
import 'package:demo_agora/helpers/app_colors.dart';
import 'package:demo_agora/helpers/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CallingPage extends StatelessWidget {
  CallingPage({super.key});

  final CallingController controller = Get.find<CallingController>();

  Widget showDisableBg() {
    return Container(
      decoration: BoxDecoration(gradient: callGradient),

      // image:
      //     DecorationImage(image: AssetImage("assets/img/back_call.png"))),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return GetBuilder<CallingController>(builder: (controller) {
    return Scaffold(
      // appBar: AppBar(
      //     // title: const Text('Agora Video Call'),
      //     ),
      body: Stack(
        children: [
          Center(
            child: Obx(() {
              return controller.localUserJoined.value
                  ? controller.isVideoCall.value
                      ? _remoteVideo(context)
                      : Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: showDisableBg(),
                            ),
                          ],
                        )
                  : SizedBox();
            }),
          ),

          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(child: Obx(() {
                debugPrint(
                    "checkVideoController:- ${controller.localUserJoined.value}");
                return controller.localUserJoined.value &&
                        controller.isVideoCall.value &&
                        controller.remoteUid.value != 0 &&
                        controller.remoteUid.value != null
                    ? localUserVideo()
                    : const SizedBox();
              })),
            ),
          ),

          //Join video channel
          Obx(() {
            return !controller.localUserJoined.value &&
                    (controller.remoteUid.value == null ||
                        controller.remoteUid.value == 0)
                ? Positioned(
                    bottom: 250,
                    right: 70,
                    child: GestureDetector(
                      onTap: () {
                        controller.joinVideoChannel();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(100)),
                        padding: EdgeInsets.all(7),
                        child: Row(
                          children: [
                            Text(
                              "Join video call channel",
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.call,
                              color: Colors.white,
                              size: 48,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox();
          }),

          //Join audio channel
          Obx(() {
            return !controller.localUserJoined.value &&
                    (controller.remoteUid.value == null ||
                        controller.remoteUid.value == 0)
                ? Positioned(
                    bottom: 390,
                    right: 70,
                    child: GestureDetector(
                      onTap: () {
                        controller.joinAudioChannel();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(100)),
                        padding: EdgeInsets.all(7),
                        child: Row(
                          children: [
                            Text(
                              "Join audio call channel",
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.call,
                              color: Colors.white,
                              size: 48,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox();
          }),

          //Call controls
          Obx(() {
            return controller.localUserJoined.value
                ? Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // controller.leaveChannel();
                      },
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(1),
                          width: MediaQuery.of(context).size.width / 100 * 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              color: Colors.transparent),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ///Audio controls
                              !controller.isVideoCall.value
                                  ? Container(
                                      height: 140,
                                      width: MediaQuery.of(context).size.width /
                                          100 *
                                          99.4,
                                      child: Padding(
                                        padding: EdgeInsets.all(18.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ///
                                            !controller.isVideoCall.value
                                                ? setupIcons(
                                                    controller.isSoundEnable.value
                                                        ? Icons.volume_up_rounded
                                                        : Icons
                                                            .volume_off_rounded,
                                                    AppColors.iconBg, () {
                                                    controller
                                                        .updateSoundSpeaker();
                                                  })
                                                : SizedBox(),

                                            ///
                                            setupIcons(Icons.call_end, Colors.red,
                                                () {
                                              controller.leaveChannel();
                                            }),

                                            ///
                                            setupIcons(
                                                controller.isMicEnable.value
                                                    ? Icons.mic
                                                    : Icons.mic_off,
                                                AppColors.iconBg, () {
                                              controller.updateMic();
                                            }),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(
                                      color: AppColors.iconBg.withAlpha(130),
                                      height: 140,
                                      width: MediaQuery.of(context).size.width /
                                          100 *
                                          99.4,
                                      child: Padding(
                                        padding: EdgeInsets.all(18.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ///
                                            controller.isVideoCall.value
                                                ? setupIcons(
                                                    Icons.cameraswitch_outlined,
                                                    Colors.transparent, () {
                                                    controller.changeCamera();
                                                  })
                                                : SizedBox(),

                                            ///
                                            controller.isVideoCall.value
                                                ? GestureDetector(
                                                    onTap: () {
                                                      controller.updateCamera();
                                                    },
                                                    child: SvgPicture.asset(
                                                      controller.isCameraEnable
                                                              .value
                                                          ? "assets/img/recording.svg"
                                                          : "assets/img/recording_off.svg",
                                                    ),
                                                  )
                                                /*setupIcons(
                                                    Icons.camera_alt_outlined,
                                                    controller.isCameraEnable.value
                                                        ? Colors.lightGreen.shade300
                                                        : Colors.black12, () {
                                                    controller.updateCamera();
                                                  })*/
                                                : SizedBox(),

                                            ///
                                            setupIcons(
                                                Icons.call_end, Colors.red, () {
                                              controller.leaveChannel();
                                            }),

                                            ///
                                            setupIcons(
                                                controller.isMicEnable.value
                                                    ? Icons.mic
                                                    : Icons.mic_off,
                                                Colors.transparent, () {
                                              controller.updateMic();
                                            }),
                                          ],
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox();
          })
        ],
      ),
    );
    // });
  }

  Widget showLoadingRemoteView() {
    return SizedBox(
      height: 10,
      width: 10,
      child: CircularProgressIndicator(
        color: Colors.white60,
      ),
    );
  }

  Widget showRemoteVideoByState() {
    return Obx(() {
      switch (controller.remoteVideoState.value) {
        // case RemoteVideoState.remoteVideoStateDecoding:
        //   {
        //     return showLoadingRemoteView();
        //   }
        //
        // case RemoteVideoState.remoteVideoStateFailed:
        //   {
        //     return showDisableBg();
        //   }
        //
        // case RemoteVideoState.remoteVideoStateFrozen:
        //   {
        //     return showLoadingRemoteView();
        //   }

        case RemoteVideoState.remoteVideoStateStopped:
          {
            return showDisableBg();
          }

        // case RemoteVideoState.remoteVideoStateStarting:
        //   {
        //     return AgoraVideoView(
        //       controller: VideoViewController.remote(
        //         rtcEngine: controller.engine!,
        //         canvas: VideoCanvas(uid: controller.remoteUid.value),
        //         connection: RtcConnection(channelId: controller.channel),
        //       ),
        //     );
        //   }

        default:
          {
            return AgoraVideoView(
              controller: VideoViewController.remote(
                rtcEngine: controller.engine!,
                canvas: VideoCanvas(uid: controller.remoteUid.value),
                connection: RtcConnection(channelId: controller.channel),
              ),
            );
          }
        // childDragAnchorStrategy(draggable, context, position)
      }
    });
  }

  // Widget to display remote video
  Widget _remoteVideo(context) {
    return Obx(() {
      final remoteUid = controller.remoteUid.value; // capture the observable

      debugPrint(
          "remoteUidOBX-> ${remoteUid}  ${controller.localUserJoined.value}");
      if (controller.engine != null &&
          controller.remoteUid.value != 0 &&
          controller.remoteUid.value != null) {
        return showRemoteVideoByState();
      } else if (controller.localUserJoined.value) {
        return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: controller.isCameraEnable.value
                ? localUserVideo()
                : showDisableBg());
      } else {
        return Text(
          'Welcome to video/audio call demo',
          textAlign: TextAlign.center,
        );
      }
    });
  }

  Widget localUserVideo() {
    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: controller.engine!,
        canvas: const VideoCanvas(uid: 0),
      ),
    );
  }

  Widget setupIcons(IconData icon, Color bgColor, VoidCallback callback) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          decoration: BoxDecoration(
              color: bgColor, borderRadius: BorderRadius.circular(100)),
          padding: EdgeInsets.all(10),
          child: Icon(
            icon,
            color: Colors.white,
            size: 35,
          ),
        ),
      ),
    );
  }
}
