public with sharing class task10Aug {
    @AuraEnabled(cacheable=true)
    public static void createAcc(String Name,String Industry) {
        Account acc = new Account();
        acc.Name = Name;
        acc.Industry = Industry;
        System.debug(acc);
        INSERT acc;
    }
}