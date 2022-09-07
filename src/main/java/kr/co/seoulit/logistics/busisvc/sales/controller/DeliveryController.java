package kr.co.seoulit.logistics.busisvc.sales.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.seoulit.logistics.busisvc.logisales.to.SalesHistoryTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import kr.co.seoulit.logistics.busisvc.sales.service.SalesService;
import kr.co.seoulit.logistics.busisvc.logisales.to.ContractInfoTO;
import kr.co.seoulit.logistics.busisvc.sales.to.DeliveryInfoTO;

@RestController
@RequestMapping("/sales/*")
public class DeliveryController {
	
	@Autowired
	private SalesService salesService;
	
	ModelMap map=null;

	private static Gson gson = new GsonBuilder().serializeNulls().create(); // 속성값이 null 인 속성도 변환

	/*@RequestMapping(value="/delivery/list" ,method=RequestMethod.GET)
	public ModelMap searchDeliveryInfoList(HttpServletRequest request, HttpServletResponse response) {
		ArrayList<DeliveryInfoTO> deliveryInfoList = null;
		map = new ModelMap();
		try {
			deliveryInfoList = salesService.getDeliveryInfoList();

			map.put("gridRowJson", deliveryInfoList);
			map.put("errorCode", 0);
			map.put("errorMsg", "성공");
		} catch (Exception e1) {
			e1.printStackTrace();
			map.put("errorCode", -1);
			map.put("errorMsg", e1.getMessage());
		}
		return map;
	}
*/


	@RequestMapping(value="/searchSalesList" ,method=RequestMethod.POST)
	public ModelMap searchSalesHistoryList(HttpServletRequest request, HttpServletResponse response) {


		String salesInfo =request.getParameter("ableContractInfo");
		System.out.println("히스토리salesInfo은?"+salesInfo);

		map = new ModelMap();

		HashMap<String,String> sales = gson.fromJson(salesInfo, new TypeToken<HashMap<String,String>>() {
		}.getType());

		System.out.println("sales???"+sales);

		HashMap<String,Object> salesList = null;

		salesList = salesService.getSalesContractList(sales);
		System.out.println("salesList????"+salesList);
		System.out.println("보내는값sales???"+sales);
		map.put("salesList", salesList);
		map.put("errorCode", 0);
		map.put("errorMsg", "성공");
		System.out.println("map에는????"+map);

		return map;
	}


	@RequestMapping(value="/searchSalesListDetail" ,method=RequestMethod.GET)
	public ModelMap searchSalesHistoryListDetail(HttpServletRequest request, HttpServletResponse response) {
		String contractno = request.getParameter("contractNo");
		System.out.println("contract??"+contractno);

		map = new ModelMap();

		HashMap<String,String> conMap = new HashMap<>();

		conMap.put("contractno",contractno);
		System.out.println("conMap??"+conMap);
		HashMap<String,Object> salesListDetail = null;
		salesListDetail = salesService.getSalesContractListDetail(conMap);
		System.out.println("salesListDetail????"+salesListDetail);
		System.out.println("보내는값contractno???"+contractno);
		map.put("salesListDetail", salesListDetail);
		map.put("errorCode", 0);
		map.put("errorMsg", "성공");
		System.out.println("map에는????"+map);

		return map;
	}

	@RequestMapping(value="/delivery/batch" ,method=RequestMethod.POST)
	public ModelMap deliveryBatchListProcess(HttpServletRequest request, HttpServletResponse response) {
		String batchList = request.getParameter("batchList");
		map = new ModelMap();
		try {
			List<DeliveryInfoTO> deliveryTOList = gson.fromJson(batchList, new TypeToken<ArrayList<DeliveryInfoTO>>() {
			}.getType());
			HashMap<String, Object> resultMap = salesService.batchDeliveryListProcess(deliveryTOList);

			map.put("result", resultMap);
			map.put("errorCode", 1);
			map.put("errorMsg", "성공");
		} catch (Exception e1) {
			e1.printStackTrace();
			map.put("errorCode", -1);
			map.put("errorMsg", e1.getMessage());

		} 
		return map;
	}

	@RequestMapping(value="/deliver/list/contractavailable" ,method=RequestMethod.GET)
	public ModelMap searchDeliverableContractList(HttpServletRequest request, HttpServletResponse response) {
		String ableContractInfo =request.getParameter("ableContractInfo");
		System.out.println("ableContractInfo??"+ableContractInfo);
		map = new ModelMap();
		try {
			HashMap<String,String> ableSearchConditionInfo = gson.fromJson(ableContractInfo, new TypeToken<HashMap<String,String>>() {
			}.getType());
			
			ArrayList<ContractInfoTO> deliverableContractList = null;
			deliverableContractList = salesService.getDeliverableContractList(ableSearchConditionInfo);
			map.put("gridRowJson", deliverableContractList);
			map.put("errorCode", 0);
			map.put("errorMsg", "성공");
		} catch (Exception e1) {
			e1.printStackTrace();
			map.put("errorCode", -1);
			map.put("errorMsg", e1.getMessage());
		} 
		return map;
	}

	@RequestMapping(value="/deliverylist" ,method=RequestMethod.GET)
	public ModelMap searchDeliveryList(HttpServletRequest request, HttpServletResponse response) {
		String deliveryInfo =request.getParameter("deliveryInfo");
		System.out.println("deliveryInfo??"+deliveryInfo);
		map = new ModelMap();
		try {
			HashMap<String,String> ableSearchConditionInfo = gson.fromJson(deliveryInfo, new TypeToken<HashMap<String,String>>() {
			}.getType());

			ArrayList<DeliveryInfoTO> deliveryHistoryList = null;
			deliveryHistoryList = salesService.getDeliveryList(ableSearchConditionInfo);

			map.put("gridRowJson", deliveryHistoryList);
			map.put("errorCode", 0);
			map.put("errorMsg", "성공");
			System.out.println("map???"+map);
		} catch (Exception e1) {
			e1.printStackTrace();
			map.put("errorCode", -1);
			map.put("errorMsg", e1.getMessage());
		}
		return map;
	}


	@RequestMapping(value="/deliver" ,method=RequestMethod.POST)
	public ModelMap deliver(HttpServletRequest request, HttpServletResponse response) {
		String contractDetailNo = request.getParameter("contractDetailNo");
		map = new ModelMap();
		try {
			map = salesService.deliver(contractDetailNo);
		} catch (Exception e1) {
			e1.printStackTrace();
			map.put("errorCode", -1);
			map.put("errorMsg", e1.getMessage());
		}
		return map;
	}

}
