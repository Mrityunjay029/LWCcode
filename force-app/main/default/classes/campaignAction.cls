public with sharing class campaignAction {
    @AuraEnabled
    public static String importdata(string recId) {
        system.debug('Id: '+recId);
        List<Campaign> lis = [SELECT Name,Id FROM Campaign WHERE Id =:recId];
        return lis[0].Name;
    }
    @AuraEnabled
    public static Integer contacts(string recId){
        List<CampaignMember> lis = [SELECT Name,ContactId,CampaignId FROM CampaignMember WHERE CampaignId =: recId];
        Set<Id> s = new Set<Id>();
        for(CampaignMember c : lis){
            s.add(c.ContactId);
        }
        List<Contact> con = [SELECT Name,Id FROM Contact WHERE Id IN: s];
        return con.size();
    }
    @AuraEnabled
    public static Integer lead(string recId){
        List<CampaignMember> lis = [SELECT Name,LeadId,CampaignId FROM CampaignMember WHERE CampaignId =: recId];
        Set<Id> s = new Set<Id>();
        for(CampaignMember c : lis){
            s.add(c.LeadId);
        }
        List<Lead> leads = [SELECT Name,Id FROM Lead WHERE Id IN: s];
        return leads.size();
    }
    @AuraEnabled
    public static List<Contact> dataofcontacts( string recId){
        List<CampaignMember> lis = [SELECT Name,ContactId,CampaignId FROM CampaignMember WHERE CampaignId =: recId];
        Set<Id> s = new Set<Id>();
        for(CampaignMember c : lis){
            s.add(c.ContactId);
        }
        List<Contact> con = [SELECT Name,Email,MobilePhone,Id FROM Contact WHERE Id IN: s];
        system.debug('This is contact list'+ con);
        return con;
    }
    @AuraEnabled
    public static List<lead> dataofleads(string recId){
        List<CampaignMember> lis = [SELECT Name,LeadId,CampaignId FROM CampaignMember WHERE CampaignId =: recId];
        Set<Id> s = new Set<Id>();
        for(CampaignMember c : lis){
            s.add(c.LeadId);
        }
        List<Lead> leads = [SELECT Name,Company,Status,Id FROM Lead WHERE Id IN: s];
        system.debug('This is lead list'+ leads);
        return leads;
    }
    }