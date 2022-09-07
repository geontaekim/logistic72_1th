package kr.co.seoulit.logistics.purcstosvc.purchase.to;

import kr.co.seoulit.logistics.logiinfosvc.compinfo.to.BaseTO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class PurcSalesTO extends BaseTO {

	private String customerCode;
	private String itemCode;
	private String itemName;
	private String instructAmount;
	private String unitPrice;
	private String totalPrice;


}