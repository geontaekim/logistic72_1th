package kr.co.seoulit.logistics.logiinfosvc.help.controller;


import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import jdk.swing.interop.SwingInterOpUtils;
import kr.co.seoulit.logistics.logiinfosvc.help.to.BoardFileDto;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import kr.co.seoulit.logistics.logiinfosvc.help.service.BoardInfoService;
import kr.co.seoulit.logistics.logiinfosvc.help.to.boardTO2;
import kr.co.seoulit.logistics.logiinfosvc.help.to.replyTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@RestController
@RequestMapping("/help/*")
@Slf4j
public class BoardSaveCreController {

	ModelMap map = null;
	// SLF4J logger
	
	private static Gson gson = new GsonBuilder().serializeNulls().create();

	 @Autowired 
	private BoardInfoService boardInfoService;
	
	 
	 @PostMapping("/boardSaveCreation")
	public ModelMap addContent(boardTO2 bean, HttpServletRequest request, HttpServletResponse response , MultipartHttpServletRequest multipartHttpServletRequest) throws Exception {

		 System.out.println("bean?:"+bean.toString().trim());
		 System.out.println("multipartHttpServletRequest??"+multipartHttpServletRequest);
		 boardInfoService.addContent(bean,multipartHttpServletRequest);

		 try {
			 String contextPath = request.getContextPath();
			response.sendRedirect(contextPath+"/help/board/view");
		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}


	@PostMapping(value = "/boardSaveCre")
	public ModelMap contentList(HttpServletRequest request, HttpServletResponse response) {

		map = new ModelMap();

		ArrayList<boardTO2> boardList = boardInfoService.getBoardList();

		map.put("contentList", boardList);
		map.put("errorCode", 1);
		map.put("errorMsg", "성공");

		return map;
	}
	@PostMapping(value ="/getboardcontent")
	public ModelMap getcontent(boardTO2 bean) {

		map = new ModelMap();
		System.out.println("bean?"+bean.getSeq_num());
		boardTO2 coninfo = boardInfoService.getcontents(bean.getSeq_num());

		map.put("coninfo", coninfo); 
		map.put("errorCode", 1);
		map.put("errorMsg", "성공");

		return map;
	}
	@DeleteMapping(value="/boardDelete")
	public ModelMap deletecontent(boardTO2 bean) {

		
		map = new ModelMap();


		boardInfoService.deleteContents(bean.getSeq_num());

		map.put("coninfo", null);
		map.put("errorCode", 1);
		map.put("errorMsg", "성공");

		
		return map;
	}
	
	@PostMapping(value ="/myboardSaveCre")
	public ModelMap mycontentList(boardTO2 bean) {

		map = new ModelMap();

		ArrayList<boardTO2> boardList = boardInfoService.getBoardList(bean.getUsername());

		map.put("contentList", boardList);
		map.put("errorCode", 1);
		map.put("errorMsg", "성공");

		
		return map;

	}
	@PostMapping(value ="/replyList")
	public ModelMap replyList(HttpServletRequest request, HttpServletResponse response) {

		map = new ModelMap();
		String frmname=request.getParameter("frmname");
		System.out.println("frmname??"+frmname);
		ArrayList<replyTO> replyList = boardInfoService.getreplyList(frmname);
		if(replyList.size()==0){
			map.put("errorCode", 0);
			map.put("errorMsg", "값이없음");

		}else {
			System.out.println("replyList???" + replyList);
			map.put("replylist", replyList);
			map.put("errorCode", 1);
			map.put("errorMsg", "성공");

		}
		System.out.println("map에는???" + map);
		System.out.println("replyList.size()??"+replyList.size());
		return map;

	}


	@PostMapping(value ="/FileList")
	public ModelMap fileList(HttpServletRequest request, HttpServletResponse response) {

		map = new ModelMap();
		String seq_num=request.getParameter("seq_num");
		System.out.println("seq_num??"+seq_num);
		ArrayList<BoardFileDto> fileList = boardInfoService.getFileList(seq_num);


		if(fileList.size()==0){
			map.put("errorCode", 0);
			map.put("errorMsg", "값이없음");

		}else {
			System.out.println("fileList???" + fileList);
			map.put("fileList", fileList);
			map.put("errorCode", 1);
			map.put("errorMsg", "성공");

		}
		System.out.println("map에는???" + map);
		System.out.println("fileList.size()??"+fileList.size());
		return map;




	}

	@GetMapping (value ="/downloadBoardFile")
	public void downloadBoardFile(HttpServletRequest request, HttpServletResponse response) throws IOException {

		map = new ModelMap();
		String seq_num=request.getParameter("seq_num");
		System.out.println("seq_num??"+seq_num);
		ArrayList<BoardFileDto> fileList = boardInfoService.getFileList(seq_num);
		System.out.println("fileList???"+fileList);
		for(BoardFileDto file:fileList) {
			file.getOriginalFileName();


			if (ObjectUtils.isEmpty(fileList) == false) {
				String fileName = file.getOriginalFileName();

				byte[] files = new byte[0];
					files = FileUtils.readFileToByteArray(new File(file.getStoredFilePath()));
				response.setContentType("application/octet-stream");
				response.setContentLength(files.length);
				response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName, "UTF-8") + "\";");

				response.getOutputStream().write(files);
				response.getOutputStream().flush();
				response.getOutputStream().close();
			}
		}


	}

	@GetMapping(value ="/replyInto")
	public ModelMap replyRegiste(replyTO reply ,HttpServletRequest request, HttpServletResponse response) {


		System.out.println("reply???"+reply);
		boardInfoService.addReply(reply);
		try {
			String contextPath = request.getContextPath();
			response.sendRedirect(contextPath+"/help/board/view");
		} catch (IOException e) {

			e.printStackTrace();
		}

		return null;


	}

}
