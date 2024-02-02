public class Task6july {
    public static void main(){
        List<listview> lis = [SELECT Id,Name, Sobjecttype FROM ListView WHERE Sobjecttype='Account'];

        for(listview x:lis){
            System.debug(x);
        }

    }
}