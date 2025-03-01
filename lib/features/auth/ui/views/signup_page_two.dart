import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupPageTwo extends StatelessWidget {
  final TextEditingController birthYearController;
  final TextEditingController birthMonthController;
  final TextEditingController birthDayController;
  final TextEditingController heightController;
  final TextEditingController weightController;

  const SignupPageTwo({
    super.key,
    required this.birthYearController,
    required this.birthMonthController,
    required this.birthDayController,
    required this.heightController,
    required this.weightController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "BIRTH DAY",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "This information helps us personalize your experience",
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            // Year Field
            Expanded(
              child: TextFormField(
                controller: birthYearController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF1A2E4A),
                  hintText: "YYYY",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    int? year = int.tryParse(value);
                    int currentYear = DateTime.now().year;
                    if (year == null || year < 1900 || year > currentYear) {
                      return 'Invalid year';
                    }
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 10),
            
            // Month Field
            Expanded(
              child: TextFormField(
                controller: birthMonthController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF1A2E4A),
                  hintText: "MM",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    int? month = int.tryParse(value);
                    if (month == null || month < 1 || month > 12) {
                      return 'Invalid month';
                    }
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 10),
            
            // Day Field
            Expanded(
              child: TextFormField(
                controller: birthDayController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF1A2E4A),
                  hintText: "DD",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    int? day = int.tryParse(value);
                    if (day == null || day < 1 || day > 31) {
                      return 'Invalid day';
                    }
                    
                    // تحقق إضافي للتأكد من صحة اليوم مع الشهر
                    String monthStr = birthMonthController.text;
                    if (monthStr.isNotEmpty) {
                      int? month = int.tryParse(monthStr);
                      if (month != null) {
                        if ((month == 4 || month == 6 || month == 9 || month == 11) && day > 30) {
                          return 'Invalid day for month';
                        } else if (month == 2) {
                          String yearStr = birthYearController.text;
                          if (yearStr.isNotEmpty) {
                            int? year = int.tryParse(yearStr);
                            if (year != null) {
                              bool isLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
                              if (isLeapYear && day > 29) {
                                return 'Invalid day for Feb in leap year';
                              } else if (!isLeapYear && day > 28) {
                                return 'Invalid day for Feb';
                              }
                            }
                          } else if (day > 29) {
                            return 'Invalid day for Feb';
                          }
                        }
                      }
                    }
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        
        const Text(
          "HEIGHT",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            // Height Field
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: heightController,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF1A2E4A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    int? height = int.tryParse(value);
                    if (height == null || height < 50 || height > 250) {
                      return 'Height should be between 50-250 cm';
                    }
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 10),
            
            // CM Label
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2E4A),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  "CM",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        
        const Text(
          "WEIGHT",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            // Weight Field
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: weightController,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF1A2E4A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    int? weight = int.tryParse(value);
                    if (weight == null || weight < 20 || weight > 300) {
                      return 'Weight should be between 20-300 kg';
                    }
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 10),
            
            // KG Label
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2E4A),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  "KG",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}