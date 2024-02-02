public class TASK3MAY {
    @AuraEnabled
    public static id createOpp(string name , string stage, integer amount , string types , date Cdate){
        Opportunity opp = new Opportunity(
            Name = name,
            StageName = stage,
            Amount = amount,
            Type = types,
            CloseDate = Cdate
        );
        insert opp;
        return opp.Id;
    }
}