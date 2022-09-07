package kr.co.seoulit.logistics.logiinfosvc.help.to;

import lombok.Data;

@Data
public class replyTO extends BaseTO2{

	private String replyNo;
	private String replyText;
	private String replyWriter;
	private String regDate;
	private String frmname;

}