@IsTest
public class Task12julyTestClass {
    @IsTest
    static void testAccountTrigger() {
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            Account acc = new Account(Name = 'MyAccount ' + i, Intel__c = false);
            testAccounts.add(acc);
        }
        insert testAccounts;
        List<Contact> testContacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            Contact con = new Contact(
                FirstName = 'My',
                LastName = 'Contact ' + i,
                AccountId = testAccounts[i].Id,
                Dead__c = false
            );
            testContacts.add(con);
        }
        insert testContacts;
        Test.startTest();
        for (Contact con : testContacts) {
            con.Dead__c = true;
        }
        update testContacts;
        delete testContacts;
        Test.stopTest();
        List<Account> updatedAccounts = [SELECT Id, Intel__c FROM Account WHERE Id IN :testAccounts];
        for (Account acc : updatedAccounts) {
            System.assertEquals(true, acc.Intel__c);
        }
    }
}