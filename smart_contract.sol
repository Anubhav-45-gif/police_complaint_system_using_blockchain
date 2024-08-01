pragma solidity ^0.5.0;

contract PoliceComplaint {
    uint public complaint_count = 0;
    string public name = "Complaint";
    mapping(uint => Complaint) public complaints;
    address public owner;

    struct Complaint {
        uint id;
        string hash;
        string title;
        address author;
    }

    event ComplaintUploaded(
        uint id,
        string hash,
        string title,
        address author
    );

    constructor() public {
        owner = msg.sender;
    }

    modifier hashlength(string memory _dataHash) {
        require(bytes(_dataHash).length > 0, "Data hash must be provided.");
        _;
    }

    modifier titlelength(string memory _title) {
        require(bytes(_title).length > 0, "Title must be provided.");
        _;
    }

    modifier validuser() {
        require(msg.sender != address(0), "Invalid user address.");
        _;
    }

    function uploadcomplaint(string memory _dataHash, string memory _title) public hashlength(_dataHash) titlelength(_title) validuser {
        complaint_count++;
        complaints[complaint_count] = Complaint(complaint_count, _dataHash, _title, msg.sender);
        emit ComplaintUploaded(complaint_count, _dataHash, _title, msg.sender);
    }
}
