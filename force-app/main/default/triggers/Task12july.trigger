trigger Task12july on Contact (After insert,After Update,After Delete) {
    /* Set<Id> s = new Set<Id>();
    if((trigger.isAfter && trigger.isInsert) || (trigger.isAfter && trigger.isUpdate)){
        for(Contact con : trigger.new)
            s.add(con.AccountId);
        
    }
    else if(trigger.isAfter && trigger.isDelete){
        for(Contact con : trigger.old)
            s.add(con.AccountId);
    }
        List<Account> lis = [SELECT Id,Name,Intel__c,(SELECT Name,AccountId,Dead__c FROM Contacts) FROM Account WHERE Id IN : s];
        List<Account> UPD = new List<Account>();
        for(Account li : lis){
            Integer count = 0;
            for(Contact con : li.Contacts){
                if(coN.Dead__c == True)
                    count++;
            }
            if(li.contacts.size()!=0){
                if(count/li.contacts.size() >= 0.75)
                    li.Intel__c = True;
                else li.Intel__c = False;
            }
            else if(li.contacts.size()==0){
                li.Intel__c = False;
            }
            UPD.add(li);
        }
        if(UPD.size()>0)
            UPDATE UPD; */
}