import { LightningElement,track } from 'lwc';

export default class Practice3 extends LightningElement {
    @track Label = 'SHOW';
    @track showTemplate = false;
    handleClick(event){
        const name = event.target.label;
        if(name==='SHOW'){
            this.Label = 'HIDE';
            this.showTemplate = true;
        }
        else if(name==='HIDE'){
            this.Label = 'SHOW';
            this.showTemplate = false;
        }
    }
}