package kr.co.seoulit.logistics.busisvc.receivables.to;

import kr.co.seoulit.logistics.logiinfosvc.compinfo.to.BaseTO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class AdvReciveTO extends BaseTO {

	private String receivSeq;
	private String estimateDate;
	private String personCodeInCharge;
	private String personNameCharge;
	private String estimateRequester;
	private String description;
	private String advRecived;
	private String customerName;
	private String deliveryNo;
	private String divReceive;
}
