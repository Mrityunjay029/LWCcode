({
	myAction : function(component, event, helper) {
		var temp = event.getParam("message");
		console.log(temp);
		component.set("v.childmes",temp);
	}
})