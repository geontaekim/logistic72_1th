package kr.co.seoulit.logistics.busisvc.receivables.service;


import kr.co.seoulit.logistics.busisvc.logisales.to.EstimateDetailTO;
import kr.co.seoulit.logistics.busisvc.logisales.to.EstimateTO;
import kr.co.seoulit.logistics.busisvc.logisales.to.TotalAmountTO;
import kr.co.seoulit.logistics.busisvc.receivables.mapper.ReceiveMapper;
import kr.co.seoulit.logistics.busisvc.receivables.to.AdvReciveTO;
import kr.co.seoulit.logistics.busisvc.receivables.to.ReceivablesTO;

import kr.co.seoulit.logistics.purcstosvc.stock.to.StockTO;
import org.apache.jasper.tagplugins.jstl.core.Out;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import java.sql.SQLOutput;
import java.util.ArrayList;
import java.util.HashMap;

@Service
public class ReceiveServiceImpl implements ReceiveService {

	@Autowired
	private ReceiveMapper receiveMapper;

	public HashMap<String,Object> getReceiveList(HashMap<String,String> manarecInfo){

		System.out.println("manarecInfo??"+manarecInfo);
		ArrayList<ReceivablesTO> receivelist=null;
		ArrayList<TotalAmountTO> total = new ArrayList<>();
		HashMap<String,Object> sortMap = new HashMap<>();

		receivelist= receiveMapper.selectReceiveList(manarecInfo);
		System.out.println("receivelist???"+receivelist);
			sortMap.put("receivelist",receivelist);



		return sortMap;

	}

	@Override
	public ArrayList<AdvReciveTO> getReceiveCashList() {

		ArrayList<AdvReciveTO> ReceivedCashList = null;

		ReceivedCashList = receiveMapper.selectReceiveCashList();

		return ReceivedCashList;
	}

	@Override
	public ModelMap addNewReceive(AdvReciveTO newReceiveTO) {

		ModelMap resultMap = new ModelMap();
		HashMap<String,String> receiv = new HashMap<>();

		receiv.put("estimateDate",newReceiveTO.getEstimateDate());
		receiv.put("personCodeInCharge",newReceiveTO.getPersonCodeInCharge());
		receiv.put("personNameCharge",newReceiveTO.getPersonNameCharge());
		receiv.put("estimateRequester",newReceiveTO.getEstimateRequester());
		receiv.put("description",newReceiveTO.getDescription());
		receiv.put("advRecived",newReceiveTO.getAdvRecived());
		receiv.put("customerName",newReceiveTO.getCustomerName());
		receiv.put("deliveryNo",newReceiveTO.getDeliveryNo());
		receiv.put("divReceive",newReceiveTO.getDivReceive());


		receiveMapper.insertReceive(receiv);
		String recivSeq=receiv.get("receivSeq");
		System.out.println("recivSeq???"+recivSeq);
		resultMap.put("recivSeq",recivSeq);


		return resultMap;
	}

}
