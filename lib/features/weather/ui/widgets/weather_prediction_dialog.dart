import 'package:flutter/material.dart';
import 'package:fitness_app/features/weather/domain/entities/weather_prediction_entity.dart';

class WeatherPredictionDialog extends StatelessWidget {
  final WeatherPredictionEntity prediction;
  
  const WeatherPredictionDialog({
    super.key,
    required this.prediction,
  });
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: const Color(0xFF0A1929),
      contentPadding: const EdgeInsets.all(20),
      title: Text(
        prediction.canGoOutside ? 'يمكنك الخروج!' : 'من الأفضل البقاء في المنزل',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            prediction.canGoOutside ? Icons.check_circle : Icons.cancel,
            color: prediction.canGoOutside ? Colors.green : Colors.red,
            size: 80,
          ),
          const SizedBox(height: 16),
          Text(
            prediction.message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: prediction.canGoOutside ? Colors.green.shade700 : Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'حسناً',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
      actionsPadding: const EdgeInsets.only(bottom: 20, right: 20),
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}