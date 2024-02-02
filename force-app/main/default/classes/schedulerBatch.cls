global class schedulerBatch implements Schedulable {
   global void execute(SchedulableContext SC) {
       DuplicateAccountBatch x = new DuplicateAccountBatch();
       Database.executeBatch(x);
   }
}