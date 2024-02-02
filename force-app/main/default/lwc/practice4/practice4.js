import { LightningElement,track,wire} from 'lwc';
import getOpp from '@salesforce/apex/practice4.getOpp';
export default class Practice4 extends LightningElement {
    @track columns = [{label : 'Id', fieldName : 'Id'},{label : 'Name' , fieldName : 'Name'},{label : 'CloseDate' , fieldName : 'CloseDate'},{label : 'StageName' , fieldName : 'StageName'}];
    @track data = [];

    @wire(getOpp)
    Mydata({error,data}){
        if(error)
        console.log(error);
        else if(data){
        this.data=data;
        console.log(data);
        }
    } 
}