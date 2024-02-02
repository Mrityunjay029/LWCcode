trigger Task14July on Contact (Before insert) {
    if(trigger.isBefore && trigger.isInsert){
        Set<Id> s = new Set<Id>();
        for(Contact con : trigger.new){
            s.add(con.AccountId);
        }
        List<Account> lis = [SELECT Id,Name,(SELECT AccountId FROM Contacts) FROM Account WHERE Id IN : s];
        Map<Id,Integer> mp = new Map<Id,Integer>();
        for(Account li : lis) mp.put(li.Id,li.contacts.size());
        
        for(Contact con : trigger.new) {
            if(mp.get(con.AccountId)==2) con.addError('More than 2 contacts not allowed');
        }
    } 
}