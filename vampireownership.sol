// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.28;

import "./safemath.sol";
import "./vampirecombat.sol";
import "./erc721.sol";

contract ZombieOwnership is ZombieAttack, ERC721 {
   using SafeMath for uint256;
   mapping (uint => address) vampireApprovals;
....

  function balanceOf(address _owner) external view returns (uint256) {
    return ownerVampireCount[_owner];
  }

    function ownerOf(uint256 _tokenId) external view returns (address) {
    return vampireToOwner[_tokenId];
  }


  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerVampireCount[_to] = ownerVampireCount[_to].add(1);
    ownerVampireCount[_from] = ownerVampireCount[_from].sub(1);
    vampireToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
    require (vampireToOwner[_tokenId] == msg.sender || vampireApprovals[_tokenId] == msg.sender);
    _transfer(_from, _to, _tokenId);
  }

  }

  function approve(address _approved, uint256 _tokenId) external payable onlyOwnerOf(_tokenId) {
    vampireApprovals[_tokenId] = _approved;
    emit Approval(msg.sender, _approved, _tokenId);
  }

}