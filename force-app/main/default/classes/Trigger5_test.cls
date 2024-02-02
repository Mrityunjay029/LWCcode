@isTest
public class Trigger5_test {
    @isTest
    public static void main(){
        Account acc = new Account(Name='Parent1');
        INSERT acc;
        Test.startTest();
        Contact con = new Contact(LastName='Mrityunjay',AccountId = acc.Id);
        INSERT con;
        Account acc1 = [SELECT Number_of_Contacts__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(1, acc1.Number_of_Contacts__c);
        Test.stopTest();
    }
}