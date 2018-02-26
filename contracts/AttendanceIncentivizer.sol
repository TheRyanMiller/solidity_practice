pragma solidity ^0.4.19;

contract AttendanceIncentivizer {
  event Donate(address indexed donater, uint indexed amount);
  event Payout(address indexed donater, uint indexed amount);
  event Validate(address indexed validator, address indexed validatee);

  mapping (address => uint) public donaters;
  mapping (address => uint) public validations;
  address[] public donaterList;
  address public owner;
  address public winner;
  uint constant minimumDonation = 1;
  uint totalContractValue = 0;
  int256 i=0;

  function AttendanceIncentivizer() public payable {
    owner = msg.sender;
    donaters[msg.sender] += msg.value;
    totalContractValue += msg.value;
    donaterList.push(msg.sender);
  }

  function donate() public payable {
    //require(msg.value >= minimumDonation);
    if(donaters[msg.sender]==0){
      donaterList.push(msg.sender); //If address has not donated before, add them to bytearray
    }
    totalContractValue += msg.value; //increase contract value
    donaters[msg.sender] += msg.value; //add to value associated with address
    Donate(msg.sender, msg.value); //Event

  }

  function validate(address validatee) public {
    require (validatee != msg.sender); //Require validator is not same as validatee
    require (donaters[msg.sender] > 0); //Require validator has donated
    require (donaters[validatee] > 0); //Require that validatee has dontated
    validations[validatee] += 1;
    Validate(msg.sender, validatee); //Log event
  }

  function payout() public{
    require (donaterList.length>0);
    winner = calculateWinner();
    winner.transfer(totalContractValue);
    Payout(winner, totalContractValue);
    winner = address(0); //Clear out address of calculateWinner
    totalContractValue = 0; //clear out total _value
    i = int(donaterList.length)-1;
    while(i>=0){
        donaters[donaterList[uint(i)]]=0;
        delete donaterList[uint(i)];
        i--;
    }
  }

  function calculateWinner() private view returns(address) {
    /*THIS SECTION NEEDS WORK*/
    return donaterList[0];
  }

  function checkIfValidated(address validatee) public view returns (bool){
    return validations[validatee] > 0;
  }

  function checkAmountDonated(address donater) public view returns (uint) {
    return donaters[donater];
  }

  function checkContractValue() public view returns (uint) {
    return totalContractValue;
  }

  function getListOfDonaters() public view returns (address[]) {
    return donaterList;
  }

}
