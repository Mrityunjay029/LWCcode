import { LightningElement, api, track} from 'lwc';

export default class CalculatorChild extends LightningElement {
    @api getvalue1;
    @api getvalue2;
    @track output;
    handleClick(event){
        switch(event.target.name){
            case "Add" : this.output = parseFloat(this.getvalue1) + parseFloat(this.getvalue2);
            break;
            case "Subtract" : this.output = parseFloat(this.getvalue1) - parseFloat(this.getvalue2);
            break;
            case "Multiply" : this.output = parseFloat(this.getvalue1) * parseFloat(this.getvalue2);
            break;
            case "Divide" : this.output = parseFloat(this.getvalue1) / parseFloat(this.getvalue2);
            break;
        }
    }
}