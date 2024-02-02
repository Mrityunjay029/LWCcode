public class Task7july {
    public static void main(){
        String CampId = '7012w000000MSL9AAO';
        set<id> leadIds = new set<id>();
        set<id> contactIds = new set<id>();
        list<CampaignMember> cam = [select id,FirstName, LeadId , ContactId , CampaignId FROM CampaignMember WHERE CampaignId = :CampId];
        for(CampaignMember c : cam){
            if(c.LeadId!=NULL){
                leadIds.add(c.LeadId);
            }else if(c.ContactId!=NULL){
                contactIds.add(c.ContactId);
            }
        }
        list<lead> leads = [select id,Name FROM Lead WHERE id IN :leadIds];
        list<contact>contacts = [select id, LastName FROM Contact WHERE id IN :contactIds];
        system.debug('Leads--->' + leads);
        system.debug('Contacts--->' +contacts);
    }
}