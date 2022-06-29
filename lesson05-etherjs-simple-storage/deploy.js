const ethers = require("ethers");
const fs = require("fs-extra");

async function main() {
  const provider = new ethers.providers.JsonRpcProvider(
    "HTTP://172.31.208.1:7545"
  );
  const wallet = new ethers.Wallet(
    "4c31aac42214dd19d4f72d624e9571493c6caa95301fff5268fca0bf33d1cd34",
    provider
  );
  const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8");
  const binary = fs.readFileSync(
    "./SimpleStorage_sol_SimpleStorage.bin",
    "utf8"
  );

  const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
  console.log("Start deploying...");
  // await = Stop and wait for the Promise
  const contract = await contractFactory.deploy();
  const transactionReceipt = await contract.deployTransaction.wait(1);
  // console.log("Deployment Transaction");
  // console.log(contract.deployTransaction);
  // console.log("Transaction Receipt after waiting for 1+ block");
  // console.log(transactionReceipt);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
