trigger CheckContacts on Contact (after insert,after update,before delete) {
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
        Set<Id> s = new Set<Id>();
        for(Contact con : trigger.new){
            s.add(con.AccountId);
        }
        
        List<Account> upd = new List<Account>();
        aggregateResult a = [SELECT count(Id) total FROM Contact WHERE Dead__c = True AND AccountId IN : s GROUP BY AccountId];
        for(Account acc : [SELECT Id,Intel__c,(SELECT AccountId,Dead__c FROM Contacts) FROM Account WHERE Id IN : s]){
            if(acc.contacts.size()!=0 && (((Integer)a.get('total')/acc.contacts.size())*100 >= 70)){
                acc.Intel__c = true;
                upd.add(acc);
            }else{
                acc.Intel__c = false;
                upd.add(acc);
            }
        }
        if(upd.size()>0)
            UPDATE upd;
    }
    if(trigger.isBefore && trigger.isDelete){
        Set<Id> s = new Set<Id>();
        Map<Id,Integer> mp = new Map<Id,Integer>();
        for(Contact con : trigger.old){
            s.add(con.Id);
            if(mp.containskey(con.AccountId))
                mp.put(con.AccountId,mp.get(con.AccountId)+1);
            else
                mp.put(con.AccountId,1);
        }
        List<Account> upd = new List<Account>();
        aggregateResult c = [SELECT count(Id) total FROM Contact WHERE Dead__c = True AND AccountId IN : mp.keySet() AND Id NOT IN : s];
        for(Account acc : [SELECT Id,Intel__c,(SELECT AccountId,Dead__c FROM Contacts) FROM Account WHERE Id IN: mp.keySet()]){
            if(((Integer)c.get('total')/(acc.Contacts.size()-mp.get(acc.Id)))*100 >= 70)
                acc.Intel__c = true;
            else
                acc.Intel__c = false;
            upd.add(acc);
        }
        if(upd.size()>0)
            UPDATE upd;
    }
}