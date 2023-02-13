// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;


contract Lottery {
    address public owner;
    address payable[] public players;
    uint public lotteryID;
    mapping (uint => address payable) public lotteryHistory;

    constructor () {
        owner = msg.sender;
        lotteryID = 1;
    }

    function getWinnerByLottery(uint lottery_ID) public view returns(address payable){
        return lotteryHistory[lottery_ID];
    }

    function getPotBalance() public view returns(uint){
        return address(this).balance;
    }

    function getPlayers() public view returns(address payable[] memory) {
        return players;
    }

    function enterLottery() public payable {
        require(msg.value > 0.01 ether);
        // address of player intering lottery
        players.push(payable(msg.sender));

    }

    function getRandomNumber() public view returns(uint){
        return uint(keccak256(abi.encodePacked(owner, block.timestamp)));
    }

    function pickWinner() public onlyOwner {
       
        uint index = getRandomNumber() % players.length;
        players[index].transfer(address(this).balance);

        lotteryHistory[lotteryID] = players[index];
        lotteryID++;
        
    
        /// reset the state of the contract

        players = new address payable[](0);    
    }

    modifier onlyOwner (){
        require(msg.sender == owner);
        _;
    }

    


}