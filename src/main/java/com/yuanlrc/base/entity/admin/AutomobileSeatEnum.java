package com.yuanlrc.base.entity.admin;

/**
    汽车座位
 */
public enum  AutomobileSeatEnum {

    TWOSEATS(0,"2座"),
    FOURSEATS(1,"4座"),
    FIVESEATS(2,"5座"),
    SEVENSEATS(3,"7座");


    private Integer code;

    private String name;

    AutomobileSeatEnum(Integer code, String name) {
        this.code = code;
        this.name = name;
    }

    public static String getByCode(int code){
        for (AutomobileSeatEnum value : AutomobileSeatEnum.values()){
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
