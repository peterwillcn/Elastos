import ElastosCarrierSDK

public class DefaultCarrierOptions : CarrierOptions {
    init(path: String) {
        super.init()

        setOptions(path)
    }

    private func setOptions(path: String) {
        setUdpEnabled(true)
        setPersistentLocation(path) // path is used to cache carrier data for better performance

        var arrayList = Array<BootstrapNode>()
        var node: BootstrapNode

        node = BootstrapNode()
        node.setIpv4("13.58.208.50")
        node.setPort("33445")
        node.setPublicKey("89vny8MrKdDKs7Uta9RdVmspPjnRMdwMmaiEW27pZ7gh")
        arrayList.append(node)

        node = BootstrapNode()
        node.setIpv4("18.216.102.47");
        node.setPort("33445");
        node.setPublicKey("G5z8MqiNDFTadFUPfMdYsYtkUDbX5mNCMVHMZtsCnFeb");
        arrayList.append(node)

        node = BootstrapNode()
        node.setIpv4("52.83.127.216");
        node.setPort("33445");
        node.setPublicKey("4sL3ZEriqW7pdoqHSoYXfkc1NMNpiMz7irHMMrMjp9CM");
        arrayList.append(node)

        node = BootstrapNode()
        node.setIpv4("52.83.127.85");
        node.setPort("33445");
        node.setPublicKey("CDkze7mJpSuFAUq6byoLmteyGYMeJ6taXxWoVvDMexWC");
        arrayList.append(node)

        node = BootstrapNode()
        node.setIpv4("18.216.6.197");
        node.setPort("33445");
        node.setPublicKey("H8sqhRrQuJZ6iLtP2wanxt4LzdNrN2NNFnpPdq1uJ9n2");
        arrayList.append(node)

        node = BootstrapNode()
        node.setIpv4("52.83.171.135");
        node.setPort("33445");
        node.setPublicKey("5tuHgK1Q4CYf4K5PutsEPK5E3Z7cbtEBdx7LwmdzqXHL");
        arrayList.append(node)

        setBootstrapNodes(arrayList)
    }
}
