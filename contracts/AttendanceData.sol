pragma solidity ^0.4.11;

contract AttendanceData {

  struct Attendee {
    string name;
    uint amountDonated;
    uint lastAttendedEvent;
    uint totalEventsAttended;
    mapping(address => Validator) validators;
    address[] validatorList;
    uint256 listPointer;
  }

  struct Validator {
    bool hasAlreadyValidated;
    uint256 listPointer;
    uint eventId;
  }

  uint eventId; //start at 0, iterate up for each event
  mapping(address => Attendee) public attendees;
  address[] public attendeeList;
  mapping(address => uint) private winningsBalance; //map addresses to their winnings balance
  address[] public eventResults; //track winners of each event
  uint public unclaimedValue; //total unclaimed value in the contract (available only to winners)
  uint public currentEventValue; //value of current meetup
  address private owner;

  modifier onlyOwner {
    require(msg.sender == owner);
    _; // The "_;" is replaced by fxn body.
  }

  function AttendanceData() public {
    unclaimedValue=0;
    currentEventValue=0;
    owner = msg.sender;
  }

  /*
    Read functions
  */
  function isAttendee(address attendeeAddress) public constant returns(bool isAttendee) {
    if(attendeeList.length == 0) return false;
    return (attendeeList[attendees[attendeeAddress].listPointer] == attendeeAddress
        && attendees[attendeeAddress].lastAttendedEvent == eventId
      );
  }

  function hasPastAttendeeRecord(address attendeeAddress) public constant returns(bool isAttendee) {
    return (attendees[attendeeAddress].lastAttendedEvent != eventId
              && attendees[attendeeAddress].lastAttendedEvent >= 0);
  }

//"0xca35b7d915458ef540ade6068dfe2f44e8fa733c","0x14723a09acff6d2a60dcdf7aa4aff308fddc160c"

  function hasAlreadyValidated(address attendeeAddress, address validatorAddress) public constant returns(bool hasAlreadyValidated) {
    /*
      Check if a particular address has already validated a particular attendee
        1. Ensure attendee exists
        2. Grab validator object from attendee struct
        3.
    */
    if(attendees[attendeeAddress].validatorList.length == 0) return false;
    if(isAttendee(attendeeAddress) == false) return false;
    return attendees[attendeeAddress].validators[validatorAddress].hasAlreadyValidated;
  }

  function getAttendeeCount() public constant returns(uint attendeeCount) {
    return attendeeList.length;
  }

  function newAttendee(string name) public payable returns(bool success) {
    /*
      Adding new attendee:
        1. Make sure attendee doesn't already exist
        2. Add AttendeeStruct data to mapping
        3. Push address onto array
    */
    address attendeeAddress = msg.sender;
    uint amountDonated = msg.value;
    if(isAttendee(attendeeAddress)) throw;
    if(amountDonated<=0) throw;
    if(hasPastAttendeeRecord(attendeeAddress)){
      updateAttendee(attendeeAddress, name, amountDonated);
      attendees[attendeeAddress].listPointer = attendeeList.push(attendeeAddress) - 1;
      attendees[attendeeAddress].lastAttendedEvent = eventId;
      attendees[attendeeAddress].totalEventsAttended++;
      return true;
    }
    else{
      attendees[attendeeAddress].name = name;
      attendees[attendeeAddress].lastAttendedEvent = eventId;
      attendees[attendeeAddress].amountDonated = amountDonated;
      attendees[attendeeAddress].listPointer = attendeeList.push(attendeeAddress) - 1;
      attendees[attendeeAddress].totalEventsAttended=1;
      currentEventValue+=amountDonated;
      unclaimedValue+=amountDonated;
      return true;
    }
  }

  function updateAttendee(address attendeeAddress, string name, uint amountDonated) private returns(bool success) {
    if(!isAttendee(attendeeAddress)) throw;
    attendees[attendeeAddress].name = name;
    attendees[attendeeAddress].lastAttendedEvent = eventId;
    attendees[attendeeAddress].amountDonated = amountDonated;
    currentEventValue+=amountDonated;
    unclaimedValue+=amountDonated;
    return true;
  }

  function updateAttendeeName(address attendeeAddress, string name) public returns(bool success) {
    if(!isAttendee(attendeeAddress)) throw;
    attendees[attendeeAddress].name = name;
    return true;
  }

  function validateAttendee(address attendeeAddress) public returns(bool success) {
    if(attendeeAddress==msg.sender) throw; //prevent self-confimration
    if(!isAttendee(attendeeAddress)) throw; //Make sure that validatee is an attendee
    if(!isAttendee(msg.sender)) throw;//Make sure that validator is an attendee too
    if(hasAlreadyValidated(attendeeAddress, msg.sender)) throw; // check if already validated before
    attendees[attendeeAddress].validators[msg.sender].hasAlreadyValidated = true;
    attendees[attendeeAddress].validators[msg.sender].listPointer = attendees[attendeeAddress].validatorList.push(msg.sender) - 1;
    return true;
  }

  function deleteAttendee(address attendeeAddress) public returns(bool success) {
    if(!isAttendee(attendeeAddress)) throw;
    uint rowToDelete = attendees[attendeeAddress].listPointer; // array index of specified address
    address keyToMove = attendeeList[attendeeList.length-1]; // address at last position
    attendeeList[rowToDelete] = keyToMove; //set address of deleted index, to address of last index
    attendees[keyToMove].listPointer = rowToDelete; // update pointer of last
    attendeeList.length--;
    return true;
  }

  function payout() public returns(bool success) {
    require (attendeeList.length>0);
    address winner = calculateWinner();
    winningsBalance[winner] += currentEventValue;
    currentEventValue = 0;
    resetAttendance();
    return true;
  }

  function resetAttendance() private returns(bool success){
    //Can only be run by .payOut()
    attendeeList.length=0;
    currentEventValue=0;
    eventId++;
    return true;
  }

  function collectWinnings() public returns(bool success){
    //Can only be run by .payOut()
    if(winningsBalance[msg.sender] > 0) throw;
    msg.sender.transfer(winningsBalance[caller]);
    return true;
  }

  function calculateWinner() private view returns(address) {
    /*THIS SECTION NEEDS WORK
      1. Grab list of validated addresses
      2. Add ransomized selection algorithm
    */
    return attendeeList[0];
  }


}
