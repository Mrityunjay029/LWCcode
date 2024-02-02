public class BirthdayController {
     
   private static Integer rowsToDisplay = (Integer)BirthdaySettings__c.getInstance().DaysToDisplay__c;
   private static Integer upcomingNumberOfdaysSize = (Integer)BirthdaySettings__c.getInstance().UpcomingNumberofdays__c;                                                                                                                                                                                                                 

    @AuraEnabled(cacheable=true)
    public static birthdayWrapper getTodayBdays(){
        date today = Date.today();
        date endDate = today.addDays(rowsToDisplay);
        list<Contact> todayBdays = [SELECT Id, Name, Birthdate,Phone,Email FROM Contact WHERE DAY_IN_MONTH(Birthdate) = :today.day() AND CALENDAR_MONTH(Birthdate) = :today.month()];
        system.debug('upcoming: '+upcomingNumberOfdaysSize);
        return new birthdayWrapper(todayBdays , rowsToDisplay,upcomingNumberOfdaysSize);
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> upcomingBdays() {
    
        // Query for future birthdays
        List<Contact> futureBdayList = [
            SELECT Id, Name, Birthdate, Email, Phone
            FROM Contact 
            WHERE Birthdate != NULL
        ];
        return futureBdayList;
    }

}