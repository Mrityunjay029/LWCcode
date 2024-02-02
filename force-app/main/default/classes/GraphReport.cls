public with sharing class GraphReport {
    public class wrapper{
         @AuraEnabled
         public String obj{get;set;}
         @AuraEnabled
         public Integer count{get;set;}
    }
    @AuraEnabled
     public static List<wrapper> countRecords(Date start, Date endDate) {
         Map<String, Integer> r = new Map<String, Integer>();
         List<wrapper> m=new List<wrapper>();
         List<Account> a_rec= [Select id from Account where CreatedDate >= :start and CreatedDate <= :endDate];
         r.put('Account', a_rec.size());
         
         List<Contact> c_rec= [Select id from Contact where CreatedDate >= :start and CreatedDate <= :endDate];
          r.put('Contact', c_rec.size());
         
         List<Lead> l_rec= [Select id from Lead where CreatedDate >= :start and CreatedDate <= :endDate];
          r.put('lead', l_rec.size());
         
         List<Opportunity> o_rec= [Select id from opportunity where CreatedDate >= :start and CreatedDate <= :endDate];
          r.put('Opportunity', o_rec.size());
         
         List<Campaign> cam_rec= [Select id from Campaign where CreatedDate >= :start and CreatedDate <= :endDate];
          r.put('Campaign', cam_rec.size());
         
         for(String s:r.KeySet()){
             wrapper w = new wrapper();
             w.obj=s;
             w.count=r.get(s);
             m.add(w);
             
         }
         system.debug(r);
         return m;
     }
}