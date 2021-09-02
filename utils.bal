isolated function getRequestPayload(string query, map<anydata> definedVariables, map<anydata>? additionalVaribales = ()) 
                                    returns json|error {
    json varaibales = definedVariables.toJson();
    if (additionalVaribales != ()) {
        varaibales = check varaibales.mergeJson(definedVariables.toJson());
    }
    json graphqlPayload = {
        query: query,
        variables: varaibales
    };
    return graphqlPayload;
}