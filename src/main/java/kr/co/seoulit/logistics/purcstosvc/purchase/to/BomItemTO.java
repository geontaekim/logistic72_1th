package kr.co.seoulit.logistics.purcstosvc.purchase.to;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class BomItemTO {
	private String itemCode;
	private String itemName;
	private String leadTime;
	private String standardUnitPrice;
	private String parentItemCode;
	private String no;
	private String netAmount;

	/*필요 칼럼 = ITEM_CODE , ITEM_NAME , LEAD_TIME , STANDARD_UNIT_PRICE ,
			PARENT_ITEM_CODE , NO , NET_AMOUNT ,*/

}
