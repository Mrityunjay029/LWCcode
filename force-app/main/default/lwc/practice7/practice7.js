import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class Practice7 extends LightningElement {
    toasttitle = ''
    toastmessage = ''
    toastvariant = ''
    handleClick(event){
        switch(event.target.label){
            case 'SUCCESS':
                this.toasttitle = 'Congrats';
                this.toastmessage = 'Successful';
                this.toastvariant = 'Mission Passed';
                break;
            case 'FAILURE':
                this.toasttitle = 'Fail';
                this.toastmessage = 'Failed';
                this.toastvariant = 'Mission Failed';
                break;
                case 'WARNING':
                    this.toasttitle = 'warned';
                    this.toastmessage = 'warning';
                    this.toastvariant = 'Mission about to fail';
                    break;
        }
        const event1 = new ShowToastEvent({
            title: this.toasttitle,
            message: this.toastmessage,
            variant: this.toastvariant
        });
        this.dispatchEvent(event1);
    }
}