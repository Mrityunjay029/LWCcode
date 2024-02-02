public class EnquiryTriggerHandler {
    
    public static Boolean checker = false;

    public static void handleInsert(List<Enquiry__c> newEnquiries) {
        Set<Id> contactIds = new Set<Id>();
        contactIds.addAll((new Map<Id, AggregateResult>([SELECT Contact__c Id FROM Enquiry__c GROUP BY Contact__c])).keySet());
        Set<Id> contactsToModify = new Set<Id>();
        for(Integer i = 0; i < newEnquiries.size(); i++) {
            Enquiry__c eq = newEnquiries[i];
            
            if(eq.Site_Visit__c && !contactsToModify.contains(eq.Contact__c)) {
                eq.Source__c = 'Primary';
                contactsToModify.add(eq.Contact__c);
                contactIds.add(eq.Contact__c);
            } else if(contactIds.contains(eq.Contact__c) && eq.Source__c == 'Primary') {
                eq.addError('Contact can only have one primary enquiry');
            } else if(!contactIds.contains(eq.Contact__c) && !contactsToModify.contains(eq.Contact__c)) {
                contactIds.add(eq.Contact__c);
                eq.Source__c = 'Primary';
            }
        }
        
        List<Enquiry__c> toUpdate = new List<Enquiry__c>();
        for(Enquiry__c eq: [SELECT Source__c FROM Enquiry__c WHERE Contact__c IN :contactsToModify]) {
            eq.Source__c = 'Secondary';
            toUpdate.add(eq);
        }
        
        for(Enquiry__c eq: newEnquiries) {
            if(contactsToModify.contains(eq.Contact__c) && !eq.Site_Visit__c && eq.Source__c == 'Primary') {
                eq.Source__c = 'Secondary';
            }
        }
        
        if(toUpdate.size() > 0) {
            checker = true;
            UPDATE toUpdate;
        }
    }
    
    public static void handleBeforeUpdate(List<Enquiry__c> oldEnquiries, List<Enquiry__c> newEnquiries) {	
        
        Set<Id> contactIds = (new Map<Id, AggregateResult>([SELECT Contact__c Id FROM Enquiry__c GROUP BY Contact__c])).keySet();
        for(Integer i = 0; i < oldEnquiries.size(); i++) {
            Enquiry__c eq1 = oldEnquiries[i];
            Enquiry__c eq2 = newEnquiries[i];
            
            if(contactIds.contains(eq2.Contact__c) && eq2.Source__c == 'Primary') {
                eq2.addError('Contact can only have one primary enquiry');
            }
        }
    }
    
    public static void handleAfterUpdate(List<Enquiry__c> oldEnquiries, List<Enquiry__c> newEnquiries) {
        if(checker) {
            checker = false;
            return;
        }
        
        List<Enquiry__c> toDelete = new List<Enquiry__c>();
        for(Integer i = 0; i < oldEnquiries.size(); i++) {
            Enquiry__c eq1 = oldEnquiries[i];
            Enquiry__c eq2 = newEnquiries[i];
            
            if(eq1.Contact__c != eq2.Contact__c || (eq1.Source__c == 'Primary' && eq2.Source__c != 'Primary')) {
                if(eq1.Contact__c != null) toDelete.add(eq1);
            } 
        }
        
        handleDelete(toDelete);
    }
    
    public static void handleDelete(List<Enquiry__c> oldEnquiries) {
        Set<Id> contactIds = new Set<Id>();
        Set<Id> enquiryIds = new Set<Id>();
        for(Integer i = 0; i < oldEnquiries.size(); i++) {
            Enquiry__c eq = oldEnquiries[i];
            if(eq.Contact__c != null && eq.Source__c == 'Primary') {
                contactIds.add(eq.Contact__c);
                enquiryIds.add(eq.Id);
            }
        }
        
        List<Enquiry__c> toUpdate = new List<Enquiry__c>();
        for(Enquiry__c eq: [SELECT Source__c, Contact__c FROM Enquiry__c WHERE Contact__c IN :contactIds AND (NOT Id IN :enquiryIds) ORDER BY CreatedDate]) {
            if(!contactIds.contains(eq.Contact__c)) continue;
            eq.Source__c = 'Primary';
            contactIds.remove(eq.Contact__c);
            toUpdate.add(eq);
        }
        
        if(toUpdate.size() > 0) {
            checker = true;
            UPDATE toUpdate;
        }
    }
}