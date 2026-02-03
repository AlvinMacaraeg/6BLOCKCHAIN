// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ServiceFee {

    // Service Code 1: Consultation
    function consultationFee() public pure returns (uint256) {
        uint256 baseFee = 10000;
        uint256 tax = (baseFee * 12) / 100;
        return baseFee + tax;
    }

    // Service Code 2: Documents
    function documentsFee() public pure returns (uint256) {
        uint256 baseFee = 2000;
        uint256 serviceCharge = (baseFee * 10) / 100;
        uint256 tax = (baseFee * 12) / 100;
        return baseFee + serviceCharge + tax;
    }

    function generateHash(
        string memory firstName,
        string memory middleName,
        string memory lastName,
        uint8 serviceCode
    ) public pure returns (bytes32, uint256) {

        uint256 fee;

        if (serviceCode == 1) {
            fee = consultationFee();

            return (
                keccak256(
                    abi.encodePacked(
                        bytes(firstName)[0],
                        bytes(middleName)[bytes(middleName).length - 1],
                        bytes(lastName)[0],
                        serviceCode,
                        firstDigit(fee)
                    )
                ),
                fee
            );

        } else if (serviceCode == 2) {
            fee = documentsFee();

            return (
                keccak256(
                    abi.encode(
                        bytes(firstName)[0],
                        bytes(middleName)[bytes(middleName).length - 1],
                        bytes(lastName)[0],
                        serviceCode,
                        firstDigit(fee)
                    )
                ),
                fee
            );
        }

        revert("Invalid service code");
    }

    function firstDigit(uint256 number) internal pure returns (uint256) {
        while (number >= 10) {
            number /= 10;
        }
        return number;
    }
}
