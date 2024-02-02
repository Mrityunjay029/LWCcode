@isTest
public class TestPracticeNumofContacts {
    @isTest
    public static void main(){
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Contact con = new Contact(
        LastName = 'Test Contact',
        AccountId = acc.Id
        );
        insert con;
        
        Account testacc = [SELECT Id,Number_of_related_Contacts__c FROM Account WHERE Id = :con.AccountId];
        System.assertEquals(1,testacc.Number_of_related_Contacts__c);
        
        DELETE con;
        System.assertEquals(0,acc.Number_of_related_Contacts__c);
    }
}