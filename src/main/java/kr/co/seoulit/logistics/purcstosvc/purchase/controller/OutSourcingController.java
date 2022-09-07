package kr.co.seoulit.logistics.purcstosvc.purchase.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import kr.co.seoulit.logistics.purcstosvc.purchase.to.PurcSalesTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.co.seoulit.logistics.purcstosvc.purchase.service.PurchaseService;
import kr.co.seoulit.logistics.purcstosvc.purchase.to.OutSourcingTO;

@RestController
@RequestMapping("/purchase/*")
public class OutSourcingController {

	@Autowired
	private PurchaseService purchaseService;




	ModelMap map = null;

	@RequestMapping(value="/outsourcing/list" , method=RequestMethod.GET)
	public ModelMap searchOutSourcingList(HttpServletRequest request, HttpServletResponse response) {
		map = new ModelMap();
		
		try {
			ArrayList<OutSourcingTO> outSourcingList = purchaseService.searchOutSourcingList();
			System.out.println("outSourcingList????"+outSourcingList);
			map.put("outSourcingList", outSourcingList);
			map.put("errorCode", 1);
			map.put("errorMsg", "성공");
		} catch (Exception e1) {
			e1.printStackTrace();
			map.put("errorCode", -1);
			map.put("errorMsg", e1.getMessage());
		} 
		return map;
	}

	@RequestMapping(value="/getOutsourcing/list" , method=RequestMethod.GET)
	public ModelMap getOutSourcingList(@RequestParam("customerCode")String CusCode) {

		System.out.println("CusCode???"+CusCode);
		map = new ModelMap();

		try {
			ArrayList<OutSourcingTO> getoutSourcingList = purchaseService.getOutSourcingList(CusCode);
			System.out.println("getoutSourcingList????"+getoutSourcingList);
			map.put("getoutSourcingList", getoutSourcingList);
			map.put("errorCode", 1);
			map.put("errorMsg", "성공");
		} catch (Exception e1) {
			e1.printStackTrace();
			map.put("errorCode", -1);
			map.put("errorMsg", e1.getMessage());
		}
		return map;
	}

	@RequestMapping(value="/getSumOutsourcing/list" , method=RequestMethod.GET)
	public ModelMap getSumOutSourcingList(@RequestParam("customerCode")String CusCode) {

		System.out.println("CusCode???"+CusCode);
		map = new ModelMap();

		try {
			ArrayList<PurcSalesTO> getSumoutSourcingList = purchaseService.getSumOutSourcingList(CusCode);
			System.out.println("getSumoutSourcingList????"+getSumoutSourcingList);
			map.put("getSumoutSourcingList", getSumoutSourcingList);
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
