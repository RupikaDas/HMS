pragma solidity >=0.4.22 <0.7.0;

/**
 * @title Patient records
 * @dev Store & retrieve Patient details 
 */
contract Patient {
    mapping(uint256 => patient) patientList;
    mapping(uint256 => attendant) attendantList;

    struct patient {
        string patient_name;
        uint256 age;
        string gender;
        string height;
        uint256 weight;
        string patient_address;
        uint256 phone_no;
        string email_id;
        uint256 date;
        uint256 doctor_id;
        uint256 hospital_id;
    }

    struct attendant {
        uint256 patient_id;
        string attendant_name;
        string attendant_relation;
        uint256 attendant_phn_no;
    }

    address owner;

    /**
     * @dev Set the owner to the address deploying the contract
     */
    constructor() public {
        owner = msg.sender; // Address of Hospital
    }

    // Modifier to give access only to the owner
    modifier isOwner() {
        require(msg.sender == owner, "Access is not allowed");
        _;
    }

    // Event to log patient details storage
    event PatientStored(
        uint256 indexed patient_id,
        string patient_name,
        uint256 age,
        string gender,
        string height,
        uint256 weight,
        string patient_address,
        uint256 phone_no,
        string email_id,
        uint256 date
    );

    // Event to log attendant details storage
    event AttendantStored(
        uint256 indexed patient_id,
        string attendant_name,
        string attendant_relation,
        uint256 attendant_phn_no
    );

    /**
     * @dev Store patient details
     * @param patient_id patient id
     * @param _patient_name patient name
     * @param _age age
     * @param _gender gender
     * @param _height height
     * @param _weight weight
     * @param _patient_address address
     * @param _phone_no phone number
     * @param _email_id email id
     * @param _date date
     */
    function store_patient_details(
        uint256 patient_id,
        string memory _patient_name,
        uint256 _age,
        string memory _gender,
        string memory _height,
        uint256 _weight,
        string memory _patient_address,
        uint256 _phone_no,
        string memory _email_id,
        uint256 _date
    ) public isOwner {
        patient memory p = patient({
            patient_name: _patient_name,
            age: _age,
            gender: _gender,
            height: _height,
            weight: _weight,
            patient_address: _patient_address,
            phone_no: _phone_no,
            email_id: _email_id,
            date: _date,
            doctor_id: 0,
            hospital_id: 0
        });

        patientList[patient_id] = p;

        emit PatientStored(patient_id, _patient_name, _age, _gender, _height, _weight, _patient_address, _phone_no, _email_id, _date);
    }

    /**
     * @dev Store attendant details
     * @param patient_id patient id
     * @param _attendant_name name of attendant
     * @param _attendant_relation relation to patient
     * @param _attendant_phn_no phone no
     */
    function store_attendant_details(
        uint256 patient_id,
        string memory _attendant_name,
        string memory _attendant_relation,
        uint256 _attendant_phn_no
    ) public isOwner {
        attendant memory a = attendant({
            patient_id: patient_id,
            attendant_name: _attendant_name,
            attendant_relation: _attendant_relation,
            attendant_phn_no: _attendant_phn_no
        });

        attendantList[patient_id] = a;

        emit AttendantStored(patient_id, _attendant_name, _attendant_relation, _attendant_phn_no);
    }

    /**
     * @dev Retrieve patient details
     * @param patient_id patient id
     */
    function retrieve_patient_details(uint256 patient_id) public view returns (
        string memory,
        uint256,
        string memory,
        string memory,
        uint256,
        string memory,
        uint256,
        string memory,
        uint256
    ) {
        patient memory p = patientList[patient_id];
        return (
            p.patient_name,
            p.age,
            p.gender,
            p.height,
            p.weight,
            p.patient_address,
            p.phone_no,
            p.email_id,
            p.date
        );
    }

    /**
     * @dev Retrieve attendant details
     * @param patient_id patient id
     */
    function retrieve_attendant_details(uint256 patient_id) public view returns (
        string memory,
        string memory,
        uint256
    ) {
        attendant memory a = attendantList[patient_id];
        return (
            a.attendant_name,
            a.attendant_relation,
            a.attendant_phn_no
        );
    }
}

