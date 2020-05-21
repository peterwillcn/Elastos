
/**
* This plugin allows you to switch the flashlight / torch of the device on and off.
*
* <br><br>
* Use 'Flashlight' in your dApp's manifest.json to use this plugin.
*
* <br><br>
* Usage:
* <br>
* declare let flashlight: CordovaFlashlightPlugin.Flashlight;
*/
declare namespace CordovaFlashlightPlugin {
    interface Flashlight {
        /**
         * To know if Flashlight is available on this device.
         *
         * @param {Function} callback The function to call to return the result if the flashlight is available.
         */
        available(callback: (avail: boolean) => void): void;

        /**
         * Switch on the flashlight.
         *
         * @param {Function} onSuccess The function to call in case of success
         * @param {Function} onFail    The function to call in case of error
         */
        switchOn(onSuccess?: () => void, onFail?: (message: string) => void): void;

        /**
         * Switch on the flashlight.
         *
         * @param {Function} onSuccess The function to call in case of success
         * @param {Function} onFail    The function to call in case of error
         */
        switchOff(onSuccess?: () => void, onFail?: (message: string) => void): void;

        /**
         * As an alternative to switchOn and switchOff.
         *
         * @param {Function} onSuccess The function to call in case of success
         * @param {Function} onFail    The function to call in case of error
         */
        toggle(onSuccess?: () => void, onFail?: (message: string) => void): void;

        /**
         * To know if the flashlight is on or off.
         *
         * @return  true/false
         */
        isSwitchedOn(): boolean;
    }
}