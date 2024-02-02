global class BirthdayEmailBatch implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // Query all contacts with a birthday today
        Date today = Date.today();
        String query = 'SELECT Id, LastName, Email, Birthdate FROM Contact WHERE Birthdate = :today';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Contact> scope) {
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();

        for(Contact con : scope) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setTemplateId('00X2w000003Lsa3'); // Replace with the ID of your email template
            email.setTargetObjectId(con.Id);
            system.debug(con.Id);
            email.setSaveAsActivity(false);
            emailList.add(email);
        }

        // Send emails
        Messaging.sendEmail(emailList);
    }

    global void finish(Database.BatchableContext BC) {
        // Execute any post-processing operations if needed
    }
}