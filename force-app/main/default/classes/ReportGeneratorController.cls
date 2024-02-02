public class ReportGeneratorController {
    @AuraEnabled
    public static List<Integer> generateReportData(Date startDate, Date endDate) {
        Integer noOfAcc = ([SELECT Id FROM Account WHERE CreatedDate >= :startDate AND CreatedDate <= :endDate]).size();
        Integer noOfCon = ([SELECT Id FROM Contact WHERE CreatedDate >= :startDate AND CreatedDate <= :endDate]).size();
        Integer noOfOpp = ([SELECT Id FROM Opportunity WHERE CreatedDate >= :startDate AND CreatedDate <= :endDate]).size();
        Integer noOfLead = ([SELECT Id FROM Lead WHERE CreatedDate >= :startDate AND CreatedDate <= :endDate]).size();
        Integer noOfCampaign = ([SELECT Id FROM Campaign WHERE CreatedDate >= :startDate AND CreatedDate <= :endDate]).size();
        List<Integer> returnVal = new List<Integer>{noOfAcc, noOfCon, noOfOpp, noOfLead, noOfCampaign};
        return returnVal;
    }
}