@isTest
private class Task12JulyTest {
    @isTest
    static void testTriggerLogic() {
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        Opportunity testOpportunity1 = new Opportunity(
            Name = 'Test Opportunity 1',
            StageName = 'Stage 1',
            CloseDate = Date.today(),
            AccountId = testAccount.Id
        );
        Opportunity testOpportunity2 = new Opportunity(
            Name = 'Test Opportunity 2',
            StageName = 'Stage 2',
            CloseDate = Date.today().addDays(-31),
            AccountId = testAccount.Id
        );
        Opportunity testOpportunity3 = new Opportunity(
            Name = 'Test Opportunity 3',
            StageName = 'Closed Won',
            CloseDate = Date.today().addDays(-35),
            AccountId = testAccount.Id
        );
        insert new List<Opportunity>{testOpportunity1, testOpportunity2, testOpportunity3};
        
        test.startTest();
        testAccount.Name = 'Updated Account Name';
        update testAccount;
        test.stopTest();
        
        List<Opportunity> updatedOpportunities = [SELECT Id, StageName FROM Opportunity WHERE AccountId = :testAccount.Id];
        
        System.assertEquals(2, updatedOpportunities.size(), 'Incorrect number of updated opportunities');
        for (Opportunity opp : updatedOpportunities) {
            System.assertEquals('Closed Lost', opp.StageName, 'Opportunity StageName should be "Closed Lost"');
        }
    }
}