import { LightningElement, track } from 'lwc';
import getAccountList from '@salesforce/apex/Task6Sept.getAccountList';
import getContactList from '@salesforce/apex/Task6Sept.getContactList';
import updateContact from '@salesforce/apex/Task6Sept.updateContact';
import deleteContact from '@salesforce/apex/Task6Sept.deleteContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AccountContact_sep6 extends LightningElement {
    @track selectedAccountId = '';
    @track accountOptions = []; 
    @track contactData = []; 
    @track editIndex;

    connectedCallback() {
        getAccountList()
            .then((result) => {
                this.accountOptions = result.map((account) => ({
                    label: account.Name,
                    value: account.Id,
                }));
            })
            .catch((error) => {
                console.log(error);
                alert("Check console");
            });
    }

    showToast(toastTitle, toastMessage, toastVariant) {
        const event = new ShowToastEvent({
            title: toastTitle,
            message: toastMessage,
            variant: toastVariant
        });
        
        this.dispatchEvent(event);
    }

    handleAccountChange(event) {
        this.contactData = [];
        getContactList({ accountId: event.detail.value })
            .then((result) => {
                if(result.length !== 0) {
                    this.contactData = result;
                } else {
                    this.showToast('Warning', 'Account doesn\'t have any contacts', 'warning');
                }
            })
            .catch((error) => {
                console.log(error);
                alert("Check console");
            });
    }

    handleEditClick(event) {
        var flag = this.contactData.some((contact) => {
            return contact.inEdit;
        });

        if(flag) {
            this.showToast('Warning', 'Can\'t edit two contacts simultaneously', 'warning');
        } else {
            this.editIndex = event.target.itemid;
            this.contactData[this.editIndex].inEdit = true;
        }
    }
    
    handleSaveClick() {
        const index = this.editIndex;
        const row = event.target.closest('tr');

        this.contactData[index]["FirstName"] = row.querySelector('input[name="FirstName"]').value;
        this.contactData[index]["LastName"] = row.querySelector('input[name="LastName"]').value;
        this.contactData[index]["Phone"] = row.querySelector('input[name="Phone"]').value;
        this.contactData[index]["Email"] = row.querySelector('input[name="Email"]').value;
        
        var contactToSend = this.contactData[index];
        delete contactToSend.inEdit;
        updateContact({ con: contactToSend })
            .then(() => {
                delete this.contactData[index].inEdit;
                this.showToast('Success', 'Contact Edited Successfully', 'Success');
            })
            .catch((error) => {
                console.log(error);
                alert("Check console");
            });
    }
    
    handleCancelClick() {
        const index = this.editIndex;
        delete this.contactData[index].inEdit;
    }

    handleDeleteClick(event) {
        var index = event.target.itemid;
        deleteContact({ conId: this.contactData[index].Id })
            .then(() => {
                this.contactData.splice(index, 1);
                this.showToast('Success', 'Contact Deleted Successfully', 'Success');
            })
            .catch((error) => {
                console.log(error);
                alert("Check console");
            });

    }
}