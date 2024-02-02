public with sharing class RecordCountController {
    @AuraEnabled(cacheable=true)
    public static Map<String, Integer> getRecordCounts(String objectName, Date startDate, Date endDate) {
        Map<String, Integer> recordCounts = new Map<String, Integer>();
        String query = 'SELECT COUNT() FROM ' + objectName + ' WHERE CreatedDate >= :startDate AND CreatedDate <= :endDate';
        List<AggregateResult> results = Database.query(query);
        for (AggregateResult result : results) {
            recordCounts.put(objectName, Integer.valueOf(result.get('expr0')));
        }
        return recordCounts;
    }
}