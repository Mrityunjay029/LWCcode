@isTest
public class Trigger6_test {
    @isTest
    public static void main(){
        Lead l = new Lead(LastName = 'Mrityunjay',Company = 'Astrea',Status = 'Open - Not Contacted',Country = 'India',State = 'Goa');
        INSERT l;
        Test.startTest();
        Lead x = [SELECT GOAL__c,Id FROM Lead WHERE Id =: l.Id];
        System.assertEquals('West', x.GOAL__c);
        Test.stopTest();
    }
}