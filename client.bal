import ballerina/http;

public isolated client class Client {
    final http:Client clientEp;
    
    public isolated function init(string serviceUrl, http:ClientConfiguration clientConfig =  {}) returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
    }

    //Generic function. Can use for every mutation and query scenario
    remote isolated function mutation(string query, UserInsertInput[]? objects = (), UsersOnConflict? on_conflict = (), 
                                      UsersBoolExp? updateUserWhere = (), UsersSetInput? _set = (), 
                                      UsersBoolExp? deleteUserWhere = (), map<anydata>? additionalVariables = ()) 
                                      returns MutationResponse|error {
        http:Request request = new;
        map<anydata> definedVaribale = {"objects" : objects, "on_conflict" : on_conflict, 
            "updateUserWhere" : updateUserWhere, "_set" : _set, "deleteUserWhere" : deleteUserWhere, 
            "additionalVariables" : additionalVariables };
        json graphQlPayload = check getRequestPayload(query, definedVaribale, additionalVariables);
        request.setPayload(graphQlPayload);        
        return check self.clientEp-> post("", request, targetType = MutationResponse);
    }

    remote isolated function query(string query, string? id = (), int? 'limit = (), int? offset = (), 
                                   map<anydata>? additionalVariables = ()) returns QueryResponse|error {
        http:Request request = new;
        map<anydata> definedVaribale = {"id" : id, "limit" : 'limit, "offset" : offset};
        json graphQlPayload = check getRequestPayload(query, definedVaribale, additionalVariables);
        request.setPayload(graphQlPayload);         
        return check self.clientEp-> post("", request, targetType = QueryResponse);
    }

    // Mutations
    remote isolated function insertUser(string query, UserInsertInput[] objects, UsersOnConflict? on_conflict = ()) 
                                        returns UsersInsertResponse|error {
        http:Request request = new;
        map<anydata> variables = { "objects" : objects, "on_conflict" : on_conflict };
        json graphQlPayload = check getRequestPayload(query, variables);
        request.setPayload(graphQlPayload);         
        return check self.clientEp-> post("", request, targetType = UsersInsertResponse);
    }

    remote isolated function updateUser(string query, UsersBoolExp 'where, UsersSetInput? _set = ()) 
                                        returns UserUpdateResponse|error {
        http:Request request = new;
        map<anydata> variables = { "where" : 'where, "_set" : _set };        
        json graphQlPayload = check getRequestPayload(query, variables);
        request.setPayload(graphQlPayload);         
        return check self.clientEp-> post("", request, targetType = UserUpdateResponse);
    }

    remote isolated function deleteUser(string query, UsersBoolExp 'where) returns UsersDeleteResponse|error {
        http:Request request = new;
        map<anydata> variables = { "where" : 'where };        
        json graphQlPayload = check getRequestPayload(query, variables);
        request.setPayload(graphQlPayload);         
        return check self.clientEp-> post("", request, targetType = UsersDeleteResponse);
    }

    // Queries
    remote isolated function getDragon(string query, string id) returns DragonResponse|error {
        http:Request request = new;      
        map<anydata> variables = { "id" : id };        
        json graphQlPayload = check getRequestPayload(query, variables);
        request.setPayload(graphQlPayload);         
        return check self.clientEp-> post("", request, targetType = DragonResponse);
    }

    remote isolated function getDragons(string query, int? 'limit = (), int? offset = ()) 
                                        returns DragonsResponse|error {
        http:Request request = new;      
        map<anydata> variables = { "limit" : 'limit, "offset" : offset };       
        json graphQlPayload = check getRequestPayload(query, variables);
        request.setPayload(graphQlPayload); 
        return check self.clientEp-> post("", request, targetType = DragonsResponse);
    }
}
