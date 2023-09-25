import ballerina/grpc;
import ballerina/protobuf;

public const string FACULTY_DESC = "0A0D466163756C74792E70726F746F1207666163756C747922670A06436F75727365121F0A0B636F757273655F6E616D65180120012809520A636F757273654E616D65121F0A0B636F757273655F636F6465180220012809520A636F75727365436F6465121B0A096E71665F6C6576656C18032001280552086E71664C6576656C22BF010A084C6563747572657212210A0C73746166665F6E756D626572180120012805520B73746166664E756D62657212230A0D6F66666963655F6E756D626572180220012805520C6F66666963654E756D626572121D0A0A73746166665F6E616D65180320012809520973746166664E616D6512140A057469746C6518042001280952057469746C6512360A0E636F75727365735F74617567687418052003280B320F2E666163756C74792E436F75727365520D636F757273657354617567687422430A124164644C6563747572657252657175657374122D0A086C6563747572657218012001280B32112E666163756C74792E4C6563747572657252086C6563747572657222440A134164644C65637475726572526573706F6E7365122D0A086C6563747572657218012001280B32112E666163756C74792E4C6563747572657252086C6563747572657222160A144C6973744C65637475726572735265717565737422480A154C6973744C6563747572657273526573706F6E7365122F0A096C656374757265727318012003280B32112E666163756C74792E4C6563747572657252096C656374757265727322690A155570646174654C656374757265725265717565737412210A0C73746166665F6E756D626572180120012805520B73746166664E756D626572122D0A086C6563747572657218022001280B32112E666163756C74792E4C6563747572657252086C6563747572657222470A165570646174654C65637475726572526573706F6E7365122D0A086C6563747572657218012001280B32112E666163756C74792E4C6563747572657252086C6563747572657222370A124765744C656374757265725265717565737412210A0C73746166665F6E756D626572180120012805520B73746166664E756D62657222440A134765744C65637475726572526573706F6E7365122D0A086C6563747572657218012001280B32112E666163756C74792E4C6563747572657252086C65637475726572223A0A1544656C6574654C656374757265725265717565737412210A0C73746166665F6E756D626572180120012805520B73746166664E756D62657222180A1644656C6574654C65637475726572526573706F6E7365223E0A1B4765744C65637475726572734279436F7572736552657175657374121F0A0B636F757273655F636F6465180120012809520A636F75727365436F6465224F0A1C4765744C65637475726572734279436F75727365526573706F6E7365122F0A096C656374757265727318012003280B32112E666163756C74792E4C6563747572657252096C656374757265727322420A1B4765744C656374757265727342794F66666963655265717565737412230A0D6F66666963655F6E756D626572180120012805520C6F66666963654E756D626572224F0A1C4765744C656374757265727342794F6666696365526573706F6E7365122F0A096C656374757265727318012003280B32112E666163756C74792E4C6563747572657252096C656374757265727332E4040A0E466163756C74795365727669636512480A0B4164644C65637475726572121B2E666163756C74792E4164644C65637475726572526571756573741A1C2E666163756C74792E4164644C65637475726572526573706F6E7365124E0A0D4C6973744C6563747572657273121D2E666163756C74792E4C6973744C6563747572657273526571756573741A1E2E666163756C74792E4C6973744C6563747572657273526573706F6E736512510A0E5570646174654C65637475726572121E2E666163756C74792E5570646174654C65637475726572526571756573741A1F2E666163756C74792E5570646174654C65637475726572526573706F6E736512480A0B4765744C65637475726572121B2E666163756C74792E4765744C65637475726572526571756573741A1C2E666163756C74792E4765744C65637475726572526573706F6E736512510A0E44656C6574654C65637475726572121E2E666163756C74792E44656C6574654C65637475726572526571756573741A1F2E666163756C74792E44656C6574654C65637475726572526573706F6E736512630A144765744C65637475726572734279436F7572736512242E666163756C74792E4765744C65637475726572734279436F75727365526571756573741A252E666163756C74792E4765744C65637475726572734279436F75727365526573706F6E736512630A144765744C656374757265727342794F666669636512242E666163756C74792E4765744C656374757265727342794F6666696365526571756573741A252E666163756C74792E4765744C656374757265727342794F6666696365526573706F6E7365620670726F746F33";

public isolated client class FacultyServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, FACULTY_DESC);
    }

    isolated remote function AddLecturer(AddLecturerRequest|ContextAddLecturerRequest req) returns AddLecturerResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddLecturerRequest message;
        if req is ContextAddLecturerRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("faculty.FacultyService/AddLecturer", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <AddLecturerResponse>result;
    }

    isolated remote function AddLecturerContext(AddLecturerRequest|ContextAddLecturerRequest req) returns ContextAddLecturerResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddLecturerRequest message;
        if req is ContextAddLecturerRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("faculty.FacultyService/AddLecturer", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <AddLecturerResponse>result, headers: respHeaders};
    }

    isolated remote function ListLecturers(ListLecturersRequest|ContextListLecturersRequest req) returns ListLecturersResponse|grpc:Error {
        map<string|string[]> headers = {};
        ListLecturersRequest message;
        if req is ContextListLecturersRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("faculty.FacultyService/ListLecturers", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ListLecturersResponse>result;
    }

    isolated remote function ListLecturersContext(ListLecturersRequest|ContextListLecturersRequest req) returns ContextListLecturersResponse|grpc:Error {
        map<string|string[]> headers = {};
        ListLecturersRequest message;
        if req is ContextListLecturersRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("faculty.FacultyService/ListLecturers", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ListLecturersResponse>result, headers: respHeaders};
    }

    isolated remote function UpdateLecturer(UpdateLecturerRequest|ContextUpdateLecturerRequest req) returns UpdateLecturerResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateLecturerRequest message;
        if req is ContextUpdateLecturerRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("faculty.FacultyService/UpdateLecturer", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <UpdateLecturerResponse>result;
    }

    isolated remote function UpdateLecturerContext(UpdateLecturerRequest|ContextUpdateLecturerRequest req) returns ContextUpdateLecturerResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateLecturerRequest message;
        if req is ContextUpdateLecturerRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("faculty.FacultyService/UpdateLecturer", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <UpdateLecturerResponse>result, headers: respHeaders};
    }

    isolated remote function GetLecturer(GetLecturerRequest|ContextGetLecturerRequest req) returns GetLecturerResponse|grpc:Error {
        map<string|string[]> headers = {};
        GetLecturerRequest message;
        if req is ContextGetLecturerRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("faculty.FacultyService/GetLecturer", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <GetLecturerResponse>result;
    }

    isolated remote function GetLecturerContext(GetLecturerRequest|ContextGetLecturerRequest req) returns ContextGetLecturerResponse|grpc:Error {
        map<string|string[]> headers = {};
        GetLecturerRequest message;
        if req is ContextGetLecturerRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("faculty.FacultyService/GetLecturer", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <GetLecturerResponse>result, headers: respHeaders};
    }

    isolated remote function DeleteLecturer(DeleteLecturerRequest|ContextDeleteLecturerRequest req) returns DeleteLecturerResponse|grpc:Error {
        map<string|string[]> headers = {};
        DeleteLecturerRequest message;
        if req is ContextDeleteLecturerRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("faculty.FacultyService/DeleteLecturer", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <DeleteLecturerResponse>result;
    }

    isolated remote function DeleteLecturerContext(DeleteLecturerRequest|ContextDeleteLecturerRequest req) returns ContextDeleteLecturerResponse|grpc:Error {
        map<string|string[]> headers = {};
        DeleteLecturerRequest message;
        if req is ContextDeleteLecturerRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("faculty.FacultyService/DeleteLecturer", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <DeleteLecturerResponse>result, headers: respHeaders};
    }

    isolated remote function GetLecturersByCourse(GetLecturersByCourseRequest|ContextGetLecturersByCourseRequest req) returns GetLecturersByCourseResponse|grpc:Error {
        map<string|string[]> headers = {};
        GetLecturersByCourseRequest message;
        if req is ContextGetLecturersByCourseRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("faculty.FacultyService/GetLecturersByCourse", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <GetLecturersByCourseResponse>result;
    }

    isolated remote function GetLecturersByCourseContext(GetLecturersByCourseRequest|ContextGetLecturersByCourseRequest req) returns ContextGetLecturersByCourseResponse|grpc:Error {
        map<string|string[]> headers = {};
        GetLecturersByCourseRequest message;
        if req is ContextGetLecturersByCourseRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("faculty.FacultyService/GetLecturersByCourse", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <GetLecturersByCourseResponse>result, headers: respHeaders};
    }

    isolated remote function GetLecturersByOffice(GetLecturersByOfficeRequest|ContextGetLecturersByOfficeRequest req) returns GetLecturersByOfficeResponse|grpc:Error {
        map<string|string[]> headers = {};
        GetLecturersByOfficeRequest message;
        if req is ContextGetLecturersByOfficeRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("faculty.FacultyService/GetLecturersByOffice", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <GetLecturersByOfficeResponse>result;
    }

    isolated remote function GetLecturersByOfficeContext(GetLecturersByOfficeRequest|ContextGetLecturersByOfficeRequest req) returns ContextGetLecturersByOfficeResponse|grpc:Error {
        map<string|string[]> headers = {};
        GetLecturersByOfficeRequest message;
        if req is ContextGetLecturersByOfficeRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("faculty.FacultyService/GetLecturersByOffice", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <GetLecturersByOfficeResponse>result, headers: respHeaders};
    }
}

public type ContextDeleteLecturerResponse record {|
    DeleteLecturerResponse content;
    map<string|string[]> headers;
|};

public type ContextGetLecturerRequest record {|
    GetLecturerRequest content;
    map<string|string[]> headers;
|};

public type ContextAddLecturerRequest record {|
    AddLecturerRequest content;
    map<string|string[]> headers;
|};

public type ContextListLecturersRequest record {|
    ListLecturersRequest content;
    map<string|string[]> headers;
|};

public type ContextUpdateLecturerRequest record {|
    UpdateLecturerRequest content;
    map<string|string[]> headers;
|};

public type ContextDeleteLecturerRequest record {|
    DeleteLecturerRequest content;
    map<string|string[]> headers;
|};

public type ContextGetLecturersByCourseResponse record {|
    GetLecturersByCourseResponse content;
    map<string|string[]> headers;
|};

public type ContextGetLecturersByOfficeRequest record {|
    GetLecturersByOfficeRequest content;
    map<string|string[]> headers;
|};

public type ContextUpdateLecturerResponse record {|
    UpdateLecturerResponse content;
    map<string|string[]> headers;
|};

public type ContextGetLecturersByOfficeResponse record {|
    GetLecturersByOfficeResponse content;
    map<string|string[]> headers;
|};

public type ContextGetLecturerResponse record {|
    GetLecturerResponse content;
    map<string|string[]> headers;
|};

public type ContextGetLecturersByCourseRequest record {|
    GetLecturersByCourseRequest content;
    map<string|string[]> headers;
|};

public type ContextAddLecturerResponse record {|
    AddLecturerResponse content;
    map<string|string[]> headers;
|};

public type ContextListLecturersResponse record {|
    ListLecturersResponse content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: FACULTY_DESC}
public type DeleteLecturerResponse record {|
|};

@protobuf:Descriptor {value: FACULTY_DESC}
public type Lecturer record {|
    int staff_number = 0;
    int office_number = 0;
    string staff_name = "";
    string title = "";
    Course[] courses_taught = [];
|};

@protobuf:Descriptor {value: FACULTY_DESC}
public type GetLecturerRequest record {|
    int staff_number = 0;
|};

@protobuf:Descriptor {value: FACULTY_DESC}
public type AddLecturerRequest record {|
    Lecturer lecturer = {};
|};

@protobuf:Descriptor {value: FACULTY_DESC}
public type ListLecturersRequest record {|
|};

@protobuf:Descriptor {value: FACULTY_DESC}
public type UpdateLecturerRequest record {|
    int staff_number = 0;
    Lecturer lecturer = {};
|};

@protobuf:Descriptor {value: FACULTY_DESC}
public type DeleteLecturerRequest record {|
    int staff_number = 0;
|};

@protobuf:Descriptor {value: FACULTY_DESC}
public type GetLecturersByCourseResponse record {|
    Lecturer[] lecturers = [];
|};

@protobuf:Descriptor {value: FACULTY_DESC}
public type GetLecturersByOfficeRequest record {|
    int office_number = 0;
|};

@protobuf:Descriptor {value: FACULTY_DESC}
public type UpdateLecturerResponse record {|
    Lecturer lecturer = {};
|};

@protobuf:Descriptor {value: FACULTY_DESC}
public type GetLecturersByOfficeResponse record {|
    Lecturer[] lecturers = [];
|};

@protobuf:Descriptor {value: FACULTY_DESC}
public type Course record {|
    string course_name = "";
    string course_code = "";
    int nqf_level = 0;
|};

@protobuf:Descriptor {value: FACULTY_DESC}
public type GetLecturerResponse record {|
    Lecturer lecturer = {};
|};

@protobuf:Descriptor {value: FACULTY_DESC}
public type GetLecturersByCourseRequest record {|
    string course_code = "";
|};

@protobuf:Descriptor {value: FACULTY_DESC}
public type AddLecturerResponse record {|
    Lecturer lecturer = {};
|};

@protobuf:Descriptor {value: FACULTY_DESC}
public type ListLecturersResponse record {|
    Lecturer[] lecturers = [];
|};

