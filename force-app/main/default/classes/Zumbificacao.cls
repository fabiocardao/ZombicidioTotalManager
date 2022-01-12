public class Zumbificacao {

    @InvocableMethod(label = 'Transforma Zumbi')
    public static void zumbificar(List<Id> ids) {
        List<Criatura__c> criaturas = [SELECT id, Bunker__r.Name, (SELECT id FROM RecursosCriatura__r) FROM Criatura__c WHERE Id IN :ids];
        List<RecursoCriatura__c> recursosCriaturaDelete = new List<RecursoCriatura__c>();
        
        for (Criatura__c criatura : criaturas) {
            String tipoZumbi = '';
            Integer rand = Math.mod(Integer.valueOf(Math.random() * 100000), 100);
            
            if (rand < 50) {
                tipoZumbi = 'Lerdo';
            } else if (rand < 80) {
                tipoZumbi = 'Rápido';
            } else {
                tipoZumbi = 'Gordo';
            }   
            
            criatura.TipoZumbi__c = tipoZumbi;
            recursosCriaturaDelete.addAll(criatura.RecursosCriatura__r);
        }
        
        update criaturas;
        delete recursosCriaturaDelete;
    }
    
}