public class Task5September {
	@AuraEnabled
    public static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account ORDER BY Name];
    }
    
    @AuraEnabled
    public static List<Contact> getRelatedContacts(String accId) {
        return [SELECT FirstName, LastName, Email, Phone FROM Contact WHERE AccountId = :accId];
    }
    
    @AuraEnabled
    public static void deleteContact(String conId) {
        System.debug(conId);
        Contact con = [SELECT Id FROM Contact WHERE Id = :conId];
        DELETE con;
    }
    
    @AuraEnabled
    public static void upsertContacts(String accId, List<Contact> conList) {
        for(Integer i = 0; i < conList.size(); i++) {
            conList[i].AccountId = accId;
        }
        UPSERT conList Contact.Fields.Id;
    }
}