trigger Trigger1 on Account (after Update) {
    if(trigger.isAfter && trigger.isUpdate){
        Map<Id, Boolean> mp = new Map<Id, Boolean>();
        for(Account acc : trigger.new){
            mp.put(acc.Id,acc.Intel__c);
        }
        List<Contact> upd = new List<Contact>(); 
        for(Contact con : [SELECT AccountId,Name,Dead__c FROM Contact WHERE AccountId IN: mp.keySet()]){
                con.Dead__c = mp.get(con.AccountId);
                upd.add(con);
        }
        if(upd.size()>0)
         UPDATE upd;
    }
}