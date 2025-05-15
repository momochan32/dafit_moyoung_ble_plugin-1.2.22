package com.moyoung.moyoung_ble_plugin.model;

public class FileTransBean {
    // Konstanta untuk tipe event
    public static final int TRANSSTART = 1;
    public static final int TRANSCHANGED = 2;
    public static final int TRANSCOMPLETED = 3;
    public static final int ERROR = 4;
    public static final int INSTALL_STATE_CHANGED = 5; // Tipe baru untuk status instalasi

    // Fields
    private int type = 0; // Default type jika tidak diset secara eksplisit
    private int progress = 0;
    private int error = 0;
    private boolean state = false; // Field untuk status instalasi (true/false), default ke false

    // Konstruktor default
    public FileTransBean() {
    }

    // Konstruktor untuk tipe event umum (TRANSSTART, TRANSCHANGED, TRANSCOMPLETED, ERROR)
    public FileTransBean(int type) {
        this.type = type;
    }

    // Konstruktor khusus untuk event INSTALL_STATE_CHANGED
    // Ini yang akan kita gunakan di WFFileTransHandler saat onInstallStateChange dipanggil
    public FileTransBean(int type, boolean installState) {
        if (type != INSTALL_STATE_CHANGED) {
            // Idealnya, berikan peringatan atau lempar exception jika tipe tidak sesuai,
            // tapi untuk sekarang kita set saja.
            // Pertimbangkan validasi yang lebih ketat jika perlu.
        }
        this.type = type;
        this.state = installState;
    }

    // Getters and Setters
    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getProgress() {
        return progress;
    }

    public void setProgress(int progress) {
        this.progress = progress;
    }

    public int getError() {
        return error;
    }

    public void setError(int error) {
        this.error = error;
    }

    // Getter untuk field 'state'
    // Menggunakan konvensi 'is' untuk boolean lebih umum di Java, tapi 'get' juga bisa
    public boolean isState() {
        return state;
    }
    
    // Anda juga bisa menggunakan getState() jika lebih disukai, Gson akan menanganinya.
    // public boolean getState() {
    //     return state;
    // }

    public void setState(boolean state) {
        this.state = state;
    }
}