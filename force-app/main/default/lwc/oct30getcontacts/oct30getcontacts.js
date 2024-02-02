import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/Oct30getcontacts.getAccounts';
import getContacts from '@salesforce/apex/Oct30getcontacts.getContacts';
const column = [
    {label: 'AccountID', fieldName: 'AccountId'},
    {label: 'Name', fieldName: 'LastName'}
]
export default class Oct30getcontacts extends LightningElement {
    @track value;
    @track options = [];
    @track data = [];
    @track columns = column;

    connectedCallback() {
        this.getallAccounts();
    }

    async getallAccounts(){
        try{
            const accdata = await getAccounts();
            console.log(accdata);
            this.options = accdata.map(result=>({
                label: result.Name,
                value: result.Id
            }))
        }
        catch(error){
            console.log(error);
        }
    }
    handleChange(event){
        this.value = event.detail.value;
        console.log("Value: ", this.value);
        this.loadcontacts();
    }

    async loadcontacts(){
        try{
            this.data = await getContacts({x : this.value})
            console.log('Data: ',this.data)
        }
        catch(error){
            console.log(error);
        }
    }

}