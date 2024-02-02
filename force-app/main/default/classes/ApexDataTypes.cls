public class ApexDataTypes {
    public static void InitializeApexDataTypes(){
        Integer a = 10;
        String s = 'ABCD';
        Boolean val = true;
        Account acc = new Account();
        acc.Name = 'TESTING';
        PrintValue(a,s,val,acc);
    }
    public static void PrintValue(Integer x,String r,Boolean t,Account y){
        System.debug(x);
        System.debug(r);
        System.debug(t);
        System.debug(y);
    }
}