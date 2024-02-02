import { LightningElement, api } from 'lwc';
import chartjs from '@salesforce/resourceUrl/ChartJS';
import { loadScript } from 'lightning/platformResourceLoader';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'; 


export default class Graph extends LightningElement {
    @api chartConfig; 
    isChartJsInitialized=false;
    renderedCallback() {


        // load chartjs from the static resource
        Promise.all([loadScript(this, chartjs)])
        .then(() => {
            this.isChartJsInitialized = true;
             if(this.chart){
                this.chart.destroy();//destory the chart once data is updated to show the new chart
                }
            const ctx = this.template.querySelector('canvas.barChart').getContext('2d');
            this.chart = new window.Chart(ctx, JSON.parse(JSON.stringify(this.chartConfig)));
            this.chart.canvas.parentNode.style.height = 'auto';
            this.chart.canvas.parentNode.style.width = '100%';
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error loading Chart',
                    message: error.message,
                    variant: 'error',
                })); });}}