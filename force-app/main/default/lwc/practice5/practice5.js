import { LightningElement,track,wire} from 'lwc';
import getAccount from '@salesforce/apex/practice5.getAccount';
export default class Practice5 extends LightningElement {
    @track columns = [{label : 'Id', fieldName : 'Id'},{label : 'Name',fieldName : 'Name'}];
    @track data = [];
    MyVal = '';
    handleChange(event){
        this.MyVal = event.target.value;
    }
    handleClick(event){
        getAccount({accName:this.MyVal})
        .then(data=>{this.data=data;})
        .catch(error=>{this.error=error;})
    }
}