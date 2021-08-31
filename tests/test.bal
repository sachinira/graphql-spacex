import ballerina/test;
import ballerina/log;

Client baseClient = check new Client("https://api.spacex.land/graphql/");
Client swClient = check new Client("https://swapi-graphql.netlify.app/.netlify/functions/index");

@test:Config {}
function  insertUser() returns error? {

    string insertUserString = string `mutation ($objects: [users_insert_input!]!) {
                                insert_users(objects: $objects) {
                                    affected_rows
                                }
                            }`;

    UsersMutationResponse|error? bEvent = check baseClient->insertUser(insertUserString, [{name: "Sachi"}]);

    if (bEvent is UsersMutationResponse) {
        log:printInfo(bEvent.toString());
    } else {
        test:assertFail();
    }
}

@test:Config {}
function  updateUser() returns error? {

    string updateUserString = string `mutation ($where: users_bool_exp!, $_set: users_set_input) {
                                        update_users(where: $where, _set: $_set) {
                                            affected_rows
                                            returning {
                                                name
                                            }
                                        }
                                    }`;
  
    UsersBoolExp 'where = {
        id: {
            _eq: "89b9d27d-dd79-48d9-a251-16e188c0720d"
        }
    };

    UsersSetInput set = {
        name: "Sachini"
    };

    UsersMutationResponse|error? bEvent = check baseClient->updateUser(updateUserString, 'where , set);

    if (bEvent is UsersMutationResponse) {
        log:printInfo(bEvent.toString());
    } else {
        test:assertFail();
    }
}

@test:Config {}
function  deleteUser() returns error? {

    string updateUserString = string `mutation ($where: users_bool_exp!) {
                                        delete_users(where: $where) {
                                            affected_rows
                                        }
                                    }`;
                                        
    UsersBoolExp 'where = {
        id: {
            _eq: "89b9d27d-dd79-48d9-a251-16e188c0720d"
        }
    };

    UsersMutationResponse|error? bEvent = check baseClient->deleteUser(updateUserString, 'where);

    if (bEvent is UsersMutationResponse) {
        log:printInfo(bEvent.toString());
    } else {
        test:assertFail();
    }
}

@test:Config {}
function  getDragon() returns error? {

    string dragonString = string `query ($id: ID!) {
                                    dragon (id: $id) {
                                        name
                                        active
                                    }
                                }`;
    string id = "";
    Dragon|error? bEvent = check baseClient->getDragon(dragonString, id);

    if (bEvent is Dragon) {
        log:printInfo(bEvent.toString());
    } else {
        test:assertFail();
    }
}

@test:Config {}
function  getDragons() returns error? {

    string dragonString = string `query ($limit: Int, $offset: Int) {
                                    dragons (limit: $limit, offset: $offset) {
                                        name
                                        active
                                    }
                                }`;
    int 'limit = 1;
    int offset = 2;
    Dragon?[]|error? bEvent = check baseClient->getDragons(dragonString, (), offset);

    if (bEvent is Dragon?[]) {
        log:printInfo(bEvent.toString());
    } else {
        test:assertFail();
    }
}

@test:Config {}
function  testScene1() returns error? {

    //InlineFragments - Interfaces

    string inlineString = string `query {
            film(filmID: 1) {
                ...on Film {
                title
                director
                }
                ...on Node {
                id
                }
            }
        }`;

    QueryResponse|error? bEvent = check swClient->query(inlineString);

    if (bEvent is QueryResponse) {
        log:printInfo(bEvent.toString());
    } else {
        test:assertFail();
    }
}

@test:Config {}
function  testScene2() returns error? {

    //InlineFragments - Union types

    string inlineString = string `query {
            film(filmID: 1) {
                ...on Film {
                title
                director
                }
                ...on Node {
                id
                }
            }
        }`;

    QueryResponse|error? bEvent = check baseClient->query(inlineString);

    if (bEvent is QueryResponse) {
        log:printInfo(bEvent.toString());
    } else {
        test:assertFail();
    }
}

@test:Config {}
function  testScene3() returns error? {

    //Fragments
    string dragonString = string `fragment DraginInfo on Dragon {
                                    active
                                    name
                                      pressurized_capsule {
                                        payload_volume {
                                        cubic_meters
                                        }
                                    }
                                }

                                query ($id: ID!){
                                    dragon(id: $id) {
                                        ...DraginInfo
                                    }
                                }`;         

    Dragon|error? bEvent = check baseClient->getDragon(dragonString, "dragon2");

    if (bEvent is Dragon) {
        log:printInfo(bEvent.toString());
    } else {
        test:assertFail();
    }
}

@test:Config {}
function  testScene4() returns error? {

    map<string> vars = {
        id1: "dragon1",
        id2: "dragon2"
    };
    //Aliases - First level
    string dragonString = string `query ($id1: ID!, $id2: ID!) {  
                                    myinfo1: dragon(id: $id1) {
                                        name
                                    }

                                    myinfo2: dragon(id: $id2) {
                                        name
                                    }
                                }`;         

    QueryResponse|error? bEvent = check baseClient->query(dragonString, additionalVariables = vars);

    if (bEvent is QueryResponse) {
        log:printInfo(bEvent.toString());
    } else {
        test:assertFail();
    }
}

@test:Config {}
function  testScene5() returns error? {

    map<int> vars = {
        filmFilmId: 1,
        speciesConnectionFirst1: 1,
        speciesConnectionSecond2: 2
    };
    // This is querying from the swapi
    //Aliases - Internal levels
    string inlineString = string `query ($filmFilmId: ID, $speciesConnectionFirst: Int, $speciesConnectionSecond: Int) {
                                    film(filmID: $filmFilmId) {
                                        speciesset1: speciesConnection (first: $speciesConnectionFirst) {
                                            species {
                                                name
                                            }
                                        }

                                        speciesset2: speciesConnection (first: $speciesConnectionSecond) {
                                            species {
                                                name
                                            }
                                        }
                                    }
                                }`;

    QueryResponse|error? bEvent = check swClient->query(inlineString, additionalVariables = vars);

    if (bEvent is QueryResponse) {
        log:printInfo(bEvent.toString());
    } else {
        test:assertFail();
    }
}

@test:Config {}
function  exampleQuery() returns error? {

    string rockets = string `query {
                                rockets {
                                    active
                                    name
                                }
                            }`;

    QueryResponse|error? bEvent = check baseClient->query(rockets);

    if (bEvent is QueryResponse) {
        log:printInfo(bEvent.toString());
    } else {
        test:assertFail();
    }
}

@test:Config {}
function  exampleMutation() returns error? {

    string insertUserString = string `mutation ($objects: [users_insert_input!]!) {
                                insert_users(objects: $objects) {
                                    affected_rows
                                }
                            }`;

    UserInsertInput[] objects = 
        [
            {name: "Sachi"},
            {name: "Hiruni"}    
            
        ];

    MutationResponse|error? bEvent = check baseClient->mutation(insertUserString, objects);

    if (bEvent is MutationResponse) {
        log:printInfo(bEvent.toString());
    } else {
        test:assertFail();
    }
} 
