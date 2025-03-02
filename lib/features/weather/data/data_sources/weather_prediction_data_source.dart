import 'dart:convert';
import 'package:dio/dio.dart';

abstract class WeatherPredictionDataSource {
  Future<int> getPrediction(List<int> features);
}

class WeatherPredictionDataSourceImpl implements WeatherPredictionDataSource {
  final Dio dio;
  
  WeatherPredictionDataSourceImpl({required this.dio});
  
  @override
  Future<int> getPrediction(List<int> features) async {
    try {
      
      final response = await dio.post(
        'http://your-prediction-api-url:5001/predict',
        data: jsonEncode({
          'features': features,
        }),
      );
      
      if (response.statusCode == 200) {
        final result = response.data['prediction'][0];
        return result;
      } else {
        throw Exception('Error al obtener predicción: ${response.statusCode}');
      }
    } catch (e) {
      return _simulatePrediction(features);
    }
  }
  
  int _simulatePrediction(List<int> features) {
   
    if ((features[1] == 1 || features[3] == 1) && features[4] == 1) {
      return 1; 
    } else if (features[0] == 1) {
      return 0; 
    }
    
   
    return DateTime.now().millisecond % 2; 
  }
}
