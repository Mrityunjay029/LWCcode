public with sharing class QuizController {
    public Boolean renderQuiz { get; set; }
    public String message { get; set; }
    public List<Account_Quiz__mdt> quizQuestions { get; set; }
    public Integer currentQuestionIndex { get; set; }
    public Account_Quiz__mdt currentQuestion { get; set; }
    public String selectedAnswer { get; set; }
    
    String[] chosenAnswers;

    public QuizController(ApexPages.StandardController stdController) {
        List<Attachment> existingAttachments = [SELECT Id FROM Attachment WHERE ParentId = :stdController.getId() AND Name = 'Questionnaire Responses.pdf' LIMIT 1];
        renderQuiz = existingAttachments.isEmpty();
        message = 'Questionnaire Already Completed. Check notes and attachments for results';
        
        if(!renderQuiz) return;
        
        Account sourceRecord = [SELECT Industry, BillingState FROM Account WHERE Id = :stdController.getId()];
        String industryStateFilter = sourceRecord.Industry + sourceRecord.BillingState;
        
        try {
        	quizQuestions = [SELECT Question__c, Question_Number__c FROM Account_Quiz__mdt WHERE Industry_State_Code__c = :industryStateFilter ORDER BY Question_Number__c];
        	if(quizQuestions.isEmpty()) throw new customException();
        } catch (Exception e) {
            renderQuiz = false;
            message = 'Questionnaire not available for this industry, billing state combination. Contact your administrator for more details';
            return;
        }
        
        chosenAnswers = new String[quizQuestions.size()];
        currentQuestionIndex = 0;
        currentQuestion = quizQuestions[currentQuestionIndex]; 
        selectedAnswer = '';
    }

    public List<SelectOption> getAnswerOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Yes', 'Yes'));
        options.add(new SelectOption('No', 'No'));
        return options;
    }

    public Boolean getHasMoreQuestions() {
        return currentQuestionIndex < quizQuestions.size() - 1;
    }

    public Boolean getNoMoreQuestions() {
        return currentQuestionIndex == quizQuestions.size() - 1;
    }
    
    public Boolean getHasPreviousQuestions() {
        return currentQuestionIndex > 0;
    }

    public PageReference previous() {
        chosenAnswers[currentQuestionIndex] = selectedAnswer;
        currentQuestionIndex--;
        currentQuestion = quizQuestions[currentQuestionIndex];
        selectedAnswer = chosenAnswers[currentQuestionIndex];
        return null;
    }

    public PageReference next() {
        if(selectedAnswer != '') {
            chosenAnswers[currentQuestionIndex] = selectedAnswer;
            currentQuestionIndex++;
            currentQuestion = quizQuestions[currentQuestionIndex];
            selectedAnswer = chosenAnswers[currentQuestionIndex];
        }
        return null;
    }

    public PageReference finish() {
        PageReference redirect;
        if(selectedAnswer != null || selectedAnswer != '') {
            chosenAnswers[currentQuestionIndex] = selectedAnswer;
        	
            for(Integer i = 0; i < quizQuestions.size(); i++) { 
                if(chosenAnswers[i] == null || chosenAnswers[i] == '') return null;
                quizQuestions[i].Selected_Answer__c = chosenAnswers[i]; 
            }
            
            PageReference pdfPage = Page.QuizPDF;
            pdfPage.getParameters().put('data', JSON.serialize(quizQuestions));
            
            Blob pdfBlob = pdfPage.getContentAsPDF();
    
            Attachment attachment = new Attachment();
            attachment.ParentId = ApexPages.currentPage().getParameters().get('id');
            attachment.Name = 'Questionnaire Responses.pdf';
            attachment.Body = pdfBlob;
            attachment.ContentType = 'application/pdf';
            INSERT attachment;
            
            redirect = new PageReference('/servlet/servlet.FileDownload?file='+attachment.Id);
            redirect.setRedirect(true);
        }
        
        return redirect;
    }
}