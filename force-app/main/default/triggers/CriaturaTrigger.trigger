trigger CriaturaTrigger on Criatura__c (after insert, after update) {

    //Identificar os Bunkers
    Map<Id, Bunker__c> bunkersUpdateMap = new Map<Id, Bunker__c>();
    for (Criatura__c criatura : Trigger.new) {
        Criatura__c nova = criatura;
        Criatura__c antiga = Trigger.oldMap.get(nova.Id);
        
        bunkersUpdateMap.put(criatura.Bunker__c, new Bunker__c(Id = criatura.Bunker__c));
    }
    
    for (Criatura__c criatura : Trigger.old) {
        if (Trigger.isDelete && criatura.Bunker__c != null) {
            bunkersUpdateMap.put(criatura.Bunker__c, new Bunker__c(Id = criatura.Bunker__c));
        }
    }
    
    System.debug(bunkersUpdateMap);
    
    List<Bunker__c> bunkersList = [SELECT Id, (SELECT Id FROM Criaturas__r) FROM Bunker__c WHERE Id in :bunkersUpdateMap.keySet()];
    
    for (Bunker__c bunker : bunkersList) {
        bunkersUpdateMap.get(bunker.Id).Populacao__c = bunker.Criaturas__r.size();
    }
    
    update bunkersUpdateMap.values();
}