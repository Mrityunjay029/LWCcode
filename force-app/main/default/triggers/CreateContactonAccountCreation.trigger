trigger CreateContactonAccountCreation on Account (after insert,before delete) {
    if(trigger.isAfter && trigger.isInsert){
        List<Contact> append = new List<Contact>();
        for(Account acc : trigger.new){
            Contact con = new Contact();
            con.AccountId = acc.Id;
            con.LastName = acc.Name;
            append.add(con);
        }
        if(append.size()>0)
            INSERT append;
    }
    if(trigger.isBefore && trigger.isDelete){
        Set<Id> s = new Set<Id>();
        for(Account acc : trigger.old)
            s.add(acc.Id);
        List<Contact> con = [select AccountId FROM Contact WHERE AccountId IN : s];
        List<Contact> upd = new List<Contact>();
        for(Contact c : con){
            upd.add(c);
        }
        if(upd.size()>0)
            DELETE upd;
    }
}