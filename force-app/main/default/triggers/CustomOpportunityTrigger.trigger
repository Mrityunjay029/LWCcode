trigger CustomOpportunityTrigger on Opportunity (before insert) {
    CustomOpportunityTriggerHandler.addprefix(trigger.new);
}