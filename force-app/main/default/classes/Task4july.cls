public class Task4july {
    public static void main(){
        Map<String,List<String>> mp = new Map<String,List<String>>();
        List<String> lis = new List<String>();
        List<String> lis1 = new List<String>();
        lis.add('abc');
        lis.add('def');
        lis.add('ghi');
        
        lis1.add('123');
        lis1.add('456');
        lis1.add('789');
        
        mp.put('x',lis);
        mp.put('y',lis1);
        convert(mp);
    }
    public static void convert(Map<String,List<String>> mp){
        Map<String,String> mp1 = new Map<String,String>();
             for(String x : mp.keySet()){
            String str = '';
            for(String li : mp.get(x)){
                str+= li;
            }
            mp1.put(x,str);
        }
        
        for(String x : mp1.keySet()){
            System.debug(x);
            System.debug(mp1.get(x));
        }
        }
}