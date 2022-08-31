/**
 * @author paulk@nebulaconsulting.co.uk
 * @date 31/08/2022
 * @description (if required)
 */
@IsTest
private class ExampleTransform {

    @IsTest
    static void failsToInsert() {
        String input = '{"company" : "Company","numberField" : 10000000000,"lastName" : "Last Name"}';

        nebc.Transformation leadTransform = new nebc.Transformation('Lead', Lead.class);

        Savepoint sp = Database.setSavepoint();

        Lead newLead = (Lead) leadTransform.call(JSON.deserializeUntyped(input));

        insert newLead;

        System.assertNotEquals(null, newLead.Id);

        Database.rollback(sp);
    }

    @IsTest
    static void insertsSuccess() {
        String input = '{"company" : "Company","numberField" : 10000000000.0,"lastName" : "Last Name"}';

        nebc.Transformation leadTransform = new nebc.Transformation('Lead', Lead.class);

        Savepoint sp = Database.setSavepoint();

        Lead newLead = (Lead) leadTransform.call(JSON.deserializeUntyped(input));

        insert newLead;

        System.assertNotEquals(null, newLead.Id);

        Database.rollback(sp);
    }

    @IsTest
    static void maxIntegerSucceeds() {
        String input = '{"company" : "Company","numberField" : 2147483647,"lastName" : "Last Name"}';

        nebc.Transformation leadTransform = new nebc.Transformation('Lead', Lead.class);

        Savepoint sp = Database.setSavepoint();

        Lead newLead = (Lead) leadTransform.call(JSON.deserializeUntyped(input));

        insert newLead;

        System.assertNotEquals(null, newLead.Id);

        Database.rollback(sp);
    }

    @IsTest
    static void maxIntegerAddOneFails() {
        String input = '{"company" : "Company","numberField" : 2147483648,"lastName" : "Last Name"}';

        nebc.Transformation leadTransform = new nebc.Transformation('Lead', Lead.class);

        Savepoint sp = Database.setSavepoint();

        Lead newLead = (Lead) leadTransform.call(JSON.deserializeUntyped(input));

        insert newLead;

        System.assertNotEquals(null, newLead.Id);

        Database.rollback(sp);
    }


}