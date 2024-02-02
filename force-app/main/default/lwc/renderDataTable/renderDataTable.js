import { LightningElement, track, wire} from 'lwc';
import getAccounts from '@salesforce/apex/RenderData.getAccounts';
export default class RenderDataTable extends LightningElement {
@track ShowTemplate = "false";
handleLabel = 'SHOW';
@track columns=[{label:'Name',fieldName:'Name'},
                {label:'Industry',fieldName:'Industry'},
                {label:'Phone',fieldName:'Phone'}];
@track data=[];
@wire(getAccounts)
wiredData({error,data}){
    if(error) {
        console.log('error');
    }
    else {
        console.log(data);
        this.data = data;
    }
}
handleClick(event){
    if(event.target.label==='SHOW'){
        this.handleLabel = 'HIDE';
        this.ShowTemplate = true;
    }
    else if(event.target.label==='HIDE'){
        this.handleLabel = 'SHOW';
        this.ShowTemplate = false;
    }
}
}