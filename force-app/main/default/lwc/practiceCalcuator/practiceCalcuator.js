import { LightningElement, track, api } from 'lwc';
export default class PracticeCalcuator extends LightningElement {
    @api output;
    @track val1 = 0;
    @track val2 = 0;

    handlechange(event){
        const labelvalue = event.target.label;
        if(labelvalue === 'VALUE1'){
            this.val1 = event.target.value;
        }
        if(labelvalue === 'VALUE2'){
            this.val2 = event.target.value;
        } 
    }
    handleClick(event){
        const x = event.target.label;
        if(x === 'Add'){
            this.output = parseInt(this.val1) + parseInt(this.val2);
        }
        if(x === 'Subtract'){
            this.output = this.val1 - this.val2;
        }
        if(x === 'Multiply'){
            this.output = this.val1 * this.val2;
        }
    }
}