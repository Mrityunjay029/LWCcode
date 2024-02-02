trigger CountContacts on Contact (after insert,after update,after delete) {
    if((trigger.isinsert && trigger.isafter) || (trigger.isupdate && trigger.isafter)){
        Set<Id> s = new Set<Id>();
        Map<Id,Integer> count = new Map<Id,Integer>();
        for(Contact con : trigger.new){
            s.add(con.AccountId);
            if(count.containsKey(con.AccountId)){
                count.put(con.AccountId,count.get(con.AccountId)+1);
            }
            else if(!count.containsKey(con.AccountId))
                count.put(con.AccountId,1);
        }
        List<Account> lis = [SELECT Id,Name,Number_of_Contact__c FROM Account WHERE Id IN : s];
        List<Account> upd = new List<Account>();
        for(Account acc : lis){
            if(acc.Number_of_Contact__c==NULL){
                acc.Number_of_Contact__c = 1;
            }
            else{
                acc.Number_of_Contact__c+= count.get(acc.Id);
            }
            upd.add(acc);
        }
        if(upd.size()>0)
            UPDATE upd;
    }
    if(trigger.isdelete && trigger.isafter){
        
        Set<Id> s = new Set<Id>();
        for(Contact con : trigger.old){
            s.add(con.AccountId);
        }
        List<Account> lis = [SELECT Id,Name,Number_of_Contact__c FROM Account WHERE Id IN : s];
        List<Account> upd = new List<Account>();
        for(Account acc : lis){
            acc.Number_of_Contact__c-=1;
            upd.add(acc);
        }
        if(upd.size()>0)
            UPDATE upd;
        
    }
}