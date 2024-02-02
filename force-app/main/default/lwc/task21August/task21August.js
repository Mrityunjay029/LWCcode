import { LightningElement,track } from 'lwc';
import NewAccount from '@salesforce/schema/Account';
import AccountName from '@salesforce/schema/Account.Name';
import Phone from '@salesforce/schema/Account.Phone';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Task21August extends LightningElement {
    @track acc = NewAccount;
    @track handleFields = [AccountName,Phone];
    showMessage(event){
        this.dispatchEvent(
            new ShowToastEvent({
                title : 'SUCCESS !',
                message : 'New Account Created'
            })
        )
    }
}