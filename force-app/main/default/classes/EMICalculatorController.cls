public class EMICalculatorController {
    public String calculate { get; set; }
    public Decimal loanAmount { get; set; }
    public Decimal interestRate { get; set; }
    public Integer loanTenure { get; set; }
    public Decimal loanEMI { get; set; }
    public Decimal totalInterest { get; set; }
    public Decimal totalPayment { get; set; }
    public List<PieData> myPieChart { get; set; }
    public EMICalculatorController() {
        calculate = 'Calculate';
    }
    public void calculateLoan() {
        Decimal monthlyInterestRate = interestRate / (12 * 100);
        Decimal numerator = loanAmount * monthlyInterestRate * (Decimal)Math.pow((Double)(1 + monthlyInterestRate), loanTenure);
        Decimal denominator = (Decimal)Math.pow((Double)(1 + monthlyInterestRate), loanTenure) - 1;
        loanEMI = numerator / denominator;
        totalInterest = (loanEMI * loanTenure) - loanAmount;
        totalPayment = loanEMI * loanTenure;
        loanEMI = loanEMI.setScale(2);
        totalInterest = totalInterest.setScale(2);
        totalPayment = totalPayment.setScale(2);
        myPieChart = new List<PieData>();
        myPieChart.add(new PieData('Principal', loanAmount));
        myPieChart.add(new PieData('Total Interest Payable', totalInterest));
    }
    
    public class PieData {
        public String name { get; set; }
        public Decimal data { get; set; }
        
        public PieData(String name, Decimal data) {
            this.name = name;
            this.data = data;
        }
    }
}