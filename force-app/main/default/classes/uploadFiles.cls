public class uploadFiles {
    @AuraEnabled(cacheable=true)
    public static List<CombinedAttachment> getOrderAttachments(String orderId) {
        List<Order> orderList = [SELECT Id, Name, (SELECT Title, Id FROM CombinedAttachments) FROM Order WHERE Id = :orderId];


        List<CombinedAttachment> attachments = new List<CombinedAttachment>();


        for (Order ord : orderList) {
            List<CombinedAttachment> combinedAttachments = ord.CombinedAttachments;


            for (CombinedAttachment attachment : combinedAttachments) {
                attachments.add(attachment);
            }
        }


        return attachments;
    }
    @AuraEnabled(cacheable=true)
    public static String getCSVContent(String contentDocumentId) {
        String csvContent = '';
        String csvBody = '';
        List<ContentVersion> contentVersions = [SELECT Id,VersionData,ContentDocumentId FROM ContentVersion WHERE ContentDocumentId = :contentDocumentId LIMIT 1];

        if (!contentVersions.isEmpty()) {
            Blob fileContent = contentVersions[0].VersionData;
            csvContent = fileContent.toString();
            system.debug(csvContent);
        }
        return csvContent;
    }
}









// public with sharing class uploadFiles {
//      @AuraEnabled(cacheable=true)
//     public static List<ContentDocumentLink> getOrderAttachments(String orderId) {
//         //List<Order> orderList = [SELECT Id, Name, (SELECT Title, Id,ContentUrl FROM CombinedAttachments) FROM Order WHERE Id = :orderId];
//         list<ContentDocumentLink> cdlRecords = [SELECT LinkedEntityId, Id, ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :orderId];
//         System.debug('cdlRecords  -> '+ cdlRecords);
//         return cdlRecords;
//        // List<CombinedAttachment> attachments = new List<CombinedAttachment>();
//     }

    
// }