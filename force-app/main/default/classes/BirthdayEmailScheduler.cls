public class BirthdayEmailScheduler implements Schedulable {
    public void execute(SchedulableContext sc) {
        // Instantiate your batch class
        BirthdayEmailBatch batchInstance = new BirthdayEmailBatch();

        // Start the batch job
        Database.executeBatch(batchInstance);
    }
}