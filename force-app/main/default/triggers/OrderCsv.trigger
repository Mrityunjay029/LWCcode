trigger OrderCsv on Order (After insert, after update) {
    HandleOrderCsv.InsertinOrder(Json.Serialize(trigger.new));
}