import { LightningElement } from 'lwc';

export default class ParentComp extends LightningElement {
    sum = 0;
    handleClick(event){
        this.sum = this.template.querySelector('c-child-comp').getsum();
    }
}