package egovframework.example.sample.service;

import java.util.Date;

public class ReplyVO {
	//댓글 번호
	private int replyIdx;
	
	//게시글 번호(외래키)
	private int idx;
	
	//댓글 작성자
	private String writer;
	
	//댓글 내용
	private String reply;
	
	//댓글 작성 일자
	private Date regDate;
	
	public int getReplyIdx() {
		return replyIdx;
	}
	public void setReplyIdx(int replyIdx) {
		this.replyIdx = replyIdx;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
}
