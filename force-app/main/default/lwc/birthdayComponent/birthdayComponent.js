import { LightningElement, track } from 'lwc';
import getTodayBdays from '@salesforce/apex/BirthdayController.getTodayBdays';
import upcomingBdays from '@salesforce/apex/BirthdayController.upcomingBdays';
import { NavigationMixin } from 'lightning/navigation';

export default class BirthdayList extends NavigationMixin(LightningElement) {
    @track originalTodayBdays = [];
    @track originalUpcoming = [];
    @track allTodaysBday = [];
    @track allUpcomingBdays = [];

    openContact(event){
        const recordId = event.target.dataset.contactid;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                actionName: "view",
                recordId: recordId
            }
        });
    }

    activeSections = ['A', 'B'];

    connectedCallback() {
        this.getBdays();
    }

    sortByUpcomingBirthdays(array) {
        const today = new Date();


        return array.sort((a, b) => {
            const parseDate = (dateString) => {
                const [day, month, year] = dateString.split('/').map(Number);
                return new Date(year, month - 1, day);
            };
            const birthdateA = parseDate(a.Birthdate);
            const birthdateB = parseDate(b.Birthdate);
            const nextBirthdayA = new Date(today.getFullYear(), birthdateA.getMonth(), birthdateA.getDate());
            const nextBirthdayB = new Date(today.getFullYear(), birthdateB.getMonth(), birthdateB.getDate());
            if (nextBirthdayA < today) {
                nextBirthdayA.setFullYear(today.getFullYear() + 1);
            }
            if (nextBirthdayB < today) {
                nextBirthdayB.setFullYear(today.getFullYear() + 1);
            }
            return nextBirthdayA - nextBirthdayB;
        });
    }


    async getBdays() {
        try {
            const data = await getTodayBdays();
            this.allTodaysBday = data.contactList;
            this.allTodaysBday = this.allTodaysBday.map((item) => ({
                ...item,
                Birthdate: new Date(item.Birthdate).toLocaleDateString('en-GB'),
                Nameurl:'/'+item.Id
            }));
            this.originalTodayBdays = this.allTodaysBday.slice(0, data.rowCount);
            this.allTodaysBday = this.allTodaysBday.map((item) => {
                const parts = item.Birthdate.split('/');
                item.Birthdate = `${parts[0]}-${parts[1]}`;
                return item;
            });

            this.allUpcomingBdays = await upcomingBdays();
            this.allUpcomingBdays = this.allUpcomingBdays.map((item) => ({
                ...item,
                Birthdate: new Date(item.Birthdate).toLocaleDateString('en-GB'),
                Nameurl: '/'+item.Id,
            }));
            this.allUpcomingBdays= this.sortByUpcomingBirthdays(this.allUpcomingBdays);
            this.allUpcomingBdays = this.allUpcomingBdays.map((item) => {
                const parts = item.Birthdate.split('/');
                item.Birthdate = `${parts[0]}-${parts[1]}`;
                return item;
            });
            this.originalUpcoming = this.allUpcomingBdays.slice(0, data.rowCount);
            this.allUpcomingBdays = this.allUpcomingBdays.slice(0,data.AllRowCount)
        } catch (err) {
            console.log("there was an error fetching today's birthdays");
        }
    }
}