public with sharing class LWCtest {
    @AuraEnabled(cacheable=true)
    public static List<Account> Accounts() {
        return [SELECT Id, Name, Industry FROM Account];
    }
}