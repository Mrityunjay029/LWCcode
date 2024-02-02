trigger PreventDuplicateOpportunity on Opportunity (before insert,before update) {
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
        Map<Id,String> mp = new Map<Id,String>();
        Set<Id> s = new Set<Id>();
        for(Opportunity opp : trigger.new)
            s.add(opp.AccountId);
        for(Opportunity opp : [SELECT Name,AccountId FROM Opportunity WHERE AccountId IN : s])
            mp.put(opp.AccountId,opp.Name);
        for(Opportunity opp : trigger.new){
            if(mp.get(opp.AccountId) == opp.Name)
                opp.addError('Duplicates Found');
        }
    }
}