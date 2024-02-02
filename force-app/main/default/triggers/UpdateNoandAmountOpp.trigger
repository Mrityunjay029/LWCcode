trigger UpdateNoandAmountOpp on Opportunity (after insert,after update,after delete,after undelete) {
        
    if((trigger.isinsert && trigger.isafter) || (trigger.isupdate && trigger.isafter)){
        Map<Id,Integer> count = new Map<Id,Integer>();
        Map<Id,Double> amount = new Map<Id,Double>();
        Set<Id> s = new Set<Id>();
        
        for(Opportunity opp : trigger.new){
            s.add(opp.AccountId);
            if(count.containsKey(opp.AccountId)){
                count.put(opp.AccountId,count.get(opp.AccountId)+1);
            }
            else if(!count.containsKey(opp.AccountId)){
                count.put(opp.AccountId,1);
            }
            if(amount.containsKey(opp.AccountId)){
                amount.put(opp.AccountId,amount.get(opp.AccountId)+opp.opp_amount__c);
            }
            else if(!amount.containsKey(opp.AccountId)){
                amount.put(opp.AccountId,opp.opp_amount__c);
            }
        }
        List<Account> lis = [SELECT Id,Name,Total_No_of_Opportunity__c,Total_Amount_of_Opportunity__c FROM Account WHERE Id IN : s];
        List<Account> upd = new List<Account>();
        for(Account li : lis){
            li.Total_No_of_Opportunity__c+= count.get(li.Id);
            li.Total_Amount_of_Opportunity__c+= amount.get(li.Id);
            upd.add(li);
        }
        if(upd.size()>0)
            UPDATE upd;
    }
    if(trigger.isDelete && trigger.isAfter){
        Set<Id> se = new Set<Id>();
        Map<Id,Integer> counto = new Map<Id,Integer>();
        Map<Id,Double> amounto = new Map<Id,Double>();
        
        for(Opportunity op : trigger.old){
            se.add(op.AccountId);
            if(counto.containsKey(op.AccountId)){
                counto.put(op.AccountId,counto.get(op.AccountId)+1);
            }
            else if(!counto.containsKey(op.AccountId)){
                counto.put(op.AccountId,1);
            }
            if(amounto.containsKey(op.AccountId)){
                amounto.put(op.AccountId,amounto.get(op.AccountId)+op.opp_amount__c);
            }
            else if(!amounto.containsKey(op.AccountId)){
                amounto.put(op.AccountId,op.opp_amount__c);
            }
        }
        
        List<Account> lis = [SELECT Name,Id,Total_No_of_Opportunity__c,Total_Amount_of_Opportunity__c FROM Account WHERE Id IN : se];
        List<Account> del = new List<Account>();
        for(Account acc : lis){
            acc.Total_No_of_Opportunity__c+= 1;
            acc.Total_Amount_of_Opportunity__c+= amounto.get(acc.Id);  
            del.add(acc);
        }
        UPDATE del;
    }
}