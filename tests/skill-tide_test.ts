import {
  Clarinet,
  Tx,
  Chain,
  Account,
  types
} from 'https://deno.land/x/clarinet@v1.0.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

Clarinet.test({
  name: "Can create new skill",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    const wallet_1 = accounts.get("wallet_1");
    let block = chain.mineBlock([
      Tx.contractCall("skill-tide", "create-skill", 
        [types.ascii("Programming"), types.utf8("Full stack development"), types.int(40), types.int(-74)], 
        wallet_1.address
      )
    ]);
    assertEquals(block.receipts[0].result.expectOk(), "u1");
  },
});

Clarinet.test({
  name: "Can create swap request",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    const wallet_1 = accounts.get("wallet_1");
    let block = chain.mineBlock([
      Tx.contractCall("skill-tide", "create-swap-request",
        [types.uint(1), types.uint(2), types.int(40), types.int(-74)],
        wallet_1.address
      )
    ]);
    assertEquals(block.receipts[0].result.expectOk(), "u1");
  },
});
