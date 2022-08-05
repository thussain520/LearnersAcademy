package com.learnersacademy;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name = "subjects")
public class Subjects implements Serializable{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int subId;
	private String subName;
	private int userId;
	@UpdateTimestamp
	@Temporal(TemporalType.TIMESTAMP)
	private Date creationDate;
	
	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name = "userId", insertable = false, updatable = false)
	private Users user;
	
	
	public Subjects(int subId, String subName, int userId, Date creationDate, Users user) {
		super();
		this.subId = subId;
		this.subName = subName;
		this.userId = userId;
		this.creationDate = creationDate;
		this.user = user;
	}
	public Subjects() {

	}
	public int getSubId() {
		return subId;
	}
	public void setSubId(int subId) {
		this.subId = subId;
	}
	public String getSubName() {
		return subName;
	}
	public void setSubName(String subName) {
		this.subName = subName;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public Date getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}
	public Users getUser() {
		return user;
	}
	public void setUser(Users user) {
		this.user = user;
	}
	
}
