public with sharing class OpportunityController {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunitiesByAccountId(String accountId) {
        return [SELECT Id, Name, StageName, Amount FROM Opportunity WHERE AccountId = :accountId];
    }
}