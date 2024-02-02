public class CustomOpportunityTriggerHandler {
    public static void addprefix(List<Opportunity> n){
        Map<String, Integer> isocode = new Map<String, Integer>{'AUD'=>1, 'NZD'=>1, 'USD'=>1};
        for(Opportunity opp:[Select Id, ISOCode__c, OppNumber__c  from Opportunity where ISOCode__c!=NULL]){
            if(opp.ISOCode__c!=NULL){
                isocode.put(opp.ISOCode__c, isocode.get(opp.ISOCode__c)+1);
            }
        }
        for(Opportunity opp:n){
            if(opp.ISOCode__c!=NULL)
            opp.OppNumber__c=opp.ISOCode__c+String.valueOf(isocode.get(opp.ISOCode__c)+10000);
        } 
    }
}