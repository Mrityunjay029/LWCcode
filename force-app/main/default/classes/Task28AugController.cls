public class Task28AugController {
	@AuraEnabled
    public static void createAccounts(List<Account> accountList) {
        System.debug(accountList);
        if (accountList != null && !accountList.isEmpty()) {
            insert accountList;
        }
    }
}