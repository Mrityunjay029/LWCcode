public with sharing class comboBox {
    @AuraEnabled
    (cacheable=true)
    public static List<Contact> getContacts(){
        return [SELECT Name,Id FROM Contact limit 46];
    }
    
}