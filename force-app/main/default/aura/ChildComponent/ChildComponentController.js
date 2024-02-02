({
    myAction : function(component, event, helper) {
        var capEvent = component.getEvent("trnEvent");
        
        var a = component.get("v.mes");
        console.log('a '+ a);
        
        capEvent.setParams({
            "message" : a 
        });
        
        capEvent.fire();
    }
})