public with sharing class practice4 {
    @AuraEnabled
    (cacheable=true)
    public static List<Opportunity> getOpp(){
        return [SELECT Id,Name,CloseDate,StageName FROM Opportunity limit 10];
    }
}