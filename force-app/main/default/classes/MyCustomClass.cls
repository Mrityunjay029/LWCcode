public without sharing class MyCustomClass {
    public static String customerName{get;set;}
    public static String customerCompany{get;set;}
    public static String customerPhone{get;set;}
    public static String customerEmail{get;set;}
    public static String customerVisit{get;set;}
    public static String customerSource{get;set;}
    public static Boolean isFormRendered{get;set;}
    
    public MyCustomClass() {
        isFormRendered = true;
    }
    
    public static void createLead() {
        isFormRendered = false;
        Lead l1 = new Lead();
        l1.LastName = customerName;
        l1.Company = customerCompany;
        l1.Phone = customerPhone;
        l1.Email = customerEmail;
        if(customerSource == 'Agent Contact') {
            l1.Status = 'Working - Contacted';
        } else {
            l1.Status = 'Open - Not Contacted';
        }
        if(customerVisit == 'Highly Likely') {
            l1.Rating = 'Hot';
        } else if(customerVisit == 'Somewhat Likely') {
            l1.Rating = 'Warm';
        } else {
            l1.Rating = 'Cold';
        }
        Insert l1;
        
        if(l1.Rating != 'Cold') {
            Account acc = new Account(Name=customerName);
            Contact con = new Contact(LastName=customerName);
            Opportunity opp = new Opportunity(Name=customerName, CloseDate=System.today(), StageName='Prospecting');
            Insert acc;
            Insert con;
            Insert opp;
        }
    }
}