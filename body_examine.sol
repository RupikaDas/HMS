pragma solidity >=0.4.22 <0.7.0;
/**

* @title Medical records
* @dev Store & retreive patient details in Medicalrecords
*/

import "@openzeppelin/contracts/token/ERC721/ERC721.sol"; // Update import if necessary

contract Body_Examine is ERC721 {
    mapping(uint256 => tests) patientTests;
    mapping(uint256 => scan) scanTests;
    mapping(uint256 => system) systemExamine;
    mapping(uint256 => prev) prevDates;
    mapping(uint256 => patient) patientList;

    struct patient {
        uint256 patient_id;
    }

    struct prev {
        uint256 patient_id;
        string previous;
    }

    struct tests {
        uint256 patient_id;
        string blood_test;
        string urine_test;
        string ecg;
        string mri_scan;
        string ct_scan;
        string xray;
        string lab_test;
    }

    struct scan {
        uint256 patient_id;
        string built;
        string nourishment;
        string eyes;
        string tongue;
        uint64 pulse;
        uint64 temp;
        string blood_pressure;
        uint64 respiratory_rate;
    }

    struct system {
        uint256 patient_id;
        string cns;
        string cvs;
        string rs;
        string abdomen;
    }

    address owner;

    /**
     * @dev Create the Token by Passing the Name and Symbol to the ERC721 Constructor
     */
    constructor() ERC721("MedicalCoin", "MEDC") public {
        owner = 0x34d8bC94989BbE14BCfd98E0550201ba4970B776; // Address of Doctor
    }

    // Modifier to give access only to the doctor
    modifier isOwner() {
        require(msg.sender == owner, "Access is not allowed");
        _;
    }

    /**
     * @dev Function to display the name of the token
     */
    function namedecl() public view returns (string memory) {
        return name();
    }

    /**
     * @dev Function to display the symbol of the token
     */
    function symboldecl() public view returns (string memory) {
        return symbol();
    }

    /**
     * @dev Function to display the total count of the token
     */
    function totalSupplycount() public view returns (uint256) {
        return totalSupply();
    }

    /**
     * @dev Function to mint token of medical record
     * @param patient_id patient id
     */
    function medical_record(uint256 patient_id) public {
        _mint(msg.sender, patient_id);

        patientList[patient_id] = patient({patient_id: patient_id});
    }

    /**
     * @dev Store previous dates of records updated
     * @param patient_id patient id
     * @param _previous previous dates of records updated
     */
    function previous_dates(uint256 patient_id, string memory _previous) public isOwner {
        prev memory pr = prev({
            patient_id: patient_id,
            previous: _previous
        });

        prevDates[patient_id] = pr;
    }

    /**
     * @dev Retrieve previous dates of records updated
     * @param patient_id patient id
     */
    function get_previous_dates(uint256 patient_id) public view returns (string memory) {
        prev memory pr = prevDates[patient_id];
        return (pr.previous);
    }

    /**
     * @dev Store investigations details
     * @param patient_id patient id
     * @param _blood_test blood test result
     * @param _urine_test urine test result
     * @param _ecg ecg result
     * @param _mri_scan mri scan report
     * @param _ct_scan ct scan report
     * @param _xray xray
     * @param _lab_test any other lab test
     */
    function investigations(
        uint256 patient_id,
        string memory _blood_test,
        string memory _urine_test,
        string memory _ecg,
        string memory _mri_scan,
        string memory _ct_scan,
        string memory _xray,
        string memory _lab_test
    ) public isOwner {
        tests memory t = tests({
            patient_id: patient_id,
            blood_test: _blood_test,
            urine_test: _urine_test,
            ecg: _ecg,
            mri_scan: _mri_scan,
            ct_scan: _ct_scan,
            xray: _xray,
            lab_test: _lab_test
        });

        patientTests[patient_id] = t;
    }

    /**
     * @dev Retrieve investigations details
     * @param patient_id patient id
     */
    function get_investigations(uint256 patient_id) public view returns (
        string memory,
        string memory,
        string memory,
        string memory,
        string memory,
        string memory,
        string memory
    ) {
        tests memory t = patientTests[patient_id];
        return (
            t.blood_test,
            t.urine_test,
            t.ecg,
            t.mri_scan,
            t.ct_scan,
            t.xray,
            t.lab_test
        );
    }

    /**
     * @dev Store general examination details
     * @param patient_id patient id
     * @param _built built of patient
     * @param _nourishment nourishment
     * @param _eyes eyes examination
     * @param _tongue tongue examination
     * @param _pulse pulse rate
     * @param _blood_pressure blood pressure
     * @param _temp temperature
     * @param _respiratory_rate respiratory rate
     */
    function general_examin(
        uint256 patient_id,
        string memory _built,
        string memory _nourishment,
        string memory _eyes,
        string memory _tongue,
        uint64 _pulse,
        string memory _blood_pressure,
        uint64 _temp,
        uint64 _respiratory_rate
    ) public isOwner {
        scan memory s = scan({
            patient_id: patient_id,
            built: _built,
            nourishment: _nourishment,
            eyes: _eyes,
            tongue: _tongue,
            pulse: _pulse,
            blood_pressure: _blood_pressure,
            temp: _temp,
            respiratory_rate: _respiratory_rate
        });

        scanTests[patient_id] = s;
    }

    /**
     * @dev Retrieve general examination details
     * @param patient_id patient id
     */
    function get_general_examin(uint256 patient_id) public view returns (
        string memory,
        string memory,
        string memory,
        string memory,
        uint64,
        string memory,
        uint64,
        uint64
    ) {
        scan memory s = scanTests[patient_id];
        return (
            s.built,
            s.nourishment,
            s.eyes,
            s.tongue,
            s.pulse,
            s.blood_pressure,
            s.temp,
            s.respiratory_rate
        );
    }

    /**
     * @dev Store systemic examination details
     * @param patient_id patient id
     * @param _cvs cardiovascular system
     * @param _cns central nervous system
     * @param _rs respiratory system
     * @param _abdomen abdomen system
     */
    function sys_examin(
        uint256 patient_id,
        string memory _cvs,
        string memory _cns,
        string memory _rs,
        string memory _abdomen
    ) public isOwner {
        system memory sys = system({
            patient_id: patient_id,
            cvs: _cvs,
            cns: _cns,
            rs: _rs,
            abdomen: _abdomen
        });

        systemExamine[patient_id] = sys;
    }

    /**
     * @dev Retrieve system examination details
     * @param patient_id patient id
     */
    function get_sys_examin(uint256 patient_id) public view returns (
        string memory,
        string memory,
        string memory,
        string memory
    ) {
        system memory sys = systemExamine[patient_id];
        return (
            sys.cvs,
            sys.cns,
            sys.rs,
            sys.abdomen
        );
    }
}