public with sharing class Selectors {
        public static List<OpportunityLineItem> getOpportunityLineItemsByOpportunityIds(Set<Id> incomeIds) {
        return [
            SELECT Id, OpportunityId, PricebookEntryId, Product2Id, Quantity, TotalPrice
            FROM OpportunityLineItem
            WHERE OpportunityId IN :incomeIds
            WITH SECURITY_ENFORCED
        ];
    }

}
