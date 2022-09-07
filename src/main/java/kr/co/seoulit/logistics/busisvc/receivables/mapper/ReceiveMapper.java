package kr.co.seoulit.logistics.busisvc.receivables.mapper;

import kr.co.seoulit.logistics.busisvc.receivables.to.AdvReciveTO;
import kr.co.seoulit.logistics.busisvc.receivables.to.ReceivablesTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.ui.ModelMap;

import java.util.ArrayList;
import java.util.HashMap;

@Mapper
public interface ReceiveMapper {

	public ArrayList<ReceivablesTO> selectReceiveList(HashMap<String, String> manarecInfo);

	public void insertReceive(HashMap<String,String> receiv);

	public ArrayList<AdvReciveTO> selectReceiveCashList();


}
