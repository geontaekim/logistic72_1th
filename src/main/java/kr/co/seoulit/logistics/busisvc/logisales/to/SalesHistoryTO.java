package kr.co.seoulit.logistics.busisvc.logisales.to;

import kr.co.seoulit.logistics.logiinfosvc.compinfo.to.BaseTO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.ArrayList;

@Data
@EqualsAndHashCode(callSuper = false)
public class SalesHistoryTO extends BaseTO {
	private String contractNo;
	private String contractTypeName;
	private String customerName;
	private String contractDate;
	private String deliveryCompletionData;
	private String itemName;
	private String estimateAmount;
	private String unitPriceOfContract;
	private String sumPriceOfContract;

}