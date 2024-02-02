public class TinyUrlApiCall {
    @AuraEnabled
    public static String getShortenedUrl(String url) {
        String endpointUrl = 'https://api.tinyurl.com/create?api_token='+Label.tiny_url_api_key;
        String returnVal;
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpointUrl);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody('{"url":"'+url+'","domain":"tinyurl.com"}');
        Http http = new Http();

        try {
            HttpResponse res = http.send(req);
            if (res.getStatusCode() == 200) {
                System.debug('200 code');
                Map<String, Object> response = (Map<String, Object>)(JSON.deserializeUntyped(res.getBody()));    
                returnVal = ((Map<String, Object>)response.get('data')).get('tiny_url').toString();
                System.debug(returnVal);
            } else {
                System.debug('Non 200 code: '+res.getStatusCode());
            }
        } catch (Exception e) {
            System.debug('Exception: ' + e.getMessage());
            System.debug('Line Number: ' + e.getLineNumber());
            System.debug('Cause: ' + e.getCause());
        }
        return returnVal;
    }
}