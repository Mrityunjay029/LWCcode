import { LightningElement,track } from 'lwc';
export default class Oct30reversestring extends LightningElement {
    @track val1;
    @track var1 = 'Show';
    @track output;
    handleChange(event){
        this.output = event.target.value;
    }
    handleClick(event){
        if(this.var1 === 'Show'){
        this.var1 = 'Hide';
        this.output=this.output.split('').reverse().join('');
        }
        else{
        this.var1 = 'Show';
        this.output=this.output.split('').reverse().join('');}
    }
}