@isTest
public class MyClassHandlerTest {
    @isTest
    public static void main(){
        test.startTest();
		Product2 PD = new Product2(Name='Prod Name');
        Insert PD;
        Id stdpdID = test.getStandardPricebookId();
        PricebookEntry PB = new PricebookEntry(Product2Id=pd.Id,Pricebook2Id = stdpdID, IsActive =True, UnitPrice = 1242);
        Insert PB;
        Opportunity opp = new Opportunity(Name='New Test ',StageName='Prospecting',closeDate=Date.today()+7,Pricebook2Id = stdpdID);
        Insert opp;
        test.stopTest();
    }

}