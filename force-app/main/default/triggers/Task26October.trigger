trigger Task26October on Contact (after insert,before delete,after update) {
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
        Set<Id> s = new Set<Id>();
        for(Contact con : trigger.new){
            s.add(con.AccountId);
        }
        if(trigger.isUpdate){
            for(Contact con : trigger.old)
                s.add(con.AccountId);
        }
        List<Account> upd = new List<Account>();
        for(Account acc : [SELECT Id,Number_of_related_Contacts__c,(SELECT AccountId FROM Contacts) FROM Account WHERE Id IN: s]){
            acc.Number_of_related_Contacts__c = acc.contacts.size();
            upd.add(acc);
        }
        if(upd.size()>0)
            UPDATE upd;
    }
    if(trigger.isBefore && trigger.isDelete){
        Map<Id,Integer> mp = new Map<Id,Integer>();
        for(Contact con : trigger.old){
            if(!mp.containskey(con.AccountId))
                mp.put(con.AccountId,1);
            else{
                mp.put(con.AccountId , mp.get(con.AccountId)+1);
            }
        }
        List<Account> upd = new List<Account>();
        for(Account acc : [SELECT Id,Number_of_related_Contacts__c,(SELECT AccountId FROM Contacts) FROM Account WHERE Id IN: mp.keySet()]){
            acc.Number_of_related_Contacts__c = acc.contacts.size() - mp.get(acc.Id);
            upd.add(acc);
        }
        if(upd.size()>0)
            UPDATE upd;
    }
}