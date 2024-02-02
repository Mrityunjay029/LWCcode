import { LightningElement ,track,wire} from 'lwc';
import getAccount from '@salesforce/apex/practice6.getAccount';
export default class Practice6 extends LightningElement {
    @track value='';
    @track getoptions = [];
    handleChange(event){
        getAccount()
        .then(data=>{
            this.getoptions = data.map((con) => ({
                label: con.Name,
                value: con.Id
            }))
            this.value = target.event.value;
        })
    }
}