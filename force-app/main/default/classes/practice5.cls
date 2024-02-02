public with sharing class practice5 {
    @AuraEnabled
    (cacheable=true)
    public static List<Account> getAccount(String accName){
        accName = '%' + accName + '%';
        return [SELECT Id,Name FROM Account WHERE Name LIKE : accName];
    }
}