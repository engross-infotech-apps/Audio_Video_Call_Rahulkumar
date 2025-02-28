import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'user.g.dart';

/// A class that represents user.
@immutable
abstract class User extends Equatable {
  /// Creates a user.
  const User._({
    required this.id,
    this.userId,
    this.fullName,
    this.displayName,
    this.profilePicture,
    this.email,
    this.isOnline,
    this.isVerified,
    this.blocked,
    this.blockedBy,
    this.lastSeen,
    this.createdAt,
    this.updatedAt,
    this.role,
  });

  const factory User({
    required String? id,
    dynamic userId,
    String? fullName,
    String? displayName,
    String? profilePicture,
    String? email,
    bool? isOnline,
    bool? isVerified,
    List? blocked,
    List? blockedBy,
    dynamic lastSeen,
    dynamic createdAt,
    dynamic updatedAt,
    String? role,
  }) = _User;

  /// Creates user from a map (decoded JSON).
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Unique firebase ID of the user.
  final String? id;

  /// Unique API user's ID of the user.
  final dynamic userId;

  final String? fullName;
  final String? displayName;
  final String? profilePicture;
  final String? email;
  final bool? isOnline;
  final bool? isVerified;
  final List? blocked;
  final List? blockedBy;

  /// Timestamp when user was last visible, in ms.
  final dynamic lastSeen;
  final dynamic createdAt;
  final dynamic updatedAt;

  /// User [UserRole] as string.
  final String? role;

  /// Equatable props.
  @override
  List<Object?> get props => [
        id,
        userId,
        fullName,
        displayName,
        profilePicture,
        email,
        isOnline,
        isVerified,
        blocked,
        blockedBy,
        lastSeen,
        createdAt,
        updatedAt,
        role,
      ];

  User copyWith({
    required String? id,
    dynamic userId,
    String? fullName,
    String? displayName,
    String? profilePicture,
    String? email,
    bool? isOnline,
    bool? isVerified,
    List? blocked,
    List? blockedBy,
    dynamic lastSeen,
    dynamic updatedAt,
    dynamic createdAt,
    String? role,
  });

  /// Converts user to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

/// A utility class to enable better copyWith.
class _User extends User {
  const _User({
    required super.id,
    super.userId,
    super.fullName,
    super.displayName,
    super.profilePicture,
    super.email,
    super.isOnline,
    super.isVerified,
    super.blocked,
    super.blockedBy,
    super.lastSeen,
    super.createdAt,
    super.updatedAt,
    super.role,
  }) : super._();

  @override
  User copyWith({
    String? id,
    dynamic userId = _Unset,
    dynamic fullName = _Unset,
    dynamic displayName = _Unset,
    dynamic profilePicture = _Unset,
    dynamic email = _Unset,
    dynamic isOnline = _Unset,
    dynamic isVerified = _Unset,
    dynamic blocked = _Unset,
    dynamic blockedBy = _Unset,
    dynamic lastSeen = _Unset,
    dynamic createdAt = _Unset,
    dynamic updatedAt = _Unset,
    dynamic role = _Unset,
  }) =>
      _User(
        id: id ?? this.id,
        userId: userId == _Unset ? this.userId : userId as dynamic,
        fullName: fullName == _Unset ? this.fullName : fullName as String?,
        displayName:
            displayName == _Unset ? this.displayName : displayName as String?,
        profilePicture: profilePicture == _Unset
            ? this.profilePicture
            : profilePicture as String?,
        email: email == _Unset ? this.email : email as String?,
        isOnline: isOnline == _Unset ? this.isOnline : isOnline as bool?,
        isVerified:
            isVerified == _Unset ? this.isVerified : isVerified as bool?,
        blocked: blocked == _Unset ? this.blocked : blocked as List?,
        blockedBy: blockedBy == _Unset ? this.blockedBy : blockedBy as List?,
        lastSeen: lastSeen == _Unset ? this.lastSeen : lastSeen as dynamic,
        createdAt: createdAt == _Unset ? this.createdAt : createdAt as dynamic,
        updatedAt: updatedAt == _Unset ? this.updatedAt : updatedAt as dynamic,
        role: role == _Unset ? this.role : role as String?,
      );
}

class _Unset {}
