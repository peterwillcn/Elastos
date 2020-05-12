import ElastosCarrierSDK

public class DefaultCarrierOptions {
    public static func createOptions (didSessionDID: String) -> CarrierOptions {
        let options = CarrierOptions()
        
        options.bootstrapNodes = [BootstrapNode]()
        options.hivebootstrapNodes = [HiveBootstrapNode]()
        options.udpEnabled = true

        let dataPath = NSHomeDirectory() + "/Documents/data"
        let dbPath = dataPath+"/contactnotifier/"+didSessionDID
        options.persistentLocation = dbPath

        var nodes = Array<BootstrapNode>()
        var node: BootstrapNode

        node = BootstrapNode()
        node.ipv4 = "13.58.208.50"
        node.port = "33445"
        node.publicKey = "89vny8MrKdDKs7Uta9RdVmspPjnRMdwMmaiEW27pZ7gh"
        nodes.append(node)

        node = BootstrapNode()
        node.ipv4 = "18.216.102.47"
        node.port = "33445"
        node.publicKey = "G5z8MqiNDFTadFUPfMdYsYtkUDbX5mNCMVHMZtsCnFeb"
        nodes.append(node)

        node = BootstrapNode()
        node.ipv4 = "52.83.127.216"
        node.port = "33445"
        node.publicKey = "4sL3ZEriqW7pdoqHSoYXfkc1NMNpiMz7irHMMrMjp9CM"
        nodes.append(node)

        node = BootstrapNode()
        node.ipv4 = "52.83.127.85"
        node.port = "33445"
        node.publicKey = "CDkze7mJpSuFAUq6byoLmteyGYMeJ6taXxWoVvDMexWC"
        nodes.append(node)

        node = BootstrapNode()
        node.ipv4 = "18.216.6.197"
        node.port = "33445"
        node.publicKey = "H8sqhRrQuJZ6iLtP2wanxt4LzdNrN2NNFnpPdq1uJ9n2"
        nodes.append(node)

        node = BootstrapNode()
        node.ipv4 = "52.83.171.135"
        node.port = "33445"
        node.publicKey = "5tuHgK1Q4CYf4K5PutsEPK5E3Z7cbtEBdx7LwmdzqXHL"
        nodes.append(node)

        options.bootstrapNodes = nodes
        
        return options
    }
}
