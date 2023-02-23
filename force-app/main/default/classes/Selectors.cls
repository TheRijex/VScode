public with sharing class Selectors {
        public static List<OpportunityLineItem> getOpportunityLineItemsFromIds(Set<Id> inIds) {
        return [
            SELECT Id, OpportunityId, PricebookEntryId, Product2Id, Quantity, TotalPrice
            FROM OpportunityLineItem
            WHERE OpportunityId IN :inIds
            WITH SECURITY_ENFORCED
        ];
    }

    public static List<QuoteLineItem> getQuoteLineItemsByQuoteId(Set<Id> inIds) {
        return [
            SELECT Id, QuoteId, PricebookEntryId, Quantity, Product2Id, TotalPrice
            FROM QuoteLineItem
            WHERE QuoteId IN :inIds
            WITH SECURITY_ENFORCED
        ];
    }

}
