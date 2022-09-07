package kr.co.seoulit.logistics.purcstosvc.purchase.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import kr.co.seoulit.logistics.purcstosvc.purchase.service.PurchaseService;
import kr.co.seoulit.logistics.purcstosvc.purchase.to.BomItemTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Collections;

@RestController
@RequestMapping("/bom/*")
public class BomListController {
	
	@Autowired
	private PurchaseService purchaseService;

	ModelMap map = null;
	private static Gson gson = new GsonBuilder().serializeNulls().create();


	@RequestMapping(value="/parent/list", method=RequestMethod.GET)
	public ModelMap searchParentBom(HttpServletRequest request, HttpServletResponse response) {

		map = new ModelMap();
		ArrayList<BomItemTO> bomList =null;
		try {
			bomList = purchaseService.getBomList();
			System.out.println("bomList??"+bomList);
			map.put("bomList", bomList);
			map.put("errorCode", 1);
			map.put("errorMsg", "성공");
		} catch (Exception e1) {
			e1.printStackTrace();
			map.put("errorCode", -1);
			map.put("errorMsg", e1.getMessage());
		}
		return map;
	}

	@RequestMapping(value="/child/bomlist", method=RequestMethod.GET)
	public ModelMap searchChildBom( @RequestParam("itemCode")String code) {

		map = new ModelMap();
		ArrayList<BomItemTO> bomChildList =null;
		System.out.println("code???"+code);


		try {
			bomChildList = purchaseService.getBomChildList(code);
			System.out.println("bomChildList??"+bomChildList);
			map.put("bomChildList", bomChildList);
			map.put("errorCode", 1);
			map.put("errorMsg", "성공");
		} catch (Exception e1) {
			e1.printStackTrace();
			map.put("errorCode", -1);
			map.put("errorMsg", e1.getMessage());
		}
		return map;
	}

}
