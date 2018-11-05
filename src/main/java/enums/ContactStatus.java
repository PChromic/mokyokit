package enums;

import com.google.gson.annotations.SerializedName;

public enum ContactStatus {

    @SerializedName("niezainteresowany")
    NOT_INTERESTED,

    @SerializedName("nie_ma_w_domu")
    NOT_AT_HOME,

    @SerializedName("poczta_glosowa")
    VOICE_MAIL,

    @SerializedName("zainteresowany")
    INTERESTED
}
