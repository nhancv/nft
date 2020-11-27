import 'package:nft/services/cache/storage.dart';
import 'package:npreferences/npreferences.dart';

/// Implement Storage by SharedPreferences
class StoragePreferences extends Storage with NPreferences {}
