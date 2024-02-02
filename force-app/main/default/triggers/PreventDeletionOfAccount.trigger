trigger PreventDeletionOfAccount on Account (before insert) {
     /*
    Map<Id, Account> accMap = new Map<Id, Account>();
for(Account acc: trigger.old) {
    accMap.put(acc.Id, acc);
    }

List<Opportunity> oppList = [SELECT StageName, AccountId FROM Opportunity WHERE (NOT (StageName = 'Closed Won' OR StageName = 'Closed Lost')) AND AccountID IN :accMap.keySet()];
for(Opportunity opp: oppList) {
     if(accMap.containsKey(opp.AccountId)) {
            accMap.get(opp.AccountId).addError('Account has open opportunities');
            accMap.remove(opp.AccountId);
       }
    }*/
}