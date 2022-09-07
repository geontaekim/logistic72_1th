package kr.co.seoulit.logistics.purcstosvc.stock.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import kr.co.seoulit.logistics.purcstosvc.stock.mapper.BomMapper;
import kr.co.seoulit.logistics.purcstosvc.stock.mapper.StockMapper;
import kr.co.seoulit.logistics.purcstosvc.stock.to.BomDeployTO;
import kr.co.seoulit.logistics.purcstosvc.stock.to.BomInfoTO;
import kr.co.seoulit.logistics.purcstosvc.stock.to.BomTO;
import kr.co.seoulit.logistics.purcstosvc.stock.to.StockChartTO;
import kr.co.seoulit.logistics.purcstosvc.stock.to.StockLogTO;
import kr.co.seoulit.logistics.purcstosvc.stock.to.StockTO;

@Service
public class StockServiceImpl implements StockService {

	@Autowired
	private BomMapper bomMapper;
	@Autowired
	private StockMapper stockMapper;

	@Override
	public ArrayList<BomDeployTO> getBomDeployList(String deployCondition, String itemCode,
			String itemClassificationCondition) {

		ArrayList<BomDeployTO> bomDeployList = null;
		
		HashMap<String, String> map = new HashMap<>();

		map.put("deployCondition", deployCondition);
		map.put("itemCode", itemCode);
		map.put("itemClassificationCondition", itemClassificationCondition);

		bomDeployList = bomMapper.selectBomDeployList(map);

		return bomDeployList;
	}

	@Override
	public ModelMap insertStockItem(String quantity, String camera, String stock) {
		ModelMap resultMap = new ModelMap();
		System.out.println("quantity??" + quantity);
		System.out.println("camera??" + camera);
		System.out.println("stock??" + stock);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("quantity", quantity);
		map.put("camera", camera);

		if (stock.equals("STOCK_AMOUNT") ) {
			stockMapper.extraupdateStock1(map);
		} else if (stock.equals("ORDER_AMOUNT")) {
			stockMapper.extraupdateStock2(map);
		} else if (stock.equals("INPUT_AMOUNT")) {
			stockMapper.extraupdateStock3(map);
		} else if (stock.equals("DELIVERY_AMOUNT")) {
			stockMapper.extraupdateStock4(map);
		} else {
			stockMapper.extraupdateStock5(map);
		}

		return resultMap;
	}

	@Override
	public ArrayList<BomInfoTO> getBomInfoList(String parentItemCode) {

		ArrayList<BomInfoTO> bomInfoList = null;

		bomInfoList = bomMapper.selectBomInfoList(parentItemCode);

		return bomInfoList;
	}


	@Override
	public ArrayList<BomInfoTO> getAllItemWithBomRegisterAvailable() {

		ArrayList<BomInfoTO> allItemWithBomRegisterAvailable = null;

		allItemWithBomRegisterAvailable = bomMapper.selectAllItemWithBomRegisterAvailable();

		return allItemWithBomRegisterAvailable;
	}

	@Override
	public HashMap<String, Object> batchBomListProcess(ArrayList<BomTO> batchBomList) {

		HashMap<String, Object> resultMap = new HashMap<>();

		int insertCount = 0;
		int updateCount = 0;
		int deleteCount = 0;

		for (BomTO TO : batchBomList) {

			String status = TO.getStatus();

			switch (status) {

			case "INSERT":

				bomMapper.insertBom(TO);

				insertCount++;

				break;

			case "UPDATE":

				bomMapper.updateBom(TO);

				updateCount++;

				break;

			case "DELETE":

				bomMapper.deleteBom(TO);

				deleteCount++;

				break;

			}

		}

		resultMap.put("INSERT", insertCount);
		resultMap.put("UPDATE", updateCount);
		resultMap.put("DELETE", deleteCount);

		return resultMap;

	}


	@Override
	public ArrayList<StockTO> getStockList() {

		ArrayList<StockTO> stockList = null;

		stockList = stockMapper.selectStockList();

		return stockList;
	}

	@Override
	public ArrayList<StockLogTO> getStockLogList(String startDate, String endDate) {

		ArrayList<StockLogTO> stockLogList = null;
		
		HashMap<String, String> map = new HashMap<>();

		map.put("startDate", startDate);
		map.put("endDate", endDate);

		stockLogList = stockMapper.selectStockLogList(map);

		return stockLogList;
	}


	@Override
	public ModelMap warehousing(ArrayList<String> orderNoArr) {

		String orderNoList = orderNoArr.toString().replace("[", "").replace("]", "");
		
		ModelMap resultMap = new ModelMap();
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("orderNoList", orderNoList);
		
		stockMapper.warehousing(map);
		
		resultMap.put("errorCode", map.get("ERROR_CODE"));
		resultMap.put("errorMsg", map.get("ERROR_MSG"));
		
    	return resultMap;
	}


	@Override
	public ModelMap changeSafetyAllowanceAmount(String itemCode, String itemName,
			String safetyAllowanceAmount) {

		ModelMap resultMap = null;
		
		HashMap<String, String> map = new HashMap<>();

		map.put("itemCode", itemCode);
		map.put("itemName", itemName);
		map.put("safetyAllowanceAmount", safetyAllowanceAmount);

		resultMap = stockMapper.updatesafetyAllowance(map);

		return resultMap;
	}

	
	@Override
	public ArrayList<StockChartTO> getStockChart() {

		ArrayList<StockChartTO> stockChart  = null;

		stockChart = stockMapper.selectStockChart();

		return stockChart;

	}
	
	@Override
	public ArrayList<StockTO> getWarehouseStockList(String warehouseCode) {

		ArrayList<StockTO> stockList = null;

		stockList = stockMapper.selectWarehouseStockList(warehouseCode);

		return stockList;
	}
	
	@Override
	public void batchStockProcess(ArrayList<StockTO> stockTOList) {

		for (StockTO bean : stockTOList) {
				
			String status = bean.getStatus();
				
			switch (status) {
				
				case "DELETE":
					stockMapper.deleteStock(bean);
					break;
						
				case "INSERT":
					stockMapper.insertStock(bean);
						break;
					
				case "UPDATE":
					stockMapper.updateStock(bean);
			}
				
		}

	}
}
