import { LightningElement } from 'lwc';

export default class Practice1 extends LightningElement {
    text = "abcdefghijk";
    handleClick(event){
        this.text = this.text.split("").reverse().join("");
    }
}