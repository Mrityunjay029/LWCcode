import lightningModal from 'lightning/modal';
import MyModal from 'c/insertOpportunityLineItem';
import { publish, MessageContext } from 'lightning/messageService';
import MyMessageChannel from '@salesforce/messageChannel/MyMessageChannel__c';
import { api,track,wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import deleteOPL from '@salesforce/apex/accountOpportunity.deleteOPL';
import fetchDataAndUpdate from 'c/accountOpportunity';
export default class OpportunityLineItemModal extends lightningModal {
    mes='abc';
    @wire(MessageContext)
    messageContext;
    @api content;
    @api myapi;
    closeModal() {
        this.close('okay');
    }
    async open(){
        console.log('1');
        const mod = await MyModal.open({
            size: 'medium',
            description: 'Todays',
            content: 'Insert item',
            OppId: this.myapi
        });
        
        console.log('2');
    }
    async handleSuccess(event) {
        await fetchDataAndUpdate();
        console.log('Record updated successfully:', event.detail.id);
    }

    async handleSubmit(event) {
        // Handle form submission, e.g., perform additional logic
        await fetchDataAndUpdate();
        console.log('Form submitted:', event);
    }

    handleError(event) {
        // Handle errors, e.g., show an error message
        console.error('Error updating record:', event.detail.message);
    }

    publishHandler(){
        const message = {
            lmsdata: {
                data: this.mes
            }
        }
        publish(this.messageContext, MyMessageChannel, message);
    }
    async handleClick(event){
        const sectionId = event.target.dataset.id;
        const name = event.target.label;
        console.log(name);
        if(name === 'Delete'){
        await deleteOPL({
            myId: sectionId
            });
        const toastEvent = new ShowToastEvent({
            title: 'Success!',
            message: 'Record Deleted successfully.',
            variant: 'success',
        });
        await publish(this.messageContext, MyMessageChannel, {});
        this.dispatchEvent(toastEvent);
        }
        if(name === 'Update Amount'){
          const toastEvent = new ShowToastEvent({
            title: 'Success!',
            message: 'Record Updated successfully.',
            variant: 'success',
        });
        await fetchDataAndUpdate();
        this.dispatchEvent(toastEvent); 
        }
        if(name === 'Insert'){
            console.log(this.myapi);
            this.open();
            
        }
        this.closeModal();
        this.publishHandler(); 
    }
}