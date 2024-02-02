import { LightningElement, api, track } from 'lwc';
import getAccountById from '@salesforce/apex/AccountController.getAccountById';
import getOpportunitiesByAccountId from '@salesforce/apex/OpportunityController.getOpportunitiesByAccountId';
import getOpportunityLineItemsByOpportunityId from '@salesforce/apex/OpportunityLineItemController.getOpportunityLineItemsByOpportunityId';

export default class AccountDetailsAccordion extends LightningElement {
    @api recordId;
    @track account;
    @track opportunities;
    @track oppLineItems;
    @track accountDetailsKey = 'accountDetails';
    @track opportunitiesKey = 'opportunities';
    @track oppLineItemsKey = 'oppLineItems';
    connectedCallback() {
        this.loadAccount();
    }

    loadAccount() {
    getAccountById({ accountId: this.recordId })
        .then(result => {
            this.account = result || {}; // Initialize with an empty object if result is falsy
            this.loadOpportunities();
        })
        .catch(error => {
            console.error('Error fetching account details:', error);
        });
}

    loadOpportunities() {
        getOpportunitiesByAccountId({ accountId: this.recordId })
            .then(result => {
                this.opportunities = result;
            })
            .catch(error => {
                console.error('Error fetching opportunities:', error);
            });
    }

    handleOpportunityClick(event) {
        const opportunityId = event.currentTarget.dataset.id;
        getOpportunityLineItemsByOpportunityId({ opportunityId })
            .then(result => {
                this.oppLineItems = result;
            })
            .catch(error => {
                console.error('Error fetching opportunity line items:', error);
            });
    }

    handleSectionToggle(event) {
        // Handle section toggle logic if needed
    }
}