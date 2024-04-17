package com.yuanlrc.base.entity.admin;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.yuanlrc.base.annotion.ValidateEntity;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 后台用户实体类
 * @author Administrator
 *
 */
@Entity
@Table(name="ylrc_user")
@EntityListeners(AuditingEntityListener.class)
public class User extends BaseEntity{

	private static final long serialVersionUID = 1L;
	
	private static final int USER_SEX_MAN = 1;//性别男
	
	private static final int USER_SEX_WOMAN = 2;//性别女
	
	private static final int USER_SEX_UNKONW = 0;//性别未知
	
	public static final int ADMIN_USER_STATUS_ENABLE = 1;//用户状态正常可用
	public static final int ADMIN_USER_STATUS_UNABLE = 0;//用户状态不可用

	public static final int ADMIN = 0;	//管理员
	public static final int SHOPS = 1;	//店铺
	public static final int SENDTHECARPOINT =2;  //送车点

	@ManyToOne
	@JoinColumn(name="role_id")
	private Role role;//用户所属角色
	
	@ValidateEntity(required=true,requiredLeng=true,minLength=4,maxLength=18,errorRequiredMsg="登录名称不能为空!",errorMinLengthMsg="登录名称长度需大于4!",errorMaxLengthMsg="登录名称长度不能大于18!")
	@Column(name="username",nullable=false,length=18,unique=true)
	private String username;//用户名
	
	@ValidateEntity(required=true,requiredLeng=true,minLength=4,maxLength=32,errorRequiredMsg="登录密码不能为空！",errorMinLengthMsg="登录密码长度需大于4!",errorMaxLengthMsg="登录密码长度不能大于32!")
	@Column(name="password",nullable=false,length=32)
	private String password;//登录密码
	
	@ValidateEntity(required=false)
	@Column(name="status",length=1)
	private int status = ADMIN_USER_STATUS_ENABLE; //用户状态,默认可用
	
	@ValidateEntity(required=false)
	@Column(name="head_pic",length=128)
	private String headPic; //用户头像
	
	@ValidateEntity(required=false)
	@Column(name="sex",length=1)
	private int sex = USER_SEX_UNKONW; //用户性别
	
	@ValidateEntity(required=false)
	@Column(name="mobile",length=15)
	private String mobile; //用户手机号
	
	@ValidateEntity(required=false)
	@Column(name="email",length=32)
	private String email; //用户邮箱

	@ValidateEntity(required=false)
	@Column(name="shop_name")
	private String shopName; //店铺名字

	@ValidateEntity(required=false)
	@Column(name="province")
	private String province; //地址省

	@ValidateEntity(required=false)
	@Column(name="city")
	private String city;	//地址城市

	@ValidateEntity(required=false)
	@Column(name="district")
	private String district; 	//地址区

	@ValidateEntity(required=false)
	@Column(name="site")
	private String site;//店铺地址

	@ValidateEntity(required=false)
	@Column(name="longitude_and_latitude")
	private String longitudeAndLatitude;//经纬

	@Column(name="type")
	private Integer type; //类型(判断后台管理员|店铺送车点)

	@Temporal(TemporalType.TIME)
	@ValidateEntity(required = false)
	@Column(name="opening_hours")
	@DateTimeFormat(pattern="HH:mm")
	@JsonFormat(pattern="HH:mm",timezone = "GMT+8")
	private Date openingHours;	//营业开始时间

	@Temporal(TemporalType.TIME)
	@ValidateEntity(required = false)
	@Column(name="close_of_business")
	@DateTimeFormat(pattern="HH:mm")
	@JsonFormat(pattern="HH:mm",timezone = "GMT+8")
	private Date closeOfBusiness;	//营业结束时间

	@ValidateEntity(required = false)
	@Column(name="service_charge")
	private Double serviceCharge;  //服务费

	public Double getServiceCharge() {
		return serviceCharge;
	}

	public void setServiceCharge(Double serviceCharge) {
		this.serviceCharge = serviceCharge;
	}

	public String getLongitudeAndLatitude() {
		return longitudeAndLatitude;
	}

	public void setLongitudeAndLatitude(String longitudeAndLatitude) {
		this.longitudeAndLatitude = longitudeAndLatitude;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public Date getOpeningHours() {
		return openingHours;
	}

	public void setOpeningHours(Date openingHours) {
		this.openingHours = openingHours;
	}

	public Date getCloseOfBusiness() {
		return closeOfBusiness;
	}

	public void setCloseOfBusiness(Date closeOfBusiness) {
		this.closeOfBusiness = closeOfBusiness;
	}


	//	@ValidateEntity(required=false)
//	@Column(name="shop_type")
//	private Integer shopType; //类型(判断后台店铺|送车点)
//
//	public Integer getShopType() {
//		return shopType;
//	}
//
//	public void setShopType(Integer shopType) {
//		this.shopType = shopType;
//	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public String getSite() {
		return site;
	}

	public void setSite(String site) {
		this.site = site;
	}


	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getHeadPic() {
		return headPic;
	}

	public void setHeadPic(String headPic) {
		this.headPic = headPic;
	}

	public int getSex() {
		return sex;
	}

	public void setSex(int sex) {
		this.sex = sex;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "DeskUser [role=" + role + ", username=" + username + ", password="
				+ password + ", status=" + status + ", headPic=" + headPic
				+ ", sex=" + sex + ", mobile=" + mobile + ", email=" + email
				+ "]";
	}

	
	
	
}
