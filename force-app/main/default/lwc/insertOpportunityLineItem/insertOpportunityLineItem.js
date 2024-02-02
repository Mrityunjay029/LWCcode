import lightningModal from 'lightning/modal';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { api,track,wire } from 'lwc';
import insertOpl from '@salesforce/apex/accountOpportunity.insertOPL'
import getPriceBookEntries from '@salesforce/apex/accountOpportunity.getPriceBookEntries';
export default class InsertOpportunityLineItem extends lightningModal{
    @api OppId;
    
    @track unitPrice = 0;
    @track quantity = 0;
    @track amount = 0;


    selectedPriceBookEntryId = '';
    selectedPriceBookEntryLabel = '';
    priceBookEntryOptions = [];

    closeModal() {
        this.close('okay');
    }
    loaded = false;

    handleClick() {
        this.loaded = !this.loaded;
    }
    @wire(getPriceBookEntries)
    priceBookEntries({ error, data }) {
        if (data) {
            this.priceBookEntryOptions = data.map(entry => ({
                label: entry.Name, 
                value: entry.Id
            }));
        } else if (error) {
            console.error('Error fetching Price Book Entries', error);
        }
    }

    handleComboChange(event) {
        this.selectedPriceBookEntryId = event.detail.value;
        const selectedOption = this.priceBookEntryOptions.find(option => option.value === this.selectedPriceBookEntryId);
        if (selectedOption) {
            this.selectedPriceBookEntryLabel = selectedOption.label;
        }
    }

    handleQuantityChange(event) {
        this.quantity = event.target.value;
    }

    handleUnitPriceChange(event) {
        this.unitPrice = event.target.value;
    }

    handleAmountChange(event){
        this.amount = event.target.value;
    }
    async createOpl(event){
        try{
            console.log('Inserting OLI');
            await insertOpl({
                myId: this.OppId,
                ProductName: this.selectedPriceBookEntryLabel,
                pbeId: this.selectedPriceBookEntryId,
                Quantity: this.quantity,
                UnitPrice: this.unitPrice,
                Amount : this.amount
            })
            const toastEvent = new ShowToastEvent({
            title: 'Success!',
            message: 'Opportunity Line Item Inserted successfully.',
            variant: 'success',
        });
        this.dispatchEvent(toastEvent);
        this.closeModal();
        }
        catch(e){
            console.log('error',e);
        }
    }
}