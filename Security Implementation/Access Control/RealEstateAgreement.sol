// // SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract RealEstateAgreement {

    address private owner; // Accesss Control implementation
    uint256 public price;
    bool public sellingPaysClosingFees;

    constructor(uint256 _price) {
        owner = msg.sender; // Accesss Control implementation
        price = _price;
        sellingPaysClosingFees = false;
    }

    function setPrice(uint256 _price) public onlyOwner{
        //require(owner == msg.sender, " only owner can update agreement terms"); // Accesss Control implementation
        price = _price;
    }

    function setClosingFeeAgreement(bool _ownerPays) public onlyOwner{
        sellingPaysClosingFees = _ownerPays;
    }

    modifier onlyOwner(){
         require(owner == msg.sender, " only owner can update agreement terms"); // Accesss Control implementation
         _;
    }
}