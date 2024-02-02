public class Controller_task18October {
    
    public static Map<String, Object> dontRepeatYourself(String url) {
        Map<String, Object> returnVal;
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');

        Http http = new Http();

        try {
            HttpResponse res = http.send(req);
            if (res.getStatusCode() == 200) {
                System.debug('200 code');
                returnVal = (Map<String, Object>)(JSON.deserializeUntyped(res.getBody()));
            } else {
                System.debug('Non 200 code: ' + res.getStatusCode());
            }
        } catch (Exception e) {
            System.debug('Exception: ' + e.getMessage());
        }
        return returnVal;
    }
    
    @AuraEnabled
    public static List<Map<String, String>> getCurrencyList() {
        Map<String, Object> response = dontRepeatYourself('https://api.frankfurter.app/currencies');
        List<Map<String, String>> returnVal = new List<Map<String, String>>();
        for(String s: response.keySet()) {
            returnVal.add(new Map<String, String>{'label' => String.valueOf(response.get(s)), 'value' => s});
        }
        if(response != null) {
        	return returnVal;
        } else {
            return null;
        }
    }
    
    @AuraEnabled
    public static Object getConversion(Decimal amount, String currency_from, String currency_to) {
        Map<String, Object> response = dontRepeatYourself('https://api.frankfurter.app/latest?amount='+amount+'&from='+currency_from+'&to='+currency_to);
        if(response != null) {
        	return response.get('rates');
        } else {
            return null;
        }
    }
}