public class toastEvent {
    @AuraEnabled
    public static void Create(String Name,String Email){
        Account acc = new Account();
        acc.Name = Name;
        acc.Email__c = Email;
        INSERT acc;
    }
}