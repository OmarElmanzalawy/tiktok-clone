import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'navigation_bar_index.g.dart';

@riverpod
class NavigationBarIndex extends _$NavigationBarIndex{

  @override
  int build(){
    return 0;
    
  }

  void updateValue(int value){
    state = value;
  }
}