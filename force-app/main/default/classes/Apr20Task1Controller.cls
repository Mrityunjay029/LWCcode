public class Apr20Task1Controller {
    public static String acc_name{get;set;}
    
    public static PageReference createAcc() {
        Account acc = new Account(Name=acc_name);
        Insert acc;
        PageReference pgr = new PageReference('https://astreaitservices78-dev-ed.develop.lightning.force.com/lightning/r/Account/'+acc.Id+'/view');
        pgr.setRedirect(true);
        return pgr;
    }
}