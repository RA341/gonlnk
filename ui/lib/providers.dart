import 'package:flutter_riverpod/legacy.dart';

// Provider to manage the selected index of the bottom nav bar / sidebar
final navigationProvider = StateProvider<int>((ref) => 0);
