trigger EnquiryTrigger on Enquiry__c (before insert, before update, after update, after delete, after undelete) {
    
    if(trigger.isInsert) {
        EnquiryTriggerHandler.handleInsert(trigger.new);
    }
    
    if(trigger.isDelete) {
        EnquiryTriggerHandler.handleDelete(trigger.old);
    }
    
    if(trigger.isUpdate) {
        if(trigger.isBefore) {
            EnquiryTriggerHandler.handleBeforeUpdate(trigger.old, trigger.new);
        } else {
            EnquiryTriggerHandler.handleAfterUpdate(trigger.old, trigger.new);
        }
    }
}