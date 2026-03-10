
// scripts/events-counter.js 

const { Web3 } = require("web3"); 

require("dotenv").config(); 

const { COUNTER_ABI } = require("./abi.cjs"); 

  

const RPC_URL  = process.env.SEPOLIA_RPC_URL; 

const CONTRACT = '0x12407ba16F41E8408a51648051896058d2aDe6F0'; 

  

async function main() { 

  const web3 = new Web3(RPC_URL); 

  const counter = new web3.eth.Contract(COUNTER_ABI, CONTRACT); 

  

  // Fetch all CountIncremented events from block 0 to latest 

const currentBlock = await web3.eth.getBlockNumber();
  const fromBlock = currentBlock - 9n;
  const events = await counter.getPastEvents(
    'CountIncremented',
    { fromBlock: fromBlock, toBlock: 'latest' }
  );

  

  console.log(`Found ${events.length} CountIncremented event(s):`); 

  events.forEach((e, i) => { 

    console.log(`  [${i+1}] block ${e.blockNumber}`, 

      '| by:', e.returnValues.by, 

      '| newCount:', e.returnValues.newCount.toString()); 

  }); 

} 

  

main().catch(console.error); 

