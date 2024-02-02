public class UpdateAmountsTriggerHandler {
    public static void handleOperationsInsertUpdate(List<OpportunityLineItem> mylist,Integer a){
        system.debug(mylist);
        Set<Id> s = new Set<Id>();
        Map<Id,Double> mp = new Map<Id,Double>();
        Map<Id,Decimal> count = new Map<Id,Decimal>();
        List<OpportunityLineItem> lisopl = new List<OpportunityLineItem>();
        List<Opportunity> lis = new List<Opportunity>();
        List<Opportunity> updateopp = new List<Opportunity>();
        List<Account> updateacc = new List<Account>();
        
        if(a==0){
        for(OpportunityLineItem opp : mylist){
            s.add(opp.OpportunityId);
        }
        lisopl = [SELECT Id,OpportunityId,Amount__c FROM OpportunityLineItem WHERE OpportunityId IN: s];
        for(OpportunityLineItem opl : lisopl){
            if(!mp.containsKey(opl.OpportunityId)){
                mp.put(opl.OpportunityId,opl.Amount__c);
            }
            else if(mp.containskey(opl.OpportunityId)){
                mp.put(opl.OpportunityId,mp.get(opl.OpportunityId) + opl.Amount__c);
            }
            if(!count.containskey(opl.OpportunityId))
                count.put(opl.OpportunityId,1);
            else if(count.containskey(opl.OpportunityId))
                count.put(opl.OpportunityId,count.get(opl.OpportunityId)+1);
        }
        }
        else{
            for(OpportunityLineItem opp : mylist){
            if(!mp.containskey(opp.OpportunityId)){
                mp.put(opp.OpportunityId,opp.Amount__c);
            }
            else{
                mp.put(opp.OpportunityId,mp.get(opp.OpportunityId) + opp.Amount__c);
            }
            if(!count.containskey(opp.OpportunityId))
                count.put(opp.OpportunityId,1);
            else if(count.containskey(opp.OpportunityId))
                count.put(opp.OpportunityId,count.get(opp.OpportunityId)+1);
        }
        }
        
        //part1
        if(a==0)
            lis = [SELECT Id,Name,AccountId,AMOUNT__c,Number_of_Opp_Line_Items__c from Opportunity WHERE Id IN: s];
        else
            lis = [SELECT Id,AccountId,AMOUNT__c,Number_of_Opp_Line_Items__c FROM Opportunity WHERE Id IN: mp.keySet()];
        s.clear();
        if(a==0){
        for(Opportunity opp : lis){
            s.add(opp.AccountId);
            opp.AMOUNT__c = mp.get(opp.Id);
            opp.Number_of_Opp_Line_Items__c = count.get(opp.Id);
            updateopp.add(opp);
        }
        }
        else{
            for(Opportunity opp : lis){
            s.add(opp.AccountId);
            opp.Amount__c = opp.Amount__c - mp.get(opp.Id);
            opp.Number_of_Opp_Line_Items__c = opp.Number_of_Opp_Line_Items__c - count.get(opp.Id);
            updateopp.add(opp);
        }
        }
        system.debug(updateopp);
        if(updateopp.size()>0)
            UPDATE updateopp;
        
        //part2
        mp.clear();
        count.clear();
        List<Opportunity> lisopp = [SELECT Id,AccountId,AMOUNT__c,Number_of_Opp_Line_Items__c FROM Opportunity WHERE AccountId IN: s];
        for(Opportunity opp : lisopp){
            if(!mp.containskey(opp.AccountId)){
                mp.put(opp.AccountId,opp.AMOUNT__c);
            }
            else if(mp.containskey(opp.AccountId)){
                mp.put(opp.AccountId,mp.get(opp.AccountId) + opp.AMOUNT__c);
            }
            if(!count.containsKey(opp.AccountId)){
                count.put(opp.AccountId,opp.Number_of_Opp_Line_Items__c);
            }
            else if(count.containsKey(opp.AccountId)){
                count.put(opp.AccountId,count.get(opp.AccountId) + opp.Number_of_Opp_Line_Items__c);
            }
        }
        
        //part3
        List<Account> acclist = [SELECT Id,AMOUNT__c,Number_of_Opp_Line_Items__c FROM Account WHERE Id IN: mp.keyset()];
        for(Account acc : acclist){
            acc.AMOUNT__c = mp.get(acc.Id);
            acc.Number_of_Opp_Line_Items__c = count.get(acc.Id);
            updateacc.add(acc);
        }
        if(updateacc.size()>0)
            UPDATE updateacc;
    }
}