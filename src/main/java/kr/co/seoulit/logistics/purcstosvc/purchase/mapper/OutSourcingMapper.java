package kr.co.seoulit.logistics.purcstosvc.purchase.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.seoulit.logistics.purcstosvc.purchase.to.PurcSalesTO;
import org.apache.ibatis.annotations.Mapper;

import kr.co.seoulit.logistics.purcstosvc.purchase.to.OutSourcingTO;

@Mapper
public interface OutSourcingMapper {

	ArrayList<OutSourcingTO> selectOutSourcingList();

	ArrayList<OutSourcingTO> selectGetOutSourcingList(HashMap<String, String> map);

	ArrayList<PurcSalesTO> selectGetSumOutSourcingList(HashMap<String, String> map);

}
