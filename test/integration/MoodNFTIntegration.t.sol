// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {MoodNFT} from "../../src/MoodNFT.sol";
import {DeployMoodNFT} from "../../script/DeployMoodNFT.s.sol";
import {console} from "forge-std/console.sol";

contract MoodNFTIntegrationTest is Test {
    MoodNFT moodNFT;
    DeployMoodNFT deployer;
    string public constant Happy_SVG_URI =
        "data:application/json;base64,eyJuYW1lIjoiTW9vZE5GVCIsICJkZXNjcmlwdGlvbiI6IkFuIE5GVCB0aGF0IHJlZmxlY3RzIHRoZSBtb29kIG9mIHRoZSBvd25lciwgMTAwJSBvbiBDaGFpbiEiLCAiYXR0cmlidXRlcyI6IFt7InRyYWl0X3R5cGUiOiAibW9vZGluZXNzIiwgInZhbHVlIjogMTAwfV0sICJpbWFnZSI6ImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjJhV1YzUW05NFBTSXdJREFnTWpBd0lESXdNQ0lnZDJsa2RHZzlJalF3TUNJZ0lHaGxhV2RvZEQwaU5EQXdJaUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lQZ29nSUR4amFYSmpiR1VnWTNnOUlqRXdNQ0lnWTNrOUlqRXdNQ0lnWm1sc2JEMGllV1ZzYkc5M0lpQnlQU0kzT0NJZ2MzUnliMnRsUFNKaWJHRmpheUlnYzNSeWIydGxMWGRwWkhSb1BTSXpJaTgrQ2lBZ1BHY2dZMnhoYzNNOUltVjVaWE1pUGdvZ0lDQWdQR05wY21Oc1pTQmplRDBpTnpBaUlHTjVQU0k0TWlJZ2NqMGlNVElpTHo0S0lDQWdJRHhqYVhKamJHVWdZM2c5SWpFeU55SWdZM2s5SWpneUlpQnlQU0l4TWlJdlBnb2dJRHd2Wno0S0lDQThjR0YwYUNCa1BTSnRNVE0yTGpneElERXhOaTQxTTJNdU5qa2dNall1TVRjdE5qUXVNVEVnTkRJdE9ERXVOVEl0TGpjeklpQnpkSGxzWlQwaVptbHNiRHB1YjI1bE95QnpkSEp2YTJVNklHSnNZV05yT3lCemRISnZhMlV0ZDJsa2RHZzZJRE03SWk4K0Nqd3ZjM1puUGc9PSJ9";
    string public constant Sad_SVG_URI =
        "data:application/json;base64,eyJuYW1lIjoiTW9vZE5GVCIsICJkZXNjcmlwdGlvbiI6IkFuIE5GVCB0aGF0IHJlZmxlY3RzIHRoZSBtb29kIG9mIHRoZSBvd25lciwgMTAwJSBvbiBDaGFpbiEiLCAiYXR0cmlidXRlcyI6IFt7InRyYWl0X3R5cGUiOiAibW9vZGluZXNzIiwgInZhbHVlIjogMTAwfV0sICJpbWFnZSI6ImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjNhV1IwYUQwaU1UQXlOSEI0SWlCb1pXbG5hSFE5SWpFd01qUndlQ0lnZG1sbGQwSnZlRDBpTUNBd0lERXdNalFnTVRBeU5DSWdlRzFzYm5NOUltaDBkSEE2THk5M2QzY3Vkek11YjNKbkx6SXdNREF2YzNabklqNEtJQ0E4Y0dGMGFDQm1hV3hzUFNJak16TXpJaUJrUFNKTk5URXlJRFkwUXpJMk5DNDJJRFkwSURZMElESTJOQzQySURZMElEVXhNbk15TURBdU5pQTBORGdnTkRRNElEUTBPQ0EwTkRndE1qQXdMallnTkRRNExUUTBPRk0zTlRrdU5DQTJOQ0ExTVRJZ05qUjZiVEFnT0RJd1l5MHlNRFV1TkNBd0xUTTNNaTB4TmpZdU5pMHpOekl0TXpjeWN6RTJOaTQyTFRNM01pQXpOekl0TXpjeUlETTNNaUF4TmpZdU5pQXpOeklnTXpjeUxURTJOaTQySURNM01pMHpOeklnTXpjeWVpSXZQZ29nSUR4d1lYUm9JR1pwYkd3OUlpTkZOa1UyUlRZaUlHUTlJazAxTVRJZ01UUXdZeTB5TURVdU5DQXdMVE0zTWlBeE5qWXVOaTB6TnpJZ016Y3ljekUyTmk0MklETTNNaUF6TnpJZ016Y3lJRE0zTWkweE5qWXVOaUF6TnpJdE16Y3lMVEUyTmk0MkxUTTNNaTB6TnpJdE16Y3llazB5T0RnZ05ESXhZVFE0TGpBeElEUTRMakF4SURBZ01DQXhJRGsySURBZ05EZ3VNREVnTkRndU1ERWdNQ0F3SURFdE9UWWdNSHB0TXpjMklESTNNbWd0TkRndU1XTXROQzR5SURBdE55NDRMVE11TWkwNExqRXROeTQwUXpZd05DQTJNell1TVNBMU5qSXVOU0ExT1RjZ05URXlJRFU1TjNNdE9USXVNU0F6T1M0eExUazFMamdnT0RndU5tTXRMak1nTkM0eUxUTXVPU0EzTGpRdE9DNHhJRGN1TkVnek5qQmhPQ0E0SURBZ01DQXhMVGd0T0M0MFl6UXVOQzA0TkM0eklEYzBMalV0TVRVeExqWWdNVFl3TFRFMU1TNDJjekUxTlM0MklEWTNMak1nTVRZd0lERTFNUzQyWVRnZ09DQXdJREFnTVMwNElEZ3VOSHB0TWpRdE1qSTBZVFE0TGpBeElEUTRMakF4SURBZ01DQXhJREF0T1RZZ05EZ3VNREVnTkRndU1ERWdNQ0F3SURFZ01DQTVObm9pTHo0S0lDQThjR0YwYUNCbWFXeHNQU0lqTXpNeklpQmtQU0pOTWpnNElEUXlNV0UwT0NBME9DQXdJREVnTUNBNU5pQXdJRFE0SURRNElEQWdNU0F3TFRrMklEQjZiVEl5TkNBeE1USmpMVGcxTGpVZ01DMHhOVFV1TmlBMk55NHpMVEUyTUNBeE5URXVObUU0SURnZ01DQXdJREFnT0NBNExqUm9ORGd1TVdNMExqSWdNQ0EzTGpndE15NHlJRGd1TVMwM0xqUWdNeTQzTFRRNUxqVWdORFV1TXkwNE9DNDJJRGsxTGpndE9EZ3VObk01TWlBek9TNHhJRGsxTGpnZ09EZ3VObU11TXlBMExqSWdNeTQ1SURjdU5DQTRMakVnTnk0MFNEWTJOR0U0SURnZ01DQXdJREFnT0MwNExqUkROalkzTGpZZ05qQXdMak1nTlRrM0xqVWdOVE16SURVeE1pQTFNek42YlRFeU9DMHhNVEpoTkRnZ05EZ2dNQ0F4SURBZ09UWWdNQ0EwT0NBME9DQXdJREVnTUMwNU5pQXdlaUl2UGdvOEwzTjJaejRLIn0=";
    address USER = makeAddr("user");

    function setUp() public {
        deployer = new DeployMoodNFT();
        moodNFT = deployer.run();
    }

    function testViewTokenUri2() public {
        vm.prank(USER);
        moodNFT.mintNft();
        console.log(moodNFT.tokenURI(0));
    }

    function testFlipToken() public {
        vm.prank(USER);
        moodNFT.mintNft();

        vm.prank(USER);
        moodNFT.flipmood(0);

        assert(keccak256(abi.encodePacked(moodNFT.tokenURI(0))) == keccak256(abi.encodePacked(Sad_SVG_URI)));
    }
}
