package kr.co.seoulit.logistics.logiinfosvc.help.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jdk.swing.interop.SwingInterOpUtils;
import kr.co.seoulit.logistics.logiinfosvc.help.common.FileUtils;
import kr.co.seoulit.logistics.logiinfosvc.help.to.BoardFileDto;
import kr.co.seoulit.logistics.logiinfosvc.help.to.replyTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import kr.co.seoulit.logistics.logiinfosvc.help.Mapper.BoardMapper;
import kr.co.seoulit.logistics.logiinfosvc.help.to.boardTO2;
import org.springframework.util.CollectionUtils;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component
public class BoardInfoServiceImpl implements BoardInfoService {
	
	@Autowired
	private BoardMapper boardMapper;

	@Autowired
	private FileUtils fileUtils;


	/*
	 * // SLF4J logger private static Logger logger =
	 * LoggerFactory.getLogger(BoardInfoServiceImpl.class);
	 */

	/*
	 * @Autowired private static BoardInfoService instance;
	 */

	@Override
	public ArrayList<boardTO2> getBoardList() {
		
		ArrayList<boardTO2> boardList = null;
		
			boardList = boardMapper.selectBoardList();
			
			System.out.println("boardList:"+boardList);
		return boardList;
	}
	public ArrayList<boardTO2> getBoardList(String username) {

	
		ArrayList<boardTO2> boardList = null;

			boardList = boardMapper.selectBoardList2(username);
			System.out.print("boardList"+boardList);
		

		return boardList;
	}

	public ArrayList<replyTO> getreplyList(String frmname) {

		ArrayList<replyTO> replyList = null;

		replyList = boardMapper.selectReplyList(frmname);
		System.out.print("replyList"+replyList);

		return replyList;
	}


	public ArrayList<BoardFileDto> getFileList(String seq_num) {

		ArrayList<BoardFileDto> fileList = null;
		System.out.println("seq_num???"+seq_num);
		fileList = boardMapper.selectFileList(seq_num);
		System.out.print("filList"+fileList);

		return fileList;
	}
	

		@Override
		public void addContent(boardTO2 bean , MultipartHttpServletRequest multipartHttpServletRequest) throws Exception {

			Map<String,Object> map = new HashMap<>();
				map.put("frmTitle",bean.getFrmTitle());
				map.put("errnum",bean.getErrnum());
				map.put("username",bean.getUsername());
				map.put("boardStatus",bean.getBoardStatus());
				map.put("frmContents",bean.getFrmContents());

				boardMapper.insertContent(map);
				System.out.println("시퀀스???"+map.get("seq_num"));
			Object seq_num = map.get("seq_num");

			System.out.println("파사드에서 빈값:"+bean);
			List<BoardFileDto> list = FileUtils.parseFileInfo(bean.getSeq_num(), multipartHttpServletRequest);

			System.out.println("list???"+list);
			if(CollectionUtils.isEmpty(list) == false) {
				for(BoardFileDto list2:list){
					list2.setSeq_num((long)map.get("seq_num"));
					boardMapper.insertBoardFileList(list2);
				}
			}
		}

	@Override
	public void addReply(replyTO reply) {

		System.out.println("파사드에서 리플값:"+reply);
		boardMapper.insertreply(reply);

	}

	public boardTO2 getcontents(long seq) {
			
			return boardMapper.selectcontent(seq);
			
		}
		
		public void deleteContents(long seq) {
			
			boardMapper.deleteboardcontent(seq);
			
		}
		
}
