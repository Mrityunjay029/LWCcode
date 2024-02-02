import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/task11August.getAccounts';
import getContactsForAccount from '@salesforce/apex/task11August.getContactsForAccount';

export default class AccountContactViewer extends LightningElement {
    @track accountOptions = [];
    @track selectedAccountId;
    @track contacts = [];
    contactColumns = [
        { label: 'First Name', fieldName: 'FirstName' },
        { label: 'Last Name', fieldName: 'LastName' },
        { label: 'Email', fieldName: 'Email' }
    ];

    async connectedCallback() {
        this.accountOptions = await this.loadAccountOptions();
    }

    async loadAccountOptions() {
        const accounts = await getAccounts();
        return accounts.map(account => ({
            label: account.Name,
            value: account.Id
        }));
    }

    async handleAccountChange(event) {
        this.selectedAccountId = event.detail.value;
        this.contacts = await this.loadContactsForAccount(this.selectedAccountId);
    }

    async loadContactsForAccount(accountId) {
        const contacts = await getContactsForAccount({ accountId });
        return contacts;
    }
}