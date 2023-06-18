import 'package:flutter/material.dart';

class AboutUsPagear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String appVersion = '1.0.0';
    return Scaffold(
      appBar: AppBar(
        title: Text('عنا'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مرحبًا بك في تطبيق "Xelon" لبيع العطور!',
                style: TextStyle(
                  fontFamily: 'nz',
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'نحن نسعى لتوفير أجود العطور لعملائنا وتقديم تجربة تسوق استثنائية.',
                style: TextStyle(
                  fontFamily: 'nz',
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'نبذة عنا:',
                style: TextStyle(
                  fontFamily: 'nz',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'تطبيق "Xelon" هو نتاج جهود مجموعة من المحترفين المتخصصين في صناعة العطور. نحن نجمع بين خبراتنا العميقة وشغفنا لنقدم لكم تشكيلة واسعة من العطور الفاخرة.',
                style: TextStyle(
                  fontFamily: 'nz',
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'ما نقدمه:',
                style: TextStyle(
                  fontFamily: 'nz',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'في تطبيق "Xelon"، يمكنكم استعراض مجموعة متنوعة من العطور الفاخرة للنساء والرجال. نحرص على اختيار أحدث العطور من أشهر الماركات العالمية لتناسب أذواقكم المتنوعة.',
                style: TextStyle(
                  fontFamily: 'nz',
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'تواصل معنا:',
                style: TextStyle(
                  fontFamily: 'nz',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'إذا كان لديكم أي استفسارات أو اقتراحات، يسعدنا التواصل معكم. يمكنكم التواصل معنا عبر البريد الإلكتروني أو الاتصال بنا عبر الهاتف.',
                style: TextStyle(
                  fontFamily: 'nz',
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'gshinopy@gmail.com ,07509012913',
                style: TextStyle(
                  fontFamily: 'nz',
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'شكرًا لاختياركم تطبيق "Xelon". نتطلع لخدمتكم بأفضل ما لدينا!',
                style: TextStyle(
                  fontFamily: 'nz',
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'إصدار التطبيق: $appVersion',
                style: TextStyle(
                  fontFamily: 'nz',
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
