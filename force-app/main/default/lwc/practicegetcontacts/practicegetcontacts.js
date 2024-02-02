import { LightningElement,track ,wire  } from 'lwc';
import getaccounts from '@salesforce/apex/practicegetcontacts.getAccounts';
import getcontacts from '@salesforce/apex/practicegetcontacts.getContacts'
const column = [
    {label: 'AccountId', fieldName: 'AccountId'},
    {label: 'Name', fieldName: 'LastName'}
];
export default class Practicegetcontacts extends LightningElement {
    @track options = [];
    @track temp = false;
    @track data = [];
    @track selectedId;

    @wire(getaccounts)
    fetchacc({data,error}){
        if(data){
            this.options = data.map(account => ({
                label: account.Name,
                value: account.Id
            }))
        }
        else if(error)
        this.error = error;
    }
    handleChange(event){
        this.selectedId = event.detail.value;
        if(temp === false){
            this.temp = true;
        }
        else this.temp = false;
        getcontacts({AccountId : this.selectedId})
        .then(result =>{
            this.data = result;
        })
        .catch(error => console.log(error))
    }
      
    }