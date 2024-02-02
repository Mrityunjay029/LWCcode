global class DuplicateAccountsBatch implements Database.Batchable<SObject>, Database.Stateful {

    private Integer duplicateAccountCount = 0;
    private List<String> mergedAccountNames = new List<String>();
    private Map<String, Account> m1 = new Map<String, Account>();

    global Database.QueryLocator start(Database.BatchableContext context) {
        String query = 'SELECT Id, Name FROM Account ORDER BY Name ASC';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext context, List<Account> accounts) {
        Map<Account, List<Account>> duplicateAccounts = new Map<Account, List<Account>>();
        List<Contact> updatedContacts = new List<Contact>();
        List<Case> updatedCases = new List<Case>();
        List<Opportunity> updatedOpportunities = new List<Opportunity>();
        List<Account> accountsToDelete = new List<Account>();

        for (Account currentAccount : accounts) {
            if (!m1.containsKey(currentAccount.Name)) {
                m1.put(currentAccount.Name, currentAccount);
                duplicateAccounts.put(currentAccount, new List<Account>());
            } else if (!duplicateAccounts.containsKey(m1.get(currentAccount.Name))) {
                duplicateAccounts.put(currentAccount, new List<Account>());
            } else {
                duplicateAccounts.get(m1.get(currentAccount.Name)).add(currentAccount);
            }
        }

        for (Contact contact : [SELECT Id, AccountId, Account.Name FROM Contact WHERE AccountId != NULL]) {
            if (!duplicateAccounts.get(m1.get(contact.Account.Name)).isEmpty()) {
                contact.AccountId = m1.get(contact.Account.Name).Id;
                updatedContacts.add(contact);
            }
        }

        for (Opportunity opportunity : [SELECT Id, AccountId, Account.Name FROM Opportunity WHERE AccountId != NULL]) {
            if (!duplicateAccounts.get(m1.get(opportunity.Account.Name)).isEmpty()) {
                opportunity.AccountId = m1.get(opportunity.Account.Name).Id;
                updatedOpportunities.add(opportunity);
            }
        }

        for (Case currentCase : [SELECT Id, AccountId, Account.Name FROM Case WHERE AccountId != NULL]) {
            if (!duplicateAccounts.get(m1.get(currentCase.Account.Name)).isEmpty()) {
                currentCase.AccountId = m1.get(currentCase.Account.Name).Id;
                updatedCases.add(currentCase);
            }
        }

        if (!updatedContacts.isEmpty()) {
            update updatedContacts;
        }

        if (!updatedOpportunities.isEmpty()) {
            update updatedOpportunities;
        }

        if (!updatedCases.isEmpty()) {
            update updatedCases;
        }

        for (Account account : duplicateAccounts.keySet()) {
            if (!duplicateAccounts.get(account).isEmpty()) {
                accountsToDelete.addAll(duplicateAccounts.get(account));
                mergedAccountNames.add(account.Name);
            }
        }

        duplicateAccountCount += accountsToDelete.size();
        System.debug('duplicateAccountCount: ' + duplicateAccountCount);

        if (!accountsToDelete.isEmpty()) {
            delete accountsToDelete;
        }
    }

    global void finish(Database.BatchableContext context) {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] { 'mrityunjay@astreait.com' });
        email.setSubject('Duplicate Accounts Merged');
        email.setPlainTextBody('Total Duplicate accounts that have been merged successfully are ' +
                duplicateAccountCount + ':{' + mergedAccountNames + '}');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
    }
}