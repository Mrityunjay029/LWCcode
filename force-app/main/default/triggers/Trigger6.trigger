trigger Trigger6 on Lead (before insert,before update) {
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
        List<Lead> upd = new List<Lead>();
        Set<String> north = new Set<String>{'Uttar Pradesh', 'Ladakh', 'Jammu & Kashmir', 'Jammu and Kashmir', 'Himachal Pradesh', 'Punjab', 'Chandigarh', 'Uttarakhand', 'Haryana', 'Delhi','Leh'};
        Set<String> south = new Set<String>{'Andaman & Nicobar', 'Andhra Pradesh', 'Karnataka', 'Lakshadweep', 'Kerala', 'Tamil Nadu', 'Puducherry'};
        Set<String> east = new Set<String>{'Chhattisgarh', 'Bihar', 'Sikkim', 'Arunachal Pradesh', 'Nagaland', 'Manipur', 'Mizoram', 'Tripura', 'Meghalaya', 'Assam', 'West Bengal', 'Jharkhand', 'Odisha'};
        Set<String> west = new Set<String>{'Goa', 'Rajasthan', 'Madhya Pradesh', 'Gujarat', 'Daman & Diu', 'Daman and Diu', 'Dadra & Nagar Haveli', 'Dadra and Nagar Haveli', 'Dadra and Nagar Hav.', 'Maharashtra'};
        
        for(Lead l : trigger.new){
            if(l.Country!='India' && l.Country!=NULL){
                l.GOAL__c = 'Export';
            }
            else{
                if(north.contains(l.State))
                    l.GOAL__c = 'North';
                else if(south.contains(l.State))
                    l.GOAL__c = 'South';
                else if(west.contains(l.State))
                    l.GOAL__c = 'West';
                else if(east.contains(l.State))
                    l.GOAL__c = 'East';
            }
        }
    }
}