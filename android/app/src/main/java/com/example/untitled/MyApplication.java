package com.example.untitled;

import io.flutter.app.FlutterApplication;
import com.clevertap.android.sdk.pushnotification.CTPushNotificationListener;
import com.clevertap.android.sdk.ActivityLifecycleCallback;
import com.clevertap.android.sdk.CleverTapAPI;
import android.util.Log;
import java.util.HashMap;
import io.flutter.app.FlutterApplication;
import com.clevertap.android.pushtemplates.PushTemplateNotificationHandler;
import com.clevertap.android.sdk.interfaces.NotificationHandler;
import com.clevertap.android.pushtemplates.TemplateRenderer;

public class MyApplication extends FlutterApplication implements CTPushNotificationListener{
    @Override
    public void onCreate() {
        CleverTapAPI.setDebugLevel(3);
        //CleverTapAPI.setUIEditorConnectionEnabled(true);
        ActivityLifecycleCallback.register(this);
        super.onCreate();
        CleverTapAPI cleverTapAPI = CleverTapAPI.getDefaultInstance(getApplicationContext());
        cleverTapAPI.setCTPushNotificationListener(this);
        CleverTapAPI.setNotificationHandler((NotificationHandler)new PushTemplateNotificationHandler());
        TemplateRenderer.setDebugLevel(3);
//        Log.d("payload","Tets");
    }
    @Override
    public void onNotificationClickedPayloadReceived(HashMap<String, Object> payload) {
        //Use your custom logic for  the payload
        Log.d("payload","Tets");
//        GetMethodChannel(payload);
    }
}