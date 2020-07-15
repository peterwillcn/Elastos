// Type definitions for cordova-plugin-device 2.0
// Project: https://github.com/apache/cordova-plugin-device
// Definitions by: Microsoft Open Technologies Inc <http://msopentech.com>
//                 Tim Brust <https://github.com/timbru31>
// Definitions: https://github.com/DefinitelyTyped/DefinitelyTyped

/**
 * This plugin provides an API for getting the device's hardware and software information.
 * <br><br>
 * Please use 'Device' as the plugin name in the manifest.json if you want to use
 * this facility.
 * <br><br>
 * Usage:
 * <br>
 * device.getInfo((info)=>{console.log(info.platform)}, (err)=>{});
 */

declare namespace CordovaDevicePlugin {
    /**
    * The device information.
    */
    type DeviceInfo = {
        /** Get the version of Cordova running on the device. */
        cordova: string;
        /** Indicates that Cordova initialize successfully. */
        available: boolean;
        /**
         * The device.model returns the name of the device's model or product. The value is set
         * by the device manufacturer and may be different across versions of the same product.
         */
        model: string;
        /** Get the device's operating system name. */
        platform: string;
        /** Get the device's Universally Unique Identifier (UUID). */
        uuid: string;
        /** Get the operating system version. */
        version: string;
        /** Get the device's manufacturer. */
        manufacturer: string;
        /** Whether the device is running on a simulator. */
        isVirtual: boolean;
        /** Get the device hardware serial number. */
        serial: string;
    }

    interface Device {
        /**
         * Get device info
         *
         * @param {Function} onSuccess The function to call when the heading data is available
         * @param {Function} onError The function to call when there is an error getting the heading data. (OPTIONAL)
         */
        getInfo(onSuccess: (info: DeviceInfo)=>void, onError?:(err: string)=>void);
    }
}

declare var device: CordovaDevicePlugin.Device;