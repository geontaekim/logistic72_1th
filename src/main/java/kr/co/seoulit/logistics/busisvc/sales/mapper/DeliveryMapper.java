package kr.co.seoulit.logistics.busisvc.sales.mapper;

import kr.co.seoulit.logistics.busisvc.sales.to.DeliveryInfoTO;
import kr.co.seoulit.logistics.busisvc.sales.to.SalesPlanTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.ui.ModelMap;

import java.util.ArrayList;
import java.util.HashMap;

@Mapper
public interface DeliveryMapper {
	public ArrayList<DeliveryInfoTO> selectDeliveryListForDate(HashMap<String, String> map);

	public ArrayList<DeliveryInfoTO> selectDeliveryList(HashMap<String,String> cmap);

	public ArrayList<DeliveryInfoTO> selectDeliveryListForCode(HashMap<String, String> map);
			
	public ArrayList<DeliveryInfoTO> selectDeliveryInfoList();

	public ModelMap deliver(HashMap<String, Object> map);
	public void insertDeliveryResult(DeliveryInfoTO bean);

	public void updateDeliveryResult(DeliveryInfoTO bean);

	public void deleteDeliveryResult(DeliveryInfoTO bean);

	public void updateSalesPlan(SalesPlanTO TO);
	

	
}
