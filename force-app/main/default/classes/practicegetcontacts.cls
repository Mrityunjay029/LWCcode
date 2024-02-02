public class practicegetcontacts {
    @AuraEnabled(cacheable=true)
    public static Map<String,String> getAccounts(){
        List<Account> lis = [SELECT Name,Id from Account limit 20];
        Map<String,String> mp = new Map<String,String>();
        for(Account acc : lis){
            mp.put(acc.Name,acc.Id);
        }
        return mp;
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String X){
        return [SELECT AccountId,LastName FROM Contact WHERE AccountId = :X];
    }
}