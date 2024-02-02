import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountOpportunityController.getAccounts';
import getOpportunities from '@salesforce/apex/AccountOpportunityController.getOpportunities';
import getOpportunityLineItems from '@salesforce/apex/AccountOpportunityController.getOpportunityLineItems';

export default class AccountOpportunityExplorer extends LightningElement {
    accounts;
    selectedAccount;
    selectedOpportunity;

    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
        } else if (error) {
            console.error(error);
        }
    }

    handleAccountClick(event) {
        const accountId = event.target.key;
        this.selectedAccount = this.accounts.find(acc => acc.Id === accountId);
        this.selectedOpportunity = null;
    }

    handleOpportunityClick(event) {
        const opportunityId = event.target.key;
        getOpportunities({ accountId: this.selectedAccount.Id })
            .then(result => {
                this.selectedOpportunity = result.find(opp => opp.Id === opportunityId);
            })
            .catch(error => {
                console.error(error);
            });
    }
}