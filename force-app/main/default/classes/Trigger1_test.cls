@isTest
public class Trigger1_test {
    @isTest
    public static void main() {
        //
        Account acc = new Account(Name='Vedansh', Intel__c=true);
        INSERT acc;
        Contact con = new Contact(LastName='Agarwal', Dead__c=true, AccountId=acc.Id);
        INSERT con;
        
        
        Test.startTest();
            acc.Intel__c = false;
            UPDATE acc;
        	Contact con1 = [SELECT Dead__c FROM Contact WHERE Id = :con.Id];
        	System.assertEquals(false, con1.Dead__c);
        Test.stopTest();
    }
}