
import UIKit

/*
{
    MaxCount = 2;
    Transactions =     (
                {
            Amount = 100;
            Attribute =             (
                                {
                    Data = 2090399656;
                    Usage = 0;
                },
                                {
 Data =override  747970653a746578742c6d73673ae6b58be8af95;
                    Usage = 129;
                }
            );
            ConfirmStatus = 62;
            Direction = Received;
            Fee = 0;
            Height = 535623;
            Inputs = "<null>";
            Memo = "\U6d4b\U8bd5";
            OutputPayload =             (
            );
            Outputs =             {
                ESAyto27X2rVJD4iqCaoqV38DcfEju4gMd = 100;
            };
            Payload = "<null>";
            Status = Confirmed;
            Timestamp = 1589187156;
            TxHash = 470fabdad12b743d9874acececd84d3476814815bdf157ee6696542795fdbaeb;
            Type = 2;
        }
    );
}
*/
class DetailsModel: NSObject {
    var amount: String = ""
    var direction: String = ""
    var height: String = ""
    var status: String = ""
    var timestamp: String = ""
    var confirmStatus: String = ""
    var txHash: String = ""
    var type: String = ""
    var fee: String = ""
    var inputs: String = ""
    var memo: String = ""
    var outputPayload: String = ""

    override init() {
    }
}
