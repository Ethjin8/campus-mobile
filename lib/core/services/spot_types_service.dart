import 'package:campus_mobile_experimental/core/models/spot_types_model.dart';
import 'package:campus_mobile_experimental/core/services/networking.dart';

class SpotTypesService {
  SpotTypesService() {
    fetchSpotTypesData();
  }
  bool _isLoading = false;
  DateTime _lastUpdated;
  String _error;
  final NetworkHelper _networkHelper = NetworkHelper();
  final Map<String, String> headers = {
    "accept": "application/json",
  };

  SpotTypeModel _spotTypeModel = SpotTypeModel();

  final String endpoint =
      "https://mobile.ucsd.edu/replatform/v1/qa/webview/parking/spot_types.json";
  Future<bool> fetchSpotTypesData() async {
    _error = null;
    _isLoading = true;
    try {
      /// fetch data
      String _response = await _networkHelper.fetchData(endpoint);
      _spotTypeModel = spotTypeModelFromJson(_response);

      _isLoading = false;
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      return false;
    }
  }

  bool get isLoading => _isLoading;
  String get error => _error;
  DateTime get lastUpdated => _lastUpdated;
  SpotTypeModel get spotTypeModel => _spotTypeModel;
}
