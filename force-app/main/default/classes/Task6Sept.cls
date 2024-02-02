public with sharing class Task6Sept {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList() {
        return [SELECT Id, Name FROM Account];
    }

    @AuraEnabled()
    public static List<Contact> getContactList(String accountId) {
        return [SELECT Id, FirstName, LastName, Phone, Email FROM Contact WHERE AccountId = :accountId];
    }

    @AuraEnabled()
    public static void updateContact(Contact con) {
        UPDATE con;
    }

    @AuraEnabled()
    public static void deleteContact(String conId) {
        Contact con = [SELECT Id FROM Contact WHERE Id = :conId];
        DELETE con;
    }
}