({
    loadAccounts: function(component) {
        var action = component.get("c.getAccounts");
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.accounts", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(action);
    },
    
    loadContacts: function(component, accountId) {
        var action = component.get("c.getContactsByAccount");
        action.setParams({
            accountId: accountId
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.contacts", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(action);
    }
})