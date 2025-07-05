const fs = require("fs");
const path = require("path");
const solc = require("solc");
const { ethers } = require("ethers");

async function main() {
    const provider = new ethers.providers.JsonRpcProvider("http://localhost:8545");
    const signer = provider.getSigner(0);

    const sourcePath = path.resolve(__dirname, "../src/nft.sol");
    const source = fs.readFileSync(sourcePath, "utf8");

    const input = {
        language: "Solidity",
        sources: {
            "nft.sol": {
                content: source,
            },
        },
        settings: {
            outputSelection: {
                "*": {
                    "*": ["abi", "evm.bytecode"],
                },
            },
        },
    };

    function findImports(importPath) {
        try {
            const fullPath = path.resolve(__dirname, "../node_modules", importPath);
            const content = fs.readFileSync(fullPath, "utf8");
            return { contents: content };
        } catch (e) {
            return { error: `File not found: ${importPath}` };
        }
    }

    const output = JSON.parse(solc.compile(JSON.stringify(input), { import: findImports }));

    if (output.errors) {
        output.errors.forEach((err) => console.error(err.formattedMessage));
    }

    const contractData = output.contracts["nft.sol"]["nft"];
    const bytecode = contractData.evm.bytecode.object;
    const abi = contractData.abi;

    const factory = new ethers.ContractFactory(abi, bytecode, signer);
    const contract = await factory.deploy();
    await contract.deployed();

    console.log("nft deployed to:", contract.address);
}

main().catch((error) => {
    console.error(error);
    process.exit(1);
});
