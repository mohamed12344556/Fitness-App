// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) =>
    WeatherResponse(
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      current: CurrentWeather.fromJson(json['current'] as Map<String, dynamic>),
      forecast:
          json['forecast'] == null
              ? null
              : ForecastData.fromJson(json['forecast'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherResponseToJson(WeatherResponse instance) =>
    <String, dynamic>{
      'location': instance.location,
      'current': instance.current,
      'forecast': instance.forecast,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
  name: json['name'] as String,
  region: json['region'] as String,
  country: json['country'] as String,
  lat: (json['lat'] as num).toDouble(),
  lon: (json['lon'] as num).toDouble(),
  tz_id: json['tz_id'] as String,
  localtime: json['localtime'] as String,
);

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
  'name': instance.name,
  'region': instance.region,
  'country': instance.country,
  'lat': instance.lat,
  'lon': instance.lon,
  'tz_id': instance.tz_id,
  'localtime': instance.localtime,
};

CurrentWeather _$CurrentWeatherFromJson(Map<String, dynamic> json) =>
    CurrentWeather(
      temp_c: (json['temp_c'] as num).toDouble(),
      temp_f: (json['temp_f'] as num).toDouble(),
      is_day: (json['is_day'] as num).toInt(),
      condition: Condition.fromJson(json['condition'] as Map<String, dynamic>),
      wind_kph: (json['wind_kph'] as num).toDouble(),
      humidity: (json['humidity'] as num).toInt(),
      cloud: (json['cloud'] as num).toInt(),
      feelslike_c: (json['feelslike_c'] as num).toDouble(),
      vis_km: (json['vis_km'] as num).toDouble(),
      uv: (json['uv'] as num).toDouble(),
    );

Map<String, dynamic> _$CurrentWeatherToJson(CurrentWeather instance) =>
    <String, dynamic>{
      'temp_c': instance.temp_c,
      'temp_f': instance.temp_f,
      'is_day': instance.is_day,
      'condition': instance.condition,
      'wind_kph': instance.wind_kph,
      'humidity': instance.humidity,
      'cloud': instance.cloud,
      'feelslike_c': instance.feelslike_c,
      'vis_km': instance.vis_km,
      'uv': instance.uv,
    };

Condition _$ConditionFromJson(Map<String, dynamic> json) => Condition(
  text: json['text'] as String,
  icon: json['icon'] as String,
  code: (json['code'] as num).toInt(),
);

Map<String, dynamic> _$ConditionToJson(Condition instance) => <String, dynamic>{
  'text': instance.text,
  'icon': instance.icon,
  'code': instance.code,
};

ForecastData _$ForecastDataFromJson(Map<String, dynamic> json) => ForecastData(
  forecastday:
      (json['forecastday'] as List<dynamic>?)
          ?.map((e) => ForecastDay.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ForecastDataToJson(ForecastData instance) =>
    <String, dynamic>{'forecastday': instance.forecastday};

ForecastDay _$ForecastDayFromJson(Map<String, dynamic> json) => ForecastDay(
  date: json['date'] as String,
  date_epoch: (json['date_epoch'] as num).toInt(),
  day: DayWeather.fromJson(json['day'] as Map<String, dynamic>),
  astro: Astro.fromJson(json['astro'] as Map<String, dynamic>),
  hour:
      (json['hour'] as List<dynamic>?)
          ?.map((e) => HourWeather.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$ForecastDayToJson(ForecastDay instance) =>
    <String, dynamic>{
      'date': instance.date,
      'date_epoch': instance.date_epoch,
      'day': instance.day,
      'astro': instance.astro,
      'hour': instance.hour,
    };

DayWeather _$DayWeatherFromJson(Map<String, dynamic> json) => DayWeather(
  maxtemp_c: (json['maxtemp_c'] as num).toDouble(),
  mintemp_c: (json['mintemp_c'] as num).toDouble(),
  avgtemp_c: (json['avgtemp_c'] as num).toDouble(),
  maxwind_kph: (json['maxwind_kph'] as num).toDouble(),
  totalprecip_mm: (json['totalprecip_mm'] as num).toDouble(),
  avgvis_km: (json['avgvis_km'] as num).toDouble(),
  avghumidity: (json['avghumidity'] as num).toDouble(),
  condition: Condition.fromJson(json['condition'] as Map<String, dynamic>),
  uv: (json['uv'] as num).toDouble(),
);

Map<String, dynamic> _$DayWeatherToJson(DayWeather instance) =>
    <String, dynamic>{
      'maxtemp_c': instance.maxtemp_c,
      'mintemp_c': instance.mintemp_c,
      'avgtemp_c': instance.avgtemp_c,
      'maxwind_kph': instance.maxwind_kph,
      'totalprecip_mm': instance.totalprecip_mm,
      'avgvis_km': instance.avgvis_km,
      'avghumidity': instance.avghumidity,
      'condition': instance.condition,
      'uv': instance.uv,
    };

Astro _$AstroFromJson(Map<String, dynamic> json) => Astro(
  sunrise: json['sunrise'] as String,
  sunset: json['sunset'] as String,
  moonrise: json['moonrise'] as String,
  moonset: json['moonset'] as String,
  moon_phase: json['moon_phase'] as String,
  moon_illumination: (json['moon_illumination'] as num).toInt(),
  is_moon_up: (json['is_moon_up'] as num?)?.toInt() ?? 0,
  is_sun_up: (json['is_sun_up'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AstroToJson(Astro instance) => <String, dynamic>{
  'sunrise': instance.sunrise,
  'sunset': instance.sunset,
  'moonrise': instance.moonrise,
  'moonset': instance.moonset,
  'moon_phase': instance.moon_phase,
  'moon_illumination': instance.moon_illumination,
  'is_moon_up': instance.is_moon_up,
  'is_sun_up': instance.is_sun_up,
};

HourWeather _$HourWeatherFromJson(Map<String, dynamic> json) => HourWeather(
  time_epoch: (json['time_epoch'] as num).toInt(),
  time: json['time'] as String,
  temp_c: (json['temp_c'] as num).toDouble(),
  temp_f: (json['temp_f'] as num).toDouble(),
  is_day: (json['is_day'] as num).toInt(),
  condition: Condition.fromJson(json['condition'] as Map<String, dynamic>),
  wind_kph: (json['wind_kph'] as num).toDouble(),
  humidity: (json['humidity'] as num).toInt(),
  feelslike_c: (json['feelslike_c'] as num).toDouble(),
);

Map<String, dynamic> _$HourWeatherToJson(HourWeather instance) =>
    <String, dynamic>{
      'time_epoch': instance.time_epoch,
      'time': instance.time,
      'temp_c': instance.temp_c,
      'temp_f': instance.temp_f,
      'is_day': instance.is_day,
      'condition': instance.condition,
      'wind_kph': instance.wind_kph,
      'humidity': instance.humidity,
      'feelslike_c': instance.feelslike_c,
    };
