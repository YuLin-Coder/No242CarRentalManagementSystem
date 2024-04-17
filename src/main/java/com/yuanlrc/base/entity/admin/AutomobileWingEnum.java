package com.yuanlrc.base.entity.admin;

public enum AutomobileWingEnum {

    PEUGECE(0,"两厢"),
    SALOON(1,"三厢"),
    HALFASTA(2,"两厢半车");

    private Integer code;

    private String name;

    AutomobileWingEnum(Integer code, String name) {
        this.code = code;
        this.name = name;
    }

    public static String getByCode(int code){
        for (AutomobileWingEnum value : AutomobileWingEnum.values()){
            if (code == value.getCode()){
                return value.getName();
            }
        }
        return null;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}
