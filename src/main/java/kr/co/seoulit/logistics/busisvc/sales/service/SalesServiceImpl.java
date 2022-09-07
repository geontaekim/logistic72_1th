package kr.co.seoulit.logistics.busisvc.sales.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import kr.co.seoulit.logistics.busisvc.logisales.to.SalesHistoryTO;
import kr.co.seoulit.logistics.busisvc.logisales.to.TotalAmountTO;
import org.apache.jasper.tagplugins.jstl.core.Out;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import kr.co.seoulit.logistics.busisvc.logisales.mapper.ContractMapper;
import kr.co.seoulit.logistics.busisvc.logisales.to.ContractInfoTO;
import kr.co.seoulit.logistics.busisvc.sales.mapper.DeliveryMapper;
import kr.co.seoulit.logistics.busisvc.sales.mapper.SalesPlanMapper;
import kr.co.seoulit.logistics.busisvc.sales.to.DeliveryInfoTO;
import kr.co.seoulit.logistics.busisvc.sales.to.SalesPlanTO;

@Service
public class SalesServiceImpl implements SalesService {

	@Autowired
	private ContractMapper contractMapper;
	@Autowired
	private SalesPlanMapper salesPlanMapper;
	@Autowired
	private DeliveryMapper deliveryMapper;



	@Override
	public ArrayList<ContractInfoTO> getDeliverableContractList(HashMap<String,String> ableSearchConditionInfo) {

		ArrayList<ContractInfoTO> deliverableContractList = null;

		deliverableContractList = contractMapper.selectDeliverableContractList(ableSearchConditionInfo);

		for (ContractInfoTO bean : deliverableContractList) { // 해당 수주의 수주상세 리스트 세팅 

			bean.setContractDetailTOList(contractMapper.selectDeliverableContractDetailList(bean.getContractNo()));

		}

		return deliverableContractList;
	}

	public ArrayList<DeliveryInfoTO> getDeliveryList(HashMap<String,String> SearchConditionInfo) {

		ArrayList<DeliveryInfoTO> deliveryHistoryList = null;

		System.out.println("SearchConditionInfo??"+SearchConditionInfo);
		//SearchConditionInfo??{endDate=2022-08-31, searchCondition=searchByDate, customerCode=, startDate=2022-08-02}
		String search = SearchConditionInfo.get("searchCondition");
		System.out.println("SearchConditionInfo.get(\"searchCondition\")???"+SearchConditionInfo.get("searchCondition"));
		if(search.equals("searchByDate")) {
			deliveryHistoryList = deliveryMapper.selectDeliveryListForDate(SearchConditionInfo);
			System.out.println("데이트");
		}else{
			deliveryHistoryList = deliveryMapper.selectDeliveryListForCode(SearchConditionInfo);
			System.out.println("커스텀");
		}

		return deliveryHistoryList;
	}

	public ArrayList<DeliveryInfoTO> getDeliveryListForReceive(HashMap<String,String> cmap) {

		ArrayList<DeliveryInfoTO> deliveryHistoryList = null;

			deliveryHistoryList = deliveryMapper.selectDeliveryList(cmap);

		return deliveryHistoryList;
	}

	
	@Override
	public ArrayList<SalesPlanTO> getSalesPlanList(String dateSearchCondition, String startDate, String endDate) {

		ArrayList<SalesPlanTO> salesPlanTOList = null;
		
		HashMap<String, String> map = new HashMap<>();

		map.put("dateSearchCondition", dateSearchCondition);
		map.put("startDate", startDate);
		map.put("endDate", endDate);

		salesPlanTOList = salesPlanMapper.selectSalesPlanList(map);
		
		return salesPlanTOList;
	}

	public HashMap<String,Object> getSalesContractList(HashMap<String,String> sales){


		ArrayList<SalesHistoryTO> saleshistorylist=null;
		ArrayList<TotalAmountTO> total = new ArrayList<>();
		HashMap<String,Object> sortMap = new HashMap<>();
		HashMap<String,Object> sortMap2 = new HashMap<>();
		long sumTotalprice=0;
		int TotalestimateAmount=0;
		if(sales.get("searchCondition").equals("searchByDate")) {

			saleshistorylist=contractMapper.selectSalesContractList(sales);
			sortMap.put("saleshistorylist",saleshistorylist);

			for(SalesHistoryTO i:saleshistorylist){
				long sumprice = Integer.parseInt(i.getSumPriceOfContract());
				System.out.println("sumprice????"+sumprice);
				sumTotalprice = sumTotalprice+sumprice;
				sortMap.put("sumTotalprice",sumTotalprice);
				int sumamount =  Integer.parseInt(i.getEstimateAmount());
				TotalestimateAmount = TotalestimateAmount+sumamount;


			}
			TotalAmountTO to = new TotalAmountTO();
			to.setSumTotalprice(sumTotalprice);
			to.setTotalestimateAmount(TotalestimateAmount);
			total.add(to);
			sortMap.put("total",total);


		}else {

			saleshistorylist=contractMapper.selectSalesContractListBycustom(sales);
			sortMap.put("saleshistorylist",saleshistorylist);
			System.out.println("saleshistorylist??"+saleshistorylist);
			for(SalesHistoryTO i:saleshistorylist){
				long sumprice = Integer.parseInt(i.getSumPriceOfContract());
				System.out.println("sumprice????"+sumprice);
				sumTotalprice = sumTotalprice+sumprice;
				System.out.println("sumTotalprice???"+sumTotalprice);
				int sumamount =  Integer.parseInt(i.getEstimateAmount());
				TotalestimateAmount = TotalestimateAmount+sumamount;
				System.out.println("sortMap???"+sortMap);
			}
			TotalAmountTO to = new TotalAmountTO();
			to.setSumTotalprice(sumTotalprice);
			to.setTotalestimateAmount(TotalestimateAmount);
			total.add(to);
			sortMap.put("total",total);

			//sumTotalpricem, TotalestimateAmount
		}
		return sortMap;

	}


	public HashMap<String,Object> getSalesContractListDetail(HashMap<String,String> conMap){


		ArrayList<SalesHistoryTO> saleshistorylistDetail=null;
		HashMap<String,Object> sortMap = new HashMap<>();
		System.out.println("contractno??"+conMap);

		saleshistorylistDetail=contractMapper.selectSalesContractListDetail(conMap);
			sortMap.put("saleshistorylistDetail",saleshistorylistDetail);
		System.out.println("sortMap??"+sortMap);

		return sortMap;

	}



	@Override
	public ModelMap batchSalesPlanListProcess(ArrayList<SalesPlanTO> salesPlanTOList) {

		ModelMap resultMap = new ModelMap();
		
		ArrayList<String> insertList = new ArrayList<>();
		ArrayList<String> updateList = new ArrayList<>();
		ArrayList<String> deleteList = new ArrayList<>();

		for (SalesPlanTO bean : salesPlanTOList) {

			String status = bean.getStatus();

			switch (status) {

			case "INSERT":

				String newSalesPlanNo = getNewSalesPlanNo(bean.getSalesPlanDate());

				bean.setSalesPlanNo(newSalesPlanNo);

				salesPlanMapper.insertSalesPlan(bean);

				insertList.add(newSalesPlanNo);

				break;

			case "UPDATE":

				salesPlanMapper.updateSalesPlan(bean);

				updateList.add(bean.getSalesPlanNo());
				
				break;

			case "DELETE":

				salesPlanMapper.deleteSalesPlan(bean);

				deleteList.add(bean.getSalesPlanNo());

				break;

			}

		}

		resultMap.put("INSERT", insertList);
		resultMap.put("UPDATE", updateList);
		resultMap.put("DELETE", deleteList);

		return resultMap;
	}

	public String getNewSalesPlanNo(String salesPlanDate) {

		StringBuffer newEstimateNo = null;

		int newNo = salesPlanMapper.selectSalesPlanCount(salesPlanDate);

		newEstimateNo = new StringBuffer();

		newEstimateNo.append("SA");
		newEstimateNo.append(salesPlanDate.replace("-", ""));
		newEstimateNo.append(String.format("%02d", newNo)); // 2자리 숫자
		
		return newEstimateNo.toString();
	}

	@Override
	public ArrayList<DeliveryInfoTO> getDeliveryInfoList() {

		ArrayList<DeliveryInfoTO> deliveryInfoList = null;

		deliveryInfoList = deliveryMapper.selectDeliveryInfoList();

		return deliveryInfoList;
	}

	@Override
	public ModelMap batchDeliveryListProcess(List<DeliveryInfoTO> deliveryTOList) {
		
		ModelMap resultMap = new ModelMap();
		
		ArrayList<String> insertList = new ArrayList<>();
		ArrayList<String> updateList = new ArrayList<>();
		ArrayList<String> deleteList = new ArrayList<>();

		for (DeliveryInfoTO bean : deliveryTOList) {

			String status = bean.getStatus();

			switch (status.toUpperCase()) {

			case "INSERT":

				String newDeliveryNo = "새로운";

				bean.setDeliveryNo(newDeliveryNo);
				deliveryMapper.insertDeliveryResult(bean);
				insertList.add(newDeliveryNo);
					
				break;

			case "UPDATE":

				deliveryMapper.updateDeliveryResult(bean);

				updateList.add(bean.getDeliveryNo());

				break;

			case "DELETE":

				deliveryMapper.deleteDeliveryResult(bean);

				deleteList.add(bean.getDeliveryNo());
				
				break;

			}

		}

		resultMap.put("INSERT", insertList);
		resultMap.put("UPDATE", updateList);
		resultMap.put("DELETE", deleteList);

		return resultMap;
	}

	@Override
	public ModelMap deliver(String contractDetailNo) {
		
        ModelMap resultMap = new ModelMap();
        
        HashMap<String, Object> map = new HashMap<String, Object>();
        
        map.put("contractDetailNo", contractDetailNo);
        
        deliveryMapper.deliver(map);

		resultMap.put("errorCode", map.get("ERROR_CODE"));
		resultMap.put("errorMsg", map.get("ERROR_MSG"));
		
		return resultMap;
	}
	
}
