// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['Id'] as String?,
      userId: json['UserId'] as dynamic,
      fullName: json['FullName'] as String?,
      displayName: json['DisplayName'] as String?,
      profilePicture: json['ProfilePicture'] as String?,
      email: json['Email'] as String?,
      isOnline: json['IsOnline'] as bool?,
      isVerified: json['IsVerified'] as bool?,
      blocked: json['Blocked'] as List?,
      blockedBy: json['BlockedBy'] as List?,
      lastSeen: json['LastSeen'] as dynamic,
      createdAt: json['CreatedAt'] as dynamic,
      updatedAt: json['UpdatedAt'] as dynamic,
      role: json['Role'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  val['Id'] = instance.id;
  writeNotNull('UserId', instance.userId);
  writeNotNull('FullName', instance.fullName);
  writeNotNull('DisplayName', instance.displayName);
  writeNotNull('ProfilePicture', instance.profilePicture);
  writeNotNull('Email', instance.email);
  writeNotNull('IsOnline', instance.isOnline);
  writeNotNull('IsVerified', instance.isVerified);
  writeNotNull('Blocked', instance.blocked);
  writeNotNull('BlockedBy', instance.blockedBy);
  writeNotNull('LastSeen', instance.lastSeen);
  writeNotNull('createdAt', instance.createdAt);
  writeNotNull('updatedAt', instance.updatedAt);
  writeNotNull('Role', instance.role);

  return val;
}

// const _$RoleEnumMap = {
//   UserRole.admin: 'admin',
//   Role.agent: 'agent',
//   Role.moderator: 'moderator',
//   Role.user: 'user',
// };
