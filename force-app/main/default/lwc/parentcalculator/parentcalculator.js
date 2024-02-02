import { LightningElement,track,api} from 'lwc';
export default class Parentcalculator extends LightningElement {
    @track result;
    @track x;
    handleChange(event){
        this.x = event.target.value.split('').reverse.join('');
    }
    handleClick(event){
        this.result = result;
    }
}