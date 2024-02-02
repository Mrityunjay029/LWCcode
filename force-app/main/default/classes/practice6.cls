public with sharing class practice6 {
    @AuraEnabled
    (cacheable=true)
    public static List<Account> getAccount(){
        return [SELECT Id,Name From Account limit 10];
    }
}