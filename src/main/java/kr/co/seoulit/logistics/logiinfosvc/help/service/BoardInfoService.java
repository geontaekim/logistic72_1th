package kr.co.seoulit.logistics.logiinfosvc.help.service;

import java.util.ArrayList;

import kr.co.seoulit.logistics.logiinfosvc.help.to.BoardFileDto;
import kr.co.seoulit.logistics.logiinfosvc.help.to.replyTO;
import org.springframework.stereotype.Component;

import kr.co.seoulit.logistics.logiinfosvc.help.to.boardTO2;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component
public interface BoardInfoService {

	public ArrayList<boardTO2> getBoardList();
	
	public ArrayList<boardTO2> getBoardList(String username);

	public ArrayList<replyTO> getreplyList(String frmname);

	public ArrayList<BoardFileDto> getFileList(String seq_num);

	public void addContent(boardTO2 bean , MultipartHttpServletRequest multipartHttpServletRequest) throws Exception;
	public void addReply(replyTO reply);
	
	public boardTO2 getcontents(long seq);
	
	public void deleteContents(long seq);
	
}
