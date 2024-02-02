public with sharing class OpportunityLineItemController {
    @AuraEnabled(cacheable=true)
    public static List<OpportunityLineItem> getOpportunityLineItemsByOpportunityId(String opportunityId) {
        return [SELECT Id, Product2.Name, Quantity, UnitPrice FROM OpportunityLineItem WHERE OpportunityId = :opportunityId];
    }
}