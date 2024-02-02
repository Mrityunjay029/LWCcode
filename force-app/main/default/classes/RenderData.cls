public with sharing class RenderData {
        @AuraEnabled(cacheable=true)
        public static List<Account> getAccounts() {
            List<Account> li =  [SELECT Name, Industry, Phone FROM Account LIMIT 10];
            System.debug(li.size());
            return li;
}
}