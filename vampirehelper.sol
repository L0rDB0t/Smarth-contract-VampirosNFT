// SPDX-License-Identifier: UNLICENSED 
pragma solidity  ^0.8.28;

import './vampirefeeding.sol';

contract VampireHelper is VampireFeeding {

  uint levelUpFee = 0.001 ether;


  modifier aboveLevel(uint _level, uint _vampireId) {
    require(vampires[_vampireId].level >= _level);
    _;
  }

  function withdraw() external onlyOwner {
    address _owner = owner();
    _owner.transfer(address(this).balance);

  }  

  function setLevelUpFee(uint _fee) external onlyOwner {
    levelUpFee = _fee;
  }

  function levelUp(uint _vampireId) external payable {
    require(msg.value == levelUpFee);
    vampires[_vampireId].level++;
  }

  function levelUp(uint _vampireId) external payable {
    require(msg.value == levelUpFee);
    vampires[_vampireId].level++;
  }

   function changeName(uint _vampireId, string _newName) external aboveLevel(2, _vampireId) OnlyOwnerOf(_vampireId) {
    vampires[_vampireId].name = _newName;
  }

  function changeBlood(uint _vampireId, uint _newBlood) external aboveLevel(20, _vampireId) OnlyOwnerOf(_vampireId) {
    vampires[_vampireId].blood = _newBlood;
  }

  function getVampiresByOwner(address _owner) external view returns(uint[]) { //funcion para ahorra gas

    uint[] memory result = new uint[](ownerVampireCount[_owner]);
   
    uint counter = 0;
    for (uint i = 0; i < vampires.length; i++) {
      if (vampiresToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }

    return result;
  }

}