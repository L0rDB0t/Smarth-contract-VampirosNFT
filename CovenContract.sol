// SPDX-License-Identifier: UNLICENSED 
pragma solidity  ^0.8.28;

import "./ownable.sol";
import "./safemath.sol";


contract CovenContract is Ownable {   

using SafeMath for uint256;
using SafeMath32 for uint32;
using SafeMath16 for uint16;

event NewVampire(uint vampireId, string name, uint blood);
   uint bloodDigits = 16;
   uint bloodModulus = 10 ** bloodDigits;
   uint cooldownTime = 1 days;

 struct Vampire {
        string name;
        uint blood;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 lossCount;
    }

 Vampire[] public Vampires;

    mapping (uint => address) public vampireToOwner;
    mapping (address => uint) ownerVampireCount;

function createvampire(string memory _name, uint _blood) internal {
    uint id = vampires.push(Vampire(_name, _blood, 1, uint32(now + cooldownTime), 0, 0)) - 1;
     vampireToOwner[id] = msg.sender;
     ownerVampireCount[msg.sender] = ownerVampireCount[msg.sender].add(1);
     emit NewVampire(id, _name, _blood);
 }

 }

    function _generateRandomBlood(string memory _str) private view returns (uint) {
        
        require(ownerVampireCount[msg.sender] == 0);
        uint rand = uint(keccak256(_str)));
        return rand % bloodModulus;
    }
    function createRandomVampire(string memory _name) public {
        uint bloodline = _generateRandomBlood(_name);
        createvampire(_name, bloodline);
    }

}

 contract VampireFeeding is CovenContract {
 }