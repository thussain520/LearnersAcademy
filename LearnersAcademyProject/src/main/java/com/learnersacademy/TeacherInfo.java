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
@Table(name = "teacherinfo")
public class TeacherInfo implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int tId;
	private int userId;
	private int classId;
	private int subId;
	@Column(name = "createdBy")
	private int cBy;
	@UpdateTimestamp
	@Temporal(TemporalType.TIMESTAMP)
	private Date creationDate;

	public TeacherInfo() {
		
	}

	public TeacherInfo(int tId, int userId, int classId, int subId, int cBy, Date creationDate) {
		super();
		this.tId = tId;
		this.userId = userId;
		this.classId = classId;
		this.subId = subId;
		this.cBy = cBy;
		this.creationDate = creationDate;
	}

	public int gettId() {
		return tId;
	}

	public void settId(int tId) {
		this.tId = tId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getClassId() {
		return classId;
	}

	public void setClassId(int classId) {
		this.classId = classId;
	}

	public int getSubId() {
		return subId;
	}

	public void setSubId(int subId) {
		this.subId = subId;
	}

	public int getcBy() {
		return cBy;
	}

	public void setcBy(int cBy) {
		this.cBy = cBy;
	}

	public Date getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}	
	
}
