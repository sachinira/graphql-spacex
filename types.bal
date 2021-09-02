type ObjectParameters record {|
    string query;
    json? variables;
|};

public type InsertUserVariables record {|
    UserInsertInput[] objects;
    UsersOnConflict? on_conflict = ();
|};

public type UserInsertInput record {
    string id?;
    string name?;
    string rocket?;
    string twitter?;
};

public type UsersOnConflict record {
    UsersConstraint constraint;
    UsersUpdateInput update_columns;
};

public type UsersConstraint record {
    string users_pkey?;
};

public type UsersUpdateInput record {
    string id?;
    string name?;
    string rocket?;
    string twitter?;
    string timestamp?; //scalar
};

public type UsersMutationResponse record {
    int affected_rows;
    Users[]? returning?;
};

public type UsersDeleteData record {
   UsersMutationResponse? delete_users?;
};

public type UsersUpdateData record {
   UsersMutationResponse? update_users?;
};

public type UsersInsertData record {
   UsersMutationResponse? insert_users?;
};

public type UsersDeleteResponse record {
    UsersDeleteData? data?;
    Error[]? errors?;
    record {}? extensions?;
}; 

public type UsersInsertResponse record {
    UsersInsertData? data?;
    Error[]? errors?;
    record {}? extensions?;
}; 

public type UserUpdateResponse record {
    UsersUpdateData? data?;
    Error[]? errors?;
    record {}? extensions?;
}; 

public type Error record {
    string message;
    Location[]? locations?;
    record {}? extensions?;
};

public type Location record {
    int line?;
    int column?;
};

public type Users record {
    string id?;
    string? name?;
    string? rocket?;
    string? twitter?;
    string timestamp?;
};

public type UsersSetInput record {
    string id?;
    string? name?;
    string? rocket?;
    string? twitter?;
    string timestamp?;
};

public type UsersBoolExp record {
    UsersBoolExp?[]? _and?;
    UsersBoolExp? _not?;
    UsersBoolExp[]? _or?;
    UuidComparisonExp? id?;
    StringComparisonExp? name?;
    StringComparisonExp? rocket?;
    //TimestampzComparisonExp? timestamp?; //contain the timestamptz scalar type
    StringComparisonExp? twitter?;
};

public type UuidComparisonExp record {
    string? _eq?;
    string? _gt?;
    string? _gte?;
    string[]? _in?;
    boolean? _is_null?;
    string? _lt?;
    string? _lte?;
    string? _neq?;
    string[]? _nin?;
};

public type StringComparisonExp record {
    string? _eq?;
    string? _gt?;
    string? _gte?;
    string? _ilike?;
    string[]? _in?;
    boolean? _is_null?;
    string? _like?;
    string? _lt?;
    string? _lte?;
    string? _neq?;
    string? _nilike?;
    string[]? _nin?;
    string? _nlike?;
    string? _nsimilar?;
    string? _similar?;
};

public type Dragon record {
    boolean? active?;
    int? crew_capacity?;
    string? description?;
    Distance diameter?;
    int? dry_mass_kg?;
    int? dry_mass_lb?;
    string? first_flight?;
    DragonHeatShield heat_shield?;
    Distance height_w_trunk?;
    string? id?;
    Mass launch_payload_mass?;
    Volume umelaunch_payload_vol?;
    string? name?;
    int? orbit_duration_yr?;
    DragonPressurizedCapsule pressurized_capsule?;
    Mass return_payload_mass?;
    Volume return_payload_vol?;
    float? sidewall_angle_deg?;
    DragonThrust[] thrusters?;
    DragonTrunk trunk?;
    string? 'type?;
    string? wikipedia?;
};

public type DragonResponse record {
    DragonData? data?;
    Error[]? errors?;
    record {}? extensions?;
}; 

public type DragonData record {
    Dragon? dragon?;
};

public type DragonsResponse record {
    DragonsData data?;
    Error[]? errors?;
    record {}? extensions?;
}; 

public type DragonsData record {
    Dragon?[]? dragons?;
};

public type Distance record {
    float? feet?;
    float? meters?;
};

public type DragonHeatShield record {
    string? dev_partner?;
    string? material?;
    float? size_meters?;
    int? temp_degrees?;
};

public type Mass record {
    int? kg?;
    int? lb?;
};

public type Volume record {
    int? cubic_feet?;
    int? cubic_meters?;
};

public type DragonPressurizedCapsule record {
    Volume? paylod_volume?;
};

public type DragonThrust record {
    int? amount?;
    string? fuel_1?;
    string? fuel_2?;
    int? pods?;
    Force? thrust?;
    string? 'type?;
};

public type Force record {
    float? kN?;
    float? lbf?;
};

public type DragonTrunk record {
    DragonTrunkCargo? cargo?;
    Volume? trunk_volume?;
};

public type DragonTrunkCargo record {
    int? solar_array?;
    boolean? unpressurized_cargo?;
};

public type DragonArray Dragon?[];

public type MutationData record {
   UsersMutationResponse? insert_users?;
   UsersMutationResponse? delete_users?;
   UsersMutationResponse? update_users?;
};

public type MutationResponse record {
    MutationData? data?;
    Error[]? errors?;
    record {}? extensions?;
};

public type QueryData record {
    Dragon? dragon?;
    Dragon?[]? dragons?;
};

public type QueryResponse record {
    MutationData? data?;
    Error[]? errors?;
    record {}? extensions?;
};
