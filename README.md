# Fitness App 🏃‍♂️💪

![Fitness App Banner](assets/images/app_banner.png)

## 📱 نظرة عامة

تطبيق لياقة بدنية عصري مبني بواسطة Flutter يمكن المستخدمين من تتبع أهدافهم الرياضية، مراقبة الأنشطة اليومية، والوصول إلى معلومات الطقس لتخطيط التمارين الخارجية. يستخدم التطبيق Firebase Authentication لإدارة المستخدمين بشكل آمن.

### 🎬 فيديو توضيحي
🔗 **[اضغط هنا لمشاهدة العرض التوضيحي](https://drive.google.com/file/d/1AQX28xomD18VSH2rx0knTlVuaqHh4jgg/view?usp=sharing)**  

## ✨ المميزات

- **🔐 نظام المصادقة**
  - تسجيل الدخول وإنشاء حساب باستخدام البريد الإلكتروني وكلمة المرور
  - إمكانية استعادة كلمة المرور
  - إدارة الملف الشخصي للمستخدم

- **📊 تتبع النشاط**
  - عداد الخطوات اليومية
  - تتبع المسافة المقطوعة
  - حساب السعرات الحرارية المحروقة
  - مراقبة معدل ضربات القلب
  - رسوم بيانية لعرض التقدم

- **🌦️ تكامل بيانات الطقس**
  - بيانات الطقس في الوقت الحقيقي
  - توقعات الطقس حسب الموقع
  - واجهة خريطة تفاعلية

- **📱 تصميم متجاوب**
  - يتكيف مع مختلف أحجام الشاشات
  - تجربة مستخدم متناسقة عبر جميع الأجهزة

## 📸 لقطات شاشة

<table>
  <tr>
    <td align="center">
      <img src="assets/screenshots/welcome_screen.png" width="200px" alt="شاشة الترحيب"/>
      <br/>شاشة الترحيب
    </td>
    <td align="center">
      <img src="assets/screenshots/login_screen.png" width="200px" alt="تسجيل الدخول"/>
      <br/>تسجيل الدخول
    </td>
    <td align="center">
      <img src="assets/screenshots/forgot_password.png" width="200px" alt="استعادة كلمة المرور"/>
      <br/>استعادة كلمة المرور
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="assets/screenshots/signup_screen1.png" width="200px" alt="إنشاء حساب - الخطوة 1"/>
      <br/>إنشاء حساب - البيانات الأساسية
    </td>
    <td align="center">
      <img src="assets/screenshots/signup_screen2.png" width="200px" alt="إنشاء حساب - الخطوة 2"/>
      <br/>إنشاء حساب - البيانات الإضافية
    </td>
    <td align="center">
      <img src="assets/screenshots/confirmation_dialog.png" width="200px" alt="تأكيد إنشاء الحساب"/>
      <br/>تأكيد إنشاء الحساب
    </td>
  </tr>
</table>

## 🏗️ العمارة البرمجية

يتبع هذا المشروع مبادئ **Clean Architecture** لضمان:
- فصل المسؤوليات
- قابلية الاختبار
- سهولة الصيانة
- قابلية التوسع

### هيكل المشروع

```
lib/
├── core/                # الطبقة الأساسية
│   ├── di/              # حقن التبعيات
│   ├── error/           # معالجة الأخطاء
│   ├── api/             # واجهات API وخدمات الشبكة
│   ├── routes/          # توجيه التطبيق
│   └── utils/           # أدوات مشتركة
│
├── features/            # ميزات التطبيق
│   ├── auth/            # ميزة المصادقة
│   │   ├── data/        # طبقة البيانات
│   │   ├── domain/      # طبقة المجال
│   │   └── ui/          # طبقة واجهة المستخدم
│   │
│   ├── weather/         # ميزة الطقس
│   │   ├── data/        # طبقة البيانات
│   │   ├── domain/      # طبقة المجال
│   │   └── ui/          # طبقة واجهة المستخدم
│   │
│   └── fitness/         # ميزة اللياقة البدنية (مستقبلًا)
│
├── fitness_app.dart     # مكون التطبيق الرئيسي
└── main.dart            # نقطة الدخول للتطبيق
```

## 🛠️ التقنيات المستخدمة

- **Flutter**: إطار عمل واجهة المستخدم
- **Firebase**: المصادقة والخلفية
- **BLoC/Cubit**: إدارة الحالة
- **Dio & Retrofit**: التعامل مع واجهات API
- **Clean Architecture**: هيكل المشروع
- **Dependency Injection**: نمط Service Locator باستخدام GetIt
- **واجهة API الطقس**: بيانات الطقس في الوقت الحقيقي

## 🚀 البدء

### المتطلبات الأساسية

- Flutter SDK (أحدث إصدار)
- Dart SDK
- حساب Firebase
- مفتاح واجهة API الطقس (من WeatherAPI.com)

### التثبيت

1. استنساخ المستودع:
   ```bash
   git clone https://github.com/mohamed12344556/Fitness-App.git
   cd fitness_app
   ```

2. تثبيت التبعيات:
   ```bash
   flutter pub get
   ```

3. تكوين Firebase:
   - إنشاء مشروع Firebase جديد
   - إضافة تطبيقات Android/iOS في وحدة تحكم Firebase
   - تنزيل ووضع ملفات التكوين
   - تمكين مصادقة البريد الإلكتروني/كلمة المرور

4. إضافة مفتاح API الطقس الخاص بك:
   - تعديل ملف `api_constants.dart` 
   - إضافة مفتاح API الخاص بك: `static const String apiKey = 'your_api_key_here';`

5. تشغيل التطبيق:
   ```bash
   flutter run
   ```

## ✅ المهام المكتملة

- [x] تنفيذ تسجيل الدخول وإنشاء الحساب باستخدام Firebase Authentication
- [x] اتباع مبادئ Clean Architecture
- [x] استخدام Cubit لإدارة الحالة
- [x] إنشاء واجهة مستخدم متجاوبة لأحجام شاشة مختلفة
- [x] دمج خدمات الطقس
- [x] إنشاء نظام أساسي لإدارة الملف الشخصي للمستخدم

## 🧪 الاختبارات

```bash
# تشغيل اختبارات الوحدة
flutter test

# تشغيل اختبارات التكامل
flutter test integration_test
```

## 📄 الترخيص

هذا المشروع مرخص بموجب رخصة MIT - راجع ملف [LICENSE](LICENSE) للحصول على التفاصيل.

## 🤝 المساهمة

المساهمات مرحب بها! لا تتردد في تقديم طلب سحب.

---

تم تطويره بـ ❤️ بواسطة [mohamed12344556](https://github.com/mohamed12344556/Fitness-App.git)