trigger Trigger3 on Account (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        Set<Id> s = new Set<Id>();
        for(Account acc : trigger.new){
            s.add(acc.Id);
        }
        List<Account> upd = new List<Account>();
        for(Account acc : [SELECT Name,Id,(SELECT AccountId FROM Contacts WHERE AccountId IN:s) FROM Account]){
            acc.Number_of_Contacts__c = acc.contacts.size();
            upd.add(acc);
        }
        if(upd.size()>0)
            UPDATE upd;
    }
}