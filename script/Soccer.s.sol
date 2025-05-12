// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Script, console } from 'forge-std/Script.sol';

import { Soccer } from '../src/Soccer.sol';

// 1744225200

contract SoccerScript is Script {
    Soccer public soccer;

    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint('PRIVATE_KEY');
        address deployer = vm.addr(deployerPrivateKey);
        vm.startBroadcast(deployer);

        vm.deal(deployer, 1000 ether);

        soccer = new Soccer();

        console.log('start');

        soccer.setScheduleInfo(
            1744225200,
            unicode'Paris Saint Germain',
            unicode'Aston Villa',
            'https://cdn.live-score-api.com/teams/91ec29fa81c480ad9529573c1d3bcdac.png',
            'https://cdn.live-score-api.com/teams/7b05eac2c0fdee116af7092fe27129c2.png'
        );
        soccer.setScheduleInfo(
            1744225200,
            unicode'Borussia Dortmund',
            unicode'Barcelona',
            'https://cdn.live-score-api.com/teams/91ec29fa81c480ad9529573c1d3bcdac.png',
            'https://cdn.live-score-api.com/teams/7b05eac2c0fdee116af7092fe27129c2.png'
        );

        uint256 recentMatchId = soccer.matchId();

        // Soccer.MatchInfo[] memory allMatches = soccer.getAllMatchs();
        Soccer.MatchInfo memory matchInfo = soccer.getMatchInfo(1);

        console.log(matchInfo.homeTeamName);
        console.log(matchInfo.awayTeamName);
        console.log(matchInfo.homeTeamLogo);
        console.log(matchInfo.awayTeamLogo);

        console.log(deployer.balance / 10 ** 18);
        console.log('=== Betting Start ===');

        // 첫 번째 경기에 2 ETH로 홈팀 베팅
        // soccer.betting{ value: 2 ether }(0, 0);
        // soccer.betting{ value: 3 ether }(1, 1);
        // Soccer.BettingInfo[] memory bettingInfo = soccer.getBettingHistory();

        // for (uint256 i = 0; i < bettingInfo.length; i++) {
        //     console.log(bettingInfo[i].matchId);
        //     console.log(bettingInfo[i].winBalance);
        //     console.log(bettingInfo[i].loseBalance);
        //     console.log(bettingInfo[i].drawBalance);
        //     console.log(bettingInfo[i].participant);
        // }

        // Soccer.battingInfo memory bettingInfo2 = soccer.getBettingInfo();

        // console.log(bettingInfo2.matchId);
        // console.log(bettingInfo2.winBalance);
        // console.log(bettingInfo2.loseBalance);
        // console.log(bettingInfo2.drawBalance);
        // console.log(bettingInfo2.participant);

        // for (uint256 i = 0; i < recentMatchId; i++) {
        //     (
        //         uint256 matchId,
        //         uint256 matchDate,
        //         string memory homeTeamName,
        //         string memory awayTeamName,
        //         string memory homeTeamLogo,
        //         string memory awayTeamLogo,
        //         uint256 homeTeamScore,
        //         uint256 awayTeamScore,
        //         uint256 totalWinBalance,
        //         uint256 totalLoseBalance,
        //         uint256 totalDrawBalance
        //     ) = soccer.schaduleInfo(i);

        //     console.log('Match', i);
        //     console.log('ID:', matchId);
        //     console.log('Date:', matchDate);
        //     console.log('Home Team:', homeTeamName);
        //     console.log('Away Team:', awayTeamName);
        //     console.log('Home Logo:', homeTeamLogo);
        //     console.log('Away Logo:', awayTeamLogo);
        //     console.log('Home Score:', homeTeamScore);
        //     console.log('Away Score:', awayTeamScore);
        //     console.log('Total Win Balance:', totalWinBalance);
        //     console.log('Total Lose Balance:', totalLoseBalance);
        //     console.log('Total Draw Balance:', totalDrawBalance);
        // }

        vm.stopBroadcast();
    }
}
