public class test11Jan {
    @AuraEnabled(cacheable=true)
    public static void processFileUpload(String myId){
        System.debug('Success');
        List<ContentVersion> lis = [SELECT Id, Title, ContentDocumentId, VersionData, FileType FROM ContentVersion WHERE ContentDocumentId =: myId];
        system.debug(lis[0].FileType);
        String fileName = lis[0].Title +'.'+ lis[0].FileType;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        System.debug(fileName);
        Blob fileBlob = lis[0].VersionData;
        String encodedFile = EncodingUtil.base64Encode(fileBlob);
        System.debug(encodedFile);
        
        request.setEndpoint('https://www.ftp-api.com/ftp/upload');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('username', 'if0_35652449');
        request.setHeader('password', 'CcPbziKFaubwxN');
        request.setHeader('port', '21');
        request.setHeader('ftp-host', 'ftpupload.net');
        request.setHeader('ftp-type', 'FTP');
        request.setBody('[{"fileName":"'+fileName+'", "path":"/htdocs", "body":"'+encodedFile+'"}]');
        response = http.send(request);
        System.debug(response.getStatusCode());

        if (response.getStatusCode() == 200) {
            System.debug('File ' + fileName + ' uploaded successfully!');
        } else {
            System.debug('Uploading Fail ' + fileName + ': ' + response.getStatusCode());
            System.debug('Response Body: ' + response.getBody());
        }
    }

    //GET THE DATA TO DISPLAY
    @AuraEnabled(cacheable=true)
    public static list<ContentVersion> getcontentversion(String orderId){
        system.debug('This is orderId : => ');
        system.debug(orderId);
    List<ContentDocumentLink> contentDocumentLinks = [
    SELECT ContentDocumentId, LinkedEntityId
    FROM ContentDocumentLink
    WHERE LinkedEntityId = :orderId
];
    Set<Id> s = new Set<Id>();
for(ContentDocumentLink cdlink : contentDocumentLinks){
    s.add(cdlink.ContentDocumentId);
}
    List<ContentVersion> contentVersions = [
        SELECT Id, Title, ContentDocumentId, VersionData, FileType
        FROM ContentVersion
        WHERE ContentDocumentId IN: s
    ];
    return contentVersions;
}
    //FETCH THE CHOOSEN CSV FILE'S DATA IN STRING FORM
    @AuraEnabled(cacheable=true)
    public static String getData(String conId){
        String csvdata = '';
        List<ContentVersion> cv = [SELECT VersionData,ContentDocumentId,FileType FROM ContentVersion WHERE ContentDocumentId =: conId];
        csvdata = cv[0].VersionData.toString();
        system.debug(csvdata);
        return csvdata;
    }

}