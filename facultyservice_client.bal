
import ballerina/http;
import ballerina/io;
import ballerina/log;

// Define the lecturer data structure
type Lecturer record {
    string staffNumber;
    string name;
    string officeNumber;
    string courseCode;
};

// Create an in-memory store for lecturers
map<string, Lecturer> lecturerStore = {};

// Function to add a new lecturer
public function addLecturer(Lecturer newLecturer) returns error? {
    // Check if the lecturer already exists
    if (lecturerStore.hasKey(newLecturer.staffNumber)) {
        return error("Lecturer with staff number " + newLecturer.staffNumber + " already exists.");
    }

    // Add the new lecturer to the store
    lecturerStore[newLecturer.staffNumber] = newLecturer;
    log:printInfo("Lecturer added: " + newLecturer.staffNumber);
    return ();
}

// Function to retrieve a list of all lecturers
public function getAllLecturers() returns Lecturer[] {
    return lecturerStore.values();
}

// Function to update an existing lecturer's information by staff number
public function updateLecturerByStaffNumber(string staffNumber, Lecturer updatedLecturer) returns error? {
    // Check if the lecturer exists
    if (!lecturerStore.hasKey(staffNumber)) {
        return error("Lecturer with staff number " + staffNumber + " not found.");
    }

    // Update the lecturer's information
    lecturerStore[staffNumber] = updatedLecturer;
    log:printInfo("Lecturer updated: " + staffNumber);
    return ();
}

// Function to retrieve the details of a specific lecturer by their staff number
public function getLecturerByStaffNumber(string staffNumber) returns Lecturer? {
    return lecturerStore[staffNumber];
}

// Function to delete a lecturer's record by their staff number
public function deleteLecturerByStaffNumber(string staffNumber) returns error? {
    // Check if the lecturer exists
    if (!lecturerStore.hasKey(staffNumber)) {
        return error("Lecturer with staff number " + staffNumber + " not found.");
    }

    // Remove the lecturer from the store
    lecturerStore.remove(staffNumber);
    log:printInfo("Lecturer deleted: " + staffNumber);
    return ();
}

// Function to retrieve all the lecturers that teach a certain course
public function getLecturersByCourseCode(string courseCode) returns Lecturer[] {
    return lecturerStore.values().filter(function (Lecturer l) returns boolean {
        return l.courseCode == courseCode;
    });
}

// Function to start the HTTP service
public function startService() returns error? {
    http:Listener listener = new(9090);
    var ep = listener.createEndpoint("lecturerEndpoint");
    
    // Define service endpoints
    ep.addResource("/lecturers", getAllLecturers, ["GET"]);
    ep.addResource("/lecturers/<string:staffNumber>", updateLecturerByStaffNumber, ["PUT"]);
    ep.addResource("/lecturers/<string:staffNumber>", getLecturerByStaffNumber, ["GET"]);
    ep.addResource("/lecturers/<string:staffNumber>", deleteLecturerByStaffNumber, ["DELETE"]);
    ep.addResource("/lecturers/course/<string:courseCode>", getLecturersByCourseCode, ["GET"]);

    // Start the listener
    var result = listener.start();
    if (result is http:Error) {
        return result;
    }
    io:println("Lecturer Service started successfully.");
    return ();
}

// Entry point for the Ballerina program
public function main() {
    // Start the HTTP service
    var startErr = startService();
    if (startErr != null) {
        log:printError("Error starting the Lecturer Service: " + startErr.message());
    }

    // CLI menu for interacting with the service
    while (true) {
        io:println("Choose an option:");
        io:println("1) Add a new lecturer");
        io:println("2) Retrieve a list of all lecturers");
        io:println("3) Update an existing lecturer's information");
        io:println("4) Retrieve the details of a specific lecturer by their staff number");
        io:println("5) Delete a lecturer's record by their staff number");
        io:println("6) Retrieve all the lecturers that teach a certain course");
        io:println("7) Exit");

        string choice = io:readln();

        match choice {
            "1" => {
                io:println("Enter lecturer details:");
                string staffNumber = io:readln("Staff Number: ");
                string name = io:readln("Name: ");
                string officeNumber = io:readln("Office Number: ");
                string courseCode = io:readln("Course Code: ");

                Lecturer newLecturer = {staffNumber, name, officeNumber, courseCode};
                var addError = addLecturer(newLecturer);
                if (addError == null) {
                    io:println("Lecturer added successfully.");
                } else {
                    io:println("Error adding lecturer: " + addError.message());
                }
            }
            "2" => {
                io:println("List of all lecturers:");
                Lecturer[] lecturers = getAllLecturers();
                if (lengthof lecturers == 0) {
                    io:println("No lecturers found.");
                } else {
                    foreach var lecturer in lecturers {
                        io:println(lecturer);
                    }
                }
            }
            "3" => {
                string staffNumber = io:readln("Enter staff number of the lecturer to update: ");
                Lecturer? existingLecturer = getLecturerByStaffNumber(staffNumber);
                if (existingLecturer == null) {
                    io:println("Lecturer with staff number " + staffNumber + " not found.");
                } else {
                    io:println("Update lecturer details (leave empty to keep existing values):");
                    string name = io:readln("Name: ");
                    if (lengthof name > 0) {
                        existingLecturer.name = name;
                    }
                    string officeNumber = io:readln("Office Number: ");
                    if (lengthof officeNumber > 0) {
                        existingLecturer.officeNumber = officeNumber;
                    }
                    string courseCode = io:readln("Course Code: ");
                    if (lengthof courseCode > 0) {
                        existingLecturer.courseCode = courseCode;
                    }

                    var updateError = updateLecturerByStaffNumber(staffNumber, existingLecturer);
                    if (updateError == null) {
                        io:println("Lecturer updated successfully.");
                    } else {
                        io:println("Error updating lecturer: " + updateError.message());
                    }
                }
            }
            "4" => {
                string staffNumber = io:readln("Enter staff number of the lecturer to retrieve: ");
                Lecturer? lecturer = getLecturerByStaffNumber(staffNumber);
                if (lecturer == null) {
                    io:println("Lecturer with staff number " + staffNumber + " not found.");
                } else {
                    io:println("Lecturer details:");
                    io:println(lecturer);
                }
            }
            "5" => {
                string staffNumber = io:readln("Enter staff number of the lecturer to delete: ");
                var deleteError = deleteLecturerByStaffNumber(staffNumber);
                if (deleteError == null) {
                    io:println("Lecturer deleted successfully.");
                } else {
                    io:println("Error deleting lecturer: " + deleteError.message());
                }
            }
            "6" => {
                string courseCode = io:readln("Enter course code to retrieve lecturers: ");
                Lecturer[] lecturers = getLecturersByCourseCode(courseCode);
                if (lengthof lecturers == 0) {
                    io:println("No lecturers found for course code " + courseCode);
                } else {
                    io:println("Lecturers for course code " + courseCode + ":");
                    foreach var lecturer in lecturers {
                        io:println(lecturer);
                    }
                }
            }
            "7" => {
                io:println("Exiting.");
                break;
            }
            _ => {
                io:println("Invalid choice. Please enter a valid option.");
            }
        }
    }
}
