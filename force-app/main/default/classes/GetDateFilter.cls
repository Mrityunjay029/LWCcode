public class GetDateFilter {
	@InvocableMethod
    public static List<List<Date>> getDateList() {
        Date min = System.now().date();
        try {
            Account acc = [SELECT CreatedDate FROM Account ORDER BY CreatedDate LIMIT 1];
            min = acc.CreatedDate.date();
        } catch(Exception e) {}
        List<List<Date>> returnList = new List<List<Date>>();
        List<Date> intermediateList = new List<Date>();
        Date dateIterator;
        List<Integer> daysToSubtract = new List<Integer>{-7, -15, -30, -60, -120, -365};
        Integer i = 0;
        do {
            dateIterator = System.now().date().addDays(daysToSubtract[i++]);
            intermediateList.add(dateIterator);
        } while(dateIterator >= min && i < daysToSubtract.size());
        dateIterator = System.now().date().addDays(-365);
        while(dateIterator > min) {
            dateIterator = dateIterator.addMonths(-4);
            intermediateList.add(dateIterator);
        }
        returnList.add(intermediateList);
        return returnList;
    }
}