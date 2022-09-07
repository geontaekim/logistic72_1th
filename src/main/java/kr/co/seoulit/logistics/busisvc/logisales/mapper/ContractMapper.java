package kr.co.seoulit.logistics.busisvc.logisales.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.seoulit.logistics.busisvc.logisales.to.*;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ContractMapper {

	public ArrayList<EstimateTO> selectEstimateListInContractAvailable(HashMap<String, String> map);

	public ArrayList<ContractInfoTO> selectContractList(HashMap<String, String> map);
	
	public ArrayList<ContractInfoTO> selectDeliverableContractList(HashMap<String, String> ableSearchConditionInfo);
	
	public int selectContractCount(String contractDate);

	public void insertContract(ContractTO TO);

	public void updateContract(ContractTO TO);

	public void deleteContract(ContractTO TO);

	public ArrayList<SalesHistoryTO> selectSalesContractListBycustom(HashMap<String, String> ableSearchConditionInfo);

	public ArrayList<SalesHistoryTO> selectSalesContractList(HashMap<String,String> sales);

	public ArrayList<SalesHistoryTO> selectSalesContractListDetail(HashMap<String,String> contractno);


	//ContractDetail
	public ArrayList<ContractDetailTO> selectContractDetailList(String contractNo);

	public ArrayList<ContractDetailTO> selectDeliverableContractDetailList(String contractNo);
	
	public int selectContractDetailCount(String contractNo);

	public ArrayList<ContractDetailInMpsAvailableTO> selectContractDetailListInMpsAvailable(
			HashMap<String, String> map);
/*
	public void insertContractDetail(ContractDetailTO TO);

	public void updateContractDetail(ContractDetailTO TO);*/

	public void changeMpsStatusOfContractDetail(HashMap<String, String> map);

	public void deleteContractDetail(ContractDetailTO TO);
	
	public void insertContractDetail(HashMap<String,String>  workingContractList);

}
