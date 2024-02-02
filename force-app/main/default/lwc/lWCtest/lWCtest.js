import { LightningElement, wire } from 'lwc';
import fetchAccounts from '@salesforce/apex/LWCtest.Accounts';

export default class LWCtest extends LightningElement {
    accountList;
    columns = [
        { label: 'AccountId', fieldName: 'Id', type: 'text' },
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Industry', fieldName: 'Industry', type: 'text' }
    ];

    @wire(fetchAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accountList = data;
        } else if (error) {
            console.error(error);
        }
    }
}