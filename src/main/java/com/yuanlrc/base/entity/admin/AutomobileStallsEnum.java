package com.yuanlrc.base.entity.admin;

/**
 * 汽车排挡
 */
public enum AutomobileStallsEnum {

    MANUALOPERATION(0,"手动"),
    SELFMOTION(1,"自动"),
    INFINITELYVARIABLESPEEDS(2,"无级变速"),
    SINCETHEONEHAND(3,"手自一体"),
    DUALCLUTCH(4,"双离合");


    private Integer code;

    private String name;

    AutomobileStallsEnum(Integer code, String name) {
        this.code = code;
        this.name = name;
    }

    public static String getByCode(int code){
        for (AutomobileStallsEnum value : AutomobileStallsEnum.values()){
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
