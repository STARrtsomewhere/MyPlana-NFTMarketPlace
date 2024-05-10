// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyPlana_NFTMarketPlace {
    mapping (address => mapping (uint256 => NFT)) public ownedNFTs;
    mapping (address => address) public walletAddresses;

    struct NFT {
        uint256 id;
        string name;
        string imageURI;
        uint256 price;
    }

    event NewNFT(uint256 id, string name, string imageURI);

    event NFTPurchase(uint256 id, address buyer, uint256 price);

    function mintNFT(string memory _name, string memory _imageURI) public {
        uint256 id = uint256(keccak256(abi.encodePacked(_name, _imageURI)));

        NFT memory newNFT = NFT(id, _name, _imageURI, 0);

        ownedNFTs[msg.sender] [id] = newNFT;

        emit NewNFT(id, _name, _imageURI);
    }

    function connectWallet(address _walletAddress) public {
        walletAddresses[msg.sender] = _walletAddress;
    }

        function purchaseNFT(uint256 _id) public payable {
            NFT memory nft = ownedNFTs[msg.sender][_id];

            require(nft.price > 0 && msg.value >= nft.price, "Invalid NFT or insufficient funds");

             ownedNFTs[msg.sender][_id] = NFT(0, "", "", 0);

             emit NFTPurchase(_id, msg.sender, nft.price);
             }
             function getwalletAddress() external view returns(address) {
                return walletAddresses[msg.sender];
                
    
             }

    }