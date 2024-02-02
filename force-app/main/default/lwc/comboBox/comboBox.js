import { LightningElement ,track, wire } from 'lwc';
import getContacts from '@salesforce/apex/comboBox.getContacts';
export default class ComboBox extends LightningElement {
    @track value='';
    @track getoptions=[]
    @wire(getContacts)
    wiredinfo({error,data}){
        if(error)
        console.log('error');
        else if(data){
       // this.data = data;
        this.getoptions = data.map((con) =>
            ({label: con.Name,
             value: con.Id}
             ));
     }
    }
    handleChange(event){
       this.value = event.target.value;
    }
}