This is a build script to generate the Trinity TypeScript types.

TS types are provided by each trinity plugin to match its JS classes and methods, and provided to DApp developers as a NPM package in order to get code completion and prototype verification in their DApps, as they develop DApps without a real access to Trinity plugins.

## Usage

### Package creation

Gather all types files from their respective plugins modules and aggregate them into a single types file:

- `cd dist`
- `npm run build`

The generated content will be available in dist/ and ready to publish to NPM.

# Publishing account

- Organization: @elastosfoundation
- Owner: @benjaminpiette

# How to publish to npmjs.com

- `npm adduser` (once)
- `npm login` (once)
- Increase version number in package.json
- `npm publish --access=public` (from the dist/ folder)

# How to install this tool (for DApp developers)

- `npm install -g @elastosfoundation/trinity-types`

# Types usage in TS DApps

    import { AppManager } from '@elastosfoundation/trinity-types';