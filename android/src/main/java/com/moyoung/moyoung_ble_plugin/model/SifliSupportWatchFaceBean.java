package com.moyoung.moyoung_ble_plugin.model;

import java.util.List;

public class SifliSupportWatchFaceBean {
    private List<Integer> typeList;
    private List<SifliWatchFace> list;

    public SifliSupportWatchFaceBean(List<Integer> typeList) {
        this.typeList = typeList;
    }

    public void setList(List<SifliWatchFace> list) {
        this.list = list;
    }

    public static class SifliWatchFace {
        private String state;
        private int id;

        public SifliWatchFace(String state, int id) {
            this.state = state;
            this.id = id;
        }
    }
}
