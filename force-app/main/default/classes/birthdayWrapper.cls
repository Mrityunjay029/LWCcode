public class birthdayWrapper {
    @AuraEnabled
    public List<Contact> contactList { get; set; }

    @AuraEnabled
    public Integer rowCount { get; set; }
    @AuraEnabled
    public Integer AllRowCount { get; set; }

    public BirthdayWrapper(List<Contact> contactList, Integer rowCount, Integer AllRowCount) {
        this.contactList = contactList;
        this.rowCount = rowCount;
        this.AllRowCount = AllRowCount;
    }
}