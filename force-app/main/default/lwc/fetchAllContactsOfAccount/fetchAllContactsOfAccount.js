import { LightningElement, track, wire} from 'lwc';
import getAccounts from '@salesforce/apex/fetchrelatedcontacts.getAccounts';
import getcontacts from '@salesforce/apex/fetchrelatedcontacts.getContacts';

const getcoumns = [
            {label: 'Id', fieldName: 'AccountId',type: 'text'},
            {label: 'Name', fieldName: 'LastName',type: 'text'}
        ];
export default class FetchAllContactsOfAccount extends LightningElement {
    @track options = [];
    @track selectedId;
    @track getcon = [];
    @track temp = false;

    
        
    @wire(getAccounts)
    getdata({data, error}){
        if(data){
            this.options = data.map(account =>({
                label : account.Name,
                value : account.Id
            }));
        }
        else{
            this.error = error;
            console.log(error);
        }
    }
    
    @wire(getcontacts, {AccountId : '$selectedId'})
    fetchcon({data, error}){
        if(data){
            this.getcon = data;
        }else if(error){
         this.error = error;
         console.log(error);
        }
    }

    handlechange(event){
        this.selectedId = event.target.value;
        if(temp===true){
            this.temp = false;
        }else this.temp = true;
    }

    
    
}