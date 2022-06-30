const ethers = require("ethers");
const fs = require("fs-extra");
require("dotenv").config({ path: "./.env" });

async function main() {
    const provider = new ethers.providers.JsonRpcProvider(process.env.RPC_URL);

    const abi = fs.readFileSync(
        "./SimpleStorage_sol_SimpleStorage.abi",
        "utf8"
    );

    const contractAddress = "0x8b0a8C129208532649f46F2363d9fF2BA73B5fa4";
    const contract = new ethers.Contract(contractAddress, abi, provider);

    console.log(`Contract Address: ${contract.address}`);
    const updatedFavoriteNumber = await contract.getFavoriteNumber("jon");
    console.log(
        `Jon's favorite number(updated): ${updatedFavoriteNumber.toString()}`
    );
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
