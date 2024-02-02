public class AccountsWithRelatedContactsController {
    public String selectedAccountId { get; set; }
    public List<SelectOption> accountOptions { get; set; }
    public List<Contact> relatedContacts { get; set; }

    public AccountsWithRelatedContactsController() {
        accountOptions = new List<SelectOption>();
        relatedContacts = new List<Contact>();
        populateAccountOptions();
    }

    private void populateAccountOptions() {
        List<Account> accounts = [SELECT Id, Name FROM Account];
        for (Account acc : accounts) {
            accountOptions.add(new SelectOption(acc.Id, acc.Name));
        }
    }

    public void fetchRelatedContacts() {
        if (selectedAccountId != null) {
            relatedContacts = [SELECT Id, Name, Email, Phone FROM Contact WHERE AccountId = :selectedAccountId LIMIT 5];
        } else {
            relatedContacts.clear();
        }
    }
}