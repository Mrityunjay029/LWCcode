// opportunityModal.js
import {  api,track } from 'lwc';
import lightningModal from 'lightning/modal';
import getOpportunityLineItems from '@salesforce/apex/accountOpportunity.getOPL';
import MyModal from 'c/opportunityLineItemModal';
export default class OpportunityModal extends lightningModal {
    @api content;
    @track opldata;
    @api OPPID;
    async open(){
        console.log('1');
        this.closeModal();
        const mod = await MyModal.open({
            size: 'medium',
            description: 'Todays',
            content: this.opldata,
            myapi: this.OPPID
        });
        console.log('2');
    }

    closeModal() {
        this.close('okay');
    }

    async handleClick(event){
        const openedSectionId = event.target.dataset.id;
        this.OPPID = event.target.dataset.id;
        console.log('Opportunity Id: ',this.OPPID);
        console.log('ID: ',openedSectionId);
        try{
            this.opldata = await getOpportunityLineItems({
                oppId: openedSectionId
            })
            console.log(JSON.stringify(this.opldata));
            await this.open();
        }catch(e){
            console.error('e: ',e.message());
        }
    }
}