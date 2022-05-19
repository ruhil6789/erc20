// SPDX-License-Identifier: GPL-3.0
// The ERC20 Smart Contract

pragma solidity >=0.6.0 <0.9.0;

//ERC20 Interface
interface IERC20 {

    function stotalSupply() external view returns (uint256);
    function sbalanceOf(address account) external view returns (uint256);
    function sallowance(address owner, address spender) external view returns (uint256);

    function stransfer(address recipient, uint256 amount) external returns (bool);
    function sapprove(address spender, uint256 amount) external returns (bool);
    function stransferFrom(address sender, address recipient, uint256 amount) external returns (bool);


    event sTransfer(address indexed from, address indexed to, uint256 value);
    event sApproval(address indexed owner, address indexed spender, uint256 value);
}

//MyToken Contract - sachin
contract Sachin is IERC20 {

    string public constant name = "sachin";
    string public constant symbol = "soK";
    uint8 public constant decimals = 18;


    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
    event Transfer(address indexed from, address indexed to, uint tokens);


    mapping(address => uint256) balances;

    mapping(address => mapping (address => uint256)) allowed;

    uint256 totalSupply_ = 1000;

   constructor() public {
    balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public  view returns (uint256) {
    return totalSupply_;
    }

    function balanceOf(address tokenOwner) public view returns (uint256) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint256 numTokens) public  returns (bool) {
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - numTokens;
        balances[receiver] = balances[receiver] + numTokens;
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

    function approve(address delegate, uint256 numTokens) public  returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function allowance(address owner, address delegate) public  view returns (uint) {
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint256 numTokens) public returns (bool) {
        require(numTokens <= balances[owner]);
        require(numTokens <= allowed[owner][msg.sender]);

        balances[owner] = balances[owner] - numTokens;
        allowed[owner][msg.sender] = allowed[owner][msg.sender] - numTokens;
        balances[buyer] = balances[buyer] + numTokens;
        emit Transfer(owner, buyer, numTokens);
        return true;
    }
}






