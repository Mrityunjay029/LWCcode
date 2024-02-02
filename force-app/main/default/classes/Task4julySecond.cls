public class Task4julySecond {
    public static void main(){
        Map<String,List<Contact>> map1 = new Map<String,List<Contact>>();
        Map<String,String> map2 = new Map<String,String>();
        List<Account> accIDs = [Select ID FROM Account LIMIT 10];
        
        map<String,Account> map3 = new map<String,Account>([select Id,
                                                                 (SELECT Name FROM Contacts) 
                                                                 FROM account WHERE Id IN :accIDs]);

        
        for(string i:map3.keySet()){
            List<contact> con = map3.get(i).contacts;
            map1.put(i,con);            
        }
        
        
        for(string i:map1.keyset()){
            list<contact> x = map1.get(i);
            String str = '';
            for(contact con:x){
                str += con.Name ;
                str += '  '; 
            }
            map2.put(i,str);
        }
        
        for(string i:map1.keyset()){
            System.debug(i + map1.get(i));     
        }
        
        for(string i:map2.keyset()){
            System.debug(i + map2.get(i));     
        }
    }
}