public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static Account getAccountById(String accountId) {
        return [SELECT Id, Name, Industry, Type FROM Account WHERE Id = :accountId LIMIT 1];
    }
}