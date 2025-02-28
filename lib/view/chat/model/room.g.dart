// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
      createdAt: json['createdAt'] as dynamic,
      id: json['id'] as dynamic,
      authorId: json['authorId'] as dynamic,
      profilePicture: json['profilePicture'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      fullName: json['fullName'] as String?,
      displayName: json['displayName'] as String?,
      updatedAt: json['updatedAt'] as dynamic,
      users: (json['users'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      userUnreadCountInfo: json['userUnreadCountInfo'] as dynamic,
      clearChatInfo: json['clearChatInfo'] as dynamic,
      blockUser: json['blockUser'] != null
          ? List<String>.from(json["blockUser"].map(
              (x) => x,
            ))
          : [],
      type: null,
    );

Map<String, dynamic> _$RoomToJson(Room instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('createdAt', instance.createdAt);
  val['id'] = instance.id;
  writeNotNull('authorId', instance.authorId);
  writeNotNull('profilePicture', instance.profilePicture);
  writeNotNull('metadata', instance.metadata);
  writeNotNull('displayName', instance.displayName);
  writeNotNull('fullName', instance.fullName);
  writeNotNull('type', _$RoomTypeEnumMap[instance.type]);
  writeNotNull('updatedAt', instance.updatedAt);
  val['users'] = instance.users.map((e) => e.toJson()).toList();
  val['userUnreadCountInfo'] = instance.userUnreadCountInfo;
  val['clearChatInfo'] = instance.clearChatInfo;
  val['blockUser'] = instance.blockUser?.map((e) => e).toList() ?? [];

  return val;
}

const _$RoomTypeEnumMap = {
  RoomType.channel: 'channel',
  RoomType.direct: 'direct',
  RoomType.group: 'group',
};
