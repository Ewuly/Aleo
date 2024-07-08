program simple_token_o8clwxy.aleo;

record Token:
    owner as address.private;
    amount as u64.private;

// A global mapping to store balances of each address.
mapping balances: address.private => u64.private;

function mint:
    input r0 as address.private;
    input r1 as u64.private;
    // Update the balance mapping.
    balances[r0] += r1;
    cast r0 r1 into r2 as Token.record;
    output r2 as Token.record;

function transfer:
    input r0 as Token.record;
    input r1 as address.private;
    input r2 as u64.private;
    // Checks the given token record has sufficient balance.
    sub r0.amount r2 into r3;
    // Update the balance mapping for the sender and the receiver.
    balances[r0.owner] -= r2;
    balances[r1] += r2;
    cast r0.owner r3 into r4 as Token.record;
    cast r1 r2 into r5 as Token.record;
    output r4 as Token.record;
    output r5 as Token.record;

// The `get_balance` function returns the balance of the specified address.
function get_balance:
    input r0 as address.private;
    balances[r0] into r1 as u64.private;
    output r1 as u64.private;
