//SPDX-License-Identifier:MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
contract MyToken is ERC20{
    constructor() ERC20("MyToken", "MTK") {}
    uint256 public depositedEther;
    uint256 tokenPerEther=10; //1 ether=10 erc20 tkns
    function Mint(address to) public payable{
        depositedEther = msg.value;
        uint256 amount = depositedEther * tokenPerEther;
        _mint(to, amount);
    }
}
contract MyToken1 is ERC721, Ownable {
    constructor() ERC721("MyToken1", "MTK1"){}
    function mint(address to, uint256 amount) public{
       for(uint256 i=1; i<=amount; i++){
        _mint(to, i);
       }
    }
}
contract nftSwap{
    IERC721 public nftContract;
    IERC20 public tokenContract;
    address public owner1;
    constructor(address _tokenContract, address _nftContract, address _owner1){
        tokenContract = IERC20(_tokenContract);
        nftContract = IERC721(_nftContract);
        owner1=_owner1; //owner of MyToken1 contract
    }
    function buyNFT(uint256 _amount, uint _nft) public payable{
        tokenContract.transferFrom(msg.sender, address(this), _amount); //depositing erc20
        nftContract.transferFrom(owner1, msg.sender, _nft); // getting nft
    }
}

