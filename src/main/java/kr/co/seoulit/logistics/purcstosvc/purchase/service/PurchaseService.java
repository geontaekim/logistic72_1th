package kr.co.seoulit.logistics.purcstosvc.purchase.service;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.seoulit.logistics.purcstosvc.purchase.to.BomItemTO;
import kr.co.seoulit.logistics.purcstosvc.purchase.to.PurcSalesTO;
import org.springframework.ui.ModelMap;

import kr.co.seoulit.logistics.purcstosvc.purchase.to.OrderInfoTO;
import kr.co.seoulit.logistics.purcstosvc.purchase.to.OutSourcingTO;

public interface PurchaseService {
	
	public ArrayList<OutSourcingTO> searchOutSourcingList();

	public ArrayList<OutSourcingTO> getOutSourcingList(String CusCode);

	public ArrayList<PurcSalesTO> getSumOutSourcingList(String CusCode);
	
	public HashMap<String, Object> getOrderList(String startDate, String endDate);
	
	public HashMap<String, Object> getOrderDialogInfo(String mrpNoArr);
	
	public ModelMap order(ArrayList<String> mrpGaNoArr);

	public ArrayList<BomItemTO> getBomList();

	public ArrayList<BomItemTO> getBomChildList(String code);
	
	public ModelMap optionOrder(String itemCode, String itemAmount);
	
	public ArrayList<OrderInfoTO> getOrderInfoListOnDelivery();
	
	public ArrayList<OrderInfoTO> getOrderInfoList(String startDate,String endDate);

	public ModelMap checkOrderInfo(ArrayList<String> orderNoArr);
	
}
