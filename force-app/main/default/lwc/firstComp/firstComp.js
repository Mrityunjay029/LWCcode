import { LightningElement, api } from 'lwc';
import { ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class FirstComp extends LightningElement {
    word = "Hello World";
    
    Click(event){
        this.word = this.reverseStr(this.word);
    }
    reverseStr(statement){
    return statement.split('').reverse().join('');
}
}