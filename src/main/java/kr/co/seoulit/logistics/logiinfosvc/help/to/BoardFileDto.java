package kr.co.seoulit.logistics.logiinfosvc.help.to;

import lombok.Data;

@Data
public class BoardFileDto {
	private int idx;
	private long seq_num;
	private String originalFileName;
	private String storedFilePath;
	private long fileSize;

}