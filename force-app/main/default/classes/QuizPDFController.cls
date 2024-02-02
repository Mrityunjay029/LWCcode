public with sharing class QuizPDFController {
	public List<Account_Quiz__mdt> quizQuestions { get; set; }
    
    public QuizPDFController() {
        String serializedList = ApexPages.currentPage().getParameters().get('data');
        quizQuestions = (List<Account_Quiz__mdt>)(JSON.deserialize(serializedList, List<Account_Quiz__mdt>.class));
    }
}