package com.moyoung.moyoung_ble_plugin.model;

import com.crrepa.ble.conn.bean.CRPActionDetailsInfo;
import com.crrepa.ble.conn.bean.CRPStepsCategoryInfo;

public class ActionDetailsBean {
    public static final  int STEPSCATEGORYCHANGE = 1;
    public static final int ACTIONDETAILSCHANGE = 2;

    private int type;
    private CRPStepsCategoryInfo stepsCategoryInfo;
    private CRPActionDetailsInfo actionDetailsInfo;

    public ActionDetailsBean(int type) {
        this.type = type;
    }

    public void setStepsCategoryInfo(CRPStepsCategoryInfo stepsCategoryInfo) {
        this.stepsCategoryInfo = stepsCategoryInfo;
    }

    public void setActionDetailsInfo(CRPActionDetailsInfo actionDetailsInfo) {
        this.actionDetailsInfo = actionDetailsInfo;
    }
}
