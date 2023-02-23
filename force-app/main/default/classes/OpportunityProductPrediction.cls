public with sharing class OpportunityProductPrediction {

    public Id                       initSObjectId;
    public Decimal                  percentage;
    public Map<Id, Recommendation>  recommendations = new Map<Id, Recommendation>();

    public class Recommendation {
        public Id       recommendedProductId;
        public String   recommendedProductName;
        public Id       pricebookEntryId;
        public Decimal  quantity;
        public Decimal  totalPrice;
    }
}
