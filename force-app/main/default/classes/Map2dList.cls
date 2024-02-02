public class Map2dList {
    public static void main(){
        List<List<Integer>> lis = new List<List<Integer>>{new List<Integer>{1, 2, 3}, new List<Integer>{4, 5, 6}, new List<Integer>{7,8,9}};
        transpose(lis);
    }
    public static void transpose(List<List<Integer>> transposelist){
        for(Integer i=0;i<transposelist.size();i++){
            for(Integer j=0;j<transposelist[i].size();j++){
                if(transposelist.size()==transposelist[i].size()){
                if(j>=i){
                Integer temp = transposelist[i][j];
                transposelist[i][j] = transposelist[j][i];
                transposelist[j][i] = temp;
                }
                }
                else if(transposelist.size()>transposelist[i].size()){
                    
                }
                else{
                    
                }
            }
        }
        System.debug(transposelist);
}
    }