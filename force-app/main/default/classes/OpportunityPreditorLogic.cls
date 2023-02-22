public with sharing class OpportunityPreditorLogic {
    List<OpportunityLineItem> opportunityItems;
    List<QuoteLineItem>       quoteItems;

    Boolean                   isInsert             = false;
    
    Set<Id>                   incomingOppId;
    Set<Id>                   incomingQuoteId;
    Set<SObject>              incomingOppObj;
    Set<SObject>              incomingQuoteObj;

    public OpportunityPreditorLogic() {
        System.debug('hello');
    }
    
    public static void dataEntryPoint(Set<Id> incIds) {
        Boolean                   isDataIsOpportunites = false;
        Boolean                   isDataIsQuote        = false;
        for(Id incId : incIds) {
            if(incId.getSobjectType().getDescribe().getLabel() == 'Opportunity') { 
                isDataIsOpportunites = true;
            }

            if(incId.getSobjectType().getDescribe().getLabel() == 'Quote') { 
                isDataIsQuote = true;
            }

            else { return;}
            
        }
    }
}
