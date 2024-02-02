@RestResource(urlMapping='/insertAccount')
global with sharing class CustomRESTEndpoint {
    @HttpPost
    global static void doPost() {
        RestRequest req = RestContext.request;
        System.debug(JSON.deserializeUntyped(req.requestBody.toString()));
        Account account = (Account)JSON.deserialize(req.requestBody.toString(), Account.class);
        insert account;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        res.responseBody = Blob.valueOf(JSON.serialize(account));
    }
}