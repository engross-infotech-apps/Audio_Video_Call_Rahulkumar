import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'user.dart';

part 'room.g.dart';

/// All possible room types.
enum RoomType { channel, direct, group }

/// A class that represents a room where 2 or more participants can chat.
@immutable
abstract class Room extends Equatable {
  /// Creates a [Room].
  const Room._({
    this.createdAt,
    required this.id,
    this.authorId,
    this.profilePicture,
    this.metadata,
    this.displayName,
    this.fullName,
    required this.type,
    this.updatedAt,
    required this.users,
    this.userUnreadCountInfo,
    this.clearChatInfo,
    this.blockUser,
  });

  const factory Room({
    dynamic createdAt,
    required String id,
    String? authorId,
    String? profilePicture,
    Map<String, dynamic>? metadata,
    String? displayName,
    String? fullName,
    required RoomType? type,
    dynamic updatedAt,
    required List<User> users,
    int? userUnreadCountInfo,
    Map<String, dynamic>? clearChatInfo,
    List<String>? blockUser,
  }) = _Room;

  /// Creates room from a map (decoded JSON).
  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  /// Created room timestamp, in ms.
  final dynamic createdAt;

  /// Room's unique ID.
  final String id;
  final String? authorId;

  /// Room's image. In case of the [RoomType.direct] - avatar of the second person,
  /// otherwise a custom image [RoomType.group].
  final String? profilePicture;

  /// List of last messages this room has received.

  /// Additional custom metadata or attributes related to the room.
  final Map<String, dynamic>? metadata;

  /// Room's name. In case of the [RoomType.direct] - name of the second person,
  /// otherwise a custom name [RoomType.group].
  final String? displayName;
  final String? fullName;

  /// [RoomType].
  final RoomType? type;

  /// Updated room timestamp, in ms.
  final dynamic updatedAt;

  /// List of users which are in the room.
  final List<User> users;

  /// Updated room unread counter.
  final int? userUnreadCountInfo;

  final Map<String, dynamic>? clearChatInfo;

  final List<String>? blockUser;

  /// Equatable props.
  @override
  List<Object?> get props => [
        createdAt,
        id,
        authorId,
        profilePicture,
        metadata,
        displayName,
        fullName,
        type,
        updatedAt,
        users,
        userUnreadCountInfo,
        clearChatInfo,
        blockUser,
      ];

  /// Creates a copy of the room with an updated data.
  /// [imageUrl], [name] and [updatedAt] with null values will nullify existing values
  /// [metadata] with null value will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwite keys from the previous one.
  /// [type] and [users] with null values will be overwritten by previous values.
  Room copyWith({
    dynamic createdAt,
    String? id,
    String? authorId,
    String? profilePicture,
    Map<String, dynamic>? metadata,
    String? displayName,
    String? fullName,
    RoomType? type,
    dynamic updatedAt,
    List<User>? users,
    Map<String, dynamic>? userUnreadCountInfo,
    Map<String, dynamic>? clearChatInfo,
    List<String>? blockUser,
  });

  /// Converts room to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => _$RoomToJson(this);
}

/// A utility class to enable better copyWith.
class _Room extends Room {
  const _Room({
    super.createdAt,
    required super.id,
    super.authorId,
    super.profilePicture,
    super.metadata,
    super.displayName,
    super.fullName,
    required super.type,
    super.updatedAt,
    required super.users,
    super.userUnreadCountInfo,
    super.clearChatInfo,
    super.blockUser,
  }) : super._();

  @override
  Room copyWith({
    dynamic createdAt = _Unset,
    String? id,
    dynamic authorId = _Unset,
    dynamic profilePicture = _Unset,
    dynamic lastMessages = _Unset,
    dynamic metadata = _Unset,
    dynamic displayName = _Unset,
    dynamic fullName = _Unset,
    dynamic type = _Unset,
    dynamic updatedAt = _Unset,
    List<User>? users,
    dynamic userUnreadCountInfo = _Unset,
    dynamic clearChatInfo = _Unset,
    List<String>? blockUser,
  }) =>
      _Room(
        createdAt: createdAt == _Unset ? this.createdAt : createdAt as dynamic,
        id: id ?? this.id,
        authorId: authorId ?? this.authorId,
        profilePicture: profilePicture == _Unset
            ? this.profilePicture
            : profilePicture as String?,
        metadata: metadata == _Unset
            ? this.metadata
            : metadata as Map<String, dynamic>?,
        displayName:
            displayName == _Unset ? this.displayName : displayName as String?,
        fullName: fullName == _Unset ? this.fullName : fullName as String?,
        type: type == _Unset ? this.type : type as RoomType?,
        updatedAt: updatedAt == _Unset ? this.updatedAt : updatedAt as dynamic,
        users: users ?? this.users,
        userUnreadCountInfo: userUnreadCountInfo == _Unset
            ? this.userUnreadCountInfo
            : userUnreadCountInfo,
        clearChatInfo: clearChatInfo == _Unset
            ? this.clearChatInfo
            : clearChatInfo as Map<String, dynamic>?,
        blockUser: blockUser ?? this.blockUser,
      );
}

class _Unset {}
