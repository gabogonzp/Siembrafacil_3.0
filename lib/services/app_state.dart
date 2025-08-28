import '../models/user.dart';
import '../models/parcel.dart';
import '../models/analysis_result.dart';

class AppState {
  static bool _isFirstTime = true;
  static bool _isLoggedIn = false;
  static User? _currentUser;
  static Parcel? _activeParcel;
  static final List<Parcel> _parcels = [];
  static final List<AnalysisResult> _analysisHistory = [];

  // Getters
  static bool get isFirstTime => _isFirstTime;
  static bool get isLoggedIn => _isLoggedIn;
  static User? get currentUser => _currentUser;
  static Parcel? get activeParcel => _activeParcel;
  static List<Parcel> get parcels => _parcels;
  static List<AnalysisResult> get analysisHistory => _analysisHistory;

  // Authentication
  static void completeOnboarding() {
    _isFirstTime = false;
  }

  static void login(User user) {
    _isLoggedIn = true;
    _currentUser = user;
  }

  static void logout() {
    _isLoggedIn = false;
    _currentUser = null;
    _parcels.clear();
    _activeParcel = null;
    _analysisHistory.clear();
  }

  // Parcel Management
  static void addParcel(Parcel parcel) {
    _parcels.add(parcel);
    _activeParcel ??= parcel;
  }

  static void updateParcel(Parcel updatedParcel) {
    final index = _parcels.indexWhere((p) => p.id == updatedParcel.id);
    if (index != -1) {
      _parcels[index] = updatedParcel;
      if (_activeParcel?.id == updatedParcel.id) {
        _activeParcel = updatedParcel;
      }
    }
  }

  static void removeParcel(String parcelId) {
    _parcels.removeWhere((p) => p.id == parcelId);
    if (_activeParcel?.id == parcelId) {
      _activeParcel = _parcels.isNotEmpty ? _parcels.first : null;
    }
  }

  static void setActiveParcel(Parcel? parcel) {
    _activeParcel = parcel;
  }

  // Analysis Management
  static void addAnalysisResult(AnalysisResult result) {
    _analysisHistory.insert(0, result); // Add to beginning for latest first
  }
}
