package kr.co.seoulit.logistics.purcstosvc.purchase.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.seoulit.logistics.logiinfosvc.help.to.boardTO2;
import kr.co.seoulit.logistics.purcstosvc.purchase.to.BomItemTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.ui.ModelMap;

import kr.co.seoulit.logistics.purcstosvc.purchase.to.OrderInfoTO;

@Mapper
public interface OrderMapper {
	
	public void getOrderList(HashMap<String, Object> map);
	 
	public void getOrderDialogInfo(HashMap<String, String> map);
	 
	 public ArrayList<OrderInfoTO> getOrderInfoListOnDelivery();
	 
	 public ArrayList<OrderInfoTO> getOrderInfoList(HashMap<String, String> map);



	 public void order(HashMap<String, String> map);
	 
	 public ModelMap optionOrder(HashMap<String, String> map);

	public ArrayList<BomItemTO> selectBomList();

	public ArrayList<BomItemTO> selectBomChildList(HashMap<String, String> map);

	 public void updateOrderInfo(HashMap<String, String> map);

}
