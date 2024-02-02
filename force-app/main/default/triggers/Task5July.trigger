trigger Task5July on Account (after Update) {
   Map<Id, String> accNameMap = new Map<Id, String>();
        for(Integer i = 0; i < trigger.old.size(); i++) {
            if(trigger.old[i].Type != trigger.new[i].Type) {
                accNameMap.put(trigger.new[i].Id, trigger.new[i].Name);
            }
        }
        List<Contact> conList = [SELECT Email, AccountId FROM Contact WHERE AccountId IN :accNameMap.keySet()];
        Map<Id, Messaging.SingleEmailMessage> emailMap = new Map<Id, Messaging.SingleEmailMessage>();
        Map<Id, List<String>> emailList = new Map<Id, List<String>>();
        for(Contact ob: conList) {
            if(emailMap.containsKey(ob.AccountId)) {
                List<String> emails = emailList.get(ob.AccountId);
                emails.add(ob.Email);      
                Messaging.SingleEmailMessage newMail = emailMap.get(ob.AccountId);
                newMail.setBccAddresses(emails);
                emailMap.put(ob.AccountId, newMail);
                emailList.put(ob.AccountId, emails);
            } else {
                List<String> emails = new List<String>();
                emails.add(ob.Email);
                Messaging.SingleEmailMessage newMail = new Messaging.SingleEmailMessage();
                newMail.setSubject(accNameMap.get(ob.AccountId));
                newMail.setPlainTextBody('Parent account type was changed.');
                newMail.setBccAddresses(emails);
                emailMap.put(ob.AccountId, newMail);
                emailList.put(ob.AccountId, emails);
            }
        }
        Messaging.sendEmail(emailMap.values());
}