public with sharing class task11August {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsForAccount(Id accountId) {
        return [SELECT Id, FirstName, LastName, Email FROM Contact WHERE AccountId = :accountId];
    }
}