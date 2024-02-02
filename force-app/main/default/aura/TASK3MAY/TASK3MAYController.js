({
	
    handleClick : function(component, event, helper) {
		let name = component.get('v.Fname');
        let date = component.get('v.Cdate');
        let stage = component.get('v.stage');
        let type = component.get('v.types');
        let amount = component.get('v.amount');
        
        let action = component.get('c.createOpp');
        
        action.setParams({
            'name':name,
            'stage':stage,
            'amount':amount,
            'types':type,
            'Cdate':date
        });
        
        action.setCallback(this, function(res){
            let state = res.getState();
            if(state=="SUCCESS"){
                let oppId = res.getReturnValue();
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "The Opportunity record has been inserted successfully, Opp ID : " + oppId,
                    "variant": "success"
                });
                toastEvent.fire();
            }else{
                if(name=='' || date=='' || stage=='' || amount==''){
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Required Field!",
                        "message": "Required Field can't be left blank",
                        "variant": "info"
                    });
                    toastEvent.fire();
                }
            }
        });
        
        $A.enqueueAction(action);
	},
    clearFields : function(component,event,helper){
        component.set('v.Fname','');
        component.set('v.Cdate','');
        component.set('v.stage','');
        component.set('v.types','');
        component.set('v.amount','');
    },
    raisetoast : function(component,event,helper){
        let name = component.get('v.Fname');
        let date = component.get('v.Cdate');
        let stage = component.get('v.stage');
        let amount = component.get('v.amount');
        if(name=='' || date=='' || stage=='' || amount==''){
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Required Field!",
                "message": "Required Field can't be left blank",
                "variant": "info"
            });
            toastEvent.fire();
        }
    }
})