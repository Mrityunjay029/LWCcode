import { LightningElement } from 'lwc';
import generateReportData from '@salesforce/apex/ReportGeneratorController.generateReportData';
export default class ReportGenerator extends LightningElement {

    startDate;
    endDate;

    chartConfiguration;

    handleStartChange(event) {
        this.startDate = event.detail.value;
        this.callOutput();
    }

    handleEndChange(event) {
        this.endDate = event.detail.value;
        this.callOutput();
    }

    callOutput() {
        this.chartConfiguration = undefined;
        if(this.startDate && this.endDate) {
            generateReportData({startDate: this.startDate, endDate: this.endDate})
            .then((data) => {
                this.chartConfiguration = {
                    type: 'bar',
                    data: {
                        labels: ['Accounts', 'Contacts', 'Opportunities', 'Leads', 'Campaigns'],
                        datasets: [
                            {
                                label: `Number of records between ${this.startDate} and ${this.endDate}`,
                                barPercentage: 0.5,
                                barThickness: 6,
                                maxBarThickness: 8,
                                minBarLength: 2,
                                backgroundColor: "green",
                                data: data
                            }
                        ],
                    },
                    options: {
                    }
                };
            })
            .catch((err) => {
                console.log(err);
            })
        }
    }
}