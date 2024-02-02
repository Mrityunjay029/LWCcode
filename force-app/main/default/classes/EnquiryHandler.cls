public class EnquiryHandler {
    public static void handleInsert(List<Enquiry__c> enquiries) {
        System.debug('Insert');
        Set<Id> contactIds = new Set<Id>();
    	contactIds.addAll((new Map<Id, AggregateResult>([SELECT Contact__c Id FROM Enquiry__c GROUP BY Contact__c])).keySet());
        Set<Id> contactIdsToUpdate = new Set<Id>();
        for(Enquiry__c enquiry: enquiries) {
            if(!contactIds.contains(enquiry.Contact__c) || (enquiry.Site_Visit__c && contactIdsToUpdate.contains(enquiry.Contact__c))) {
                enquiry.Source__c = 'Primary';
                contactIdsToUpdate.add(enquiry.Contact__c);
            } else {
                enquiry.Source__c = 'Secondary';
            }
        }
        
        List<Enquiry__c> toUpdate = new List<Enquiry__c>();
        for(Enquiry__c enquiry: [SELECT Id, Source__c FROM Enquiry__c WHERE Contact__c IN :contactIdsToUpdate AND Source__c = 'Primary']) {
            enquiry.Source__c = 'Secondary';
            toUpdate.add(enquiry);
        }
        
        if(toUpdate.size() > 0) {
            UPDATE toUpdate;
        }
    }
    
    public static void handleUpdate(List<Enquiry__c> oldEnquiries, List<Enquiry__c> newEnquiries) {
        System.debug('Update');
        Set<Id> contactIds = new Set<Id>();
    	contactIds.addAll((new Map<Id, AggregateResult>([SELECT Contact__c Id FROM Enquiry__c GROUP BY Contact__c])).keySet());
        
        List<Enquiry__c> handleInsert = new List<Enquiry__c>();
        List<Enquiry__c> handleDelete = new List<Enquiry__c>();
        for(Integer i = 0; i < oldEnquiries.size(); i++) {
            if(oldEnquiries[i].Contact__c != newEnquiries[i].Contact__c) {
                if(newEnquiries[i] != null) {
                	handleInsert.add(newEnquiries[i]);
                }
                if(oldEnquiries[i] != null) {
                	handleDelete.add(oldEnquiries[i]);
                }
            } else if(oldEnquiries[i].Source__c != 'Primary' && newEnquiries[i].Source__c == 'Primary' && newEnquiries[i].Contact__c != null) {
                if(contactIds.contains(newEnquiries[i].Contact__c)) {
                    newEnquiries[i].addError('Contact cannot have more than one primary enquiry');
                } else {
                    contactIds.add(newEnquiries[i].Contact__c);
                }
            }
        }
        if(handleInsert.size() > 0) {
            handleInsert(handleInsert);
        }
        
        if(handleDelete.size() > 0) {
            handleDelete(handleDelete);
        }
    }
    
    public static void handleDelete(List<Enquiry__c> oldEnquiries) {
        System.debug('Delete');
        Set<Id> contactIds = new Set<Id>();
        Set<Id> enquiryIds = new Set<Id>();
        for(Enquiry__c enquiry: oldEnquiries) {
            if(enquiry.Contact__c != null && enquiry.Source__c == 'Primary') {
            	contactIds.add(enquiry.Contact__c);
                enquiryIds.add(enquiry.Id);
            }
        }
        
        List<Enquiry__c> toProcess = [SELECT Id, Source__c, Contact__c FROM Enquiry__c WHERE Contact__c IN :contactIds AND (NOT Id IN :enquiryIds) ORDER BY CreatedDate];
        List<Enquiry__c> toUpdate = new List<Enquiry__c>();
        for(Enquiry__c enquiry: toProcess) {
            if(!contactIds.contains(enquiry.Contact__c)) continue;
            enquiry.Source__c = 'Primary';
            toUpdate.add(enquiry);
            contactIds.remove(enquiry.Contact__c);
        }
        
        if(toUpdate.size() > 0) {
            UPDATE toUpdate;
        }
    }
}