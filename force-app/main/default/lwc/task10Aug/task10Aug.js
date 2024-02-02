// createAccountLWC.js
import { LightningElement, track} from 'lwc';
import createAcc from '@salesforce/apex/task10Aug.createAcc';

export default class CreateAccountLWC extends LightningElement {
    @track accountName;
    @track industry;
    
    handleChange(event){
        this.accountName = this.event.value;
    }
    industryOptions = [
        { label: 'Finance', value: 'Finance' },
        { label: 'Healthcare', value: 'Healthcare' },
        // Add more industry options as needed
    ];
    createind(event){
        this.industry = this.event.value;
    }
    handleCreate(event) {
        createAcc({ Name: this.accountName, Industry: this.industry })
        .then(result => {
            alert('Account created');
        })
        .catch(error => {
            console.log(error);
            alert('Account not created');
        })
    }

}