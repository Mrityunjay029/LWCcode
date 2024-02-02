// fileUploader.js
import { LightningElement, api, track, wire } from 'lwc';
import getCSVContent from '@salesforce/apex/test10Jan.getCSVContent';
import {NavigationMixin} from 'lightning/navigation';
import getOrderAttachments from '@salesforce/apex/uploadFiles.getOrderAttachments';

export default class FileUploader extends LightningElement {
}