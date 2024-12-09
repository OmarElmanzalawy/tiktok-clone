import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone2/models/user.dart';

class SearchService {
  static Future<List<UserModel>> searchUser(String typedUser) async {
    print(typedUser);
    print('search user');
    
    List<UserModel> retVal = [];
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isGreaterThanOrEqualTo: typedUser)
          .get(); // Use `get()` for a one-time fetch
      
      for (var doc in querySnapshot.docs) {
        print(doc.data());
        retVal.add(UserModel.fromSnap(doc));
      }
      print('before return: ${retVal.toString()}');
    } catch (e) {
      print('Error searching user: $e');
    }
    
    return retVal;
  }
}