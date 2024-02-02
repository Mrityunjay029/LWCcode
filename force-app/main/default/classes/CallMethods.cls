public class CallMethods {
    public static void method1(){
        List<Contact> x = method2();
        for(Contact y : x){
            System.debug(y);
            System.debug('\n');
        }
    }
    public static List<Contact> method2() {
        List<Contact> l = [SELECT Name FROM Contact WHERE Name LIKE '% %'];
        return l;
    }
}