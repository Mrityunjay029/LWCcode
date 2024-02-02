public with sharing class getObjects {
    @AuraEnabled
    (cacheable=true)
    public static List<sObject> getall(){
        return [SELECT SObjectType FROM ObjectPermissions GROUP BY SObjectType ORDER BY SObjectType ASC];
    }
}