package com.moyoung.moyoung_ble_plugin.common;

import android.graphics.Bitmap;
import android.graphics.Matrix;
import android.util.Log;

public class ImageUtils {
    public static Bitmap resizingBitmap(Bitmap bitmap, int width, int height) {

        // 等比例缩放图片
        int w = bitmap.getWidth();
        int h = bitmap.getHeight();
        Matrix matrix = new Matrix();
        matrix.postScale((float) width / w, (float) height / h);
        return Bitmap.createBitmap(bitmap, 0, 0, w, h, matrix, true);
    }
}
