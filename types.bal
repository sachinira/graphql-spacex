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
    //timestamp: timestamptz // scalar
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
    //timestamp: timestamptz //scalar
};

public type UsersMutationResponse record {
    int affected_rows;
    Users[] returning?;
}; 

public type Users record {
    string id?;
    string? name?;
    string? rocket?;
    string? twitter?;
    //timestamp: timestamptz! //scalar
};


public type UsersSetInput record {
    string id?;
    string? name?;
    string? rocket?;
    string? twitter?;
    //timestamp: timestamptz
};

public type UsersBoolExp record {
    (UsersBoolExp|())[]? _and?;
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
    //Distance diameter?;
    int? dry_mass_kg?;
    int? dry_mass_lb?;
    string? first_flight?;
    //DragonHeatShield heat_shield?;
    //Distance height_w_trunk?;
    string? id?;
    //Mass launch_payload_mass?;
    //Vol umelaunch_payload_vol?;
    string? name?;
    int? orbit_duration_yr?;
    //DragonPressurizedCapsule pressurized_capsule?;
    //Mass return_payload_mass?;
    //Volume return_payload_vol?;
    float? sidewall_angle_deg?;
    //DragonThrust[] thrusters?;
    //DragonTrunk trunk?;
    string? 'type?;
    string? wikipedia?;
};

type DragonArray Dragon[];
