// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Script.sol";
import {JsonDeploymentHandler} from "./JsonDeploymentHandler.sol";
import {NFT} from "../src/nft/NFT.sol";
import {Token} from "../src/tokens/Token.sol";
import {GameAttestation, IGameAttestation} from "../src/sign/GameAttestation.sol";
import {Attestation} from "@ethsign/sign-protocol-evm/src/models/Attestation.sol";
import {Schema, ISPHook} from "@ethsign/sign-protocol-evm/src/models/Schema.sol";
import {SP} from "@ethsign/sign-protocol-evm/src/core/SP.sol";
import {JsonDeploymentHandler} from "./JsonDeploymentHandler.sol";
import {DataLocation} from "@ethsign/sign-protocol-evm/src/models/DataLocation.sol";
import {Game, IGame} from "../src/game/Game.sol";
import {GameUtils} from "../src/utils/GameUtils.sol";
import {VRFConsumerMod} from "../src/chainlink/VRFConsumerMod.sol";
import {VRFCoordinatorV2Mock} from "../src/chainlink/VRFCoordinatorV2Mock.sol";
import {StreamCreator} from "../src/sablier/StreamCreator.sol";
import {Controller} from "../src/utils/Controller.sol";
import {CCIPLocalSimulatorFork, Register} from "@chainlink/local/src/ccip/CCIPLocalSimulatorFork.sol";
import {CCIPLocalSimulator, IRouterClient, LinkToken} from "@chainlink/local/src/ccip/CCIPLocalSimulator.sol";
import {SablierV2LockupLinear} from "@sablier/v2-core/src/SablierV2LockupLinear.sol";
import {SablierV2Comptroller} from "@sablier/v2-core/src/SablierV2Comptroller.sol";
import {SablierV2NFTDescriptor} from "@sablier/v2-core/src/SablierV2NFTDescriptor.sol";
import {ISablierV2LockupLinear} from "@sablier/v2-core/src/interfaces/ISablierV2LockupLinear.sol";

contract GameFaucetScript is Script, GameUtils, JsonDeploymentHandler {
    SablierV2LockupLinear public lockupLinear;
    SablierV2NFTDescriptor public sablierV2NFTDescriptor;
    VRFCoordinatorV2Mock public vrfMockCoordinator;
    VRFConsumerMod public vrfConsumer;
    GameAttestation public gameAttestation;
    StreamCreator public streamCreator;
    NFT public nft;
    SP public signProtocol;
    Token public token;
    Controller public controller;
    CCIPLocalSimulator public ccipLocalSimulator;
    Game public game;
    uint256 public chainAForkID;
    uint64 public SUBSCRIPTION_ID;
    uint96 public immutable BASEFEE = 100000000000000000;
    uint96 public immutable GASPRICELINK = 1000000000;
    uint256 public constant COST_TO_PLAY = 5 ether;
    address public spha;
    address public mike;
    address public owner;
    uint64 public chainSelector;
    IRouterClient public sourceRouter;
    IRouterClient public destinationRouter;
    LinkToken public linkToken;
    PoolPrize[] public prizePool;
    CCIPLocalSimulatorFork public ccipLocalSimulatorFork;
    Register.NetworkDetails public chainNetworkDetails;
    Register.NetworkDetails chainBNetworkDetails;

    constructor() JsonDeploymentHandler("main") {}
    function setUp() public virtual {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        address(0x0eBE8De635A1877faa067baD289f6977BA11a41b).call{value: 5 ether}("");
       
    }

}
