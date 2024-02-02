import { LightningElement,track } from 'lwc';

export default class ConditionalRender extends LightningElement {
    @track showTemplate = "false";
    @track handleLabel = 'SHOW';

    handleClick(event){
        const name = event.target.label;
        if(name==='SHOW'){
            this.handleLabel = 'HIDE';
            this.showTemplate = true;
        }
        else if(name==='HIDE'){
            this.handleLabel = 'SHOW';
            this.showTemplate = false;
        }
    }
}