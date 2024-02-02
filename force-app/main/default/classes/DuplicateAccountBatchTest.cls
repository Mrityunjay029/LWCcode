@isTest
private class DuplicateAccountBatchTest {

    @isTest
    static void testDuplicateAccountBatch() {
        Account acc1 = new Account(Name = 'Test Account 1');
        insert acc1;

        Account acc2 = new Account(Name = 'Test Account 2');
        insert acc2;

        Contact con1 = new Contact(FirstName = 'John', LastName = 'Doe', AccountId = acc1.Id);
        insert con1;

        Contact con2 = new Contact(FirstName = 'Jane', LastName = 'Doe', AccountId = acc2.Id);
        insert con2;

        Opportunity opp1 = new Opportunity(Name = 'Test Opportunity 1', Amount = 1000, CloseDate = System.today(), StageName = 'Prospecting', AccountId = acc1.Id);
        insert opp1;

        Opportunity opp2 = new Opportunity(Name = 'Test Opportunity 2', Amount = 2000, CloseDate = System.today(), StageName = 'Prospecting', AccountId = acc2.Id);
        insert opp2;

       
Test.startTest();
String jobId =  Database.executeBatch(new DuplicateAccountBatch());
Test.stopTest();


if (Test.isRunningTest()) {
    Integer waitTimeMillis = 30000; 
    Long endTime = DateTime.now().getTime() + waitTimeMillis;
    while (DateTime.now().getTime() < endTime) {
       
        AsyncApexJob batchInstance = [SELECT Id, Status FROM AsyncApexJob WHERE Id = :jobId];
        if (batchInstance.Status == 'Completed' || batchInstance.Status == 'Failed' || batchInstance.Status == 'Aborted') {
            break;
        }
    }
}


AsyncApexJob batchInstance = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems FROM AsyncApexJob WHERE Id = :jobId];


System.assertEquals('Completed', batchInstance.Status);
System.assertEquals(0, batchInstance.NumberOfErrors);
System.assertNotEquals(0, batchInstance.JobItemsProcessed);
System.assertNotEquals(0, batchInstance.TotalJobItems);


        List<Account> mergedAccounts = [SELECT Id, Name FROM Account WHERE Id = :acc1.Id OR Id = :acc2.Id];
        System.assertEquals(1, mergedAccounts.size());

        
        List<Contact> mergedContacts = [SELECT Id, FirstName, LastName, AccountId FROM Contact WHERE Id = :con1.Id OR Id = :con2.Id];
        System.assertEquals(1, mergedContacts.size());
        System.assertEquals(mergedAccounts[0].Id, mergedContacts[0].AccountId);

        List<Opportunity> mergedOpportunities = [SELECT Id, Name, AccountId FROM Opportunity WHERE Id = :opp1.Id OR Id = :opp2.Id];
        System.assertEquals(1, mergedOpportunities.size());
        System.assertEquals(mergedAccounts[0].Id, mergedOpportunities[0].AccountId);
    
    }
}