public with sharing class AccountContactViewerController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsForAccount(String accountId) {
        return [SELECT Id, FirstName, LastName, Email FROM Contact WHERE AccountId = :accountId];
    }
}