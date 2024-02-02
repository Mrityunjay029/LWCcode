({
	addAccount : function(component, event, helper) {
        var accList = JSON.parse(JSON.stringify(component.get("v.accountList")));
        accList.push({"Name": "", "Email__c": "", "Phone": ""});
        component.set("v.accountList", accList);
    },
    
    deleteRow: function(component, event, helper) {
        var accountList = JSON.parse(JSON.stringify(component.get("v.accountList")));
        if(accountList.length === 1) {
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Warning",
                "message": "Can't delete first row",
                "type": "warning"
            });
            toastEvent.fire();
        } else {
            var index = event.getSource().get("v.name");
            if (index >= 0 && index < accountList.length) {
                accountList.splice(index, 1);
                component.set("v.accountList", accountList);
            }
        }
    },
    
    save : function(component, event, helper) {
        var accList = component.get("v.accountList");
        console.log(JSON.parse(JSON.stringify(accList)));
        
        var isEmptyAccountName = JSON.parse(JSON.stringify(accList)).some(function(account) {
            return !account.Name || account.Name === '';
        });
        
        if (isEmptyAccountName) {
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Validation Error",
                "message": "Account Name cannot be empty",
                "type": "error"
            });
            toastEvent.fire();
        } else {
            var action = component.get("c.createAccounts");
            action.setParams({
                "accountList": JSON.parse(JSON.stringify(accList))
            });
            
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var accList = [];
                    accList.push({"Name": "", "Email__c": "", "Phone": ""});
                    component.set("v.accountList", accList);
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Success",
                        "message": "Accounts created successfully.",
                        "type": "success"
                    });
                    toastEvent.fire();
                } else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        console.error("Error: " + errors[0].message);
                    }
                }
            });
            $A.enqueueAction(action);
        }
	}
})