# Initial setup (for node dependencies)

- `npm install`

# Development run command
- `npm getepksigner` (from the cli/ folder - only the first time (no bin folder) or to get new versions of the epksigner)
- `npm run devprepare && node bin/trinity xxxx` (from the dapp folder (for run command) )

# Publishing account

- Organization: @elastosfoundation
- Owner: @benjaminpiette

# How to publish to npmjs.com

- `npm adduser` (once)
- `npm login` (once)
- `npm run prepublish`
- `npm publish --access=public`

# How to install this tool (for DApp developers)

- `npm install -g @elastosfoundation/trinity-cli`

# How to execute this tool (for DApp developers)

- `trinity-cli`

## Examples

- Deploy a DApp on an android device: `trinity-cli run -p android`