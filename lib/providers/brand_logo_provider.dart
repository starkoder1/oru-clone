import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oru_copy/services/brand_model_service.dart';
import '../models/brand_model.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final brandProvider = FutureProvider<List<Brand>>((ref) async {
  return ref.watch(apiServiceProvider).fetchBrands();
});