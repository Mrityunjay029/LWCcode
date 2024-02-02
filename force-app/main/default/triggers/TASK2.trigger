trigger TASK2 on Opportunity (After insert) {
    if (Trigger.isInsert) {
        Set<Id> s = new Set<Id>();
        for(Opportunity opp : trigger.new)
            s.add(opp.AccountId);
        
        List<Account> lis = [SELECT Id,Name,(SELECT AccountId,Name FROM Opportunities) FROM Account WHERE Id IN : s];
        
        
    }
}