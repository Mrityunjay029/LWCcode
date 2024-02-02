global class CalculateAverageDealAmountBatch implements Database.Batchable<sObject>, Database.Stateful {

    // Query to retrieve deals closed in the previous month
    private static final String DEAL_QUERY = 'SELECT Id, OwnerId, Deal_Amount__c, Close_Date__c FROM Deal__c WHERE Close_Date__c = LAST_N_MONTHS:1';

    // Map to store total deal amounts and count for each user
    private Map<Id, AggregateData> userDataMap = new Map<Id, AggregateData>();

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(DEAL_QUERY);
    }

    global void execute(Database.BatchableContext bc, List<Deal__c> scope) {
        // Aggregate data for each user
        for (Deal__c deal : scope) {
            Id ownerId = deal.OwnerId;
            if (!userDataMap.containsKey(ownerId)) {
                userDataMap.put(ownerId, new AggregateData());
            }
            userDataMap.get(ownerId).totalAmount += deal.Deal_Amount__c;
            userDataMap.get(ownerId).dealCount++;
        }
    }

    global void finish(Database.BatchableContext bc) {
        // Update the Average_Deal_Amount__c field on User records
        List<User> usersToUpdate = new List<User>();

        for (Id userId : userDataMap.keySet()) {
            AggregateData userData = userDataMap.get(userId);

            if (userData.dealCount > 0) {
                // Calculate average and round to two decimal places
                Decimal averageDealAmount = userData.totalAmount / userData.dealCount;
                averageDealAmount = averageDealAmount.setScale(2);

                // Create a User record with the calculated average
                User userToUpdate = new User(Id = userId, averageDealAmount__c = averageDealAmount);
                usersToUpdate.add(userToUpdate);
            }
        }

        // Update User records
        if (!usersToUpdate.isEmpty()) {
            Database.update(usersToUpdate);
        }
    }

    // Helper class to store aggregate data for each user
    private class AggregateData {
        Decimal totalAmount = 0;
        Integer dealCount = 0;
    }
}