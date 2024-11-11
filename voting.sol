// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Proposal {
        string description;
        uint voteCount;
    }

    Proposal[] public proposals;
    mapping(address => bool) public hasVoted;

    // Initialize with proposals
    constructor(string[] memory proposalDescriptions) {
        for (uint i = 0; i < proposalDescriptions.length; i++) {
            proposals.push(Proposal({
                description: proposalDescriptions[i],
                voteCount: 0
            }));
        }
    }

    // Voting function
    function vote(uint proposalIndex) public {
        require(!hasVoted[msg.sender], "Tu voto ya fue recibido");
        require(proposalIndex < proposals.length, "La opcion no es valida");

        proposals[proposalIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
    }

    // Get proposal details
    function getProposal(uint index) public view returns (string memory description, uint voteCount) {
        require(index < proposals.length, "La opcion no es valida");
        Proposal storage proposal = proposals[index];
        return (proposal.description, proposal.voteCount);
    }

    // Get all proposals
    function getAllProposals() public view returns (Proposal[] memory) {
        return proposals;
    }
}