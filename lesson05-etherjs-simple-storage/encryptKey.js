const ethers = require("ethers");
const fs = require("fs-extra");
require("dotenv").config({ path: "./.env" });

async function main() {
  // @ts-ignore
  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY);
  // @ts-ignore
  const encryptedJSON = await wallet.encrypt(process.env.PRIVATE_KEY_PASSWORD);
  console.log(encryptedJSON);
  fs.writeFileSync("encryptedKey.json", encryptedJSON);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
