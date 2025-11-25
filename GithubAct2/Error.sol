// SPDX-License-Identifier: MIT
pragma solidity ^ 0.8.20;

contract ErrorHandle{
    mapping(address => uint256) public valueMapping;

    function setValue(uint256 _value) public {
        require(_value != 0,  "Value cannot be zero");
        valueMapping[msg.sender] = _value;
    }

    function getValue() public view returns (uint256) {
        return  valueMapping [msg.sender];
    }

}