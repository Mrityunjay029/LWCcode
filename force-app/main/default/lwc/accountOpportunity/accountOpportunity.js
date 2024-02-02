import { LightningElement,wire,track } from 'lwc';
import getAccounts from '@salesforce/apex/accountOpportunity.getAccounts';
import { subscribe, MessageContext } from 'lightning/messageService';
import getOpportunities from '@salesforce/apex/accountOpportunity.getOpportunities';
import MyModal from 'c/opportunityModal';
import MyMessageChannel from '@salesforce/messageChannel/MyMessageChannel__c';
import { RefreshEvent } from 'lightning/refresh';

export default class AccountOpportunity extends LightningElement {
    @track accounts;
    @track amount = 0;
    @track opportunities;
    activeSections = ['A','B'];
    subscription = null;
    
    @wire(MessageContext)
    messageContext;

    renderedCallback() {
        this.amount = 1;
        console.log('Amount = ',this.amount);
        console.log('rendered callback used');
        this.subscription = subscribe(
            this.messageContext,
            MyMessageChannel,
            (message) => {
                this.handleMessage(message)
            }
        );
        console.log('Calling fetch data from renderedCB');
        
    }

    // Function to handle the incoming message
    handleMessage(message) {
        // Call the fetchUpdate function when the modal is closed
        console.log('FETCH UPDATE CALLED');
        this.fetchDataAndUpdate();
    }

    async connectedCallback() {
        console.log('Connected callback called');
        await this.fetchDataAndUpdate();
    }

    disconnectedCallback() {
        amount = 2;
        console.log('Amount = ',this.amount);

        // Unsubscribe when the component is disconnected or destroyed
        unsubscribe(this.subscription);
    }
    
    async fetchDataAndUpdate() {
        try {
            console.log('Called fetch update on modal closing');
            this.accounts = await getAccounts();
        } catch (error) {
            console.error('Error fetching data:', error);
        }
    }
    async open(){
        console.log('1');
        const mod = await MyModal.open({
            size: 'large',
            description: 'Todays',
            content: this.opportunities,
            label: 'Opp'
        });
        mod.close();
    }

    async handleClick(event){
        const openedSectionId = event.target.dataset.id;
        console.log('ID: ',openedSectionId);
        try{
            this.opportunities = await getOpportunities({
                accId: openedSectionId
            })
            console.log(JSON.stringify(this.opportunities));
            await this.open();
        }catch(e){
            console.error('e: ',e.message());
        }
    }
}