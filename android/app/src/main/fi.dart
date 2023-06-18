<manifest xmlns:android="http://schemas.android.com/apk/res/android">



<uses-feature
android:name="android.hardware.telephony"
android:required="false" />

<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.CALL_PHONE" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<application
android:label="@string/auth1"
android:name="${applicationName}"
android:icon="@mipmap/ic_launcher"
tools:replace="android:auth1" >

<activity
android:name=".MainActivity"
android:exported="true"
android:launchMode="singleTop"
android:theme="@style/LaunchTheme"
android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
android:hardwareAccelerated="true"
android:windowSoftInputMode="adjustResize">
<!-- Specifies an Android theme to apply to this Activity as soon as
the Android process has started. This theme is visible to the user
while the Flutter UI initializes. After that, this theme continues
to determine the Window background behind the Flutter UI. -->

<meta-data
android:name="io.flutter.embedding.android.NormalTheme"
android:resource="@style/NormalTheme"
/>
<intent-filter>
<action android:name="android.intent.action.MAIN"/>
<category android:name="android.intent.category.LAUNCHER"/>
</intent-filter>
</activity>

<!-- Don't delete the meta-data below.
This is used by the Flutter tool to generate GeneratedPluginRegistrant.java -->
<meta-data
android:name="flutterEmbedding"
android:value="2" />

<meta-data android:name="com.google.android.geo.API_KEY"
android:value="AIzaSyDQ2c_pOSOFYSjxGMwkFvCVWKjYOM9siow"/>
</application>
</manifest>
