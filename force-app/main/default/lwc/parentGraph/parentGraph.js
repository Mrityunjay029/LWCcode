import { LightningElement,track } from 'lwc';
import countRecords from '@salesforce/apex/GraphReport.countRecords';


export default class parentGraph extends LightningElement {
    @track start;
    @track end;
    @track chartConfiguration;


    handleStartDateChange(event) {
        this.start = event.target.value; 
    }
    handleEndDateChange(event) {
        this.endDate = event.target.value;
    }
    getRecords(){
        console.log(this.start);
        this.chartConfiguration=null;
    countRecords({start: this.start, endDate:this.end})
        .then(data=>{
            let chartData = [];
            let chartLabels = [];
            data.forEach(r => {
                chartData.push(r.count);
                chartLabels.push(r.obj);
                });
                
            this.chartConfiguration = {
                type: 'bar',
                data: {
                    labels: chartLabels,
                    datasets: [{
                        label: 'Count',
                        // barPercentage: 0.5,
                        // barThickness: 6,
                        // maxBarThickness: 8,
                        // minBarLength: 2,
                        backgroundColor: "blue",
                        data: chartData,
                        },
                    ],
                },
                options: {},
                };
                console.log('data => ', data);
                this.error = null;
        })
        .catch(error=>{
            this.chartConfiguration = null;
            console.error('ClassReportOfObjectsRecords'+ error);
        })}}