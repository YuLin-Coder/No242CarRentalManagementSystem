package com.yuanlrc.base.entity.admin;

public enum OrderEnum {

    RESERVING(1,"预约中"),
    RENTING(2,"租赁中"),
    COMPLETE(3,"已完成"),
    CANCELED(4,"已取消");

    private Integer code;

    private String name;

    OrderEnum(Integer code, String name) {
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
