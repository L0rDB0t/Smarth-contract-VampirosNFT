// SPDX-License-Identifier: UNLICENSED 
pragma solidity  ^0.8.28;

import "./vampirehelper.sol";

contract VampireCombat is VampireHelper {
  uint randNonce = 0;
  uint attackVictoryProbability = 60;


//forma poco segura de generar numeros aletorios en la blockchain advertencia
  function randMod(uint _modulus) internal returns(uint) {
    randNonce = randNonce.add(1);
    return uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % _modulus;
  } 
  
  function attack(uint _vampiresId, uint _targetId) external OnlyOwnerOf(_vampireId) {
    Vampire storage myVampire = vampires[_vampireId];
    Vampire storage enemyVampire = vampires[_targetId];
    uint rand = randMod(100);
 
     if (rand <= attackVictoryProbability) {
      myVampire.winCount = myVampire.winCount.add(1);
      myVampire.level = myVampire.level.add(1);
      enemyVampire.lossCount = enemyVampire.lossCount.add(1);
      feedAndMultiply(_vampireId, enemyVampire.blood, "vampire");
      } else {
      myVampire.lossCount = myVampire.lossCount.add(1);
      enemyVampire.winCount = enemyVampire.winCount.add(1);
      _triggerCooldown(myVampire);

    
    }
  }
}
