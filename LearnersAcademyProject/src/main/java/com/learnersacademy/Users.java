package com.learnersacademy;

import java.io.Serializable;
import org.hibernate.annotations.GenerationTime;
import org.hibernate.annotations.UpdateTimestamp;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.annotation.Generated;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name = "users")
public class Users implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int userId;
	private String username;
	private String password;
	private String name;
	private int roleId;
	private Integer classId;
	
	@Column(name = "createdBy")
	private Integer cBy;
	
	@OneToOne
	@JoinColumn(name="createdBy", insertable = false, updatable = false)
	private Users createdBy;
	
	@UpdateTimestamp
	@Temporal(TemporalType.TIMESTAMP)
	private Date creationDate;
	
	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name = "roleId", insertable = false, updatable = false)
	private Roles role;
	
	public Users(int userId, String username, String password, String name, int roleId, Integer classId, Integer cBy,
			Users createdBy, Date creationDate, Roles role) {
		super();
		this.userId = userId;
		this.username = username;
		this.password = password;
		this.name = name;
		this.roleId = roleId;
		this.classId = classId;
		this.cBy = cBy;
		this.createdBy = createdBy;
		this.creationDate = creationDate;
		this.role = role;
	}


	public Users() {
		
	}
	

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public Integer getClassId() {
		return classId;
	}

	public void setClassId(Integer classId) {
		this.classId = classId;
	}

	public Roles getRole() {
		return role;
	}
	public void setRole(Roles role) {
		this.role = role;
	}


	public Users getCreatedBy() {
		return createdBy;
	}


	public void setCreatedBy(Users createdBy) {
		this.createdBy = createdBy;
	}


	public Integer getcBy() {
		return cBy;
	}


	public void setcBy(Integer cBy) {
		this.cBy = cBy;
	}


	public Date getCreationDate() {
		return creationDate;
	}


	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}
	
	
	
}
