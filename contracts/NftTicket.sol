//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract NftTicket{
    address public owner;
    uint TICKET_AMOUNT = 100 wei;

   struct LotteryEvent{
        string description;
        uint totalTickets;
        uint numberOfTicketssold;
        mapping (address => uint) players;
        bool isOpen;
    }

    LotteryEvent lotteryEvent;
    event BuyTickets(address player, uint tickets);

    modifier onlyOwner(){ 
        require(
            msg.sender == owner,
            "Only owner can call this."
        ); 
        _;
      }

      constructor (string memory _description, uint _totalTickets) public {
        owner = msg.sender;
        lotteryEvent.description = _description;
        lotteryEvent.websiteUrl = _websiteUrl;
        lotteryEvent.totalTickets = _totalTickets;
        lotteryEvent.isOpen = true;
        lotteryEvent.numberOfTicketssold = 0;
    }

    function displayLotteryEvent() public view
    returns(string memory description, uint totalTickets, uint numberOfTicketssold, bool isOpen) 
    {
        return (lotteryEvent.description, lotteryEvent.totalTickets, lotteryEvent.numberOfTicketssold, lotteryEvent.isOpen);
    }

    function buyTickets(uint tickets) payable external {
        require(lotteryEvent.isOpen == true && msg.value >= tickets * TICKET_PRICE && tickets <= (lotteryEvent.totalTickets - lotteryEvent.sales));
        lotteryEvent.buyers[msg.sender] = tickets;
        lotteryEvent.sales = lotteryEvent.sales + tickets;
        msg.sender.transfer(msg.value - tickets * TICKET_PRICE);
        emit BuyTickets(msg.sender, tickets);
        //TODO mint nft as ticket
    }
    
}
