// import 'package:firebase_auth/firebase_auth.dart';

// class FirebaseCustomException implements Exception {
//   final String message;

//   FirebaseCustomException(this.message);

//   @override
//   String toString() => message;

//   // Factory constructor to handle Firebase exceptions
//   factory FirebaseCustomException.fromFirebaseException(Exception e) {
//     if (e is FirebaseAuthException) {
//       return FirebaseCustomException(_mapFirebaseAuthException(e));
//     } else if (e is FirebaseFirestoreException) {
//       return FirebaseCustomException(_mapFirebaseFirestoreException(e));
//     } else {
//       return FirebaseCustomException('An unexpected error occurred.');
//     }
//   }

//   // Map FirebaseAuth exceptions to custom messages
//   static String _mapFirebaseAuthException(FirebaseAuthException e) {
//     switch (e.code) {
//       case 'user-not-found':
//         return 'No user found with this email.';
//       case 'wrong-password':
//         return 'Incorrect password.';
//       case 'email-already-in-use':
//         return 'The email address is already in use.';
//       case 'invalid-email':
//         return 'The email address is not valid.';
//       case 'weak-password':
//         return 'The password is too weak.';
//       case 'too-many-requests':
//         return 'Too many attempts, try again later.';
//       case 'network-request-failed':
//         return 'Network error, please check your connection.';
//       default:
//         return 'An authentication error occurred.';
//     }
//   }

//   // Map Firestore exceptions to custom messages
//   static String _mapFirebaseFirestoreException(FirebaseFirestoreException e) {
//     switch (e.code) {
//       case 'permission-denied':
//         return 'You do not have permission to access this resource.';
//       case 'not-found':
//         return 'The requested document was not found.';
//       case 'unavailable':
//         return 'Firestore service is unavailable, try again later.';
//       case 'cancelled':
//         return 'The request was cancelled.';
//       default:
//         return 'A Firestore error occurred.';
//     }
//   }
// }
