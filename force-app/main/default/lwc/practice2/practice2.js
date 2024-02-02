import { LightningElement } from 'lwc';

export default class Practice2 extends LightningElement {
    Myvalue = "";
    Reverse = "";
    handleChange(event){
        this.Myvalue = event.target.value;
    }
    handleClick(event){
        this.Reverse = this.Myvalue.split("").reverse().join("");
    }
}