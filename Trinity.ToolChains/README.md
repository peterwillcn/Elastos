# Elastos.Trinity.ToolChains

## Tutorial

### Starting a New Ionic App

To start a new app, open your terminal/command prompt and run:

```bash
$ ionic start helloWorld tutorial
```

For more detail about Ionic, please visit [here](https://ionicframework.com/docs/).

### Viewing the app in a browser

Start Ionic Lab for multi-platform dev/testing:

```bash
$ cd helloWorld/
$ ionic lab
```

NOTE: `ionic lab` is just a convenient shortcut for `ionic serve --lab`.

### Testing and debugging the app on a device

Before a production build, you may want to test your App on a device.

And you don't want to pack and install your app again and again when you debugging your code.

You could follow these instructions:

1. Serve your App

   ```bash
   $ ionic serve --no-open
   ...
   [INFO] Development server running!

       Local: http://localhost:8100
       External: http://192.168.0.2:8100
   ...
   ```

   Please remember the `External` URL. It's needed for the next step.

1. Create a `manifest_debug.xml` like this:

   ```xml
   <?xml version='1.0' encoding='utf-8'?>
   <dapp id="com.mycompany.myapp" version="0.0.1"
       xmlns="http://mycompany.com/ns/dapps/1.0">
       <name>My App</name>
       <description>My Sample App</description>
       <launch_path>http://192.168.0.2:8100</launch_path>>
       <icons>
           <big>logo.png</big>
           <small>logo.png</small>
       </icons>
       <author name = "MyName" email = "myname@mycompany.com">
       My Name
       </author>
       <default_locale>en</default_locale>
       <urls>
           <access href="http://192.168.0.2:8100/*" />
       </urls>
   </dapp>
   ```

   The `launch_path` of the `manifest_debug.xml` is intended set to the external URL of the previous step.

1. Create a wrapper app with the debug manifest XML file

   We only pack the XML and a logo file to the EPK.

   ```bash
   $ trinity_deploy --manifest manifest_debug.xml --root-dir helloWorld/src/assets/imgs/ helloWorld_wrapper.epk
   ```

   NOTE: You could type `trinity_deploy --help` for more details.

1. Install and test your app

   Install the wrapper EPK file and launch the DApp for debugging.

   If the `URL authority request` dialog pops up, click `ALLOW`. Then click the back button return back to launcher app. And launch your wrapper DApp again to load your pages from the host computer.

1. Use browser to inspect and debug the pages

   Open Chrome browser and visit `chrome://inspect` to inspect your DApp pages.

### Deploy your DApp

After test, you may want to deploy your DApp as a product.

1. Create a production manifest XML file

   Create a `manifest_prod.xml` like this:

   ```xml
   <?xml version='1.0' encoding='utf-8'?>
   <dapp id="com.mycompany.myapp" version="0.0.1"
      xmlns="http://mycompany.com/ns/dapps/1.0">
      <name>My App</name>
      <description>My Sample App</description>
      <launch_path>index.html</launch_path>>
      <icons>
          <big>assets/imgs/logo.png</big>
          <small>assets/imgs/logo.png</small>
      </icons>
      <author name = "MyName" email = "myname@mycompany.com">
      My Name
      </author>
      <default_locale>en</default_locale>
   </dapp>
   ```

1. Generate production code

   Run this command inside the `helloWorld` folder to generate the production code:

   ```bash
   $ ionic build --prod
   ```

1. Create a production EPK file

   ```bash
   $ trinity_deploy --manifest manifest_prod.xml --root-dir helloWorld/www/ helloWorld.epk
   ```