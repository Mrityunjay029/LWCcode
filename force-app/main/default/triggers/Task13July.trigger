trigger Task13July on Account (After Update) {
    /*if(trigger.isAfter && trigger.isUpdate){
        Set<Id> s = new Set<Id>();
        for(Account acc : trigger.new)
            s.add(acc.Id);
        List<Opportunity> lis = [SELECT AccountId,Name,StageName,CloseDate,CreatedDate FROM Opportunity WHERE AccountId IN : s];
        List<Opportunity> UPD = new List<Opportunity>();
        for(Opportunity opp : lis){
            if(opp.StageName != 'Closed Won' && opp.CreatedDate.Date().daysBetween(Date.today()) > 30){
                opp.StageName = 'Closed Lost';
                UPD.add(opp);
            }
        }
        System.debug(UPD);
        if(UPD.size()>0)
            UPDATE UPD;
    }*/
}