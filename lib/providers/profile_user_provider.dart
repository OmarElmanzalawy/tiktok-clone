import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone2/services/profile_service.dart';

final profileProvider = StateNotifierProvider.family<ProfileNotifier, AsyncValue<Map<String, dynamic>>, String>((ref, uid) {
  return ProfileNotifier(uid);
});

class ProfileNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final String uid;
  final ProfileService _profileService = ProfileService();

  ProfileNotifier(this.uid) : super(const AsyncValue.loading()) {
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    try {
      final user = await _profileService.updateUserId(uid);
      state = AsyncValue.data(user!);
      print('Fetched user data: ${state.value}');
    } catch (e,stackTrace) {
      
      state = AsyncValue.error(e,stackTrace);
      //throw e;
    }
  }
}