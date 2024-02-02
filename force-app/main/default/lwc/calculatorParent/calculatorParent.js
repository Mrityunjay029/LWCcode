import { LightningElement,api} from 'lwc';

export default class CalculatorParent extends LightningElement {
    @api val1;
    @api val2;
    handleChange(event){
        switch(event.target.name) {
            case "Num1": this.val1 = event.target.value;
            console.log(this.val1);
            break;
            case "Num2": this.val2 = event.target.value;
            console.log(this.val2);
            break;
        }
    }
}