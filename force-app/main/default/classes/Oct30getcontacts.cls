public class Oct30getcontacts {
@AuraEnabled
public static List<Account> getAccounts(){
    return [SELECT Name,Id FROM Account];
}
@AuraEnabled
public static List<Contact> getContacts(Id x){
    return [SELECT Id ,AccountId,LastName FROM Contact WHERE AccountId = :x];
}
}