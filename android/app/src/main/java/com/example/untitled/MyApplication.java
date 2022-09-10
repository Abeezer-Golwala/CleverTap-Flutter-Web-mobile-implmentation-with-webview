package com.example.untitled;

import io.flutter.app.FlutterApplication;
import com.clevertap.android.sdk.pushnotification.CTPushNotificationListener;
import com.clevertap.android.sdk.ActivityLifecycleCallback;
import com.clevertap.android.sdk.CleverTapAPI;
import android.util.Log;
import java.util.HashMap;
import io.flutter.app.FlutterApplication;

public class MyApplication extends FlutterApplication implements CTPushNotificationListener{
    @Override
    public void onCreate() {
        CleverTapAPI.setDebugLevel(3);
        //CleverTapAPI.setUIEditorConnectionEnabled(true);
        ActivityLifecycleCallback.register(this);
        super.onCreate();
        CleverTapAPI cleverTapAPI = CleverTapAPI.getDefaultInstance(getApplicationContext());
        cleverTapAPI.setCTPushNotificationListener(this::onNotificationClickedPayloadReceived);
    }

    @Override
    public void onNotificationClickedPayloadReceived(HashMap<String, Object> payload) {
        //Use your custom logic for  the payload
        Log.d("payload","Tets");
//        GetMethodChannel(payload);
    }
}