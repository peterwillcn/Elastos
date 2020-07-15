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
        node.ipv4 = "18.216.6.197"
        node.port = "33445"
        node.publicKey = "H8sqhRrQuJZ6iLtP2wanxt4LzdNrN2NNFnpPdq1uJ9n2"
        nodes.append(node)

        node = BootstrapNode()
        node.ipv4 = "52.83.171.135"
        node.port = "33445"
        node.publicKey = "5tuHgK1Q4CYf4K5PutsEPK5E3Z7cbtEBdx7LwmdzqXHL"
        nodes.append(node)

        node = BootstrapNode()
        node.ipv4 = "52.83.191.228"
        node.port = "33445"
        node.publicKey = "3khtxZo89SBScAMaHhTvD68pPHiKxgZT6hTCSZZVgNEm"
        nodes.append(node)

        options.bootstrapNodes = nodes
/*
        //Hive
        var expressNodes = Array<HiveBootstrapNode>()
        var expNode: HiveBootstrapNode

        expNode = HiveBootstrapNode()
        expNode.ipv4 = "ece00.trinity-tech.io"
        expNode.port = "443"
        expNode.publicKey = "FyTt6cgnoN1eAMfmTRJCaX2UoN6ojAgCimQEbv1bruy9"
        expressNodes.append(expNode)

        expNode = HiveBootstrapNode()
        expNode.ipv4 = "ece01.trinity-tech.io"
        expNode.port = "443"
        expNode.publicKey = "FyTt6cgnoN1eAMfmTRJCaX2UoN6ojAgCimQEbv1bruy9"
        expressNodes.append(expNode)

        expNode = HiveBootstrapNode()
        expNode.ipv4 = "ece01.trinity-tech.cn"
        expNode.port = "443"
        expNode.publicKey = "FyTt6cgnoN1eAMfmTRJCaX2UoN6ojAgCimQEbv1bruy9"
        expressNodes.append(expNode)

        options.hivebootstrapNodes = expressNodes
*/
        return options
    }
}
