package kr.co.seoulit.logistics.purcstosvc.stock.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import kr.co.seoulit.logistics.purcstosvc.stock.service.StockService;
import kr.co.seoulit.logistics.purcstosvc.stock.to.StockChartTO;
import kr.co.seoulit.logistics.purcstosvc.stock.to.StockLogTO;
import kr.co.seoulit.logistics.purcstosvc.stock.to.StockTO;

@RestController
@RequestMapping("/stock/*")
public class StockController {

	@Autowired
	private StockService stockService;
	
	ModelMap map = null;

	private static Gson gson = new GsonBuilder().serializeNulls().create(); // 속성값이 null 인 속성도 json 변환

	@RequestMapping(value="/sto/list" , method=RequestMethod.GET)
	public ModelMap searchStockList(HttpServletRequest request, HttpServletResponse response) {
		map = new ModelMap();
		try {
			ArrayList<StockTO> stockList = stockService.getStockList();
			
			map.put("gridRowJson", stockList);
			map.put("errorCode", 1);
			map.put("errorMsg", "성공");
		} catch (Exception e1) {
			e1.printStackTrace();
			map.put("errorCode", -1);
			map.put("errorMsg", e1.getMessage());
		}
		return map;
	}

	@RequestMapping(value="/sto/log-list" , method=RequestMethod.GET)
	public ModelMap searchStockLogList(@RequestParam("startDate")String startDate,@RequestParam("endDate")String endDate) {

		map = new ModelMap();
		try {
			ArrayList<StockLogTO> stockLogList = stockService.getStockLogList(startDate,endDate);

			map.put("gridRowJson", stockLogList);
			map.put("errorCode", 1);
			map.put("errorMsg", "성공");
		} catch (Exception e1) {
			e1.printStackTrace();
			map.put("errorCode", -1);
			map.put("errorMsg", e1.getMessage());
		}
		return map;
	}

	@RequestMapping(value="sto/insertStock" , method=RequestMethod.POST)
	public ModelMap extraInsertStock(@RequestParam("quantity")String quantity,@RequestParam("camera")String camera,@RequestParam("stock")String stock) {

		System.out.println(("quantity??"+quantity));
		System.out.println(("camera??"+camera));
		System.out.println(("stock??"+stock));

		System.out.println("quantity??"+quantity);
		System.out.println("camera??"+camera);


		map= stockService.insertStockItem(quantity,camera,stock);

		map.put("errorCode", 1);
		map.put("errorMsg", "성공");


		return map;
	}

	@RequestMapping(value="/sto/warehousing" , method=RequestMethod.POST)
	public ModelMap warehousing(HttpServletRequest request, HttpServletResponse response) {
		//파람 적용안됨.
		String orderNoListStr= request.getParameter("orderNoList");
		System.out.println("order???"+orderNoListStr);
		map = new ModelMap();
		ArrayList<String> orderNoArr = gson.fromJson(orderNoListStr,new TypeToken<ArrayList<String>>(){}.getType());
		try {
			map = stockService.warehousing(orderNoArr);
		} catch (Exception e1) {
			e1.printStackTrace();
			map.put("errorCode", -1);
			map.put("errorMsg", e1.getMessage());
		}
		return map;
	}
	
	@RequestMapping(value="/sto/safetyallowanceamountchange" , method=RequestMethod.POST)
	public ModelMap safetyAllowanceAmountChange(@RequestParam("itemCode")String itemCode,@RequestParam("itemName")String itemName,@RequestParam("safetyAllowanceAmount")String safetyAllowanceAmount) {

		map = new ModelMap();
		try {
			map = stockService.changeSafetyAllowanceAmount(itemCode,itemName,safetyAllowanceAmount);
		} catch (Exception e1) {
			e1.printStackTrace();
			map.put("errorCode", -1);
			map.put("errorMsg", e1.getMessage());
		}
		return map;
	}
	
	@RequestMapping(value="/sto/chart" , method=RequestMethod.GET)
	public ModelMap getStockChart(HttpServletRequest request, HttpServletResponse response) {
		map = new ModelMap();
		try {
			ArrayList<StockChartTO> stockList = stockService.getStockChart();

			map.put("gridRowJson", stockList);
			map.put("errorCode", 1);
			map.put("errorMsg", "성공");
		} catch (Exception e1) {
			e1.printStackTrace();
			map.put("errorCode", -1);
			map.put("errorMsg", e1.getMessage());
		}
		return map;
	}
	
	@RequestMapping(value="/sto/warehousestocklist" , method=RequestMethod.GET)
	public ModelMap searchWarehouseStockList(@RequestParam("warehouseCode")String warehouseCode) {

		map = new ModelMap();
		try {
			ArrayList<StockTO> stockList = stockService.getWarehouseStockList(warehouseCode);
	
			map.put("gridRowJson", stockList);
			map.put("errorCode", 1);
			map.put("errorMsg", "성공");
		} catch (Exception e1) {
			e1.printStackTrace();
			map.put("errorCode", -1);
			map.put("errorMsg", e1.getMessage());
		}
		return map;
	}
	
	@RequestMapping(value="/sto/batch" , method=RequestMethod.POST)
	public ModelMap modifyStockInfo(@RequestParam("batchList")String batchList) {

		map = new ModelMap();
		try {
			ArrayList<StockTO> stockTOList = gson.fromJson(batchList,
					new TypeToken<ArrayList<StockTO>>() {}.getType());
		
			stockService.batchStockProcess(stockTOList);
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
