trigger PracticeIntel on Contact (after insert,after update,before delete) {
    if(trigger.isAfter && trigger.isInsert){
        Set<Id> s = new Set<Id>();
        for(Contact con : trigger.new)
            s.add(con.AccountId);
        Map<Id,Integer>mp = new Map<Id,Integer>();
        List<Contact> con = [SELECT AccountId,Dead__c FROM Contact WHERE AccountId IN : s];
        for(Contact co : con){
            
        }
    } 
}