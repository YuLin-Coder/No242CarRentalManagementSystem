package com.yuanlrc.base.entity.admin;

/**
 * 汽车类型
 */
public enum AutomobileTypeEnum {

    ECONOMICAL(0,"经济型","model-pic2"),
    COMFORTABLE(1,"舒适型","model-pic3"),
    ELITE(2,"精英型","model-pic4"),
    SUV(3,"SUV","model-pic5"),
    BUSINESS(4,"5-15座商务","model-pic6"),
    ELECTRIC_TYPE(5,"电动型","model-pic7"),
    HIGH_END_TYPE(6,"高端车","model-pic8");


    private Integer code;

    private String name;

    private String pic;

    AutomobileTypeEnum(Integer code, String name, String pic) {
        this.code = code;
        this.name = name;
        this.pic = pic;
    }


    public static String getByCode(int code){
        for (AutomobileTypeEnum value : AutomobileTypeEnum.values()){
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

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic;
    }
}
