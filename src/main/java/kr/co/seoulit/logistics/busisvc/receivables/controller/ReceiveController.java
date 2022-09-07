package kr.co.seoulit.logistics.busisvc.receivables.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import kr.co.seoulit.logistics.busisvc.logisales.to.ContractInfoTO;
import kr.co.seoulit.logistics.busisvc.logisales.to.EstimateTO;
import kr.co.seoulit.logistics.busisvc.receivables.service.ReceiveService;
import kr.co.seoulit.logistics.busisvc.receivables.to.AdvReciveTO;
import kr.co.seoulit.logistics.busisvc.receivables.to.ReceivablesTO;
import kr.co.seoulit.logistics.busisvc.sales.service.SalesService;
import kr.co.seoulit.logistics.busisvc.sales.to.DeliveryInfoTO;
import kr.co.seoulit.logistics.purcstosvc.stock.to.StockTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/receiv/*")
public class ReceiveController {
	


	@Autowired
	private ReceiveService receiveService;

	@Autowired
	private SalesService salesService;

	ModelMap map=null;

	private static Gson gson = new GsonBuilder().serializeNulls().create(); // 속성값이 null 인 속성도 변환



	@RequestMapping(value="/receivelist" ,method=RequestMethod.GET)
	public ModelMap searchSalesHistoryList(HttpServletRequest request, HttpServletResponse response) {


		String manarec =request.getParameter("managerRecInfo");
		System.out.println("manarec??"+manarec);

		map = new ModelMap();

		HashMap<String,String> manarecInfo = gson.fromJson(manarec, new TypeToken<HashMap<String,String>>() {
		}.getType());

		System.out.println("manarecInfo???"+manarecInfo);

		HashMap<String,Object> receiveList = null;

		receiveList = receiveService.getReceiveList(manarecInfo);
		System.out.println("salesList????"+receiveList);
		System.out.println("보내는값sales???"+manarecInfo);


		map.put("salesList", receiveList);
		map.put("errorCode", 0);
		map.put("errorMsg", "성공");
		System.out.println("map에는????"+map);

		return map;
	}

	@RequestMapping(value="/receivedCashlist" , method=RequestMethod.GET)
	public ModelMap searchReceivedCashList(HttpServletRequest request, HttpServletResponse response) {
		map = new ModelMap();
		System.out.println("asdasdasdsad");
		try {
			ArrayList<AdvReciveTO> reciveList = receiveService.getReceiveCashList();

			map.put("gridRowJson", reciveList);
			map.put("errorCode", 1);
			map.put("errorMsg", "성공");
		} catch (Exception e1) {
			e1.printStackTrace();
			map.put("errorCode", -1);
			map.put("errorMsg", e1.getMessage());
		}
		return map;
	}




	@RequestMapping(value="/addReceive", method=RequestMethod.POST)
	public ModelMap addNewReceiv(HttpServletRequest request, HttpServletResponse response) {
		String estimateDate = request.getParameter("estimateDate");
		String newReceivInfo = request.getParameter("newReceivRowValue");
		System.out.print("newReceivInfo??"+newReceivInfo);
		System.out.print("estimateDate??"+estimateDate);
		AdvReciveTO newReceiveTO = gson.fromJson(newReceivInfo, AdvReciveTO.class);

		map = new ModelMap();

		try {
			HashMap<String, Object> resultList =null;
			resultList = receiveService.addNewReceive(newReceiveTO);
			System.out.println("resultList???"+resultList);
			map.put("result", resultList);
			map.put("errorCode", 1);
			map.put("errorMsg", "성공");
		} catch (Exception e1) {
			e1.printStackTrace();
			map.put("errorCode", -1);
			map.put("errorMsg", e1.getMessage());
		}
		return map;
	}

	@RequestMapping(value="/deliverylistForReceive" ,method=RequestMethod.GET)
	public ModelMap searchDeliveryListForReceive(HttpServletRequest request, HttpServletResponse response) {
		String cucode = request.getParameter("customerCode");
		System.out.println("customerCode???"+cucode);
		map = new ModelMap();
		HashMap<String,String> cmap = new HashMap<>();
		cmap.put("cucode",cucode);
		try {
			ArrayList<DeliveryInfoTO> deliveryHistoryList = null;
			deliveryHistoryList = salesService.getDeliveryListForReceive(cmap);
			map.put("gridRowJson", deliveryHistoryList);
			map.put("errorCode", 0);
			map.put("errorMsg", "성공");
			System.out.println("딜리버리map???"+map);
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
