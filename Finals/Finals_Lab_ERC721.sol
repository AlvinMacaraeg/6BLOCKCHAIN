// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SimpleMintContract is ERC721URIStorage, Ownable{

    uint256 public mintAmount = 0.05 ether; 
    uint256 public totalSupply;
    uint256 public maxSupply; 
    bool public isMintEnabled;

    mapping(address => uint256) public mintedWallets; 

    constructor() ERC721("Sample Minting", "MACARAEG") Ownable(msg.sender){
        maxSupply = 2;
    }

    function toggleMintEnabled () external onlyOwner {
        isMintEnabled = !isMintEnabled;
    }

    function setmaxsupply(uint MaxSupply_) external onlyOwner{
        maxSupply = MaxSupply_;
    }

    function mint() external payable {
        require(isMintEnabled, "Minting not Enabled");
        require(mintedWallets[msg.sender] < 1, "Exceeds max per wallet");
        require(msg.value == mintAmount, "wrong Value");
        require(maxSupply > totalSupply, "Sold Out");

        mintedWallets[msg.sender]++;
        totalSupply++;

        uint256 tokenId = totalSupply;
        _safeMint(msg.sender, tokenId);
    }    
}    
