package kr.co.seoulit.logistics.busisvc.receivables.to;

import kr.co.seoulit.logistics.logiinfosvc.compinfo.to.BaseTO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class ReceivablesTO extends BaseTO {
	
	private String customerCode;
	private String CustomerName;
	private String amountCarriedOver;
	private String netIncome;
	private String comAccReceivable;
	private String balance;

}
