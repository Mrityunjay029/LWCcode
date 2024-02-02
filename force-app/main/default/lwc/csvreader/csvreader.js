import { LightningElement, api } from 'lwc';
import lightningModal from 'lightning/modal';
export default class Csvreader extends lightningModal{
    @api content;
    closeModal() {
        this.close('okay');
    }
}