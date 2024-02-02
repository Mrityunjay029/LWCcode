trigger UpdateAmountsTrigger on OpportunityLineItem (after update,after insert,after delete) {
    if(trigger.isAfter && (trigger.isUpdate || trigger.isInsert)){
        UpdateAmountsTriggerHandler.handleOperationsInsertUpdate(Trigger.new,0);
    }
    if(trigger.isAfter && trigger.isDelete){
        UpdateAmountsTriggerHandler.handleOperationsInsertUpdate(trigger.old,1);
    }
}