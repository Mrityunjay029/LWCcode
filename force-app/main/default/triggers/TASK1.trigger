trigger TASK1 on Account (After insert, After Update) {
    /*if(trigger.isInsert || trigger.isUpdate){
        Set<Id> s = new Set<Id>();
        for(Account acc : trigger.new){
            s.add(acc.Id);
        }
        List<Account> lis = [SELECT Id,Name,(SELECT AccountId,Name FROM Opportunities) FROM Account WHERE Id IN : s];
        List<Opportunity> opplis = new List<Opportunity>();
        for(Account acc : lis){
            if(acc.Opportunities.size()<1){
                Opportunity opp = new Opportunity();
                opp.Name = 'First Opportunity' + acc.Name;
                opp.AccountId = acc.Id;
                opp.CloseDate = System.today();
                opp.StageName = 'Closed Won';
                opplis.add(opp);
            }
        }
        System.debug(opplis);
            INSERT opplis;
    }*/
}