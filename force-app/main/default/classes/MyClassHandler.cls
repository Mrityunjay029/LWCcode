public class MyClassHandler {
     public static void main(List<Opportunity> newOppList){
		PricebookEntry PB = [SELECT ID,Name,product2Id FROM PricebookEntry LIMIT 1];

        List<OpportunityLineItem> lis = new  List<OpportunityLineItem>();
        
        for(Opportunity opp:newOppList){
            OpportunityLineItem op = new  OpportunityLineItem();
            op.OpportunityId = opp.Id;
            op.Product2Id = PB.product2Id;
            op.PricebookEntryId = PB.Id;
            op.UnitPrice = 1000;
            op.Quantity = 10;
            lis.add(op);
        }

        if(lis.size()>0){
			System.debug(lis);
            Insert lis;
        }
    }

}