@isTest
public class Task14JulyTest {
    @isTest
    static void testTriggerLogic() {
       
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

       
        List<Contact> testContacts = new List<Contact>();
        for (Integer i = 0; i < 3; i++) {
            testContacts.add(new Contact(
                FirstName = 'Test',
                LastName = 'Contact' + i,
                AccountId = testAccount.Id
            ));
        }
        
        Test.startTest();
        System.runAs(new User(Id = UserInfo.getUserId())) {
            try {
                insert testContacts;
                System.assert(false, 'exception');
            } catch (DmlException e) {
                System.assertEquals(1, e.getNumDml());
                System.assertEquals('More than 2 contacts not allowed', e.getDmlMessage(0));
            }
        }
        Test.stopTest();
    }
}