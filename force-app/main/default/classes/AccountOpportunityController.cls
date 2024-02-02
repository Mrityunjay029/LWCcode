public with sharing class AccountOpportunityController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account];
    }

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunities(Id accountId) {
        return [SELECT Id, Name FROM Opportunity WHERE AccountId = :accountId];
    }

    @AuraEnabled(cacheable=true)
    public static List<OpportunityLineItem> getOpportunityLineItems(Id opportunityId) {
        return [SELECT Id, Product2.Name, Quantity, UnitPrice FROM OpportunityLineItem WHERE OpportunityId = :opportunityId];
    }
}