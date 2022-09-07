package kr.co.seoulit.logistics.logiinfosvc.help.Mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kr.co.seoulit.logistics.logiinfosvc.help.to.BoardFileDto;
import kr.co.seoulit.logistics.logiinfosvc.help.to.replyTO;
import org.apache.ibatis.annotations.Mapper;

import kr.co.seoulit.logistics.logiinfosvc.help.to.boardTO2;
@Mapper
public interface BoardMapper {

	public ArrayList<boardTO2> selectBoardList();
	public ArrayList<boardTO2> selectBoardList2(String username);

	public ArrayList<replyTO> selectReplyList(String frmname);

	public ArrayList<BoardFileDto> selectFileList(String seq_num);
	public void insertContent(Map<String,Object> map);
	public boardTO2 selectcontent(long seq);
	public void deleteboardcontent(long seq);

	public void insertreply(replyTO reply);

	void insertBoardFileList(BoardFileDto list);

	
}
