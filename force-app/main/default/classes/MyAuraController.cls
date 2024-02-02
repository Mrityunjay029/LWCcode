public class MyAuraController {
    @AuraEnabled
    public static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account];
    }
    
    @AuraEnabled
    public static List<Contact> getContactsByAccount(String accountId) {
        return [SELECT Id, Name, Email FROM Contact WHERE AccountId = :accountId];
    }
}