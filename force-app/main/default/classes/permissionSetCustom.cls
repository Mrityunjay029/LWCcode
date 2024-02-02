public class permissionSetCustom {
    public static void createPermissionSetAndAssign(string username){
        PermissionSet perSet = new PermissionSet(Label='Test Permission Set',Name='test_permission_set');
        insert perSet;
        System.debug(perSet);
        
        
        //adding permission
        PermissionSet psToUpdate = [select id from PermissionSet WHERE Name='test_permission_set' LIMIT 1];
        psToUpdate.PermissionsModifyAllData = true;
        update psToUpdate;
        
        PermissionSetAssignment perSetAss = new PermissionSetAssignment(AssigneeId=UserInfo.getUserId() ,PermissionSetId=perSet.id);
        insert perSetAss;
        System.debug(perSetAss);
        
        }
}
//SELECT Name, COUNT(Id) FROM Account GROUP BY Name HAVING COUNT(Name) > 1