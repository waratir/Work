public with sharing class ConnectWithExactonline{

    public void getExactonline() {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Exactonline_Test/api/v1/2844363/crm/Accounts');
        request.setHeader('Accept','application/json');
        request.setMethod('GET');
        Http http = new Http();
        HttpResponse res = http.send(request);
        System.debug(res.getBody());
    }

    public void postSObjectToExactOnline(SObject record) {
        Map<String, Object> objectMap = new Map<String, Object>( record.getPopulatedFieldsAsMap() );
        objectMap.remove('Id');
//        List<Map<String, Object>> listMaps = new List<Map<String, Object>>();
//        for (SObject rec: records){
//            listMaps.add(new Map<String, Object>(rec.getPopulatedFieldsAsMap()));
//        }
//        for (Map<String, Object> maps: listMaps){
//            maps.remove('Id');
//        }

        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Exactonline_Test/api/v1/2844363/crm/Accounts');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', '');

        request.setBody(JSON.serialize(objectMap));
//        request.setBody('{"Name":"VRP111"}');

        System.debug(JSON.serialize(objectMap));
        request.setMethod('POST');
        Http http = new Http();
        HttpResponse response = http.send(request);

        if (response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        } else {
            Dom.Document doc = response.getBodyDocument();

            //Retrieve the root element for this document.
            //            Dom.XmlNode fix = address.getChildElement('entry',  null);
//            System.debug('entry' + fix);

            Dom.XmlNode address = doc.getRootElement();
            Dom.XmlNode get1 = address.getChildElement('content',  null);
            Dom.XmlNode get2 = get1.getChildElement('m:properties',  null);
            String AccId = get2.getChildElement('d:ID', null).getText();
//            Dom.XmlNode hfhf = gfgf.getChildElement('properties',  null);
//            System.debug('properties' + hfhf);
//            Dom.XmlNode dataele= address.getChildElement('content',null);
//            Dom.XmlNode rere= dataele.getChildElement('m',null);

//            String Id = rere.getChildElement('d', 'ID').getText();
//            System.debug(Id);
        }
    }

}