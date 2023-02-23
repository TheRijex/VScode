public with sharing class OpportunityPreditorLogic { 
    
    public static void dataEntryPoint(Set<Id> incIds, Boolean isIns) { // поменять возвращаемы тип на List <opportunityProduct>()
       // if(incIds.isEmpty() || incIds = null) return new List <opportunityProduct>();
        //rework
        Boolean                   isDataIsOpportunites = false;
        Boolean                   isDataIsQuote        = false;

        Set<Id>                   productScopeIds      = new Set<Id>();

        for(Id incId : incIds) {
            if(incId.getSobjectType().getDescribe().getLabel() == 'Opportunity') { 
                isDataIsOpportunites = true;
            }

            if(incId.getSobjectType().getDescribe().getLabel() == 'Quote') { 
                isDataIsQuote = true;
            }

            if(isDataIsOpportunites && isDataIsQuote) {break;}  
        }

        Map<Id, Set<Id>> productScope = getProductsIds(
            collectDataFromOrg(incomeIds, isOpportunityProductsQueryNeeded, isQuoteProductsQueryNeeded)
        );


    }

    private static Map<Id, Set<Id>> getProductsIds(List<SObject> lineItems) {
        if(lineItems.isEmpty()) {
            return new Map<Id, Set<Id>>();
        }

        Map<Id, Set<Id>> productIdsMap = new Map<Id, Set<Id>>();
        String           typeOfItem;

        for(SObject lineItem : lineItems) {
            if (String.isBlank(typeOfItem)) {typeOfItem = lineItem.getSObjectType().getDescribe().getName();}

            Id product2Id               = (Id) lineItem.get('Product2Id');
            Id lineItemRelatedObjectId  = (Id) lineItem.get(
                typeOfItem == 'OpportunityLineItem'
                ? 'OpportunityId'
                : 'QuoteId'
            );

            if (productIdsMap.containsKey(lineItemRelatedObjectId)) {
                productIdsMap.get(lineItemRelatedObjectId).add(product2Id);
            } else {
                productIdsMap.put(lineItemRelatedObjectId, new Set<Id>{product2Id});
            }

        }

        return productIdsMap;
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
