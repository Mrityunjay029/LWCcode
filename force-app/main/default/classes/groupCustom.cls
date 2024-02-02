public class groupCustom {
    public static void method(){
        Group newGroup = new Group();
        newGroup.Name = 'MyGroup';
        newGroup.DeveloperName = 'MyGroup';
        newGroup.Type = 'Regular';
        insert newGroup;
        
        GroupMember newGroupMember = new GroupMember();
        newGroupMember.GroupId = newGroup.Id;
        newGroupMember.UserOrGroupId = UserInfo.getUserId();
        insert newGroupMember;
    }
}