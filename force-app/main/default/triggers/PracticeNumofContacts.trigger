trigger PracticeNumofContacts on Contact (after insert,after update,before delete) {
    if(trigger.isAfter && trigger.isInsert){
        Map<Id,Integer> mp = new Map<Id,Integer>();
        for(Contact con : trigger.new){
            if(!mp.containskey(con.AccountId))
                mp.put(con.AccountId,1);
            else
                mp.put(con.AccountId,mp.get(con.AccountId)+1);
        }
        List<Account> upd = new List<Account>();
        for(Account acc : [SELECT Id,Number_of_related_Contacts__c FROM Account WHERE Id IN : mp.keySet()]){
            acc.Number_of_related_Contacts__c+=mp.get(acc.Id);
            upd.add(acc);
        }
        if(upd.size()>0)
            UPDATE upd;
    }
    if((trigger.isBefore && trigger.isDelete) || (trigger.isAfter && trigger.isUpdate)){
        Map<Id,Integer> mp = new Map<Id,Integer>();
        for(Contact con : trigger.old){
            if(!mp.containskey(con.AccountId))
                mp.put(con.AccountId,1);
            else
                mp.put(con.AccountId,mp.get(con.AccountId)+1);
        }
        List<Account> upd = new List<Account>();
        for(Account acc : [SELECT Id,Number_of_related_Contacts__c FROM Account WHERE Id IN : mp.keySet()]){
            acc.Number_of_related_Contacts__c-=mp.get(acc.Id);
            upd.add(acc);
        }
        if(upd.size()>0)
            UPDATE upd;
    }
}