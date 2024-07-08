program simple_token_o8clwxy.aleo {
    // The `Token` record datatype.
    record Token {
        // The token owner.
        owner: address,
        // The token amount.
        amount: u64,
    }

    // A global mapping to store balances of each address.
    mapping balances: address => u64;

    // The `mint` function initializes a new record with the
    // specified number of tokens assigned to the specified receiver.
    transition mint(owner: address, amount: u64) -> Token {
        // Update the balance mapping.
        balances[owner] += amount;

        return Token {
            owner: owner,
            amount: amount,
        };
    }

    // The `transfer` function sends the specified number of tokens
    // to the receiver from the provided token record.
    transition transfer(token: Token, to: address, amount: u64) -> (Token, Token) {
        // Checks the given token record has sufficient balance.
        // This `sub` operation is safe, and the proof will fail
        // if an overflow occurs.
        // `difference` holds the change amount to be returned to sender.
        let difference: u64 = token.amount - amount;

        // Update the balance mapping for the sender and the receiver.
        balances[token.owner] -= amount;
        balances[to] += amount;

        // Produce a token record with the change amount for the sender.
        let remaining: Token = Token {
            owner: token.owner,
            amount: difference,
        };

        // Produce a token record for the specified receiver.
        let transferred: Token = Token {
            owner: to,
            amount: amount,
        };

        // Output the sender's change record and the receiver's record.
        return (remaining, transferred);
    }

    // The `get_balance` function returns the balance of the specified address.
    function get_balance(owner: address) -> u64 {
        return balances[owner];
    }
}
