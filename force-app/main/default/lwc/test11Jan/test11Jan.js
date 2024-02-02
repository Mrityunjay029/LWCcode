import { LightningElement,api ,track, wire } from 'lwc';
import getcontentversion from '@salesforce/apex/test11Jan.getcontentversion';
import processFileUpload from '@salesforce/apex/test11Jan.processFileUpload';
import getData from '@salesforce/apex/test11Jan.getData';
import MyModal from 'c/csvreader';
import {NavigationMixin} from 'lightning/navigation'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Test11Jan extends NavigationMixin(LightningElement) {
    @api recordId;
    acceptedFormats = ['.csv','.png','.pdf'];
    @track attachments;
    csvContent;
    filesList =[]
    @track storedata;
    

    //CALL APEX FROM THIS FUNCTION TO UPLOAD TO FTP
    handleUploadFinished(event) {
        const uploadedFiles = event.detail.files;
        
            const contentDocumentId = uploadedFiles[0].documentId;
            console.log(contentDocumentId);
           processFileUpload({ myId: contentDocumentId.toString() })
                .then(result => {
                    const toastEvent = new ShowToastEvent({
                        title: 'Success',
                        message: 'File Upload Successful',
                        variant: 'success',
                    });
                    this.dispatchEvent(toastEvent);
                    console.log(result);
                })
                .catch(error => {
                    console.error(error);
                    const toastEvent = new ShowToastEvent({
                        title: 'Error',
                        message: 'An error occurred while processing the file.',
                        variant: 'error'
                    });
                    this.dispatchEvent(toastEvent);
                });
        }

    //GET DATA TO DISPLAY
    @wire(getcontentversion, { orderId: '$recordId' })
    getfileinfo({error,data}){
        if(data){
            this.attachments = data;
        }
        if(error){
            console.log('error fetching files',error);
        }
    }

    //HANDLE CLICK ON PREVIEW BUTTON
    async openFile(event){
        try{
            this.fileId = event.target.dataset.attachmentid;
            if(event.target.dataset.filetype === 'CSV'){
                this.storedata = await getData({
                conId: this.fileId
            })

            this.open();
            }
            else{
                this[NavigationMixin.Navigate]({ 
            type:'standard__namedPage',
            attributes:{ 
                pageName:'filePreview'
            },
            state:{ 
                selectedRecordId: event.target.dataset.attachmentid
            }
        })
            }
            
        }catch(e){
            console.log('error while navigating' ,e);
        }
    }
    
    async open(){
        const mod = await MyModal.open({
            size: 'medium',
            description: 'Todays',
            content: this.storedata
        });
    }
}