trigger PriorityOfCases on Case (after insert,after update) {
    Set<Id> s = new Set<Id>();
    for(Case cs : trigger.new){
        s.add(cs.AccountId);
    }
    List<Account> lis = [SELECT Name,Id FROM Account WHERE Id IN : s];
    Map<Id,Integer> mpL = new Map<Id,Integer>();
    Map<Id,Integer> mpM = new Map<Id,Integer>();
    Map<Id,Integer> mpH = new Map<Id,Integer>();
    
    for(Case cs : [SELECT ID, AccountId , Priority FROM Case WHERE AccountId IN :s]){
        if(cs.Priority=='Low'){
            if(mpL.containsKey(cs.AccountId))
                mpL.put(cs.AccountId,mpL.get(cs.AccountId)+1);
            else
                mpL.put(cs.AccountId, 1);
        }
        else if(cs.Priority=='Medium'){
            if(mpM.containsKey(cs.AccountId))
                mpM.put(cs.AccountId,mpM.get(cs.AccountId)+1);
            else
                mpM.put(cs.AccountId,1);
        }
        else if(cs.Priority=='High'){
            if(mpH.containsKey(cs.AccountId))
                mpH.put(cs.AccountId, mpH.get(cs.AccountId)+1);
            else
                mpH.put(cs.AccountId,1);
        }
    }
    List<Account> upd = new List<Account>();
    for(Account li : lis){
        if(mpL.containsKey(li.Id)){
            li.Low__c = mpL.get(li.Id);
            upd.add(li);
        }
        else if(mpM.containsKey(li.Id)){
            li.Medium__c = mpM.get(li.Id);
            upd.add(li);
        }
        else if(mpH.containsKey(li.Id)){
            li.High__c = mpH.get(li.Id);
            upd.add(li);
        }
    }
    if((trigger.isinsert && trigger.isafter) || (trigger.isupdate && trigger.isafter))
    UPDATE upd;
}