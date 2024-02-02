public class NumberofMalesFemales_Handler {
	public Map<Id, Integer> maleChange = new Map<Id, Integer>();
    public Map<Id, Integer> femaleChange = new Map<Id, Integer>();
    
    public void singleIncrementDecrement(Contact con, Integer additive) {
        if(con.Gender__c == 'Male') {
            if(maleChange.containsKey(con.AccountId)) {
                maleChange.put(con.AccountId, maleChange.get(con.AccountId) +additive);
            } else {
                maleChange.put(con.AccountId, additive);
            }
        } else if(con.Gender__c == 'Female') {
            if(femaleChange.containsKey(con.AccountId)) {
                femaleChange.put(con.AccountId, femaleChange.get(con.AccountId) +additive);
            } else {
                femaleChange.put(con.AccountId, additive);
            }
        }
    }
    
    public void listIncrementDecrement(List<Contact> conList, Integer additive) {
        for(Integer i = 0; i < conList.size(); i++) {
            singleIncrementDecrement(conList[i], additive);
        }
    }
}