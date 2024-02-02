import { LightningElement, track } from 'lwc';
import getCurrencyList from '@salesforce/apex/task18October.getCurrencyList';
import getConversion from '@salesforce/apex/task18October.getConversion';

export default class Task18October extends LightningElement {

    input;
    value_from;
    value_to;
    @track options;
    output;


    connectedCallback() {
        getCurrencyList()
        .then(result => {
            this.options = result;
        })
        .catch(error => {
            console.log(error);
            alert('Check console for errors');
        });
    }

    handleChange_from(event) {
        this.value_from = event.detail.value;
        this.getAnswer();
    }

    handleChange_to(event) {
        this.value_to = event.detail.value;
        this.getAnswer();
    }

    handleInput(event) {
        this.input = event.detail.value;
        this.getAnswer();
    }

    getAnswer() {
        if(this.input && this.value_from && this.value_to) {
            if(this.input == 0) {
                this.output = 0;
            } else if(this.value_to === this.value_from) {
                this.output = this.input;
            } else {
                getConversion({amount: this.input, currency_from: this.value_from, currency_to: this.value_to})
                .then(result => {
                    this.output = result[this.value_to];
                })
                .catch(error => {
                    console.log(error);
                    alert('Check console for errors');
                });
            }
        }
    }
}