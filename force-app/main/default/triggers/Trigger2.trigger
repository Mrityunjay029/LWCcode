trigger Trigger2 on Contact (After insert,After Update, After delete) {
        Set<Id> s = new Set<Id>();
        for(Contact con : trigger.new){
            s.add(con.AccountId);
        }
        List<Account> upd = new List<Account>();
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
        for(Account acc : [SELECT Id,Name,Child_Contacts__c FROM Account WHERE Id IN : s]){
            acc.Child_Contacts__c+=1;
            upd.add(acc);
        }
    }
    if(upd.size()>0)
            UPDATE upd;
}