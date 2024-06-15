pragma solidity >=0.4.22 <0.7.0;

/**
 * @title Hospital records
 * @dev Store & retrieve Hospital details 
 */
 
contract Hospital {
    mapping(uint256 => hospital) hospitalList;

    struct hospital {
        string hospital_name;
        string hospital_address;
        string hospital_spec;
    }

    address owner;

    /**
     * @dev Set the owner to the address deploying the contract
     */
    constructor() public {
        owner = msg.sender;
    }

    // Modifier to give access only to the owner
    modifier isOwner() {
        require(msg.sender == owner, "Access is not allowed");
        _;
    }

    // Event to log hospital details storage
    event HospitalStored(
        uint256 indexed hospital_id,
        string hospital_name,
        string hospital_address,
        string hospital_spec
    );

    /**
     * @dev Store hospital details
     * @param hospital_id hospital registration id
     * @param _hospital_name name of hospital
     * @param _hospital_address hospital address
     * @param _hospital_spec hospital specialisation
     */
    function store_hospital_details(
        uint256 hospital_id,
        string memory _hospital_name,
        string memory _hospital_address,
        string memory _hospital_spec
    ) public isOwner {
        hospital memory h = hospital({
            hospital_name: _hospital_name,
            hospital_address: _hospital_address,
            hospital_spec: _hospital_spec
        });

        hospitalList[hospital_id] = h;

        emit HospitalStored(hospital_id, _hospital_name, _hospital_address, _hospital_spec);
    }

    /**
     * @dev Retrieve hospital details
     * @param hospital_id hospital registration id
     */
    function retrieve_hospital_details(uint256 hospital_id) public view returns (
        string memory,
        string memory,
        string memory
    ) {
        hospital memory h = hospitalList[hospital_id];
        return (
            h.hospital_name,
            h.hospital_address,
            h.hospital_spec
        );
    }
}