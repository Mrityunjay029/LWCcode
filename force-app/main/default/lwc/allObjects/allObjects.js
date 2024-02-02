import { LightningElement, track, wire} from 'lwc';
import getall from '@salesforce/apex/getObjects.getall';
export default class AllObjects extends LightningElement {
    @track value = '';
    @track p = '';
    @track options = []
    @wire(getall)
    wiredData({error,data}){
        if(error)
        console.log(error);
        else{
            
        }
    }
    
}