trigger NumberofMalesFemales on Contact (after insert, after update, after delete, after undelete) {
    NumberofMalesFemales_Handler handler = new NumberofMalesFemales_Handler();
    
    if(trigger.isInsert || trigger.isUndelete || trigger.isUpdate) {
        handler.listIncrementDecrement(trigger.new, 1);
    }
    
    if(trigger.isDelete || trigger.isUpdate) {
        handler.listIncrementDecrement(trigger.old, -1);
    }
    
    Set<Id> accIds = new Set<Id>();
    accIds.addAll(handler.maleChange.keySet());
    accIds.addAll(handler.femaleChange.keySet());
    List<Account> toUpdate = new List<Account>();
    for(Account acc: [SELECT Id, Number_of_Males__c, Number_of_Females__c FROM Account WHERE Id IN :accIds]) {
        if(handler.maleChange.containsKey(acc.Id)) acc.Number_of_Males__c += handler.maleChange.get(acc.Id);
        if(handler.femaleChange.containsKey(acc.Id)) acc.Number_of_Females__c += handler.femaleChange.get(acc.Id);
        toUpdate.add(acc);
    }
    
    if(!toUpdate.isEmpty()) {
        UPDATE toUpdate;
    }
}