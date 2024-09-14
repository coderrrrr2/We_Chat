import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  final String name;
  final String pfpUrl;

  UserProfile({
    required this.uid,
    required this.name,
    required this.pfpUrl,
  });

  // Convert a UserProfile object into a Map (for Firestore)
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'pfpUrl': pfpUrl,
    };
  }

  // Create a UserProfile from a Firestore document
  factory UserProfile.fromJson(Map<String, dynamic> map) {
    return UserProfile(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      pfpUrl: map['pfpUrl'] ?? '',
    );
  }

  // Create a UserProfile from Firestore document snapshot
  factory UserProfile.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserProfile(
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      pfpUrl: data['pfpUrl'] ?? '',
    );
  }

  // Optional: String representation for easier debugging
  @override
  String toString() {
    return 'UserProfile(uid: $uid, name: $name, pfpUrl: $pfpUrl)';
  }
}
