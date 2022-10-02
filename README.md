# Deku-C DApp Template

This is a minimal template you can fork to get started developing a Deku-C smart
contract with Ligo.

## Installing the Tools

You'll need to install [Ligo](https://ligolang.org/docs/intro/installation), the
[Tuna compiler](https://github.com/marigold-dev/tuna#building), and the
[Deku cli](FIXME:).

Additionally, our example frontend's dependencies requires npm.

If you have the Nix package manager, the provided flake has everything you need:

```
nix develop .
```

## Developing the Smart Contract

Our smart contract will be a simple counter lifted straight from the Ligo
tutorials. Users can submit operations to increment, decrement, or reset an on-chain
counter. The source is ./contract/main.jsligo.

On line 26 we define a simple test for the contract using Ligo's built-in test framework.
We can run the test with the commmand:
```
ligo run test ./contract/main.jsligo 
```
You'll see the following output indicating success:
```
- test_increment exited with value ().
```

Refer to the [Ligo documentation](https://ligolang.org/docs/intro/introduction) for
more on developing with Ligo, and don't hesitate to [reach out](https://ligolang.org/contact)!

## Compiling to Web Assembly

We'll compile our Ligo contract to WebAssembly with the Tuna compiler:
```
ligo compile ./contract/main.jsligo | tunac > compiled.wat
```

## Deploying to Deku-C

Next, we'll deploy the contract to the Deku-C betanet.

First, we'll need to create an identity to use with the Deku-C network.
```
deku-c create-identity
```
By default, `deku-c` uses `~/.deku-c/identity.json`.

Next, we can deploy the contract with an initial storage of `42`:

```
deku-c deploy ./compiled.wat 42
```

This will output Dk1 address that uniquely identifies the new contract.
Save this address for the next steps:
```sh
export CONTRACT_ADDRESS=<paste your Dk1 address>
```

## Testing out our Contract

Let's check the current state of our contract:
```
deku-c get-storage $CURRENT_ADDRESS
```

Next, let's invoke an `Increment` command. We'll have Ligo compile
the parameter expression for us:
```
parameters=$(ligo compile parameter ./contract/main.jsligo "Increment (32)" )
deku-c invoke $CURRENT_ADDRESS $parameters
```

## Running our Frontend

Our frontend is a simple React app that uses the [deku-client](FIXME:) library 
along with a Beacon-compatible Tezos wallet to interact with Deku-C.

(TODO: note about compatible wallets)

Install the dependencies for the frontend:
```
cd frontend
npm install
```

Make sure the `CONTRACT_ADDRESS` variable is still in the environment,
then start the development server:
```
npm run start
```

TODO: finish this and remaining sections
