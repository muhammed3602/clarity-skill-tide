import {
  Clarinet,
  Tx,
  Chain,
  Account,
  types
} from 'https://deno.land/x/clarinet@v1.0.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

Clarinet.test({
  name: "Can add rating",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    const wallet_1 = accounts.get("wallet_1");
    const wallet_2 = accounts.get("wallet_2");
    let block = chain.mineBlock([
      Tx.contractCall("reputation", "add-rating",
        [types.principal(wallet_2.address), types.uint(5)],
        wallet_1.address
      )
    ]);
    assertEquals(block.receipts[0].result.expectOk(), true);
  },
});
