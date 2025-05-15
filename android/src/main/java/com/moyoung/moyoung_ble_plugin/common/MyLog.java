package com.moyoung.moyoung_ble_plugin.common;

import android.util.Log;

public class MyLog {
    private static final boolean isLog = true;
    public static void d(String className, String message) {
        if (isLog) {
            Log.d(className, message);
        }
    }

    public static void i(String className, String message) {
        if (isLog) {
            Log.i(className, message);
        }
    }
}
