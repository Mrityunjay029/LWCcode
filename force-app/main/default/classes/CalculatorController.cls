public class CalculatorController {
    public Decimal number1 { get; set; }
    public Decimal number2 { get; set; }
    public String operator { get; set; }
    public Decimal result { get; set; }

    public List<SelectOption> getOperators() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('+', 'Add'));
        options.add(new SelectOption('-', 'Subtract'));
        options.add(new SelectOption('*', 'Multiply'));
        options.add(new SelectOption('/', 'Divide'));
        return options;
    }

    public void calculate() {
        if (operator == '+') {
            result = number1 + number2;
        } else if (operator == '-') {
            result = number1 - number2;
        } else if (operator == '*') {
            result = number1 * number2;
        } else if (operator == '/') {
            if (number2 != 0) {
                result = number1 / number2;
            } else {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Cannot divide by zero.'));
            }
        }
    }
}