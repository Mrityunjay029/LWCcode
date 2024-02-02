import { LightningElement, wire, track, api} from 'lwc';
import Id from '@salesforce/user/Id';
import { getRecord } from 'lightning/uiRecordApi';
import UserNameFIELD from '@salesforce/schema/User.Name';
import importDATA from '@salesforce/apex/campaignAction.importdata';
import numberofcon from '@salesforce/apex/campaignAction.contacts';
import numberoflea from '@salesforce/apex/campaignAction.lead';
import dataofcontacts from '@salesforce/apex/campaignAction.dataofcontacts';
import dataofleads from '@salesforce/apex/campaignAction.dataofleads';

let columns = [
    {label: 'Id', fieldName : 'Id'},
    { label: 'Name', fieldName: 'Name' },
    { label: 'Email', fieldName: 'Email' },
    { label: 'Mobile', fieldName: 'MobilePhone'  }
];

let columns1 = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Company', fieldName: 'Company' },
    { label: 'Status', fieldName: 'Status'  }
];


export default class LWCCurrentUserInfo extends LightningElement {
    @track userId = Id;
    @track currentUserName;
    @api recordId = '7012w000000MSL4AAO';
    @track recordName;
    @track data = [];
    @track data1 = [];
    @track numberofcontacts;
    @track numberofleads;

    @track toggle;
    @track toggle1;
    @track col = columns;
    @track col1 = columns1;
    @wire(getRecord, { recordId: Id, fields: [UserNameFIELD]}) 
    currentUserInfo({error, data}) {
        if (data) {
            this.currentUserName = data.fields.Name.value;
        } else if (error) {
            this.error = error ;
        }
    }

    connectedCallback(){
        this.fun();
        this.numsofcontacts();
        this.numsofleads();
        this.dataofcons();
        this.dataofleads();
    }

    async fun() {
        try {
            const result = await importDATA({ recId: this.recordId });
            this.recordName = result;
        } catch (error) {
            console.error(error);
        }
    }
    async numsofcontacts() {
        try {
            const num1 = await numberofcon({ recId: this.recordId });
            this.numberofcontacts = num1;
        } catch (error) {
            console.error(error);
        }
    }
    async numsofleads() {
        try {
            const num2 = await numberoflea({ recId: this.recordId });
            this.numberofleads = num2;
        } catch (error) {
            console.error(error);
        }
    }
    async dataofcons(){
        try{
            let con  = await dataofcontacts({recId : this.recordId});
            console.log("This is CONTACT list",con);
            this.data = con.map(c => ({
                Id :  c.Id,
                Name: c.Name,
                Email:c.Email,
                Mobile:c.MobilePhone
            }));
            console.log("Datatable data is fetched  : ", this.data);
        }catch(error){
            console.error(error);
        }
    }

    async dataofleads(){
        try{
            let lea  = await dataofleads({recId : this.recordId});
            console.log("This is LEAD list",lea);
            this.data1 = lea.map(l => ({
                Name: l.Name,
                Company:l.Company,
                Status:l.Status
            }));
            console.log("Datatable data is fetched  : ", this.data1);
        }catch(error){
            console.error(error);
        }
    }

    handleClick(event){
        if(this.toggle === false)
        this.toggle = true;
        else
        this.toggle = false;
    }
    handleClick1(event){
        if(this.toggle1 === false)
        this.toggle1 = true;
        else
        this.toggle1 = false;
    }
}