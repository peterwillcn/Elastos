//
//  CLIService.swift
//  elastOS
//
//  Created by Benjamin Piette on 28/02/2020.
//

import Foundation
import MultipeerConnectivity

public class CLIService: NSObject, NetServiceBrowserDelegate, NetServiceDelegate {
    private static var cliService: CLIService?;
    var serviceBrowser: NetServiceBrowser?
    var services = [NetService]()
    var shouldRestartSearching = true
    var operationCompleted = false
    let appManager: AppManager!
    var isStarted = false;
    
    override init() {
        self.appManager = AppManager.getShareInstance();
        super.init()
    }
    
    static func getShareInstance() -> CLIService {
        if (CLIService.cliService == nil) {
            CLIService.cliService = CLIService();
        }
        return CLIService.cliService!;
    }
    
    func start() {
        if (isStarted) {
            return;
        }
        isStarted = true;
        searchForServices()
    }
    
    func stop() {
        isStarted = false;
        stopSearching(shouldRestart: false);
    }
    
    private func log(_ str: String) {
        print("CLIService - \(str)")
    }
    
    private func searchForServices() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            self.log("Searching for local CLI service...")
            
            if (self.serviceBrowser == nil) {
                self.serviceBrowser = NetServiceBrowser()
                self.serviceBrowser!.delegate = self
            }
            
            self.shouldRestartSearching = true
            self.operationCompleted = false
            self.serviceBrowser!.searchForServices(ofType: "_trinitycli._tcp.", inDomain: "")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(20), execute: {
                self.stopSearching(shouldRestart: true)
            })
        })
    }
    
    private func stopSearching(shouldRestart: Bool) {
        guard serviceBrowser != nil else {
            return;
        }
        
        log("Stopping service search.")
        
        self.shouldRestartSearching = shouldRestart
        serviceBrowser!.stop()
    }
    
    public func netServiceBrowserDidStopSearch(_ browser: NetServiceBrowser) {
        log("Search stopped.")
        
        self.serviceBrowser = nil
        
        if self.shouldRestartSearching {
            // Restart searching
            self.searchForServices()
        }
    }
    
    public func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        log("Found CLI service on local network: \(service)")
        
        services.append(service)
        service.delegate = self
        service.resolve(withTimeout:10)

        self.stopSearching(shouldRestart: false)
    }
    
    public func netServiceDidResolveAddress(_ service: NetService) {
        guard !operationCompleted else {
            return
        }
        
        // Got a resolved service info - we can call the service to get and install our EPK
        downloadEPK(usingService: service) { epkPath in
            self.log("Requesting app manager to install the EPK")
            self.installEPK(epkPath: epkPath)
            // Resume the bonjour search task for future EPKs.
            self.searchForServices()
        }
    }
    
    private func getServiceIPAddress(_ service: NetService) -> String? {
        guard service.addresses != nil else {
            return nil
        }
        
        for address in service.addresses! {
            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
            address.withUnsafeBytes { ptr in
                guard let sockaddr_ptr = ptr.baseAddress?.assumingMemoryBound(to: sockaddr.self) else {
                    return
                }
                let sockaddr = sockaddr_ptr.pointee
                guard getnameinfo(sockaddr_ptr, socklen_t(sockaddr.sa_len), &hostname, socklen_t(hostname.count), nil, 0, NI_NUMERICHOST) == 0 else {
                    return
                }
            }
            let ipAddress = String(cString:hostname)
            
            // Check if the resolved ip address is a ipv4 address, not ipv6.
            if ipAddress.contains(":") {
                continue
            }
            
            log("Resolved CLI service IP address: \(ipAddress) port: \(service.port)")
        
            return ipAddress
        }
        
        return nil
    }
    
    private func downloadEPK(usingService service: NetService, completion: @escaping (String)->Void) {
        // Compute the service's download EPK URL
        guard let ipAddress = getServiceIPAddress(service) else {
            log("No IP address found for the service. Aborting EPK download.")
            return
        }
        
        // Watchguard to prevent downloading multiple times when IP address is resolved multiple times.
        self.operationCompleted = true
        
        let serviceEndpoint = "http://\(ipAddress):\(service.port)/downloadepk"
        
        // Call the service to download the EPK file
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let url = URL(string: serviceEndpoint)!
        let request = try! URLRequest(url: url, method: .get)

        log("Downloading EPK file at url \(serviceEndpoint)")
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    if (statusCode >= 200 && statusCode < 400) {
                        self.log("EPK file downloaded successfully with status code: \(statusCode)")
                        
                        // Copy EPK file to a temp location as it's going to be deleted after download by the session.
                        let destTempUrl = FileManager.default.temporaryFileURL(fileName: "appinstall.epk")!
                        do {
                            // Delete the target file in case it already exists
                            try? FileManager.default.removeItem(at: destTempUrl)
                            // Copy the downloaded file to a file that won't be deleted by the network session
                            try FileManager.default.copyItem(at: tempLocalUrl, to: destTempUrl)
                            
                            completion(destTempUrl.absoluteString)
                        }
                        catch {
                            self.log("Failed copy the EPK file. \(error)")
                        }
                    }
                    else {
                        self.log("Failed to download EPK with HTTP error \(statusCode)")
                    }
                }
                else {
                    self.log("Failed to download EPK with unknown HTTP error")
                }
            } else {
                self.log("Failure: \(error?.localizedDescription ?? "?")");
            }
        }
        task.resume()
    }
     
    private func installEPK(epkPath: String) {
        DispatchQueue.main.async {
            do {
                _ = try AppManager.getShareInstance().install(epkPath, true)
            }
            catch AppError.error(let err) {
                alertDialog("Install Error", err);
            } catch let error {
                alertDialog("Install Error", error.localizedDescription);
            }
        }
    }
}
