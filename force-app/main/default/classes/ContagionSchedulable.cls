global class ContagionSchedulable implements Schedulable {

    global void execute(SchedulableContext SC) {
        this.contagiar();
    }
    
    private void contagiar() {
        List<Criatura__c> humanList = [SELECT id, Criatura__c.RecordTypeId, Bunker__r.DefesaBunker__c, Bunker__c, (SELECT id, AcrescimoDefesa__c FROM RecursosCriatura__r) FROM Criatura__c WHERE RecordTypeId = '0125f000000Zia5AAC'];
        List<Criatura__c> zombieList = [SELECT id FROM Criatura__c WHERE RecordTypeId = '0125f000000ZiaAAAS'];
        
        for (Criatura__c criatura : zombieList) {
            if (!humanList.isEmpty()) {
                Criatura__c hmn1 = humanList.get(Math.mod(Integer.valueOf(Math.random() * 1000), humanList.size()));
                
                Decimal defesa = 0;
                if (hmn1.RecordTypeId != '0125f000000ZiaAAAS') {                    
                    if (hmn1.Bunker__c != null) {
                        defesa += hmn1.Bunker__r.DefesaBunker__c;
                    }
                }
                
                if (hmn1.RecursosCriatura__r != null) {
                    for (RecursoCriatura__c recursoCriatura : hmn1.RecursosCriatura__r) {
                        defesa += recursoCriatura.AcrescimoDefesa__c;
                    }
                }
                
                Integer diceRoll = Math.mod(Integer.valueOf(Math.random() * 100000), 100) + 1;
                if (diceRoll > defesa) {
                    hmn1.RecordTypeId = '0125f000000ZiaAAAS';
                    hmn1.DataZumbificacao__c = Date.today();
                }
				defesa = 0;
				                
                Criatura__c hmn2 = humanList.get(Math.mod(Integer.valueOf(Math.random() * 1000), humanList.size()));
                if (hmn2.RecordTypeId != '0125f000000ZiaAAAS') {                    
                    if (hmn2.Bunker__c != null) {
                        defesa += hmn2.Bunker__r.DefesaBunker__c;
                    }
                }
                
                if (hmn2.RecursosCriatura__r != null) {
                    for (RecursoCriatura__c recursoCriatura : hmn2.RecursosCriatura__r) {
                        defesa += recursoCriatura.AcrescimoDefesa__c;
                    }
                }
                
                Integer diceRoll2 = Math.mod(Integer.valueOf(Math.random() * 100000), 100) + 1;
                if (diceRoll > defesa) {
                    hmn2.RecordTypeId = '0125f000000ZiaAAAS';
                    hmn2.DataZumbificacao__c = Date.today();
                }
            }
        }
        
        update humanList;
    }
    
}