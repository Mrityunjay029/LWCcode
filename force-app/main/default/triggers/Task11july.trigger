trigger Task11july on Opportunity (before insert) {
    if(trigger.isAfter && trigger.isInsert){
        MyClassHandler.main(trigger.new);        
    }
}