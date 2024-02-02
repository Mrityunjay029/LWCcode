public class ContactController {
    private final Contact myContact;

    public ContactController(ApexPages.StandardController stdController) {
        this.myContact = (Contact)stdController.getRecord();
    }

    public Contact getContact() {
        return myContact;
    }
}