package org.elastos.trinity.runtime;

import android.annotation.SuppressLint;
import android.content.Context;
import android.net.nsd.NsdManager;
import android.net.nsd.NsdServiceInfo;
import android.net.wifi.WifiManager;
import android.os.AsyncTask;
import android.os.Handler;
import android.util.Log;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.ProtocolException;
import java.net.URL;
import java.util.UUID;

public class CLIService implements NsdManager.DiscoveryListener, NsdManager.ResolveListener {
    private static final String TAG = "CLIService";
    private static final String SERVICE_TYPE = "_trinitycli._tcp.";

    private static CLIService cliService = null;
    private Context context;
    private AppManager appManager;
    private NsdManager nsdManager;
    private Boolean shouldRestartSearching = true;
    private Boolean operationCompleted = false;
    private Boolean isStarted = false;

    CLIService() {
        this.appManager = AppManager.getShareInstance();
        this.context = appManager.activity;

        nsdManager = (NsdManager)context.getSystemService(Context.NSD_SERVICE);
    }


    static CLIService getShareInstance() {
        if (CLIService.cliService == null) {
            CLIService.cliService = new CLIService();
        }
        return CLIService.cliService;
    }

    public void start() {
        if (isStarted) {
            return;
        }
        isStarted = true;
        //TODO::
//        searchForServices();
    }

    public void  stop() {
        isStarted = false;
        //TODO::
//        stopSearching(false);
    }

    private void searchForServices() {
        new Handler().postDelayed(() -> {
                Log.d(TAG, "Searching for local CLI service...");

            WifiManager wifi = (WifiManager) context.getSystemService(Context.WIFI_SERVICE);
            WifiManager.MulticastLock multicastLock = wifi.createMulticastLock("multicastLock");
            multicastLock.setReferenceCounted(true);
            multicastLock.acquire();

                shouldRestartSearching = true;
                operationCompleted = false;
                nsdManager.discoverServices(SERVICE_TYPE, NsdManager.PROTOCOL_DNS_SD, this);

                new Handler().postDelayed(() -> {
                    stopSearching(true);
                }, 20000);
            }, 5000);
    }

    private void stopSearching(Boolean shouldRestart) {
        Log.d(TAG, "Stopping service search.");

        shouldRestartSearching = shouldRestart;
        nsdManager.stopServiceDiscovery(this);
    }

    // Called as soon as service discovery begins.
    @Override
    public void onDiscoveryStarted(String regType) {
        Log.d(TAG, "Service discovery started");
    }

    @Override
    public void onServiceFound(NsdServiceInfo service) {
        Log.d(TAG, "Found CLI service on local network: "+service);

        nsdManager.resolveService(service, this);

        stopSearching(false);
    }

    @Override
    public void onServiceLost(NsdServiceInfo service) {
        // When the network service is no longer available.
        // Internal bookkeeping code goes here.
        Log.e(TAG, "service lost: " + service);
    }

    @Override
    public void onDiscoveryStopped(String serviceType) {
        Log.d(TAG, "Search stopped.");

        if (shouldRestartSearching) {
            // Restart searching
            searchForServices();
        }
    }

    @Override
    public void onStartDiscoveryFailed(String serviceType, int errorCode) {
        Log.e(TAG, "Discovery failed: Error code:" + errorCode);
        nsdManager.stopServiceDiscovery(this);
    }

    @Override
    public void onStopDiscoveryFailed(String serviceType, int errorCode) {
        Log.e(TAG, "Discovery failed: Error code:" + errorCode);
        nsdManager.stopServiceDiscovery(this);
    }

    @Override
    public void onResolveFailed(NsdServiceInfo nsdServiceInfo, int i) {
        Log.d(TAG, "Resolved failed");
    }

    @Override
    public void onServiceResolved(NsdServiceInfo nsdServiceInfo) {
        Log.d(TAG,"Service resolved");

        if (operationCompleted)
            return;

        // Got a resolved service info - we can call the service to get and install our EPK
        downloadEPK(nsdServiceInfo, (epkPath) -> {
            installEPK(epkPath);

            // Resume the bonjour search task for future EPKs.
            searchForServices();
        });
    }

    private interface DownloadListener {
        void onDownloadComplete(String epkPath);
    }

    @SuppressLint("StaticFieldLeak")
    private void downloadEPK(NsdServiceInfo nsdServiceInfo, DownloadListener completion) {
        String ipAddress = nsdServiceInfo.getHost().getHostAddress();
        if (ipAddress == null) {
            Log.d(TAG, "No IP address found for the service. Aborting EPK download.");
            return;
        }

        Log.d(TAG,"Downloading the remote EPK");

        // Watchguard to prevent downloading multiple times when IP address is resolved multiple times.
        operationCompleted = true;

        new AsyncTask<Void, Void, Void>() {
            @Override
            protected Void doInBackground(Void... voids) {
                try {
                    String serviceEndpoint = "http://"+ipAddress+":"+nsdServiceInfo.getPort()+"/downloadepk";
                    URL url = new URL(serviceEndpoint);
                    HttpURLConnection c = (HttpURLConnection) url.openConnection();

                    c.setRequestMethod("GET");
                    c.setDoOutput(true);
                    c.connect();

                    if (c.getResponseCode() >= 200 && c.getResponseCode() < 400) {
                        Log.d(TAG, "EPK file downloaded successfully with status code: "+c.getResponseCode());

                        Log.d(TAG, "Requesting app manager to install the EPK");

                        String tempFileName = UUID.randomUUID().toString()+".epk";
                        String destPath = context.getCacheDir() + "/" + tempFileName;

                        File outputFile = new File(destPath);
                        FileOutputStream fos = new FileOutputStream(outputFile);
                        InputStream is = c.getInputStream();

                        byte[] buffer = new byte[4096];
                        int len;

                        while ((len = is.read(buffer)) != -1)
                        {
                            fos.write(buffer, 0, len);
                        }

                        fos.close();
                        is.close();

                        completion.onDownloadComplete(destPath);
                    }
                    else {
                        Log.d(TAG, "Failed to download EPK with HTTP error "+c.getResponseCode());
                    }
                } catch (Exception e) {
                    Log.d(TAG, "Exception while downloading the EPK file");
                    e.printStackTrace();
                }

                return null;
            }
        }.execute(null, null, null);
    }

    private void installEPK(String epkPath) {
        appManager.setInstallUri(epkPath, true);
    }
}
