package kr.co.seoulit.logistics.busisvc.receivables.service;

import kr.co.seoulit.logistics.busisvc.logisales.to.ContractInfoTO;
import kr.co.seoulit.logistics.busisvc.logisales.to.EstimateTO;
import kr.co.seoulit.logistics.busisvc.receivables.to.AdvReciveTO;
import kr.co.seoulit.logistics.busisvc.receivables.to.ReceivablesTO;
import kr.co.seoulit.logistics.busisvc.sales.to.DeliveryInfoTO;
import kr.co.seoulit.logistics.busisvc.sales.to.SalesPlanTO;
import org.springframework.ui.ModelMap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public interface ReceiveService {


	public HashMap<String,Object> getReceiveList(HashMap<String,String> manarecInfo);

	public HashMap<String, Object> addNewReceive(AdvReciveTO newReceiveTO);

	public ArrayList<AdvReciveTO> getReceiveCashList();




	
}
