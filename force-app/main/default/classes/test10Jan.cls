public with sharing class test10Jan {
    @AuraEnabled(cacheable=true)
    public static String getCSVContent(String contentDocumentId) {
        String csvContent = '';
        String csvBody = '';
        List<ContentVersion> contentVersions = [SELECT Id,VersionData,ContentDocumentId FROM ContentVersion WHERE ContentDocumentId = :contentDocumentId LIMIT 1];

        if (!contentVersions.isEmpty()) {
            Blob fileContent = contentVersions[0].VersionData;
            csvContent = fileContent.toString();
            system.debug(csvContent);
            HttpRequest request = new HttpRequest();
            request.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + csvContent);
            request.setMethod('GET');

        Http http = new Http();
        try {
            HttpResponse response = http.send(request);

            if (response.getStatusCode() == 200) {
                csvBody =  response.getBody();
            } else {
                System.debug('Error: ' + response.getStatusCode() + ' ' + response.getStatus());
                return null;
            }
        } catch (Exception e) {
            System.debug('Exception: ' + e.getMessage());
            return null;
        }
        }
        return csvBody;
    }
}