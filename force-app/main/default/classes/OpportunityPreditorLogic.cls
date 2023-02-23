public with sharing class OpportunityPreditorLogic { 
    
    public static void dataEntryPoint(Set<Id> incIds, Boolean isIns) { // поменять возвращаемы тип на List <opportunityProduct>()
       // if(incIds.isEmpty() || incIds = null) return new List <opportunityProduct>();
        //rework
        Boolean                   isDataIsOpportunites = false;
        Boolean                   isDataIsQuote        = false;

        for(Id incId : incIds) {
            if(incId.getSobjectType().getDescribe().getLabel() == 'Opportunity') { 
                isDataIsOpportunites = true;
            }

            if(incId.getSobjectType().getDescribe().getLabel() == 'Quote') { 
                isDataIsQuote = true;
            }

            if(isDataIsOpportunites && isDataIsQuote) {break;}
            
        }
    }

    private static List<SObject> collectDataFromOrg(Set<Id> incomeIds, Boolean oppoSelect, Boolean quoteSelect) {
        List<SObject> selectedData = new List<SObject>();
        try {
           if(oppoSelect) {
            selectedData.addAll(Selectors.getOpportunityLineItemsFromIds(incomeIds));
           } 
           if (quoteSelect) {
            selectedData.addAll(Selectors.getQuoteLineItemsByQuoteId(incomeIds));
           }
        }
         catch (QueryException qException) {
            System.debug(qException.getMessage());
        }

        return selectedData;
    }
}
