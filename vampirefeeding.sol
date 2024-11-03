// SPDX-License-Identifier: UNLICENSED 
pragma solidity  ^0.8.28;

import './CovenContract.sol';

contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 blood
  );
}

contract VampireFeeding is CovenContract {
  
   KittyInterface kittyContract;
   
   modifier OnlyOwnerOf(uint _vampireId) {
    require(msg.sender == vampireToOwner[_vampireId]);
    _;
   }

   function setKittyContractAddress(address _address) external onlyOwner {
    kittyContract = KittyInterface(_address);
   }

   function _triggerCooldown(Vampire storage _vampire) internal {
    _vampire.readyTime = uint32(now + cooldownTime);
   }

   function _isReady(Vampire storage _vampire) internal view returns (bool) {
    return (_vampire.readyTime <= now);
   }

   function feedAndMultiply(uint _vampireId, uint _targetBlood, string _species)  internal OnlyownerOf(_vampireId) {
    require(msg.sender == vampireToOwner[_vampireId]);
    Vampire storage myVampire = vampires[_vampireId];
    
    require(_isReady(myVampire));
    _targetBlood = _targetBlood % bloodModulus;
    uint newBlood = (myVampire.blood + _targetBlood) / 2;
    
    if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
      newBlood = newBlood - newBlood % 100 + 99;
    }
    _createVampire("NoName", newBlood);
    _triggerCooldown(myVampire);
  }
   function feedOnKitty(uint _vampireId, uint _vampireId) public {
    uint kittyBlood;
    (,,,,,,,,,kittyBlood) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_vampireId, kittyBlood, "kitty");
  }

}
