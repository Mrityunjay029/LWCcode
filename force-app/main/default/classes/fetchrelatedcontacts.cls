public class fetchrelatedcontacts {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [SELECT Name,Id FROM Account LIMIT 10];
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String check){
        return [SELECT AccountId,LastName FROM Contact WHERE AccountId = :check];
    }
}