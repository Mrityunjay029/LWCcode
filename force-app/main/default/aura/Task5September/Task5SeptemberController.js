({
	doInit: function(component, event, helper) {
        var action = component.get("c.getAccounts");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.accounts", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    
    handleChange: function(component, event, helper) {
        var accountId = component.get("v.accId");
        if(accountId != "") {
            var action = component.get("c.getRelatedContacts");
            action.setParams({
                accId: accountId
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var contacts = response.getReturnValue();
                    for(var i = 0; i < contacts.length; i++) {
                        contacts[i].editable = false;
                    }
                    component.set("v.contacts", contacts);
                }
            });
            $A.enqueueAction(action);
        } else {
            component.set("v.contacts", []);
        }
    },
    
    editContact: function(component, event, helper) {
        var contacts = component.get("v.contacts");
        var index = event.getSource().get("v.name");
        contacts[index].editable = !contacts[index].editable;
        component.set("v.contacts", contacts);
    },
    
    delCon: function(component, event, helper) {
        var contacts = component.get("v.contacts");
        var index = event.getSource().get("v.name");
        var conToDelete = contacts[index];
        if(conToDelete.Id) {
            var contactId = conToDelete.Id;
            var action = component.get("c.deleteContact");
            action.setParams({
                conId: contactId,
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    contacts.splice(index,1);
            		component.set("v.contacts", contacts);
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Success",
                        "message": "Contact Deleted Successfully",
                        "type": "success"
                    });
                    toastEvent.fire();
                }
            });
            $A.enqueueAction(action);
        } else {
            contacts.splice(index,1);
            component.set("v.contacts", contacts);
        }
    },
    
    addContact: function(component, event, helper) {
        var contacts = component.get("v.contacts");
        var newContact = {'FirstName': '', 'LastName': '', 'Phone': '', 'Email': '', 'editable': true};
        contacts.push(newContact);
        component.set("v.contacts", contacts);
    },
    
    save: function(component, event, helper) {
        var contacts = component.get("v.contacts");
        for(var i = 0; i < contacts.length; i++) {
            if(!contacts[i].LastName) {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error",
                    "message": "Contacts Last Name cannot be empty",
                    "type": "error"
                });
                toastEvent.fire();
                return;
            }
        }
        var accountId = component.get("v.accId");
        var action = component.get("c.upsertContacts");
        action.setParams({
            accId: accountId,
            conList: contacts
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var action1 = component.get("c.getRelatedContacts");
                action1.setParams({
                    accId: accountId
                });
                action1.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var contacts = response.getReturnValue();
                        for(var i = 0; i < contacts.length; i++) {
                            contacts[i].editable = false;
                        }
                        component.set("v.contacts", contacts);
                    }
                });
                $A.enqueueAction(action1);
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success",
                    "message": "Contacts Edited Successfully",
                    "type": "success"
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    }
})