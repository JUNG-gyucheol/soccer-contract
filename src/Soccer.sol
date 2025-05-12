// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Soccer {
    struct MatchInfo {
        uint256 matchId;
        uint256 matchDate;
        string homeTeamName;
        string awayTeamName;
        string homeTeamLogo;
        string awayTeamLogo;
        uint256 homeTeamScore;
        uint256 awayTeamScore;
        uint256 totalWinBalance;
        uint256 totalLoseBalance;
        uint256 totalDrawBalance;
    }

    struct BettingInfo {
        uint256 matchId;
        uint256 winBalance;
        uint256 loseBalance;
        uint256 drawBalance;
        address participant;
        uint256 bettingTime;
    }

    mapping(uint256 => MatchInfo) public schaduleInfo;
    mapping(address => BettingInfo[]) public bettingHistory;

    uint256 public matchId = 1;

    function setScheduleInfo(
        uint256 _matchDate,
        string memory _homeTeamName,
        string memory _awayTeamName,
        string memory _homeTeamLogo,
        string memory _awayTeamLogo
    ) public {
        schaduleInfo[matchId] = MatchInfo(
            matchId,
            _matchDate,
            _homeTeamName,
            _awayTeamName,
            _homeTeamLogo,
            _awayTeamLogo,
            0,
            0,
            0,
            0,
            0
        );
        matchId++;
    }

    function setMatchResult(
        uint256 _matchId,
        uint256 _homeTeamScore,
        uint256 _awayTeamScore
    ) public {
        schaduleInfo[_matchId].homeTeamScore = _homeTeamScore;
        schaduleInfo[_matchId].awayTeamScore = _awayTeamScore;
    }

    function findMatchId(
        uint256 _matchDate,
        string memory _homeTeamName,
        string memory _awayTeamName
    ) public view returns (uint256) {
        for (uint256 i = 0; i < matchId; i++) {
            if (
                schaduleInfo[i].matchDate == _matchDate &&
                keccak256(abi.encodePacked(schaduleInfo[i].homeTeamName)) ==
                keccak256(abi.encodePacked(_homeTeamName)) &&
                keccak256(abi.encodePacked(schaduleInfo[i].awayTeamName)) ==
                keccak256(abi.encodePacked(_awayTeamName))
            ) {
                return i;
            }
        }
        revert('Match not found');
    }

    // function getAllMatchs() public view returns (schaduleInfo) {
    //     // MatchInfo[] memory allMatches;
    //     // for (uint256 i = 0; i < matchId; i++) {
    //     //     allMatches[i] = schaduleInfo[i];
    //     // }
    //     return schaduleInfo;
    // }

    function getMatchId(
        uint256 _matchDate,
        string memory _homeTeamName,
        string memory _awayTeamName
    ) public view returns (uint256) {
        return findMatchId(_matchDate, _homeTeamName, _awayTeamName);
    }

    function getMatchInfo(
        uint256 _matchId
    ) public view returns (MatchInfo memory) {
        return schaduleInfo[_matchId];
    }

    function getAllMatchs() public view returns (MatchInfo[] memory) {
        MatchInfo[] memory allMatches = new MatchInfo[](matchId);
        for (uint256 i = 0; i < matchId; i++) {
            allMatches[i] = schaduleInfo[i];
        }
        return allMatches;
    }

    // function setBattin
    function betting(uint256 _matchId, uint256 _bettingType) public payable {
        BettingInfo memory newBet;
        newBet.matchId = _matchId;
        newBet.participant = msg.sender;
        newBet.bettingTime = block.timestamp;

        if (_bettingType == 0) {
            newBet.winBalance = msg.value;
            schaduleInfo[_matchId].totalWinBalance += msg.value;
        }
        if (_bettingType == 1) {
            newBet.loseBalance = msg.value;
            schaduleInfo[_matchId].totalLoseBalance += msg.value;
        }
        if (_bettingType == 2) {
            newBet.drawBalance = msg.value;
            schaduleInfo[_matchId].totalDrawBalance += msg.value;
        }
        bettingHistory[msg.sender].push(newBet);
    }

    function getBettingHistory(
        address _participant
    ) public view returns (BettingInfo[] memory) {
        return bettingHistory[_participant];
    }

    function getBettingInfoByMatchId(
        uint256 _matchId,
        address _participant
    ) public view returns (BettingInfo memory) {
        for (uint256 i = 0; i < bettingHistory[_participant].length; i++) {
            if (bettingHistory[_participant][i].matchId == _matchId) {
                return bettingHistory[_participant][i];
            }
        }
        revert('Match not found');
    }
}
