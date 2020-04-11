const React = require('react');

const TransactionHistoryElementIcon = (props) => {
  const item = props.item;
  if (item.type == 'input') {
    return (<img src="artwork/received-ela.svg"/>);
  }
  if (item.type == 'output') {
    return (<img src="artwork/sent-ela.svg"/>);
  }
  return (<div/>);
}

module.exports = (props) => {
  const App = props.App;
  const openDevTools = props.openDevTools;
  const Version = props.Version;
  const GuiToggles = props.GuiToggles;
  return (
  <table id="home" className="bordered w750h520px">
    <tbody>
      <tr>
        <td className="bordered w250px h20px ta_center va_top">
        </td>
        <td className="bordered w250px h20px ta_center va_top">
        </td>
        <td className="bordered w250px h20px ta_right va_top">
          <Version/>
          <button className="bgcolor_black_hover" title="menu">
            <img src="artwork/menu.svg" />
          </button>
          <button className="bgcolor_black_hover" title="Refresh Blockchain Data"  onClick={(e) => App.refreshBlockchainData()}>
            <img src="artwork/refresh-ccw.svg" />
          </button>
          <button className="bgcolor_black_hover">
            <img src="artwork/code.svg"  title="Show Dev Tools" onClick={(e) => openDevTools()}/>
          </button>
        </td>
      </tr>
      <tr>
        <td className="bordered w250px h200px ta_center va_top">
          <div id="branding" className="bordered w250px h90px bgcolor_black_hover">
            Branding
          </div>
          <div id="balance" className="bordered w250px h90px bgcolor_black_hover position_relative">
            <table>
              <tbody>
                <tr>
                  <td className="w50px">
                    <a className="rotate_n90 exit_link" target="_blank" href="https://api.coingecko.com/api/v3/simple/price?ids=elastos&vs_currencies=usd">Balance</a>
                  </td>
                  <td className="w100px ta_left">
                    <span className="font_size24">USD&nbsp;</span>
                    <span className="font_size24">{App.getUSDBalance()}</span>
                    <br />
                    <span className="color_orange">{App.getELABalance()}</span>
                    <span className="color_orange">&nbsp;ELA</span>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </td>
        <td className="bordered w200px h200px ta_center va_top">
          <div id="send" className="bordered w200px h200px bgcolor_black_hover">
            Send
          </div>
        </td>
        <td className="bordered w200px h200px ta_center va_top">
          <div id="receive" className="bordered w200px h100px bgcolor_black_hover">
            Receive
            <div className="ta_left">
              <div className="font_size12">Address</div>
              <button className="bgcolor_black">
                <img src="artwork/copy.svg" />
              </button>
              <span className="font_size12">{App.getAddress()}</span>
            </div>
          </div>
          <div id="receive" className="bordered w200px h100px bgcolor_black_hover">
            <div className="ta_left">
              <div className="font_size12">Ledger</div>
              <button className="bgcolor_black">
                <img src="artwork/smartphone.svg" />
              </button>
              <span className="font_size12">Verify Address on Ledger</span>
            </div>
          </div>
        </td>
      </tr>
      <tr>
        <td className="bordered w250px h200px ta_center va_top">
          <div id="staking" className="bordered w250px h110px bgcolor_black_hover position_relative">
            <table>
              <tbody>
                <tr>
                  <td className="w50px">
                    <div className="rotate_n90">Staking</div>
                  </td>
                  <td className="w150px ta_left">
                    <span className="font_size12">{App.getProducerListStatus()}</span>
                    <br/>
                    <span className="font_size12">{App.getParsedProducerList().totalvotes}</span>
                    <span className="font_size12">&nbsp;Votes</span>
                    <br/>
                    <span className="font_size12">{App.getParsedProducerList().totalcounts}</span>
                    <span className="font_size12">&nbsp;Counts</span>
                    <br/>
                    <span className="font_size12">{App.getParsedProducerList().producersCandidateCount}</span>
                    <span className="font_size12">&nbsp;Selected Candidates</span>
                    <br/>
                    <span className="font_size12">{App.getParsedProducerList().producers.length}</span>
                    <span className="font_size12">&nbsp;Candidates Total</span>
                    <div className="font_size24">Vote Now</div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <div id="news" className="bordered w250px h110px bgcolor_black_hover">
            <a className="exit_link" target="_blank" href="https://news.elastos.org/feed/">News</a>
          </div>
          <div className="bordered w250px h50px">
            <table className="w100pct">
              <tbody>
                <tr>
                  <td id="facebook" className="w50px h50px ta_center va_bottom bgcolor_black_hover">
                    <a className="exit_link" target="_blank" href="https://www.facebook.com/elastosorg/"><img src="artwork/facebook.svg" /></a>
                  </td>
                  <td id="twitter" className="w50px h50px ta_center va_bottom bgcolor_black_hover">
                    <a className="exit_link" target="_blank" href="https://twitter.com/Elastos_org"><img src="artwork/twitter.svg" /></a>
                  </td>
                  <td id="logout" className="w100px h50px ta_center va_bottom bgcolor_black_hover">

                  <button className="bgcolor_black_hover">
                    <img src="artwork/log-out.svg"  title="Logout" onClick={(e) =>
                  GuiToggles.showLanding()}/>
                  </button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </td>
        <td colSpan="2" className="bordered w400px h200px ta_center va_top">
          <div id="transactions" className="bordered w400px h300px bgcolor_black_hover font_size12">
            <div >Transaction List Status</div>
            <br/> {App.getTransactionHistoryStatus()}
            <div >Blockchain Status</div>
            <br/> {App.getBlockchainStatus()}
            <br/>
            <div className="display_inline_block">Previous Transactions ({App.getParsedTransactionHistory().length}
              total)</div>
            <div className="float_right display_inline_block">&nbsp;{App.getConfirmations()}&nbsp;
              Confirmations</div>
            <div className="float_right display_inline_block">&nbsp;{App.getBlockchainState().height}&nbsp;
              Blocks</div>
            <p></p>
            <div className="h100px overflow_auto">
              <table className="w100pct no_border whitespace_nowrap font_size12">
                <tbody>
                  <tr>
                    <td className="no_border no_padding">Nbr</td>
                    <td className="no_border no_padding">Icon</td>
                    <td className="no_border no_padding">Value</td>
                    <td className="no_border no_padding">TX</td>
                    <td className="no_border no_padding">Time</td>
                  </tr>
                  {
                    App.getParsedTransactionHistory().map((item, index) => {
                      return (<tr key={index}>
                        <td className="no_border no_padding">{item.n}</td>
                        <td className="no_border no_padding">
                          <TransactionHistoryElementIcon item={item}/>
                        </td>
                        <td className="no_border no_padding">{item.value}
                          ELA</td>
                        <td className="no_border no_padding">
                          <a className="exit_link" href={item.txDetailsUrl} onClick={(e) => onLinkClick(e)}>{item.txHash}</a>
                        </td>
                        <td className="no_border no_padding">
                          {item.time}
                        </td>
                      </tr>)
                    })
                  }
                </tbody>
              </table>
            </div>
          </div>
        </td>
      </tr>
    </tbody>
  </table>
  );
}
