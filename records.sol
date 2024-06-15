pragma solidity >=0.4.22 <0.7.0;

/**
 * @title Medical records
 * @dev Store & retrieve patient details in Medicalrecords
 */
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

contract Records is ERC721 {
    mapping(uint256 => Insurance) private insurancelist;
    mapping(uint256 => History) private patienthistory;
    mapping(uint256 => Past) private pasthistory;
    mapping(uint256 => Diagnosis) private diagnosis;
    mapping(uint256 => Treatment) private treatment;
    mapping(uint256 => Prev) private prevdates;
    mapping(uint256 => Patient) private patientlist;

    struct Patient {
        uint256 patient_id;
    }

    struct Prev {
        string previous;
    }

    struct Insurance {
        string applicable;
        uint64 policy_no;
        string insurer;
        string policy_type;
        string policy_limit;
    }

    struct History {
        string complaints;
        string duration;
    }

    struct Past {
        string family_history;
        string personal_history;
        string drug_history;
    }

    struct Diagnosis {
        string diag_summary;
        string prescription;
    }

    struct Treatment {
        string treatment;
        string date_treatment;
        uint256 doctor_id;
        uint256 hospital_id;
        string discharge;
        string follow_up;
    }

    address private owner;

    /**
     * @dev Create the Token by Passing the Name and Symbol to the ERC721 Constructor
     */
    constructor() ERC721("AmritaMedicalCoin", "AMC") public {
        owner = msg.sender; // Address of Doctor
    }

    // Modifier to give access only to the owner
    modifier isOwner() {
        require(msg.sender == owner, "Access is not allowed");
        _;
    }

    // Event logging
    event MedicalRecordMinted(uint256 indexed patient_id, address indexed owner);
    event PreviousDatesUpdated(uint256 indexed patient_id, string previous);
    event InsuranceDetailsUpdated(uint256 indexed patient_id, string applicable, uint64 policy_no, string insurer, string policy_type, string policy_limit);
    event PresentIllnessUpdated(uint256 indexed patient_id, string complaints, string duration);
    event PastIllnessUpdated(uint256 indexed patient_id, string family_history, string personal_history, string drug_history);
    event DiagnosisUpdated(uint256 indexed patient_id, string diag_summary, string prescription);
    event TreatmentUpdated(uint256 indexed patient_id, string treatment, string date_treatment, uint256 doctor_id, uint256 hospital_id, string discharge, string follow_up);

    /**
     * @dev Function to display name of the token 
    */
    function namedecl() public view returns (string memory) {
        return name();
    }

    /**
     * @dev Function to display symbol of the token 
    */
    function symboldecl() public view returns (string memory) {
        return symbol();
    }

    /**
     * @dev Function to display total count of the token 
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
        patientlist[patient_id] = Patient(patient_id);
        emit MedicalRecordMinted(patient_id, msg.sender);
    }

    /**
     * @dev Store previous dates of records updated
     * @param patient_id patient id
     * @param _previous previous dates of records updated
     */
    function previous_dates(uint256 patient_id, string memory _previous) public isOwner {
        prevdates[patient_id] = Prev(_previous);
        emit PreviousDatesUpdated(patient_id, _previous);
    }

    /**
     * @dev Retrieve previous dates of records updated
     * @param patient_id patient id
     */
    function get_previous_dates(uint256 patient_id) public view returns (string memory) {
        return prevdates[patient_id].previous;
    }

    /**
     * @dev Store insurance details
     * @param patient_id patient id
     * @param _applicable is applicable or not
     * @param _policy_no policy number
     * @param _insurer name of insurer
     * @param _policy_type type of policy
     * @param _policy_limit limit of policy
     */
    function insurance_details(
        uint256 patient_id,
        string memory _applicable,
        uint64 _policy_no,
        string memory _insurer,
        string memory _policy_type,
        string memory _policy_limit
    ) public isOwner {
        insurancelist[patient_id] = Insurance(_applicable, _policy_no, _insurer, _policy_type, _policy_limit);
        emit InsuranceDetailsUpdated(patient_id, _applicable, _policy_no, _insurer, _policy_type, _policy_limit);
    }

    /**
     * @dev Retrieve insurance details
     * @param patient_id patient id
     */
    function get_insurance(uint256 patient_id) public view returns (string memory, uint64, string memory, string memory, string memory) {
        Insurance memory i = insurancelist[patient_id];
        return (i.applicable, i.policy_no, i.insurer, i.policy_type, i.policy_limit);
    }

    /**
     * @dev Store present illness details
     * @param patient_id patient id
     * @param _complaints complaints
     * @param _duration duration of the complaint
     */
    function present_illness(uint256 patient_id, string memory _complaints, string memory _duration) public isOwner {
        patienthistory[patient_id] = History(_complaints, _duration);
        emit PresentIllnessUpdated(patient_id, _complaints, _duration);
    }

    /**
     * @dev Retrieve present illness details
     * @param patient_id patient id
     */
    function get_present_illness(uint256 patient_id) public view returns (string memory, string memory) {
        History memory hi = patienthistory[patient_id];
        return (hi.complaints, hi.duration);
    }

    /**
     * @dev Store past illness details
     * @param patient_id patient id
     * @param _family_history history of family illness
     * @param _personal_history history of personal illness
     * @param _drug_history history of drug usage
     */
    function past_illness(uint256 patient_id, string memory _family_history, string memory _personal_history, string memory _drug_history) public isOwner {
        pasthistory[patient_id] = Past(_family_history, _personal_history, _drug_history);
        emit PastIllnessUpdated(patient_id, _family_history, _personal_history, _drug_history);
    }

    /**
     * @dev Retrieve past illness details
     * @param patient_id patient id
     */
    function get_past_illness(uint256 patient_id) public view returns (string memory, string memory, string memory) {
        Past memory pa = pasthistory[patient_id];
        return (pa.family_history, pa.personal_history, pa.drug_history);
    }

    /**
     * @dev Store functional diagnosis details
     * @param patient_id patient id
     * @param _diag_summary summary of diagnosis
     * @param _prescription prescription
     */
    function func_diagnosis(uint256 patient_id, string memory _diag_summary, string memory _prescription) public isOwner {
        diagnosis[patient_id] = Diagnosis(_diag_summary, _prescription);
        emit DiagnosisUpdated(patient_id, _diag_summary, _prescription);
    }

    /**
     * @dev Retrieve functional diagnosis details
     * @param patient_id patient id
     */
    function get_func_diagnosis(uint256 patient_id) public view returns (string memory, string memory) {
        Diagnosis memory d = diagnosis[patient_id];
        return (d.diag_summary, d.prescription);
    }

    /**
     * @dev Store treatment summary details
     * @param patient_id patient patient id
     * @param _treatment treatment
     * @param _date_treatment date of treatment
     * @param _doctor_id id of doctor treated
     * @param _hospital_id id of hospital
     * @param _discharge date of discharge
     * @param _follow_up date for follow up
     */
    function treatment_summary(
        uint256 patient_id,
        string memory _treatment,
        string memory _date_treatment,
        uint256 _doctor_id,
        uint256 _hospital_id,
        string memory _discharge,
        string memory _follow_up
    ) public isOwner {
        treatment[patient_id] = Treatment(_treatment, _date_treatment, _doctor_id, _hospital_id, _discharge, _follow_up);
        emit TreatmentUpdated(patient_id, _treatment, _date_treatment, _doctor_id, _hospital_id, _discharge, _follow_up);
    }

    /**
     * @dev Retrieve treatment summary details
     * @param patient_id patient id
     */
    function get_treatment_summary(uint256 patient_id) public view returns (string memory, string memory, uint256, uint256, string memory, string memory) {
        Treatment memory tr = treatment[patient_id];
        return (tr.treatment, tr.date_treatment, tr.doctor_id, tr.hospital_id, tr.discharge, tr.follow_up);
    }
}