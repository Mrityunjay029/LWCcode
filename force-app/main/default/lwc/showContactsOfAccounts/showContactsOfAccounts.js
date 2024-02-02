import { LightningElement, wire, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountContactViewerController.getAccounts';
import getContactsForAccount from '@salesforce/apex/AccountContactViewerController.getContactsForAccount';

export default class AccountContactViewer extends LightningElement {
    @track accountOptions = [];
    @track selectedAccount = null;
    @track contactData = [];
    @track contactColumns = [
        { label: 'First Name', fieldName: 'FirstName', type: 'text' },
        { label: 'Last Name', fieldName: 'LastName', type: 'text' },
        { label: 'Email', fieldName: 'Email', type: 'email' }
    ];

    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accountOptions = data.map(account => ({
                label: account.Name,
                value: account.Id
            }));
        } else if (error) {
            // Handle error
        }
    }

    handleAccountChange(event) {
        this.selectedAccount = event.detail.value;
        if (this.selectedAccount) {
            getContactsForAccount({ accountId: this.selectedAccount })
                .then(data => {
                    this.contactData = data;
                })
                .catch(error => {
                    // Handle error
                });
        } else {
            this.contactData = [];
        }
    }
}