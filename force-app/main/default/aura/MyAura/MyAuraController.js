({
    init: function(component, event, helper) {
        helper.loadAccounts(component);
    },
    
    handleAccountChange: function(component, event, helper) {
        var selectedAccountId = event.getSource().get("v.value");
        if (selectedAccountId) {
            component.set("v.selectedAccountId", selectedAccountId);
            helper.loadContacts(component, selectedAccountId);
        } else {
            component.set("v.contacts", []);
        }
    }
})