package com.example.chameleon;

import android.os.Build;
import android.provider.Settings;
import androidx.annotation.NonNull;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.embedding.engine.FlutterEngine;

public class MainActivity extends FlutterFragmentActivity {
    private static final String CHANNEL = "developer_options/check";


    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("checkDeveloperOptions")) {
                        boolean isEnabled = isDeveloperOptionsEnabled();
                        result.success(isEnabled);
                    } else {
                        result.notImplemented();
                    }
                }
        );
    }

    private boolean isDeveloperOptionsEnabled() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
            // Return the developer options setting without catching exception
            return Settings.Global.getInt(getContentResolver(), Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, 0) != 0;
        }
        return false;
    }
}

