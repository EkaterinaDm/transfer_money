pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Wallet {
    
    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    modifier checkOwnerAndAccept {
        require(msg.pubkey() == tvm.pubkey(), 100);
        tvm.accept();
		_;
	}

    function sendTransaction_NO_commissionPayment(address dest, uint128 value) public view checkOwnerAndAccept {
        dest.transfer(value, false, 0);
    }

    function sendTransaction_WITH_commissionPayment(address dest, uint128 value) public view checkOwnerAndAccept {
        dest.transfer(value, false, 1);
    }

    function sendAll_and_delete(address dest, uint128 value) public view checkOwnerAndAccept {
        dest.transfer(value, false, 160);
    }
}