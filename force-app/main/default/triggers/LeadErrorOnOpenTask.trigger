trigger LeadErrorOnOpenTask on Lead (before update) {
    Set<Id> whoIds = new Set<Id>();
    for(Integer i = 0; i < trigger.new.size(); i++) {
        if(Trigger.new[i].Status.contains('Closed') && 
           !Trigger.old[i].Status.contains('Closed')) {
            whoIds.add(Trigger.new[i].Id);
            whoIds.add(Trigger.new[i].ConvertedContactId);
        }
    }
    
    List<Task> openTaskList = [SELECT Id, WhoId FROM Task WHERE WhoId IN :whoIds AND IsClosed = false];
    whoIds.clear();
    for(Task t: openTaskList) { whoIds.add(t.WhoId); }
    
    for(Lead updatedLead: trigger.new) {
        if(whoIds.contains(updatedLead.Id) || whoIds.contains(updatedLead.ConvertedContactId)) {
            updatedLead.addError('Lead cannot be converted as it has open tasks');
        }
    }
}