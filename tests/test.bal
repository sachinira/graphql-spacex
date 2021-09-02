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

    UsersInsertResponse bEvent = check baseClient->insertUser(insertUserString, [{name: "Sachi"}]);
    log:printInfo(bEvent.toString());
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

    UserUpdateResponse bEvent = check baseClient->updateUser(updateUserString, 'where , set);
    log:printInfo(bEvent.toString());
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

    UsersDeleteResponse bEvent = check baseClient->deleteUser(updateUserString, 'where);
    log:printInfo(bEvent.toString());
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
    Dragon bEvent = check baseClient->getDragon(dragonString, id);
    log:printInfo(bEvent.toString());
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
    DragonsResponse bEvent = check baseClient->getDragons(dragonString);
    log:printInfo(bEvent.toString());
}

// @test:Config {}
// function  testScene1() returns error? {

//     //InlineFragments - Interfaces

//     string inlineString = string `query {
//             film(filmID: 1) {
//                 ...on Film {
//                 title
//                 director
//                 }
//                 ...on Node {
//                 id
//                 }
//             }
//         }`;

//     QueryResponse|error? bEvent = check swClient->query(inlineString);

//     if (bEvent is QueryResponse) {
//         log:printInfo(bEvent.toString());
//     } else {
//         test:assertFail();
//     }
// }

// @test:Config {}
// function  testScene2() returns error? {

//     //InlineFragments - Union types

//     string inlineString = string `query {
//             film(filmID: 1) {
//                 ...on Film {
//                 title
//                 director
//                 }
//                 ...on Node {
//                 id
//                 }
//             }
//         }`;

//     QueryResponse|error? bEvent = check baseClient->query(inlineString);

//     if (bEvent is QueryResponse) {
//         log:printInfo(bEvent.toString());
//     } else {
//         test:assertFail();
//     }
// }

@test:Config {}
function  testScene1() returns error? {
    log:printInfo("Query with Fields");
    string dragonString = string `query {
                                    dragons {
                                        crew_capacity
                                        name
                                        type
                                        wikipedia
                                        description
                                    }
                                }`;         

    Dragon bEvent = check baseClient->getDragon(dragonString, "dragon2");
    log:printInfo(bEvent.toString());
}

@test:Config {}
function  testScene2() returns error? {
    log:printInfo("Query with Fields of different levels");
    string dragonString = string `query {
                                    dragons {
                                        name
                                        thrusters {
                                        amount
                                        fuel_1
                                        thrust {
                                            kN
                                        }
                                        }
                                    }
                                }`;         

    Dragon bEvent = check baseClient->getDragon(dragonString, "dragon2");
    log:printInfo(bEvent.toString());
}

@test:Config {}
function  testScene6() returns error? {
    log:printInfo("Query with arguments");
    string dragonString = string `query ($id: ID!) {
                                    dragon(id: $id) {
                                        name
                                        wikipedia
                                        type
                                        description
                                    }
                                }`;  
           
    Dragon bEvent = check baseClient->getDragon(dragonString, "dragon2");
    log:printInfo(bEvent.toString());
}

// log:printInfo("Query with arguments at different levels");

@test:Config {}
function  testScene4() returns error? {
    log:printInfo("Query with aliases in the first level");
    map<anydata> vars = {
        id1: "dragon1",
        id2: "dragon2"
    };
    string dragonString = string `query ($id1: ID!, $id2: ID!) {  
                                    myinfo1: dragon(id: $id1) {
                                        name
                                    }

                                    myinfo2: dragon(id: $id2) {
                                        name
                                    }
                                }`;         

    QueryResponse bEvent = check baseClient->query(dragonString, additionalVariables = vars);
    log:printInfo(bEvent.toString());
}

@test:Config {}
function testScene5() returns error? {
    log:printInfo("Query with aliases in the internal level");
    map<int> vars = {
        filmFilmId: 1,
        speciesConnectionFirst1: 1,
        speciesConnectionSecond2: 2
    };
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

    QueryResponse bEvent = check swClient->query(inlineString, additionalVariables = vars);
    log:printInfo(bEvent.toString());
}

// Fragments 
// Fragments are the primary unit of composition in GraphQL.
// Reuse of common repeated selections of fields
// Fragments cannot be specified on any input value (scalar, enumeration, or input object).
// Fragments can be specified on object types, interfaces, and unions.
@test:Config {}
function  testScene3() returns error? {
    log:printInfo("Query with fragments");
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

    Dragon bEvent = check baseClient->getDragon(dragonString, "dragon2");
    log:printInfo(bEvent.toString());

}

// ... is the spread operator. This can happen through multiple levels of fragment spreads (Nested fragments)
// log:printInfo("Query with nested fragments");


// Inline Fragments can be used directly within a selection to condition upon a type condition when querying against an interface or union
// This is done to conditionally include fields based on their runtime type. 
// log:printInfo("Query with inline fragments");

// Inline fragments may also be used to apply a directive to a group of fields.
// log:printInfo("Query with inline on a driective");
// query inlineFragmentNoType($expandedInfo: Boolean) {
//   user(handle: "zuck") {
//     id
//     name
//     ... @include(if: $expandedInfo) {
//       firstName
//       lastName
//       birthday
//     }
//   }
// }

// Providing null values
    // Explicitly providing the literal value: null.
    // Implicitly not providing a value at all.


// Using enums
// Enum values are represented as unquoted names (ex. MOBILE_WEB). It is recommended that Enum values be “all caps”. 
// log:printInfo("Query with enums as input type");
// query Query($usersOrderBy: [users_order_by!]) {
//   users(order_by: $usersOrderBy) {
//     id
//     name
//   }
// }

//Lists
// Lists as inputs
// Lists as returns

//Variables
// A GraphQL query can be parameterized with variables, maximizing query reuse, and avoiding costly string building in clients at runtime.
// Variables
// Default varibales
// Variables within fragments

// GraphQL describes the types of data expected by query variables. Input types may be lists of another input type,
// or a non‐null variant of any other input type.


@test:Config {}
function  exampleQuery() returns error? {

    string rockets = string `query {
                                rockets {
                                    active
                                    name
                                }
                            }`;

    QueryResponse bEvent = check baseClient->query(rockets);
    log:printInfo(bEvent.toString());
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

    MutationResponse bEvent = check baseClient->mutation(insertUserString, objects);
    log:printInfo(bEvent.toString());
} 

