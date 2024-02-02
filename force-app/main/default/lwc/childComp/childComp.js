import { LightningElement ,api} from 'lwc';

export default class ChildComp extends LightningElement {
    @api val1 = 0;
    @api val2 = 0;
    @api sum = 0;
    @api handleChange(event){
        this.val1 = event.target.value;
    }
    @api handleChange1(event){
        this.val2 = event.target.value;
    }
    @api getsum(){
        this.sum = val1 + val2;
        return this.sum;
    }
}