public class accountOpportunity {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        system.debug('List of Account');
        return [SELECT Id,Name,Email__c,AMOUNT__c,Number_of_Opp_Line_Items__c FROM Account LIMIT 10];
    }
    @AuraEnabled
    public static List<Opportunity> getOpportunities(String accId){
        system.debug('AccId: '+accId);
        return [SELECT Id,AccountId,Name,CloseDate,StageName,AMOUNT__c,Number_of_Opp_Line_Items__c FROM Opportunity WHERE AccountId =: accId];
    }
    @AuraEnabled
    public static List<OpportunityLineItem> getOPL(String oppId){
        return [SELECT Id, Name, Product2.Name, Quantity, UnitPrice, TotalPrice, Amount__c, OpportunityId FROM OpportunityLineItem WHERE OpportunityId = :oppId];
    }
    @AuraEnabled
    public static void deleteOPL(String myId){
        OpportunityLineItem oppLineItemToDelete = [select id from OpportunityLineItem where id = :myId];
        system.debug(oppLineItemToDelete);
        delete oppLineItemToDelete;
    }

    // PriceBookEntryController.cls
    @AuraEnabled(cacheable=true)
    public static List<PriceBookEntry> getPriceBookEntries() {
        return [SELECT Id, Name FROM PriceBookEntry LIMIT 10]; // Adjust the query as needed
    }

    @AuraEnabled
    public static void insertOPL(String myId,String ProductName,String pbeId,Integer Quantity,Integer UnitPrice,Integer Amount){
        PriceBookEntry pbe = new PriceBookEntry();
        pbe.PriceBook2Id = [SELECT Id FROM PriceBook2 Limit 1][0].Id;
        pbe.Product2Id = [SELECT Id FROM Product2 Limit 1][0].Id;

        OpportunityLineItem oli = new OpportunityLineItem();
        oli.PriceBookEntryId = pbeId;
        oli.OpportunityId = myId;
        oli.Quantity = Quantity;
        oli.UnitPrice = UnitPrice;
        oli.Amount__c = Amount;
        system.debug(oli);
        INSERT oli;
    }
}