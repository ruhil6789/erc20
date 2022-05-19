// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "./mytoken.sol";

contract Marketplace is sachin, ERC721, Ownable {
    using Counters for Counters.Counter;
   
    Counters.Counter private _tokenIds;

    
    constructor() ERC721("N NFT", "nNFT") public{}

    //Buy ERC20 Tokens i.e Rishikesh Token
    function buyERC20Token(uint256 _quantity) public {
        transfer(msg.sender, _quantity);
    }
    
    function mintNFT(address receiver, string memory tokenURI) external onlyOwner returns (uint256) {
        _tokenIds.increment();

        uint256 newNftTokenId = _tokenIds.current();
        _mint(receiver, newNftTokenId);
        _setTokenURI(newNftTokenId, tokenURI);

        return newNftTokenId;
    }
    
    function sellNFT(uint256 _tokenId, address _to) public {
        require(ownerOf(_tokenId) == msg.sender);
        transferFrom(msg.sender, address(this), _tokenId);
        
        //Payment with ERC20 tokens
        //NFT Price = 1
        transferFrom(_to, msg.sender, 1);
    }
    
    
    function buyNFT(uint256 _tokenId) public {
        require(msg.sender != address(0) && msg.sender != address(this));

        safeTransferFrom(ownerOf(_tokenId), msg.sender, _tokenId);
        
        //Payment with ERC20 tokens
        //NFT Price = 1
        transferFrom(msg.sender, ownerOf(_tokenId), 1);
    }
    
}