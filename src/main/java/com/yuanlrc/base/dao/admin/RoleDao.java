package com.yuanlrc.base.dao.admin;
/**
 * 后台角色数据库操作层
 */
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.yuanlrc.base.entity.admin.Role;

import java.util.List;


@Repository
public interface RoleDao extends JpaRepository<Role, Long> {
	@Query("select r from Role r where r.id = :id")
	Role find(@Param("id")Long id);

	Role findFirstByType(Integer type);

	List<Role> findByType(@Param("type")Integer type);


}
