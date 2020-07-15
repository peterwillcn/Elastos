
/**
* The plugin creates the object CordovaClipboardPlugin.Clipboard with the methods copy(text, onSuccess, onError),
* paste(onSuccess, onError) and clear(onSuccess, onError)
*
* <br><br>
* Use 'Clipboard' in your dApp's manifest.json to use this plugin.
*
* <br><br>
* Usage:
* <br>
* declare let clipboard: CordovaClipboardPlugin.Clipboard;
*/
declare namespace CordovaClipboardPlugin {
    interface Clipboard {
        /**
         * Sets the clipboard content
         *
         * @param {String}   text      The content to copy to the clipboard
         * @param {Function} onSuccess The function to call in case of success (takes the copied text as argument)
         * @param {Function} onFail    The function to call in case of error
         */
        copy(text, onSuccess?: (text: string) => void, onFail?: (message: string) => void): void;

        /**
         * Gets the clipboard content
         *
         * @param {Function} onSuccess The function to call in case of success
         * @param {Function} onFail    The function to call in case of error
         */
        paste(onSuccess?: (text: string) => void, onFail?: (message: string) => void): void;

        /**
         * Clear the clipboard content
         *
         * @param {Function} onSuccess The function to call in case of success
         * @param {Function} onFail    The function to call in case of error
         */
        clear(onSuccess?: () => void, onFail?: (message: string) => void): void;
    }
}