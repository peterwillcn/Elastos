webpackJsonp([13], {
  124: function(l, n, t) {
    "use strict";
    t.d(n, "a", function() {
      return e
    });
    t(1);
    var e = function() {
      function l(l) {
        this.translate = l, this.keyText = ""
      }
      return l.prototype.ngOnInit = function() {
        this.text = this.translate.instant(this.keyText)
      }, l
    }()
  },
  171: function(l, n, t) {
    "use strict";
    t.d(n, "a", function() {
      return e
    });
    t(1);
    var e = function() {
      function l(l) {
        this.translate = l, this.des = this.translate.instant("text-sycn-message"), this.length = {
          width: "0%",
          transition: "width 1s",
          "-webkit-transition": "width 1s"
        }
      }
      return l.prototype.ngOnInit = function() {
        this.setData()
      }, l.prototype.setData = function() {
        this.proportion = this.proportion.replace(/%/g, ""), this.proportion ? "0" === this.proportion || 0 === this.proportion ? this.proportion = "0" : this.proportion += "%" : this.proportion = "0", this.length.width = this.proportion
      }, l.prototype.ngOnChanges = function(l) {
        this.setData()
      }, l
    }()
  },
  215: function(l, n, t) {
    "use strict";
    t.d(n, "a", function() {
      return s
    });
    t(1);
    var e = t(216),
      a = (t.n(e), t(454)),
      u = (t.n(a), t(227)),
      i = t(31),
      s = function() {
        function l(l) {
          this.http = l
        }
        return n = l, l.prototype.getByAuth = function(l, t) {
          var e = new u.d({
            "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
          });
          return a.Observable.fromPromise(this.http.get(l, new u.g({
            search: n.buildURLSearchParams(t),
            headers: e
          })).toPromise().then(function(l) {
            return l
          }, function(l) {
            return l
          }))
        }, l.prototype.postByAuth = function(l, t) {
          var e = new u.d({
            "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
            Accept: "application/json;charset=utf-8"
          });
          return this.http.post(l, n.buildURLSearchParams(t).toString(), new u.g({
            headers: e
          }))
        }, l.buildURLSearchParams = function(l) {
          var n = new u.i;
          for (var t in l) {
            var e = l[t];
            e instanceof Date && (e = i.a.dateFormat(e, "yyyy-MM-dd HH:mm:ss")), n.set(t, e)
          }
          return n
        }, l;
        var n
      }()
  },
  228: function(l, n, t) {
    "use strict";
    t.d(n, "a", function() {
      return u
    });
    t(1);
    var e = t(734),
      a = (t.n(e), t(36)),
      u = function() {
        function l() {}
        return l.info = function(l) {
          if (a.a.isDebug) {
            var n = "elastos==" + (e.isString(l) ? l : JSON.stringify(l));
            console.log(n, "color:#e8c406")
          }
        }, l
      }()
  },
  246: function(l, n, t) {
    "use strict";
    t.d(n, "a", function() {
      return e
    });
    t(1), t(171), t(124);
    var e = function() {
      return function() {}
    }()
  },
  256: function(l, n) {
    function t(l) {
      return Promise.resolve().then(function() {
        throw new Error("Cannot find module '" + l + "'.")
      })
    }
    t.keys = function() {
      return []
    }, t.resolve = t, l.exports = t, t.id = 256
  },
  287: function(l, n, t) {
    function e(l) {
      var n = a[l];
      return n ? t.e(n[1]).then(function() {
        return t(n[0])
      }) : Promise.reject(new Error("Cannot find module '" + l + "'."))
    }
    var a = {
      "../pages/about/about.module.ngfactory": [836, 12],
      "../pages/supernodeelection/superpoint/iconpromptbox/iconpromptbox.module.ngfactory": [837, 11],
      "../pages/supernodeelection/superpoint/inputpassword/inputpassword.module.ngfactory": [838, 10],
      "../pages/supernodeelection/superpoint/inputtickets/inputtickets.module.ngfactory": [839, 9],
      "../pages/supernodeelection/superpoint/joinvotelist/joinvotelist.module.ngfactory": [840, 8],
      "../pages/supernodeelection/superpoint/lockdetails/lockdetails.module.ngfactory": [841, 7],
      "../pages/supernodeelection/superpoint/myvote/myvote.module.ngfactory": [842, 6],
      "../pages/supernodeelection/superpoint/nodeinformation/nodeinformation.module.ngfactory": [843, 5],
      "../pages/supernodeelection/superpoint/pointvote/pointvote.module.ngfactory": [844, 4],
      "../pages/supernodeelection/superpoint/signup/signup.module.ngfactory": [845, 3],
      "../pages/supernodeelection/superpoint/superpoint.module.ngfactory": [846, 2],
      "../pages/supernodeelection/superpoint/votemanage/votemanage.module.ngfactory": [847, 1],
      "../pages/supernodeelection/superpoint/votingrules/votingrules.module.ngfactory": [848, 0]
    };
    e.keys = function() {
      return Object.keys(a)
    }, e.id = 287, l.exports = e
  },
  31: function(l, n, t) {
    "use strict";
    t.d(n, "a", function() {
      return a
    });
    t(1);
    var e = t(36),
      a = function() {
        function l() {}
        return l.isNull = function(l) {
          return "" === l || void 0 === l || null === l
        }, l.isMnemonicValid = function(l) {
          return 12 == l.split(/[\u3000\s]+/).length
        }, l.isAddressValid = function(l) {
          return 34 == l.length
        }, l.isEmptyObject = function(l) {
          for (var n in l)
            if (l.hasOwnProperty(n)) return !1;
          return !0
        }, l.dateFormat = function(l, n) {
          void 0 === n && (n = "yyyy-MM-dd");
          var t = {
            Year: 0,
            TYear: "0",
            Month: 0,
            TMonth: "0",
            Day: 0,
            TDay: "0",
            Hour: 0,
            THour: "0",
            hour: 0,
            Thour: "0",
            Minute: 0,
            TMinute: "0",
            Second: 0,
            TSecond: "0",
            Millisecond: 0
          };
          return t.Year = l.getFullYear(), t.TYear = String(t.Year).substr(2), t.Month = l.getMonth() + 1, t.TMonth = t.Month < 10 ? "0" + t.Month : String(t.Month), t.Day = l.getDate(), t.TDay = t.Day < 10 ? "0" + t.Day : String(t.Day), t.Hour = l.getHours(), t.THour = t.Hour < 10 ? "0" + t.Hour : String(t.Hour), t.hour = t.Hour < 13 ? t.Hour : t.Hour - 12, t.Thour = t.hour < 10 ? "0" + t.hour : String(t.hour), t.Minute = l.getMinutes(), t.TMinute = t.Minute < 10 ? "0" + t.Minute : String(t.Minute), t.Second = l.getSeconds(), t.TSecond = t.Second < 10 ? "0" + t.Second : String(t.Second), t.Millisecond = l.getMilliseconds(), n.replace(/yyyy/gi, String(t.Year)).replace(/yyy/gi, String(t.Year)).replace(/yy/gi, t.TYear).replace(/y/gi, t.TYear).replace(/MM/g, t.TMonth).replace(/M/g, String(t.Month)).replace(/dd/gi, t.TDay).replace(/d/gi, String(t.Day)).replace(/HH/g, t.THour).replace(/H/g, String(t.Hour)).replace(/hh/g, t.Thour).replace(/h/g, String(t.hour)).replace(/mm/g, t.TMinute).replace(/m/g, String(t.Minute)).replace(/ss/gi, t.TSecond).replace(/s/gi, String(t.Second)).replace(/fff/gi, String(t.Millisecond))
        }, l.checkCellphone = function(l) {
          return !/^1[3|4|5|8|9|7][0-9]\d{4,8}$/.test(l)
        }, l.objtoarr = function(l) {
          var n = [];
          for (var t in l) n.push(l[t]);
          return n
        }, l.GetQueryString = function(l) {
          var n = new RegExp("(^|&)" + l + "=([^&]*)(&|$)"),
            t = window.location.search.substr(1).match(n);
          return null != t ? decodeURI(t[2]) : null
        }, l.isCardNo = function(l) {
          return !/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/.test(l)
        }, l.isBankCard = function(l) {
          return !/^(998801|998802|622525|622526|435744|435745|483536|528020|526855|622156|622155|356869|531659|622157|627066|627067|627068|627069|622588)\d{10}$/.test(l)
        }, l.isWallNameExit = function(l) {
          var n = e.a.getMappingList();
          if (this.isEmptyObject(n)) return !1;
          var t = !0;
          for (var a in n) {
            if (n[a].wallname === l) {
              t = !0;
              break
            }
            t = !1
          }
          return t
        }, l.scientificToNumber = function(l) {
          var n, t, e = l.toString(),
            a = /^(\d+)(e)([\-]?\d+)$/,
            u = "";
          if (a.test(e)) {
            n = a.exec(e), t = Math.abs(n[3]) - 1;
            for (var i = 0; i < t; i++) u += "0";
            return "0." + u + n[1]
          }
          return l
        }, l.email = function(l) {
          return /^[a-zA-Z0-9.!#$%&*+=?^_{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/.test(l)
        }, l.phone = function(l) {
          return /^((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0,5-9]))\d{8}$/.test(l)
        }, l.username = function(l) {
          return /^[a-zA-Z0-9_-]{4,16}$/.test(l)
        }, l.password = function(l) {
          return !(l.length < 8)
        }, l.number = function(l) {
          return /^(([1-9]\d*)|\d)(\.\d{1,9})?$/.test(l)
        }, l.isWalletName = function(l) {
          return l.length > 30
        }, l
      }()
  },
  36: function(l, n, t) {
    "use strict";
    t.d(n, "a", function() {
      return e
    });
    t(1);
    var e = function() {
      function l() {}
      return l.getKycObj = function() {
        return this.kycObj
      }, l.setKycObj = function(l) {
        this.kycObj = l
      }, l.setDeviceID = function(l) {
        this.deviceID = l
      }, l.getdeviceID = function() {
        return this.deviceID
      }, l.getSerIds = function() {
        return this.serIds
      }, l.setSerIds = function(l) {
        console.info("Elastjs setSerIds serIds " + JSON.stringify(l)), this.serIds = l
      }, l.add = function(l, n, t, e) {
        for (var a in l[t][e]) {
          var u = l[t][e][a];
          n[a] = {
            id: t,
            path: e,
            serialNum: u.serialNum,
            txHash: u.txHash
          }
        }
      }, l.getSertoId = function(l) {
        var n = {};
        for (var t in l) {
          var e = t,
            a = l[e],
            u = "enterprise";
          a[u] && this.add(l, n, e, u), a[u = "identityCard"] && this.add(l, n, e, u), a[u = "phone"] && this.add(l, n, e, u), a[u = "bankCard"] && this.add(l, n, e, u)
        }
        return n
      }, l.getCurMasterWalletId = function() {
        return this.masterWalletId
      }, l.setCurMasterWalletId = function(l) {
        this.masterWalletId = l
      }, l.getMasterWalletIdList = function() {
        return this.masterWalletList
      }, l.setMasterWalletIdList = function(l) {
        this.masterWalletList = l
      }, l.uuid = function(l, n) {
        var t, e = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".split(""),
          a = [];
        if (n = n || e.length, l)
          for (t = 0; t < l; t++) a[t] = e[0 | Math.random() * n];
        else {
          var u;
          for (a[8] = a[13] = a[18] = a[23] = "-", a[14] = "4", t = 0; t < 36; t++) a[t] || (u = 0 | 16 * Math.random(), a[t] = e[19 == t ? 3 & u | 8 : u])
        }
        return a.join("")
      }, l.setMasterPer = function(l, n, t) {
        this.perObj[l] ? this.perObj[l][n] = t : (this.perObj[l] = {}, this.perObj[l][n] = t)
      }, l.getMasterPer = function(l, n) {
        return this.perObj[l] ? this.perObj[l][n] || 0 : 0
      }, l.setMappingList = function(l) {
        this.mappingList = l
      }, l.getMappingList = function() {
        return this.mappingList
      }, l.objtoarr = function(l) {
        var n = [];
        for (var t in l) n.push(l[t]);
        return n
      }, l.getWalletName = function(l) {
        return this.mappingList[l].wallname || ""
      }, l.setWalletName = function(l, n) {
        this.mappingList[l].wallname = n
      }, l.getSubWallet = function(l) {
        return this.mappingList[l].coinListCache || null
      }, l.isResregister = function(l, n) {
        return !!this.walletResregister[l] && (!!this.walletResregister[l][n] && this.walletResregister[l][n])
      }, l.setResregister = function(l, n, t) {
        this.walletResregister[l] ? this.walletResregister[l][n] = t : (this.walletResregister[l] = {}, this.walletResregister[l][n] = t)
      }, l.getAccountType = function(l) {
        return this.mappingList[l].Account || {}
      }, l.isDebug = !1, l.masterWallObj = {
        id: "",
        wallname: ""
      }, l.perObj = {}, l.masterWalletId = "1", l.masterWalletList = [], l.mappingList = {}, l.SELA = 1e8, l.BLOCKCHAIN_URL = "https://blockchain.elastos.org/", l.kycObj = {}, l.deviceID = "", l.serIds = {}, l.walletResregister = {}, l
    }()
  },
  4: function(l, n, t) {
    "use strict";
    t.d(n, "a", function() {
      return a
    });
    t(1), t(14), t(214);
    var e = t(228),
      a = function() {
        function l(l, n, t, e, a, u) {
          this.toastCtrl = l, this.clipboard = n, this.translate = t, this.app = e, this.loadingCtrl = a, this.http = u, this.mnemonicLang = "english", this.loadingIsOpen = !1
        }
        return l.prototype.info = function(l) {
          e.a.info(l)
        }, l.prototype.toast = function(l, n) {
          void 0 === l && (l = "操作完成"), void 0 === n && (n = 2e3), this.toastCtrl.create({
            message: l,
            duration: 2e3,
            position: "top"
          }).present()
        }, l.prototype.toast_trans = function(l, n) {
          void 0 === l && (l = ""), void 0 === n && (n = 2e3), l = this.translate.instant(l), this.toastCtrl.create({
            message: l,
            duration: 2e3,
            position: "top"
          }).present()
        }, l.prototype.copyClipboard = function(l) {
          return this.clipboard.copy(l)
        }, l.prototype.Go = function(l, n, t) {
          void 0 === t && (t = {}), l.push(n, t)
        }, l.prototype.setRootRouter = function(l) {
          this.app.getRootNav().setRoot(l)
        }, l.prototype.getMnemonicLang = function() {
          return this.mnemonicLang
        }, l.prototype.setMnemonicLang = function(l) {
          this.mnemonicLang = l
        }, l.prototype.clone = function(l) {
          if ("object" != typeof l) return l;
          if (null == l) return l;
          var n;
          n = l instanceof Array ? new Array : new Object;
          for (var t in l) n[t] = this.clone(l[t]);
          return n
        }, l.prototype.showLoading = function(l) {
          if (void 0 === l && (l = ""), !this.loadingIsOpen) return this.loadingIsOpen = !0, this.loading = this.loadingCtrl.create({
            content: l
          }), this.loading.present()
        }, l.prototype.hideLoading = function() {
          this.loadingIsOpen && this.loading.dismiss(), this.loadingIsOpen = !1
        }, l.prototype.getHttp = function() {
          return this.http
        }, l.prototype.getTimestamp = function() {
          return (new Date).getTime().toString()
        }, l
      }()
  },
  445: function(l, n, t) {
    "use strict";

    function e(l) {
      return a._25(0, [(l()(), a._3(0, 0, null, null, 9, "div", [
        ["class", "Bars"]
      ], null, null, null, null, null)), (l()(), a._23(-1, null, ["\n    "])), (l()(), a._3(2, 0, null, null, 6, "div", [], null, null, null, null, null)), a._2(3, 278528, null, 0, u.l, [a.t, a.k, a.E], {
        ngStyle: [0, "ngStyle"]
      }, null), (l()(), a._23(-1, null, ["\n        "])), (l()(), a._23(-1, null, ["\n        "])), (l()(), a._3(6, 0, null, null, 1, "span", [], null, null, null, null, null)), (l()(), a._23(7, null, ["", ""])), (l()(), a._23(-1, null, ["\n    "])), (l()(), a._23(-1, null, ["\n"]))], function(l, n) {
        l(n, 3, 0, n.component.length)
      }, function(l, n) {
        l(n, 7, 0, n.component.proportion)
      })
    }
    t.d(n, "a", function() {
      return i
    }), n.b = e;
    var a = t(0),
      u = t(17),
      i = a._1({
        encapsulation: 2,
        styles: [],
        data: {}
      })
  },
  446: function(l, n, t) {
    "use strict";

    function e(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "ion-nav", [], null, null, null, Va.b, Va.a)), Vt._19(6144, null, Fa.a, null, [za.a]), Vt._2(2, 4374528, [
        ["myNav", 4]
      ], 0, za.a, [
        [2, Ka.a],
        [2, Ba.a], Ya.a, Ga.a, Ha.a, Vt.k, Vt.x, Vt.D, Vt.i, Ua.l, qa.a, [2, $a.a], Za.a, Vt.l
      ], {
        root: [0, "root"]
      }, null)], function(l, n) {
        l(n, 2, 0, n.component.rootPage)
      }, null)
    }

    function a(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-tabs", [], null, null, null, lu.b, lu.a)), Vt._19(6144, null, Fa.a, null, [nu.a]), Vt._2(2, 4374528, [
        ["myTabs", 4]
      ], 0, nu.a, [
        [2, Ba.a],
        [2, Ka.a], Ya.a, Ga.a, Vt.k, Ha.a, Vt.D, $a.a, tu.a
      ], null, null), (l()(), Vt._23(-1, 0, ["\n    "])), (l()(), Vt._3(4, 0, null, 0, 2, "ion-tab", [
        ["role", "tabpanel"],
        ["tabIcon", "tab-home"]
      ], [
        [1, "id", 0],
        [1, "aria-labelledby", 0]
      ], null, null, eu.b, eu.a)), Vt._2(5, 245760, null, 0, au.a, [nu.a, Ya.a, Ga.a, Ha.a, Vt.k, Vt.x, Vt.D, Vt.i, Vt.g, Ua.l, qa.a, [2, $a.a], Za.a, Vt.l], {
        root: [0, "root"],
        tabTitle: [1, "tabTitle"],
        tabIcon: [2, "tabIcon"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 0, ["\n    "])), (l()(), Vt._3(8, 0, null, 0, 2, "ion-tab", [
        ["role", "tabpanel"],
        ["tabIcon", "tab-settings"]
      ], [
        [1, "id", 0],
        [1, "aria-labelledby", 0]
      ], null, null, eu.b, eu.a)), Vt._2(9, 245760, null, 0, au.a, [nu.a, Ya.a, Ga.a, Ha.a, Vt.k, Vt.x, Vt.D, Vt.i, Vt.g, Ua.l, qa.a, [2, $a.a], Za.a, Vt.l], {
        root: [0, "root"],
        tabTitle: [1, "tabTitle"],
        tabIcon: [2, "tabIcon"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 0, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 5, 0, t.homeRoot, Vt._6(1, "", Vt._24(n, 5, 1, Vt._15(n, 6).transform("tab-home")), ""), "tab-home");
        l(n, 9, 0, t.settingsRoot, Vt._6(1, "", Vt._24(n, 9, 1, Vt._15(n, 10).transform("tab-setting")), ""), "tab-settings")
      }, function(l, n) {
        l(n, 4, 0, Vt._15(n, 5)._tabId, Vt._15(n, 5)._btnId);
        l(n, 8, 0, Vt._15(n, 9)._tabId, Vt._15(n, 9)._btnId)
      })
    }

    function u(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "span", [
        ["style", "font-size: 1.3px"]
      ], null, null, null, null, null)), (l()(), Vt._23(1, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 1, 0, Vt._24(n, 1, 0, Vt._15(n, 2).transform("text-standard-wallte")))
      })
    }

    function i(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "span", [
        ["style", "font-size: 1.3px"]
      ], null, null, null, null, null)), (l()(), Vt._23(1, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 1, 0, Vt._24(n, 1, 0, Vt._15(n, 2).transform("text-multi-wallte")))
      })
    }

    function s(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 34, "div", [], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onItem(l.context.$implicit) && e
        }
        return e
      }, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(2, 0, null, null, 20, "ion-row", [
        ["class", "hang row"]
      ], null, null, null, null, null)), Vt._2(3, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(5, 0, null, null, 4, "ion-col", [
        ["align-self-center", ""],
        ["class", "text-center col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(6, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                        "])), (l()(), Vt._3(8, 0, null, null, 0, "img", [
        ["alt", ""],
        ["src", "./assets/images/logo-maincolor.svg"],
        ["style", "display: inline;"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(11, 0, null, null, 2, "ion-col", [
        ["align-self-center", ""],
        ["class", "text-left font-size-1 col"],
        ["col-3", ""]
      ], null, null, null, null, null)), Vt._2(12, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(13, null, ["\n                        ", "\n                    "])), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(15, 0, null, null, 6, "ion-col", [
        ["align-self-center", ""],
        ["class", "text-right font-size-1 col"],
        ["col-7", ""]
      ], null, null, null, null, null)), Vt._2(16, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                        "])), (l()(), Vt._3(18, 0, null, null, 2, "div", [], null, null, null, null, null)), (l()(), Vt._3(19, 0, null, null, 1, "span", [], [
        [8, "hidden", 0]
      ], null, null, null, null)), (l()(), Vt._23(20, null, ["", ""])), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(24, 0, null, null, 9, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(25, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(27, 0, null, null, 5, "ion-col", [
        ["class", "col"],
        ["col-12", ""]
      ], null, null, null, null, null)), Vt._2(28, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                        "])), (l()(), Vt._3(30, 0, null, null, 1, "progress-bar", [], null, null, null, ru.b, ru.a)), Vt._2(31, 638976, null, 0, cu.a, [Bt.k], {
        proportion: [0, "proportion"]
      }, null), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "]))], function(l, n) {
        l(n, 31, 0, Vt._6(1, "", n.component.idChainPer, ""))
      }, function(l, n) {
        var t = n.component;
        l(n, 13, 0, n.context.$implicit.name);
        l(n, 19, 0, !t.wallet.showBalance);
        l(n, 20, 0, n.context.$implicit.balance)
      })
    }

    function o(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 94, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(1, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(3, 0, null, 2, 10, "ion-refresher", [], [
        [2, "refresher-active", null],
        [4, "top", null]
      ], [
        [null, "ionRefresh"]
      ], function(l, n, t) {
        var e = !0;
        if ("ionRefresh" === n) {
          e = !1 !== l.component.doRefresh(t) && e
        }
        return e
      }, null, null)), Vt._2(4, 212992, null, 0, hu.a, [Ha.a, du.a, Vt.x, Ua.l], null, {
        ionRefresh: "ionRefresh"
      }), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(6, 0, null, null, 2, "ion-refresher-content", [
        ["pullingIcon", "arrow-dropdown"],
        ["pullingText", ""],
        ["refreshingSpinner", "circles"],
        ["refreshingText", ""]
      ], [
        [1, "state", 0]
      ], null, null, pu.b, pu.a)), Vt._2(7, 114688, null, 0, gu.a, [hu.a, Ga.a], {
        pullingIcon: [0, "pullingIcon"],
        pullingText: [1, "pullingText"],
        refreshingSpinner: [2, "refreshingSpinner"],
        refreshingText: [3, "refreshingText"]
      }, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(10, 0, null, null, 2, "ion-refresher-content", [], [
        [1, "state", 0]
      ], null, null, pu.b, pu.a)), Vt._2(11, 114688, null, 0, gu.a, [hu.a, Ga.a], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(15, 0, null, 1, 4, "div", [
        ["class", "home-top"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(18, 0, null, null, 0, "img", [
        ["class", "home-top-button-right"],
        ["src", "./assets/images/icon/icon-manager.svg"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onClick(1) && e
        }
        return e
      }, null, null)), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n\n    "])), (l()(), Vt._3(21, 0, null, 1, 72, "div", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(23, 0, null, null, 12, "div", [
        ["class", "home-top-box"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onClick(0) && e
        }
        return e
      }, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(25, 0, null, null, 0, "img", [
        ["src", "./assets/images/icon/icon-wallet.svg"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(27, 0, null, null, 7, "div", [
        ["style", "font-size: 1.6em;"]
      ], null, null, null, null, null)), (l()(), Vt._23(28, null, ["", "\n                "])), (l()(), Vt.Y(16777216, null, null, 1, null, u)), Vt._2(30, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt.Y(16777216, null, null, 1, null, i)), Vt._2(33, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(37, 0, null, null, 55, "ion-grid", [
        ["class", "grid"]
      ], null, null, null, null, null)), Vt._2(38, 16384, null, 0, mu.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(40, 0, null, null, 15, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(41, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(43, 0, null, null, 3, "ion-col", [
        ["class", "row-title col"],
        ["col-5", ""]
      ], null, null, null, null, null)), Vt._2(44, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(45, null, ["\n                    ", "\n                "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(48, 0, null, null, 6, "ion-col", [
        ["class", "text-right col"],
        ["col-7", ""]
      ], null, null, null, null, null)), Vt._2(49, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(51, 0, null, null, 2, "div", [
        ["class", "home-eye"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onOpen() && e
        }
        return e
      }, null, null)), Vt._2(52, 278528, null, 0, fu.g, [Vt.s, Vt.t, Vt.k, Vt.E], {
        klass: [0, "klass"],
        ngClass: [1, "ngClass"]
      }, null), Vt._18(53, {
        "home-eye-on": 0,
        "home-eye-off": 1
      }), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(57, 0, null, null, 20, "ion-row", [
        ["class", "hang row"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("click" === n) {
          e = !1 !== a.onItem(a.ElaObj) && e
        }
        return e
      }, null, null)), Vt._2(58, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(60, 0, null, null, 4, "ion-col", [
        ["align-self-center", ""],
        ["class", "text-center col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(61, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(63, 0, null, null, 0, "img", [
        ["alt", ""],
        ["src", "./assets/images/logo-maincolor.svg"],
        ["style", "display: inline;"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(66, 0, null, null, 2, "ion-col", [
        ["align-self-center", ""],
        ["class", "text-left font-size-1 col"],
        ["col-3", ""]
      ], null, null, null, null, null)), Vt._2(67, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(68, null, ["\n                    ", "\n                "])), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(70, 0, null, null, 6, "ion-col", [
        ["align-self-center", ""],
        ["class", "text-right font-size-1 col"],
        ["col-7", ""]
      ], null, null, null, null, null)), Vt._2(71, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(73, 0, null, null, 2, "div", [], null, null, null, null, null)), (l()(), Vt._3(74, 0, null, null, 1, "span", [], [
        [8, "hidden", 0]
      ], null, null, null, null)), (l()(), Vt._23(75, null, ["", ""])), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(79, 0, null, null, 9, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(80, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(82, 0, null, null, 5, "ion-col", [
        ["class", "col"],
        ["col-12", ""]
      ], null, null, null, null, null)), Vt._2(83, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(85, 0, null, null, 1, "progress-bar", [], null, null, null, ru.b, ru.a)), Vt._2(86, 638976, null, 0, cu.a, [Bt.k], {
        proportion: [0, "proportion"]
      }, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, s)), Vt._2(91, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 4, 0);
        l(n, 7, 0, "arrow-dropdown", "", "circles", ""), l(n, 11, 0);
        l(n, 30, 0, "Standard" === t.account.Type);
        l(n, 33, 0, "Multi-Sign" === t.account.Type);
        l(n, 52, 0, "home-eye", l(n, 53, 0, t.wallet.showBalance, !t.wallet.showBalance));
        l(n, 86, 0, Vt._6(1, "", t.elaPer, ""));
        l(n, 91, 0, t.coinList)
      }, function(l, n) {
        var t = n.component;
        l(n, 0, 0, Vt._15(n, 1).statusbarPadding, Vt._15(n, 1)._hasRefresher);
        l(n, 3, 0, "inactive" !== Vt._15(n, 4).state, Vt._15(n, 4)._top);
        l(n, 6, 0, Vt._15(n, 7).r.state);
        l(n, 10, 0, Vt._15(n, 11).r.state);
        l(n, 28, 0, t.wallet.name);
        l(n, 45, 0, Vt._24(n, 45, 0, Vt._15(n, 46).transform("text-coin-list")));
        l(n, 68, 0, t.ElaObj.name);
        l(n, 74, 0, !t.wallet.showBalance);
        l(n, 75, 0, t.ElaObj.balance)
      })
    }

    function r(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "ion-note", [
        ["item-end", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, xu.a, [Ga.a, Vt.k, Vt.D], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n              "]))], null, function(l, n) {
        l(n, 2, 0, n.component.currentLanguageName)
      })
    }

    function c(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 14, "button", [
        ["class", "item item-block"],
        ["ion-item", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(4) && e
        }
        return e
      }, wu.b, wu.a)), Vt._2(1, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 11, {
        contentLabel: 0
      }), Vt._21(603979776, 12, {
        _buttons: 1
      }), Vt._21(603979776, 13, {
        _icons: 1
      }), Vt._2(5, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n          "])), (l()(), Vt._3(7, 0, null, 1, 6, "ion-label", [], null, null, null, null, null)), Vt._2(8, 16384, [
        [11, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(10, 0, null, null, 2, "span", [], null, null, null, null, null)), (l()(), Vt._23(11, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n          "])), (l()(), Vt._23(-1, 2, ["\n        "]))], null, function(l, n) {
        l(n, 11, 0, Vt._24(n, 11, 0, Vt._15(n, 12).transform("text-sing-tx")))
      })
    }

    function _(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 14, "button", [
        ["class", "item item-block"],
        ["ion-item", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(3) && e
        }
        return e
      }, wu.b, wu.a)), Vt._2(1, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 14, {
        contentLabel: 0
      }), Vt._21(603979776, 15, {
        _buttons: 1
      }), Vt._21(603979776, 16, {
        _icons: 1
      }), Vt._2(5, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n          "])), (l()(), Vt._3(7, 0, null, 1, 6, "ion-label", [], null, null, null, null, null)), Vt._2(8, 16384, [
        [14, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(10, 0, null, null, 2, "span", [], null, null, null, null, null)), (l()(), Vt._23(11, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n          "])), (l()(), Vt._23(-1, 2, ["\n        "]))], null, function(l, n) {
        l(n, 11, 0, Vt._24(n, 11, 0, Vt._15(n, 12).transform("text-send-tx")))
      })
    }

    function d(l) {
      return Vt._25(0, [Vt._21(402653184, 1, {
        navBar: 0
      }), (l()(), Vt._3(1, 0, null, null, 89, "ion-content", [
        ["no-bounce", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(2, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(4, 0, null, 1, 5, "div", [
        ["class", "my-title"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(6, 0, null, null, 2, "p", [
        ["style", "font-size: 1.6em;"]
      ], null, null, null, null, null)), (l()(), Vt._23(7, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(11, 0, null, 1, 78, "ion-list", [], null, null, null, null, null)), Vt._2(12, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(14, 0, null, null, 17, "button", [
        ["class", "item item-block"],
        ["ion-item", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(5) && e
        }
        return e
      }, wu.b, wu.a)), Vt._2(15, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 2, {
        contentLabel: 0
      }), Vt._21(603979776, 3, {
        _buttons: 1
      }), Vt._21(603979776, 4, {
        _icons: 1
      }), Vt._2(19, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n              "])), (l()(), Vt._3(21, 0, null, 1, 6, "ion-label", [], null, null, null, null, null)), Vt._2(22, 16384, [
        [2, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(24, 0, null, null, 2, "span", [], null, null, null, null, null)), (l()(), Vt._23(25, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n              "])), (l()(), Vt._23(-1, 2, ["\n              "])), (l()(), Vt.Y(16777216, null, 4, 1, null, r)), Vt._2(30, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(33, 0, null, null, 14, "button", [
        ["class", "item item-block"],
        ["ion-item", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(0) && e
        }
        return e
      }, wu.b, wu.a)), Vt._2(34, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 5, {
        contentLabel: 0
      }), Vt._21(603979776, 6, {
        _buttons: 1
      }), Vt._21(603979776, 7, {
        _icons: 1
      }), Vt._2(38, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n          "])), (l()(), Vt._3(40, 0, null, 1, 6, "ion-label", [], null, null, null, null, null)), Vt._2(41, 16384, [
        [5, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(43, 0, null, null, 2, "span", [], null, null, null, null, null)), (l()(), Vt._23(44, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n          "])), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(49, 0, null, null, 14, "button", [
        ["class", "item item-block"],
        ["ion-item", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(2) && e
        }
        return e
      }, wu.b, wu.a)), Vt._2(50, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 8, {
        contentLabel: 0
      }), Vt._21(603979776, 9, {
        _buttons: 1
      }), Vt._21(603979776, 10, {
        _icons: 1
      }), Vt._2(54, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n          "])), (l()(), Vt._3(56, 0, null, 1, 6, "ion-label", [], null, null, null, null, null)), Vt._2(57, 16384, [
        [8, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(59, 0, null, null, 2, "span", [], null, null, null, null, null)), (l()(), Vt._23(60, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n          "])), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, c)), Vt._2(67, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, _)), Vt._2(70, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(74, 0, null, null, 14, "button", [
        ["class", "item item-block"],
        ["ion-item", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(8) && e
        }
        return e
      }, wu.b, wu.a)), Vt._2(75, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 17, {
        contentLabel: 0
      }), Vt._21(603979776, 18, {
        _buttons: 1
      }), Vt._21(603979776, 19, {
        _icons: 1
      }), Vt._2(79, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n          "])), (l()(), Vt._3(81, 0, null, 1, 6, "ion-label", [], null, null, null, null, null)), Vt._2(82, 16384, [
        [17, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(84, 0, null, null, 2, "span", [], null, null, null, null, null)), (l()(), Vt._23(85, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n          "])), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 30, 0, t.currentLanguageName);
        l(n, 67, 0, "Multi-Sign" === t.masterWalletType && "Readonly" != t.readonly);
        l(n, 70, 0, "Multi-Sign" === t.masterWalletType)
      }, function(l, n) {
        l(n, 1, 0, Vt._15(n, 2).statusbarPadding, Vt._15(n, 2)._hasRefresher);
        l(n, 7, 0, Vt._24(n, 7, 0, Vt._15(n, 8).transform("tab-setting")));
        l(n, 25, 0, Vt._24(n, 25, 0, Vt._15(n, 26).transform("text-language-message")));
        l(n, 44, 0, Vt._24(n, 44, 0, Vt._15(n, 45).transform("text-wallet-manager")));
        l(n, 60, 0, Vt._24(n, 60, 0, Vt._15(n, 61).transform("text-contacts")));
        l(n, 85, 0, Vt._24(n, 85, 0, Vt._15(n, 86).transform("about")))
      })
    }

    function h(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._3(13, 0, null, null, 29, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 25, "div", [
        ["id", "wrapper"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(18, 0, null, null, 22, "div", [
        ["id", "cell"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(20, 0, null, null, 6, "div", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(22, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(1) && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(23, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(24, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(28, 0, null, null, 6, "div", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(30, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(2) && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(31, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(32, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(36, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(3) && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(37, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(38, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        l(n, 23, 0, "");
        l(n, 31, 0, "");
        l(n, 37, 0, "")
      }, function(l, n) {
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-add-wallet")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 24, 0, Vt._24(n, 24, 0, Vt._15(n, 25).transform("launcher-create-wallet")));
        l(n, 32, 0, Vt._24(n, 32, 0, Vt._15(n, 33).transform("launcher-backup-import")));
        l(n, 38, 0, Vt._24(n, 38, 0, Vt._15(n, 39).transform("signature-wallet")))
      })
    }

    function p(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "ion-note", [
        ["item-end", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, xu.a, [Ga.a, Vt.k, Vt.D], null, null), (l()(), Vt._23(2, null, ["\n        ", "\n      "]))], null, function(l, n) {
        l(n, 2, 0, n.component.walletName)
      })
    }

    function g(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 20, "button", [
        ["class", "item item-block"],
        ["ion-item", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onItem(3) && e
        }
        return e
      }, wu.b, wu.a)), Vt._2(1, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 4, {
        contentLabel: 0
      }), Vt._21(603979776, 5, {
        _buttons: 1
      }), Vt._21(603979776, 6, {
        _icons: 1
      }), Vt._2(5, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n      "])), (l()(), Vt._3(7, 0, null, 0, 4, "ion-icon", [
        ["item-start", ""],
        ["role", "img"]
      ], [
        [2, "hide", null]
      ], null, null, null, null)), Vt._2(8, 147456, [
        [6, 4]
      ], 0, zu.a, [Ga.a, Vt.k, Vt.D], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(10, 0, null, null, 0, "img", [
        ["src", "assets/images/icon-language.svg"],
        ["width", "22"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n      "])), (l()(), Vt._23(-1, 2, ["\n      "])), (l()(), Vt._3(13, 0, null, 1, 6, "ion-label", [], null, null, null, null, null)), Vt._2(14, 16384, [
        [4, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(16, 0, null, null, 2, "span", [], null, null, null, null, null)), (l()(), Vt._23(17, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n      "])), (l()(), Vt._23(-1, 2, ["\n    "]))], null, function(l, n) {
        l(n, 7, 0, Vt._15(n, 8)._hidden);
        l(n, 17, 0, Vt._24(n, 17, 0, Vt._15(n, 18).transform("text-check-publickey")))
      })
    }

    function f(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 20, "button", [
        ["class", "item item-block"],
        ["ion-item", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onItem(5) && e
        }
        return e
      }, wu.b, wu.a)), Vt._2(1, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 10, {
        contentLabel: 0
      }), Vt._21(603979776, 11, {
        _buttons: 1
      }), Vt._21(603979776, 12, {
        _icons: 1
      }), Vt._2(5, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._3(7, 0, null, 0, 4, "ion-icon", [
        ["item-start", ""],
        ["role", "img"]
      ], [
        [2, "hide", null]
      ], null, null, null, null)), Vt._2(8, 147456, [
        [12, 4]
      ], 0, zu.a, [Ga.a, Vt.k, Vt.D], null, null), (l()(), Vt._23(-1, null, ["\n          "])), (l()(), Vt._3(10, 0, null, null, 0, "img", [
        ["src", " assets/images/icon-export.svg "],
        ["width", "22 "]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._3(13, 0, null, 1, 6, "ion-label", [], null, null, null, null, null)), Vt._2(14, 16384, [
        [10, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(-1, null, ["\n          "])), (l()(), Vt._3(16, 0, null, null, 2, "span", [], null, null, null, null, null)), (l()(), Vt._23(17, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, 2, ["\n      "]))], null, function(l, n) {
        l(n, 7, 0, Vt._15(n, 8)._hidden);
        l(n, 17, 0, Vt._24(n, 17, 0, Vt._15(n, 18).transform("text-export-mnemomic")))
      })
    }

    function m(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 20, "button", [
        ["class", "item item-block"],
        ["ion-item", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onItem(1) && e
        }
        return e
      }, wu.b, wu.a)), Vt._2(1, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 13, {
        contentLabel: 0
      }), Vt._21(603979776, 14, {
        _buttons: 1
      }), Vt._21(603979776, 15, {
        _icons: 1
      }), Vt._2(5, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n      "])), (l()(), Vt._3(7, 0, null, 0, 4, "ion-icon", [
        ["item-start", ""],
        ["role", "img"]
      ], [
        [2, "hide", null]
      ], null, null, null, null)), Vt._2(8, 147456, [
        [15, 4]
      ], 0, zu.a, [Ga.a, Vt.k, Vt.D], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(10, 0, null, null, 0, "img", [
        ["src", " assets/images/icon-aletr.svg "],
        ["width", "22 "]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n      "])), (l()(), Vt._23(-1, 2, ["\n      "])), (l()(), Vt._3(13, 0, null, 1, 6, "ion-label", [], null, null, null, null, null)), Vt._2(14, 16384, [
        [13, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(16, 0, null, null, 2, "span", [], null, null, null, null, null)), (l()(), Vt._23(17, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n      "])), (l()(), Vt._23(-1, 2, ["\n    "]))], null, function(l, n) {
        l(n, 7, 0, Vt._15(n, 8)._hidden);
        l(n, 17, 0, Vt._24(n, 17, 0, Vt._15(n, 18).transform("wallet-password-reset")))
      })
    }

    function v(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(13, 0, null, null, 85, "ion-content", [
        ["no-bounce", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 81, "ion-list", [], null, null, null, null, null)), Vt._2(17, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(19, 0, null, null, 23, "button", [
        ["class", "item item-block"],
        ["ion-item", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onItem(4) && e
        }
        return e
      }, wu.b, wu.a)), Vt._2(20, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(24, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n      "])), (l()(), Vt._3(26, 0, null, 0, 4, "ion-icon", [
        ["item-start", ""],
        ["role", "img"]
      ], [
        [2, "hide", null]
      ], null, null, null, null)), Vt._2(27, 147456, [
        [3, 4]
      ], 0, zu.a, [Ga.a, Vt.k, Vt.D], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(29, 0, null, null, 0, "img", [
        ["src", "assets/images/icon-wallet.svg"],
        ["width", "22"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n      "])), (l()(), Vt._23(-1, 2, ["\n      "])), (l()(), Vt._3(32, 0, null, 1, 6, "ion-label", [], null, null, null, null, null)), Vt._2(33, 16384, [
        [1, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(35, 0, null, null, 2, "span", [], null, null, null, null, null)), (l()(), Vt._23(36, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n      "])), (l()(), Vt._23(-1, 2, ["\n      "])), (l()(), Vt.Y(16777216, null, 4, 1, null, p)), Vt._2(41, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 2, ["\n    "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, g)), Vt._2(45, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(47, 0, null, null, 20, "button", [
        ["class", "item item-block"],
        ["ion-item", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onItem(0) && e
        }
        return e
      }, wu.b, wu.a)), Vt._2(48, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 7, {
        contentLabel: 0
      }), Vt._21(603979776, 8, {
        _buttons: 1
      }), Vt._21(603979776, 9, {
        _icons: 1
      }), Vt._2(52, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n      "])), (l()(), Vt._3(54, 0, null, 0, 4, "ion-icon", [
        ["item-start", ""],
        ["role", "img"]
      ], [
        [2, "hide", null]
      ], null, null, null, null)), Vt._2(55, 147456, [
        [9, 4]
      ], 0, zu.a, [Ga.a, Vt.k, Vt.D], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(57, 0, null, null, 0, "img", [
        ["src", " assets/images/icon-export.svg "],
        ["width", "22 "]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n      "])), (l()(), Vt._23(-1, 2, ["\n      "])), (l()(), Vt._3(60, 0, null, 1, 6, "ion-label", [], null, null, null, null, null)), Vt._2(61, 16384, [
        [7, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(63, 0, null, null, 2, "span", [], null, null, null, null, null)), (l()(), Vt._23(64, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n      "])), (l()(), Vt._23(-1, 2, ["\n    "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, f)), Vt._2(70, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, m)), Vt._2(73, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(76, 0, null, null, 20, "ion-item", [
        ["class", "item item-block"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onItem(2) && e
        }
        return e
      }, wu.b, wu.a)), Vt._2(77, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 16, {
        contentLabel: 0
      }), Vt._21(603979776, 17, {
        _buttons: 1
      }), Vt._21(603979776, 18, {
        _icons: 1
      }), Vt._2(81, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(83, 0, null, 0, 4, "ion-icon", [
        ["item-start", ""],
        ["role", "img"]
      ], [
        [2, "hide", null]
      ], null, null, null, null)), Vt._2(84, 147456, [
        [18, 4]
      ], 0, zu.a, [Ga.a, Vt.k, Vt.D], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(86, 0, null, null, 0, "img", [
        ["src", " assets/images/icon-del.svg "],
        ["width", "22 "]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(89, 0, null, 1, 6, "ion-label", [], null, null, null, null, null)), Vt._2(90, 16384, [
        [16, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(92, 0, null, null, 2, "span", [
        ["style", "color:#ff0000"]
      ], null, null, null, null, null)), (l()(), Vt._23(93, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 41, 0, t.walletName);
        l(n, 45, 0, t.singleAddress && !t.readonly);
        l(n, 70, 0, "Readonly" != t.readonly && "simple" != t.readonly);
        l(n, 73, 0, "Readonly" != t.readonly)
      }, function(l, n) {
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-wallet-manager")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 26, 0, Vt._15(n, 27)._hidden);
        l(n, 36, 0, Vt._24(n, 36, 0, Vt._15(n, 37).transform("wallet-name")));
        l(n, 54, 0, Vt._15(n, 55)._hidden);
        l(n, 64, 0, Vt._24(n, 64, 0, Vt._15(n, 65).transform("wallet-export")));
        l(n, 83, 0, Vt._15(n, 84)._hidden);
        l(n, 93, 0, Vt._24(n, 93, 0, Vt._15(n, 94).transform("wallet-delete")))
      })
    }

    function y(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(13, 0, null, null, 61, "ion-content", [
        ["no-bounce", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 57, "ion-list", [], null, null, null, null, null)), Vt._2(17, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(19, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(20, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(24, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(26, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(27, 16384, [
        [1, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(28, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(31, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.oldPayPassword = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(32, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(34, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(35, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(39, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(40, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 4, {
        contentLabel: 0
      }), Vt._21(603979776, 5, {
        _buttons: 1
      }), Vt._21(603979776, 6, {
        _icons: 1
      }), Vt._2(44, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(46, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(47, 16384, [
        [4, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(48, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(51, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.payPassword = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(52, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(54, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(55, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(59, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(60, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 7, {
        contentLabel: 0
      }), Vt._21(603979776, 8, {
        _buttons: 1
      }), Vt._21(603979776, 9, {
        _icons: 1
      }), Vt._2(64, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(66, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.rePayPassword = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(67, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(69, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(70, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(76, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(77, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(79, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onSubmit() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(80, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(81, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 32, 0, t.oldPayPassword);
        l(n, 35, 0, "password", Vt._6(1, "", Vt._24(n, 35, 1, Vt._15(n, 36).transform("updatepaypassword-origin_paypassword1-placeholder")), ""));
        l(n, 52, 0, t.payPassword);
        l(n, 55, 0, "password", Vt._6(1, "", Vt._24(n, 55, 1, Vt._15(n, 56).transform("updatepaypassword-paypassword1-placeholder")), ""));
        l(n, 67, 0, t.rePayPassword);
        l(n, 70, 0, "password", Vt._6(1, "", Vt._24(n, 70, 1, Vt._15(n, 71).transform("updatepaypassword-paypassword2-placeholder")), ""));
        l(n, 80, 0, "")
      }, function(l, n) {
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-wallet-info")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 28, 0, Vt._24(n, 28, 0, Vt._15(n, 29).transform("updatepaypassword-origin_paypassword1-title")));
        l(n, 31, 0, Vt._15(n, 34).ngClassUntouched, Vt._15(n, 34).ngClassTouched, Vt._15(n, 34).ngClassPristine, Vt._15(n, 34).ngClassDirty, Vt._15(n, 34).ngClassValid, Vt._15(n, 34).ngClassInvalid, Vt._15(n, 34).ngClassPending);
        l(n, 48, 0, Vt._24(n, 48, 0, Vt._15(n, 49).transform("updatepaypassword-paypassword1-title")));
        l(n, 51, 0, Vt._15(n, 54).ngClassUntouched, Vt._15(n, 54).ngClassTouched, Vt._15(n, 54).ngClassPristine, Vt._15(n, 54).ngClassDirty, Vt._15(n, 54).ngClassValid, Vt._15(n, 54).ngClassInvalid, Vt._15(n, 54).ngClassPending);
        l(n, 66, 0, Vt._15(n, 69).ngClassUntouched, Vt._15(n, 69).ngClassTouched, Vt._15(n, 69).ngClassPristine, Vt._15(n, 69).ngClassDirty, Vt._15(n, 69).ngClassValid, Vt._15(n, 69).ngClassInvalid, Vt._15(n, 69).ngClassPending);
        l(n, 81, 0, Vt._24(n, 81, 0, Vt._15(n, 82).transform("text-submit")))
      })
    }

    function b(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 91, "div", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(2, 0, null, null, 9, "div", [
        ["class", "kuangTextArea"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(4, 0, null, null, 6, "textarea", [
        ["class", "backupWalletTextArea"],
        ["rows", "4"]
      ], [
        [8, "placeholder", 0],
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"],
        [null, "input"],
        [null, "blur"],
        [null, "compositionstart"],
        [null, "compositionend"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("input" === n) {
          e = !1 !== Vt._15(l, 5)._handleInput(t.target.value) && e
        }
        if ("blur" === n) {
          e = !1 !== Vt._15(l, 5).onTouched() && e
        }
        if ("compositionstart" === n) {
          e = !1 !== Vt._15(l, 5)._compositionStart() && e
        }
        if ("compositionend" === n) {
          e = !1 !== Vt._15(l, 5)._compositionEnd(t.target.value) && e
        }
        if ("ngModelChange" === n) {
          e = !1 !== (a.keyStoreContent = t) && e
        }
        return e
      }, null, null)), Vt._2(5, 16384, null, 0, Ut.b, [Vt.E, Vt.k, [2, Ut.a]], null, null), Vt._19(1024, null, Ut.g, function(l) {
        return [l]
      }, [Ut.b]), Vt._2(7, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [2, Ut.g]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(9, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(13, 0, null, null, 77, "ion-list", [], null, null, null, null, null)), Vt._2(14, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(16, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(17, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 2, {
        contentLabel: 0
      }), Vt._21(603979776, 3, {
        _buttons: 1
      }), Vt._21(603979776, 4, {
        _icons: 1
      }), Vt._2(21, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(23, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(24, 16384, [
        [2, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(25, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(28, 0, null, 3, 5, "ion-input", [
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.importFileObj.name = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(29, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(31, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(32, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(36, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(37, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 5, {
        contentLabel: 0
      }), Vt._21(603979776, 6, {
        _buttons: 1
      }), Vt._21(603979776, 7, {
        _icons: 1
      }), Vt._2(41, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(43, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(44, 16384, [
        [5, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(45, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(48, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.importFileObj.backupPassWord = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(49, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(51, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(52, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(56, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(57, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 8, {
        contentLabel: 0
      }), Vt._21(603979776, 9, {
        _buttons: 1
      }), Vt._21(603979776, 10, {
        _icons: 1
      }), Vt._2(61, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(63, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(64, 16384, [
        [8, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(65, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(68, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.importFileObj.payPassword = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(69, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(71, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(72, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(76, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(77, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 11, {
        contentLabel: 0
      }), Vt._21(603979776, 12, {
        _buttons: 1
      }), Vt._21(603979776, 13, {
        _icons: 1
      }), Vt._2(81, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(83, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.importFileObj.rePayPassword = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(84, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(86, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(87, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "]))], function(l, n) {
        var t = n.component;
        l(n, 7, 0, t.keyStoreContent);
        l(n, 29, 0, t.importFileObj.name);
        l(n, 32, 0, "text", Vt._6(1, "", Vt._24(n, 32, 1, Vt._15(n, 33).transform("addwallet-walletname-placeholder")), ""));
        l(n, 49, 0, t.importFileObj.backupPassWord);
        l(n, 52, 0, "password", Vt._6(1, "", Vt._24(n, 52, 1, Vt._15(n, 53).transform("importkeystore-optionalpassword-placeholder")), ""));
        l(n, 69, 0, t.importFileObj.payPassword);
        l(n, 72, 0, "password", Vt._6(1, "", Vt._24(n, 72, 1, Vt._15(n, 73).transform("addwallet-paypassword1-placeholder")), ""));
        l(n, 84, 0, t.importFileObj.rePayPassword);
        l(n, 87, 0, "password", Vt._6(1, "", Vt._24(n, 87, 1, Vt._15(n, 88).transform("addwallet-paypassword2-placeholder")), ""))
      }, function(l, n) {
        l(n, 4, 0, Vt._6(1, "", Vt._24(n, 4, 0, Vt._15(n, 10).transform("import-text-keystroe-message")), ""), Vt._15(n, 9).ngClassUntouched, Vt._15(n, 9).ngClassTouched, Vt._15(n, 9).ngClassPristine, Vt._15(n, 9).ngClassDirty, Vt._15(n, 9).ngClassValid, Vt._15(n, 9).ngClassInvalid, Vt._15(n, 9).ngClassPending);
        l(n, 25, 0, Vt._24(n, 25, 0, Vt._15(n, 26).transform("addwallet-walletname-title")));
        l(n, 28, 0, Vt._15(n, 31).ngClassUntouched, Vt._15(n, 31).ngClassTouched, Vt._15(n, 31).ngClassPristine, Vt._15(n, 31).ngClassDirty, Vt._15(n, 31).ngClassValid, Vt._15(n, 31).ngClassInvalid, Vt._15(n, 31).ngClassPending);
        l(n, 45, 0, Vt._24(n, 45, 0, Vt._15(n, 46).transform("importkeystore-keystorepassword-title")));
        l(n, 48, 0, Vt._15(n, 51).ngClassUntouched, Vt._15(n, 51).ngClassTouched, Vt._15(n, 51).ngClassPristine, Vt._15(n, 51).ngClassDirty, Vt._15(n, 51).ngClassValid, Vt._15(n, 51).ngClassInvalid, Vt._15(n, 51).ngClassPending);
        l(n, 65, 0, Vt._24(n, 65, 0, Vt._15(n, 66).transform("unlock-paypassword-title")));
        l(n, 68, 0, Vt._15(n, 71).ngClassUntouched, Vt._15(n, 71).ngClassTouched, Vt._15(n, 71).ngClassPristine, Vt._15(n, 71).ngClassDirty, Vt._15(n, 71).ngClassValid, Vt._15(n, 71).ngClassInvalid, Vt._15(n, 71).ngClassPending);
        l(n, 83, 0, Vt._15(n, 86).ngClassUntouched, Vt._15(n, 86).ngClassTouched, Vt._15(n, 86).ngClassPristine, Vt._15(n, 86).ngClassDirty, Vt._15(n, 86).ngClassValid, Vt._15(n, 86).ngClassInvalid, Vt._15(n, 86).ngClassPending)
      })
    }

    function k(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-label", [], null, null, null, null, null)), Vt._2(1, 16384, [
        [26, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(2, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("show-advanced-options")))
      })
    }

    function x(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-label", [], null, null, null, null, null)), Vt._2(1, 16384, [
        [26, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(2, null, [" ", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("hide-advanced-options")))
      })
    }

    function w(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(1, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 29, {
        contentLabel: 0
      }), Vt._21(603979776, 30, {
        _buttons: 1
      }), Vt._21(603979776, 31, {
        _icons: 1
      }), Vt._2(5, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(7, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(8, 16384, [
        [29, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(9, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(12, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.mnemonicObj.phrasePassword = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(13, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(15, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(16, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n        "]))], function(l, n) {
        l(n, 13, 0, n.component.mnemonicObj.phrasePassword);
        l(n, 16, 0, "password", Vt._6(1, "", Vt._24(n, 16, 1, Vt._15(n, 17).transform("importmnes-optionalpassword-placeholder")), ""))
      }, function(l, n) {
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("importmnes-optionalpassword-title")));
        l(n, 12, 0, Vt._15(n, 15).ngClassUntouched, Vt._15(n, 15).ngClassTouched, Vt._15(n, 15).ngClassPristine, Vt._15(n, 15).ngClassDirty, Vt._15(n, 15).ngClassValid, Vt._15(n, 15).ngClassInvalid, Vt._15(n, 15).ngClassPending)
      })
    }

    function C(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 108, "div", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(2, 0, null, null, 9, "div", [
        ["class", "kuangTextArea"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(4, 0, null, null, 6, "textarea", [
        ["class", "backupWalletTextArea"],
        ["rows", "4"]
      ], [
        [8, "placeholder", 0],
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"],
        [null, "input"],
        [null, "blur"],
        [null, "compositionstart"],
        [null, "compositionend"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("input" === n) {
          e = !1 !== Vt._15(l, 5)._handleInput(t.target.value) && e
        }
        if ("blur" === n) {
          e = !1 !== Vt._15(l, 5).onTouched() && e
        }
        if ("compositionstart" === n) {
          e = !1 !== Vt._15(l, 5)._compositionStart() && e
        }
        if ("compositionend" === n) {
          e = !1 !== Vt._15(l, 5)._compositionEnd(t.target.value) && e
        }
        if ("ngModelChange" === n) {
          e = !1 !== (a.mnemonicObj.mnemonic = t) && e
        }
        return e
      }, null, null)), Vt._2(5, 16384, null, 0, Ut.b, [Vt.E, Vt.k, [2, Ut.a]], null, null), Vt._19(1024, null, Ut.g, function(l) {
        return [l]
      }, [Ut.b]), Vt._2(7, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [2, Ut.g]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(9, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(13, 0, null, null, 77, "ion-list", [], null, null, null, null, null)), Vt._2(14, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(16, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(17, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 14, {
        contentLabel: 0
      }), Vt._21(603979776, 15, {
        _buttons: 1
      }), Vt._21(603979776, 16, {
        _icons: 1
      }), Vt._2(21, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(23, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(24, 16384, [
        [14, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(25, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(28, 0, null, 3, 5, "ion-input", [
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.mnemonicObj.name = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(29, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(31, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(32, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(36, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(37, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 17, {
        contentLabel: 0
      }), Vt._21(603979776, 18, {
        _buttons: 1
      }), Vt._21(603979776, 19, {
        _icons: 1
      }), Vt._2(41, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(43, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(44, 16384, [
        [17, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(45, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(48, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.mnemonicObj.payPassword = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(49, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(51, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(52, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(56, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(57, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 20, {
        contentLabel: 0
      }), Vt._21(603979776, 21, {
        _buttons: 1
      }), Vt._21(603979776, 22, {
        _icons: 1
      }), Vt._2(61, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(63, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.mnemonicObj.rePayPassword = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(64, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(66, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(67, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(71, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(72, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 23, {
        contentLabel: 0
      }), Vt._21(603979776, 24, {
        _buttons: 1
      }), Vt._21(603979776, 25, {
        _icons: 1
      }), Vt._2(76, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(78, 0, null, 1, 3, "ion-label", [], null, null, null, null, null)), Vt._2(79, 16384, [
        [23, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(80, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(83, 0, null, 0, 5, "ion-checkbox", [], [
        [2, "checkbox-disabled", null],
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"],
        [null, "click"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("click" === n) {
          e = !1 !== Vt._15(l, 84)._click(t) && e
        }
        if ("ngModelChange" === n) {
          e = !1 !== (a.mnemonicObj.singleAddress = t) && e
        }
        return e
      }, $u.b, $u.a)), Vt._2(84, 1228800, null, 0, Zu.a, [Ga.a, Iu.a, [2, Cu.a], Vt.k, Vt.D], null, null), Vt._19(1024, null, Ut.g, function(l) {
        return [l]
      }, [Zu.a]), Vt._2(86, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [2, Ut.g]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(88, 16384, null, 0, Ut.i, [Ut.h], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(92, 0, null, null, 12, "ion-item", [
        ["class", "item item-block"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.toggleShowAdvOpts() && e
        }
        return e
      }, wu.b, wu.a)), Vt._2(93, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(603979776, 26, {
        contentLabel: 0
      }), Vt._21(603979776, 27, {
        _buttons: 1
      }), Vt._21(603979776, 28, {
        _icons: 1
      }), Vt._2(97, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt.Y(16777216, null, 1, 1, null, k)), Vt._2(100, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt.Y(16777216, null, 1, 1, null, x)), Vt._2(103, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, w)), Vt._2(107, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "]))], function(l, n) {
        var t = n.component;
        l(n, 7, 0, t.mnemonicObj.mnemonic);
        l(n, 29, 0, t.mnemonicObj.name);
        l(n, 32, 0, "text", Vt._6(1, "", Vt._24(n, 32, 1, Vt._15(n, 33).transform("addwallet-walletname-placeholder")), ""));
        l(n, 49, 0, t.mnemonicObj.payPassword);
        l(n, 52, 0, "password", Vt._6(1, "", Vt._24(n, 52, 1, Vt._15(n, 53).transform("addwallet-paypassword1-placeholder")), ""));
        l(n, 64, 0, t.mnemonicObj.rePayPassword);
        l(n, 67, 0, "password", Vt._6(1, "", Vt._24(n, 67, 1, Vt._15(n, 68).transform("addwallet-paypassword2-placeholder")), ""));
        l(n, 86, 0, t.mnemonicObj.singleAddress);
        l(n, 100, 0, !t.showAdvOpts);
        l(n, 103, 0, t.showAdvOpts);
        l(n, 107, 0, t.showAdvOpts)
      }, function(l, n) {
        l(n, 4, 0, Vt._6(1, "", Vt._24(n, 4, 0, Vt._15(n, 10).transform("text-mnemonic-format")), ""), Vt._15(n, 9).ngClassUntouched, Vt._15(n, 9).ngClassTouched, Vt._15(n, 9).ngClassPristine, Vt._15(n, 9).ngClassDirty, Vt._15(n, 9).ngClassValid, Vt._15(n, 9).ngClassInvalid, Vt._15(n, 9).ngClassPending);
        l(n, 25, 0, Vt._24(n, 25, 0, Vt._15(n, 26).transform("addwallet-walletname-title")));
        l(n, 28, 0, Vt._15(n, 31).ngClassUntouched, Vt._15(n, 31).ngClassTouched, Vt._15(n, 31).ngClassPristine, Vt._15(n, 31).ngClassDirty, Vt._15(n, 31).ngClassValid, Vt._15(n, 31).ngClassInvalid, Vt._15(n, 31).ngClassPending);
        l(n, 45, 0, Vt._24(n, 45, 0, Vt._15(n, 46).transform("unlock-paypassword-title")));
        l(n, 48, 0, Vt._15(n, 51).ngClassUntouched, Vt._15(n, 51).ngClassTouched, Vt._15(n, 51).ngClassPristine, Vt._15(n, 51).ngClassDirty, Vt._15(n, 51).ngClassValid, Vt._15(n, 51).ngClassInvalid, Vt._15(n, 51).ngClassPending);
        l(n, 63, 0, Vt._15(n, 66).ngClassUntouched, Vt._15(n, 66).ngClassTouched, Vt._15(n, 66).ngClassPristine, Vt._15(n, 66).ngClassDirty, Vt._15(n, 66).ngClassValid, Vt._15(n, 66).ngClassInvalid, Vt._15(n, 66).ngClassPending);
        l(n, 80, 0, Vt._24(n, 80, 0, Vt._15(n, 81).transform("text-signaddress")));
        l(n, 83, 0, Vt._15(n, 84)._disabled, Vt._15(n, 88).ngClassUntouched, Vt._15(n, 88).ngClassTouched, Vt._15(n, 88).ngClassPristine, Vt._15(n, 88).ngClassDirty, Vt._15(n, 88).ngClassValid, Vt._15(n, 88).ngClassInvalid, Vt._15(n, 88).ngClassPending)
      })
    }

    function I(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._3(13, 0, null, null, 29, "ion-content", [
        ["no-bounce", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 19, "div", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(18, 0, null, null, 16, "ion-segment", [
        ["color", "primary"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null],
        [2, "segment-disabled", null]
      ], [
        [null, "ngModelChange"],
        [null, "ionChange"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("ngModelChange" === n) {
          e = !1 !== (a.selectedTab = t) && e
        }
        if ("ionChange" === n) {
          e = !1 !== a.selectTab(a.selectedTab) && e
        }
        return e
      }, null, null)), Vt._2(19, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(21, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(22, 1196032, null, 1, Qu.a, [Ga.a, Vt.k, Vt.D, [2, Ut.h]], {
        color: [0, "color"]
      }, {
        ionChange: "ionChange"
      }), Vt._21(603979776, 1, {
        _buttons: 1
      }), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(25, 0, null, null, 3, "ion-segment-button", [
        ["class", "segment-button"],
        ["role", "button"],
        ["tappable", ""],
        ["value", "words"]
      ], [
        [2, "segment-button-disabled", null],
        [2, "segment-activated", null],
        [1, "aria-pressed", 0]
      ], [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== Vt._15(l, 26).onClick() && e
        }
        return e
      }, Xu.b, Xu.a)), Vt._2(26, 114688, [
        [1, 4]
      ], 0, li.a, [], {
        value: [0, "value"]
      }, null), (l()(), Vt._23(27, 0, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(30, 0, null, null, 3, "ion-segment-button", [
        ["class", "segment-button"],
        ["role", "button"],
        ["tappable", ""],
        ["value", "file"]
      ], [
        [2, "segment-button-disabled", null],
        [2, "segment-activated", null],
        [1, "aria-pressed", 0]
      ], [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== Vt._15(l, 31).onClick() && e
        }
        return e
      }, Xu.b, Xu.a)), Vt._2(31, 114688, [
        [1, 4]
      ], 0, li.a, [], {
        value: [0, "value"]
      }, null), (l()(), Vt._23(32, 0, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n\n    "])), (l()(), Vt.Y(16777216, null, 1, 1, null, b)), Vt._2(38, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 1, ["\n\n    "])), (l()(), Vt.Y(16777216, null, 1, 1, null, C)), Vt._2(41, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._3(44, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(45, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(47, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onImport() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(48, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(49, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 19, 0, t.selectedTab);
        l(n, 22, 0, "primary");
        l(n, 26, 0, "words");
        l(n, 31, 0, "file");
        l(n, 38, 0, "file" == t.selectedTab);
        l(n, 41, 0, "words" == t.selectedTab);
        l(n, 48, 0, "")
      }, function(l, n) {
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("launcher-backup-import")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 18, 0, Vt._15(n, 21).ngClassUntouched, Vt._15(n, 21).ngClassTouched, Vt._15(n, 21).ngClassPristine, Vt._15(n, 21).ngClassDirty, Vt._15(n, 21).ngClassValid, Vt._15(n, 21).ngClassInvalid, Vt._15(n, 21).ngClassPending, Vt._15(n, 22)._disabled);
        l(n, 25, 0, Vt._15(n, 26)._disabled, Vt._15(n, 26).isActive, Vt._15(n, 26).isActive);
        l(n, 27, 0, Vt._24(n, 27, 0, Vt._15(n, 28).transform("text-mnemonic")));
        l(n, 30, 0, Vt._15(n, 31)._disabled, Vt._15(n, 31).isActive, Vt._15(n, 31).isActive);
        l(n, 32, 0, Vt._24(n, 32, 0, Vt._15(n, 33).transform("text-from-keystore")));
        l(n, 49, 0, Vt._24(n, 49, 0, Vt._15(n, 50).transform("confirm")))
      })
    }

    function P(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "span", [
        ["style", "font-size: 1.3px"]
      ], null, null, null, null, null)), (l()(), Vt._23(1, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 1, 0, Vt._24(n, 1, 0, Vt._15(n, 2).transform("text-standard-wallte")))
      })
    }

    function S(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "span", [
        ["style", "font-size: 1.3px"]
      ], null, null, null, null, null)), (l()(), Vt._23(1, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 1, 0, Vt._24(n, 1, 0, Vt._15(n, 2).transform("text-multi-wallte")))
      })
    }

    function D(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(1, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 7, {
        contentLabel: 0
      }), Vt._21(603979776, 8, {
        _buttons: 1
      }), Vt._21(603979776, 9, {
        _icons: 1
      }), Vt._2(5, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(7, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(8, 16384, [
        [7, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(9, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(12, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.exprotObj.payPassword = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(13, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(15, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(16, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "]))], function(l, n) {
        l(n, 13, 0, n.component.exprotObj.payPassword);
        l(n, 16, 0, "password", Vt._6(1, "", Vt._24(n, 16, 1, Vt._15(n, 17).transform("unlock-paypassword-placeholder")), ""))
      }, function(l, n) {
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("unlock-paypassword-title")));
        l(n, 12, 0, Vt._15(n, 15).ngClassUntouched, Vt._15(n, 15).ngClassTouched, Vt._15(n, 15).ngClassPristine, Vt._15(n, 15).ngClassDirty, Vt._15(n, 15).ngClassValid, Vt._15(n, 15).ngClassInvalid, Vt._15(n, 15).ngClassPending)
      })
    }

    function M(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 43, "div", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(2, 0, null, null, 40, "ion-list", [], null, null, null, null, null)), Vt._2(3, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(5, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(6, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(10, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(12, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(13, 16384, [
        [1, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(14, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(17, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.exprotObj.backupPassWord = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(18, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(20, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(21, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(25, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(26, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 4, {
        contentLabel: 0
      }), Vt._21(603979776, 5, {
        _buttons: 1
      }), Vt._21(603979776, 6, {
        _icons: 1
      }), Vt._2(30, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(32, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.exprotObj.reBackupPassWord = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(33, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(35, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(36, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, D)), Vt._2(41, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "]))], function(l, n) {
        var t = n.component;
        l(n, 18, 0, t.exprotObj.backupPassWord);
        l(n, 21, 0, "password", Vt._6(1, "", Vt._24(n, 21, 1, Vt._15(n, 22).transform("exportwallet-keystorepassword1-placeholder")), ""));
        l(n, 33, 0, t.exprotObj.reBackupPassWord);
        l(n, 36, 0, "password", Vt._6(1, "", Vt._24(n, 36, 1, Vt._15(n, 37).transform("exportwallet-keystorepassword2-placeholder")), ""));
        l(n, 41, 0, "Readonly" != t.readonly)
      }, function(l, n) {
        l(n, 14, 0, Vt._24(n, 14, 0, Vt._15(n, 15).transform("exportwallet-keystorepassword1-title")));
        l(n, 17, 0, Vt._15(n, 20).ngClassUntouched, Vt._15(n, 20).ngClassTouched, Vt._15(n, 20).ngClassPristine, Vt._15(n, 20).ngClassDirty, Vt._15(n, 20).ngClassValid, Vt._15(n, 20).ngClassInvalid, Vt._15(n, 20).ngClassPending);
        l(n, 32, 0, Vt._15(n, 35).ngClassUntouched, Vt._15(n, 35).ngClassTouched, Vt._15(n, 35).ngClassPristine, Vt._15(n, 35).ngClassDirty, Vt._15(n, 35).ngClassValid, Vt._15(n, 35).ngClassInvalid, Vt._15(n, 35).ngClassPending)
      })
    }

    function j(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 8, "div", [
        ["class", "kuangTextArea"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(2, 0, null, null, 2, "p", [], null, null, null, null, null)), (l()(), Vt._23(3, null, ["", " "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(6, 0, null, null, 1, "textarea", [
        ["class", "backupWalletTextArea"],
        ["rows", "10"]
      ], null, null, null, null, null)), (l()(), Vt._23(7, null, ["", ""])), (l()(), Vt._23(-1, null, ["\n    "]))], null, function(l, n) {
        var t = n.component;
        l(n, 3, 0, Vt._24(n, 3, 0, Vt._15(n, 4).transform("text-keystroe-message")));
        l(n, 7, 0, t.backupWalletPlainText)
      })
    }

    function W(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onDown() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(1, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(2, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], function(l, n) {
        l(n, 1, 0, "")
      }, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("text-down")))
      })
    }

    function O(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onCopay() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(1, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(2, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], function(l, n) {
        l(n, 1, 0, "")
      }, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("text-copy-to-clipboard")))
      })
    }

    function N(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(13, 0, null, null, 21, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 11, "div", [
        ["class", "coin-info-top-box"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(18, 0, null, null, 0, "img", [
        ["src", "./assets/images/logo-maincolor.svg"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(20, 0, null, null, 6, "div", [
        ["style", "font-size: 1.6em;"]
      ], null, null, null, null, null)), (l()(), Vt._23(21, null, ["", "\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, P)), Vt._2(23, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, S)), Vt._2(26, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt.Y(16777216, null, 1, 1, null, M)), Vt._2(30, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 1, ["\n\n    "])), (l()(), Vt.Y(16777216, null, 1, 1, null, j)), Vt._2(33, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 1, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(36, 0, null, null, 8, "ion-footer", [], null, null, null, null, null)), Vt._2(37, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt.Y(16777216, null, null, 1, null, W)), Vt._2(40, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt.Y(16777216, null, null, 1, null, O)), Vt._2(43, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 23, 0, "Standard" === t.account.Type);
        l(n, 26, 0, "Multi-Sign" === t.account.Type);
        l(n, 30, 0, !t.backupWalletPlainText);
        l(n, 33, 0, t.backupWalletPlainText);
        l(n, 40, 0, !t.backupWalletPlainText);
        l(n, 43, 0, t.backupWalletPlainText)
      }, function(l, n) {
        var t = n.component;
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-wallet-export")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 21, 0, t.exprotObj.name)
      })
    }

    function T(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 4, "span", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                      "])), (l()(), Vt._3(2, 0, null, null, 1, "span", [], null, null, null, null, null)), (l()(), Vt._23(3, null, ["", ""])), (l()(), Vt._23(-1, null, ["\n                        "]))], null, function(l, n) {
        l(n, 3, 0, n.context.$implicit.text)
      })
    }

    function L(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(1, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 4, {
        contentLabel: 0
      }), Vt._21(603979776, 5, {
        _buttons: 1
      }), Vt._21(603979776, 6, {
        _icons: 1
      }), Vt._2(5, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                        "])), (l()(), Vt._3(7, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.mnemonicPassword = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(8, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(10, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(11, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                    "]))], function(l, n) {
        l(n, 8, 0, n.component.mnemonicPassword);
        l(n, 11, 0, "password", Vt._6(1, "", Vt._24(n, 11, 1, Vt._15(n, 12).transform("showmnes-optionalpassword1-placeholder")), ""))
      }, function(l, n) {
        l(n, 7, 0, Vt._15(n, 10).ngClassUntouched, Vt._15(n, 10).ngClassTouched, Vt._15(n, 10).ngClassPristine, Vt._15(n, 10).ngClassDirty, Vt._15(n, 10).ngClassValid, Vt._15(n, 10).ngClassInvalid, Vt._15(n, 10).ngClassPending)
      })
    }

    function A(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(1, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 7, {
        contentLabel: 0
      }), Vt._21(603979776, 8, {
        _buttons: 1
      }), Vt._21(603979776, 9, {
        _icons: 1
      }), Vt._2(5, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                        "])), (l()(), Vt._3(7, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.mnemonicRepassword = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(8, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(10, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(11, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                    "]))], function(l, n) {
        l(n, 8, 0, n.component.mnemonicRepassword);
        l(n, 11, 0, "password", Vt._6(1, "", Vt._24(n, 11, 1, Vt._15(n, 12).transform("showmnes-optionalpassword2-placeholder")), ""))
      }, function(l, n) {
        l(n, 7, 0, Vt._15(n, 10).ngClassUntouched, Vt._15(n, 10).ngClassTouched, Vt._15(n, 10).ngClassPristine, Vt._15(n, 10).ngClassDirty, Vt._15(n, 10).ngClassValid, Vt._15(n, 10).ngClassInvalid, Vt._15(n, 10).ngClassPending)
      })
    }

    function R(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(13, 0, null, null, 57, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 53, "div", [
        ["class", "mnemonic"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(18, 0, null, null, 50, "div", [
        ["class", "slide-container"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(20, 0, null, null, 2, "div", [
        ["class", "slide-title"]
      ], null, null, null, null, null)), (l()(), Vt._23(21, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(24, 0, null, null, 10, "div", [
        ["class", "slide-body"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(26, 0, null, null, 7, "div", [
        ["class", "phrase-container"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(28, 0, null, null, 4, "div", [
        ["class", "phrase"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                        "])), (l()(), Vt.Y(16777216, null, null, 1, null, T)), Vt._2(31, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(36, 0, null, null, 31, "div", [
        ["class", "mnemonic-password"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(38, 0, null, null, 28, "ion-list", [], null, null, null, null, null)), Vt._2(39, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(41, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(42, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(46, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                        "])), (l()(), Vt._3(48, 0, null, 1, 3, "ion-label", [
        ["style", "font-size:15px"]
      ], null, null, null, null, null)), Vt._2(49, 16384, [
        [1, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(50, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                        "])), (l()(), Vt._3(53, 0, null, 4, 5, "ion-toggle", [], [
        [2, "toggle-disabled", null],
        [2, "toggle-checked", null],
        [2, "toggle-activated", null],
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"],
        [null, "keyup"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("keyup" === n) {
          e = !1 !== Vt._15(l, 54)._keyup(t) && e
        }
        if ("ngModelChange" === n) {
          e = !1 !== (a.isSelect = t) && e
        }
        return e
      }, ui.b, ui.a)), Vt._2(54, 1228800, null, 0, ii.a, [Iu.a, Ga.a, Ha.a, Vt.k, Vt.D, si.a, [2, Cu.a], Ua.l, Za.a, Vt.x], null, null), Vt._19(1024, null, Ut.g, function(l) {
        return [l]
      }, [ii.a]), Vt._2(56, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [2, Ut.g]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(58, 16384, null, 0, Ut.i, [Ut.h], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._23(-1, null, ["\n\n                    "])), (l()(), Vt.Y(16777216, null, null, 1, null, L)), Vt._2(62, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n                    "])), (l()(), Vt.Y(16777216, null, null, 1, null, A)), Vt._2(65, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(72, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(73, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(75, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(76, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(77, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 31, 0, t.mnemonicList);
        l(n, 56, 0, t.isSelect);
        l(n, 62, 0, t.isSelect);
        l(n, 65, 0, t.isSelect);
        l(n, 76, 0, "")
      }, function(l, n) {
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-mnemonic")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 21, 0, Vt._24(n, 21, 0, Vt._15(n, 22).transform("text-mnemonic-prompt")));
        l(n, 50, 0, Vt._24(n, 50, 0, Vt._15(n, 51).transform("showmnes-optionalpassword1-title")));
        l(n, 53, 0, Vt._15(n, 54)._disabled, Vt._15(n, 54)._value, Vt._15(n, 54)._activated, Vt._15(n, 58).ngClassUntouched, Vt._15(n, 58).ngClassTouched, Vt._15(n, 58).ngClassPristine, Vt._15(n, 58).ngClassDirty, Vt._15(n, 58).ngClassValid, Vt._15(n, 58).ngClassInvalid, Vt._15(n, 58).ngClassPending);
        l(n, 77, 0, Vt._24(n, 77, 0, Vt._15(n, 78).transform("text-memory")))
      })
    }

    function J(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "button", [
        ["ion-button", ""],
        ["outline", ""],
        ["style", "text-transform: none"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.removeButton(l.context.index, l.context.$implicit) && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(1, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        outline: [0, "outline"]
      }, null), (l()(), Vt._23(2, 0, ["", ""]))], function(l, n) {
        l(n, 1, 0, "")
      }, function(l, n) {
        l(n, 2, 0, n.context.$implicit.text)
      })
    }

    function E(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "button", [
        ["ion-button", ""],
        ["outline", ""],
        ["style", "text-transform: none"]
      ], [
        [8, "disabled", 0]
      ], [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.addButton(l.context.index, l.context.$implicit) && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(1, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        outline: [0, "outline"]
      }, null), (l()(), Vt._23(2, 0, ["", "\n                    "]))], function(l, n) {
        l(n, 1, 0, "")
      }, function(l, n) {
        l(n, 0, 0, n.context.$implicit.selected);
        l(n, 2, 0, n.context.$implicit.text)
      })
    }

    function V(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 7, "div", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(2, 0, null, null, 4, "div", [
        ["class", "words"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                        "])), (l()(), Vt.Y(16777216, null, null, 1, null, E)), Vt._2(5, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._23(-1, null, ["\n                "]))], function(l, n) {
        l(n, 5, 0, n.component.mnemonicList)
      }, null)
    }

    function F(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 6, "div", [
        ["class", "bottom-absolute"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(2, 0, null, null, 3, "button", [
        ["class", "button-standard"],
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(3, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(4, 0, ["\n            ", "\n          "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "]))], function(l, n) {
        l(n, 3, 0, "")
      }, function(l, n) {
        l(n, 4, 0, Vt._24(n, 4, 0, Vt._15(n, 5).transform("confirm")))
      })
    }

    function z(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(13, 0, null, null, 33, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 29, "div", [
        ["class", "mnemonic-write"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(18, 0, null, null, 23, "div", [
        ["class", "slide-container"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(20, 0, null, null, 14, "div", [
        ["class", "slide-body"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(22, 0, null, null, 2, "div", [
        ["class", "slide-title"]
      ], null, null, null, null, null)), (l()(), Vt._23(23, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(26, 0, null, null, 7, "div", [
        ["class", "phrase-container"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(28, 0, null, null, 4, "div", [
        ["class", "phrase"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                        "])), (l()(), Vt.Y(16777216, null, null, 1, null, J)), Vt._2(31, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(36, 0, null, null, 4, "div", [
        ["class", "bottom-phrase"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt.Y(16777216, null, null, 1, null, V)), Vt._2(39, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, F)), Vt._2(44, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 31, 0, t.selectList);
        l(n, 39, 0, !t.selectComplete);
        l(n, 44, 0, t.selectComplete)
      }, function(l, n) {
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-mnemonic-check")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 23, 0, Vt._24(n, 23, 0, Vt._15(n, 24).transform("text-mnemonic-prompt2")))
      })
    }

    function K(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 6, "ion-item", [
        ["class", "item item-block"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onItem(l.context.$implicit) && e
        }
        return e
      }, wu.b, wu.a)), Vt._2(1, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(5, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(6, 2, ["\n            ", "\n        "]))], null, function(l, n) {
        l(n, 6, 0, n.context.$implicit)
      })
    }

    function B(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(13, 0, null, null, 19, "ion-content", [
        ["style", "width:100%"]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n\n    "])), (l()(), Vt._3(17, 0, null, 1, 5, "ion-list", [], null, null, null, null, null)), Vt._2(18, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, K)), Vt._2(21, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n\n    "])), (l()(), Vt._3(24, 0, null, 1, 7, "ion-infinite-scroll", [], null, [
        [null, "ionInfinite"]
      ], function(l, n, t) {
        var e = !0;
        if ("ionInfinite" === n) {
          e = !1 !== l.component.doInfinite(t) && e
        }
        return e
      }, null, null)), Vt._2(25, 1196032, null, 0, di.a, [du.a, Vt.x, Vt.k, Za.a], null, {
        ionInfinite: "ionInfinite"
      }), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(27, 0, null, null, 3, "ion-infinite-scroll-content", [
        ["loadingSpinner", "bubbles"]
      ], [
        [1, "state", 0]
      ], null, null, hi.b, hi.a)), Vt._2(28, 114688, null, 0, pi.a, [di.a, Ga.a], {
        loadingSpinner: [0, "loadingSpinner"],
        loadingText: [1, "loadingText"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        l(n, 21, 0, n.component.addrList);
        l(n, 28, 0, "bubbles", Vt._6(1, "", Vt._24(n, 28, 1, Vt._15(n, 29).transform("load-more")), ""))
      }, function(l, n) {
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-manager-address")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 27, 0, Vt._15(n, 28).inf.state)
      })
    }

    function Y(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "ion-note", [
        ["item-end", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, xu.a, [Ga.a, Vt.k, Vt.D], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "]))], null, function(l, n) {
        l(n, 2, 0, n.component.contactUser.name)
      })
    }

    function G(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "ion-note", [
        ["item-end", ""],
        ["style", "font-size: 12px"]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, xu.a, [Ga.a, Vt.k, Vt.D], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "]))], null, function(l, n) {
        l(n, 2, 0, n.component.contactUser.address)
      })
    }

    function H(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "ion-note", [
        ["item-end", ""],
        ["style", "font-size: 12px"]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, xu.a, [Ga.a, Vt.k, Vt.D], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "]))], null, function(l, n) {
        l(n, 2, 0, n.component.contactUser.phone)
      })
    }

    function U(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "ion-note", [
        ["item-end", ""],
        ["style", "font-size: 12px"]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, xu.a, [Ga.a, Vt.k, Vt.D], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "]))], null, function(l, n) {
        l(n, 2, 0, n.component.contactUser.email)
      })
    }

    function q(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "ion-note", [
        ["item-end", ""],
        ["style", "font-size: 12px"]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, xu.a, [Ga.a, Vt.k, Vt.D], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "]))], null, function(l, n) {
        l(n, 2, 0, n.component.contactUser.remark)
      })
    }

    function $(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("click" === n) {
          e = !1 !== a.pay(a.contactUser.address) && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(4, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(5, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        l(n, 4, 0, "")
      }, function(l, n) {
        l(n, 5, 0, Vt._24(n, 5, 0, Vt._15(n, 6).transform("text-transfer")))
      })
    }

    function Z(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 23, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 19, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(11, 0, null, 2, 10, "ion-buttons", [
        ["end", ""]
      ], null, null, null, null, null)), Vt._2(12, 16384, null, 1, mi.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), Vt._21(603979776, 1, {
        _buttons: 1
      }), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(15, 0, null, null, 5, "button", [
        ["icon-only", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.rightHeader() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(16, 1097728, [
        [1, 4]
      ], 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 0, ["\n              "])), (l()(), Vt._3(18, 0, null, 0, 1, "ion-icon", [
        ["name", "close"],
        ["role", "img"]
      ], [
        [2, "hide", null]
      ], null, null, null, null)), Vt._2(19, 147456, null, 0, zu.a, [Ga.a, Vt.k, Vt.D], {
        name: [0, "name"]
      }, null), (l()(), Vt._23(-1, 0, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(25, 0, null, null, 107, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(26, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(28, 0, null, 1, 103, "ion-list", [], null, null, null, null, null)), Vt._2(29, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(31, 0, null, null, 17, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(32, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 2, {
        contentLabel: 0
      }), Vt._21(603979776, 3, {
        _buttons: 1
      }), Vt._21(603979776, 4, {
        _icons: 1
      }), Vt._2(36, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(38, 0, null, 1, 6, "ion-label", [], null, null, null, null, null)), Vt._2(39, 16384, [
        [2, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(41, 0, null, null, 2, "span", [], null, null, null, null, null)), (l()(), Vt._23(42, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt.Y(16777216, null, 4, 1, null, Y)), Vt._2(47, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(50, 0, null, null, 17, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(51, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 5, {
        contentLabel: 0
      }), Vt._21(603979776, 6, {
        _buttons: 1
      }), Vt._21(603979776, 7, {
        _icons: 1
      }), Vt._2(55, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(57, 0, null, 1, 6, "ion-label", [], null, null, null, null, null)), Vt._2(58, 16384, [
        [5, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(60, 0, null, null, 2, "span", [], null, null, null, null, null)), (l()(), Vt._23(61, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt.Y(16777216, null, 4, 1, null, G)), Vt._2(66, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(69, 0, null, null, 17, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(70, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 8, {
        contentLabel: 0
      }), Vt._21(603979776, 9, {
        _buttons: 1
      }), Vt._21(603979776, 10, {
        _icons: 1
      }), Vt._2(74, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(76, 0, null, 1, 6, "ion-label", [], null, null, null, null, null)), Vt._2(77, 16384, [
        [8, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(79, 0, null, null, 2, "span", [], null, null, null, null, null)), (l()(), Vt._23(80, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt.Y(16777216, null, 4, 1, null, H)), Vt._2(85, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(88, 0, null, null, 17, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(89, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 11, {
        contentLabel: 0
      }), Vt._21(603979776, 12, {
        _buttons: 1
      }), Vt._21(603979776, 13, {
        _icons: 1
      }), Vt._2(93, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(95, 0, null, 1, 6, "ion-label", [], null, null, null, null, null)), Vt._2(96, 16384, [
        [11, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(98, 0, null, null, 2, "span", [], null, null, null, null, null)), (l()(), Vt._23(99, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt.Y(16777216, null, 4, 1, null, U)), Vt._2(104, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n\n        "])), (l()(), Vt._3(107, 0, null, null, 17, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(108, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 14, {
        contentLabel: 0
      }), Vt._21(603979776, 15, {
        _buttons: 1
      }), Vt._21(603979776, 16, {
        _icons: 1
      }), Vt._2(112, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(114, 0, null, 1, 6, "ion-label", [], null, null, null, null, null)), Vt._2(115, 16384, [
        [14, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(117, 0, null, null, 2, "span", [], null, null, null, null, null)), (l()(), Vt._23(118, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt.Y(16777216, null, 4, 1, null, q)), Vt._2(123, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(126, 0, null, null, 4, "div", [
        ["style", "text-align: center;width:100%;margin: 10px 0px"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(128, 0, null, null, 1, "qrcode", [
        ["style", "display:inline-block;"]
      ], null, null, null, vi.b, vi.a)), Vt._2(129, 638976, null, 0, yi.a, [Vt.k], {
        level: [0, "level"],
        qrdata: [1, "qrdata"],
        size: [2, "size"]
      }, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt.Y(16777216, null, null, 1, null, $)), Vt._2(135, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null)], function(l, n) {
        var t = n.component;
        l(n, 19, 0, "close");
        l(n, 47, 0, t.contactUser.name);
        l(n, 66, 0, t.contactUser.address);
        l(n, 85, 0, t.contactUser.phone);
        l(n, 104, 0, t.contactUser.email);
        l(n, 123, 0, t.contactUser.remark);
        l(n, 129, 0, "M", t.qrcode, 200);
        l(n, 135, 0, t.isShow)
      }, function(l, n) {
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-contacts")));
        l(n, 18, 0, Vt._15(n, 19)._hidden);
        l(n, 25, 0, Vt._15(n, 26).statusbarPadding, Vt._15(n, 26)._hasRefresher);
        l(n, 42, 0, Vt._24(n, 42, 0, Vt._15(n, 43).transform("contacts-name-title")));
        l(n, 61, 0, Vt._24(n, 61, 0, Vt._15(n, 62).transform("contacts-address-title")));
        l(n, 80, 0, Vt._24(n, 80, 0, Vt._15(n, 81).transform("contacts-phone-title")));
        l(n, 99, 0, Vt._24(n, 99, 0, Vt._15(n, 100).transform("contacts-email-title")));
        l(n, 118, 0, Vt._24(n, 118, 0, Vt._15(n, 119).transform("text-remark")))
      })
    }

    function Q(l) {
      return Vt._25(0, [(l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(1, 0, null, null, 4, "div", [
        ["class", "text-center"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 1, "p", [], null, null, null, null, null)), (l()(), Vt._23(4, null, ["", ""])), (l()(), Vt._23(-1, null, ["\n"]))], null, function(l, n) {
        l(n, 4, 0, n.component.text)
      })
    }

    function X(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "nodata", [
        ["keyText", "no-tx-record"]
      ], null, null, null, Q, wi)), Vt._2(1, 114688, null, 0, xi.a, [Bt.k], {
        keyText: [0, "keyText"]
      }, null)], function(l, n) {
        l(n, 1, 0, "no-tx-record")
      }, null)
    }

    function ll(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 10, "ion-refresher", [], [
        [2, "refresher-active", null],
        [4, "top", null]
      ], [
        [null, "ionRefresh"]
      ], function(l, n, t) {
        var e = !0;
        if ("ionRefresh" === n) {
          e = !1 !== l.component.doRefresh(t) && e
        }
        return e
      }, null, null)), Vt._2(1, 212992, null, 0, hu.a, [Ha.a, du.a, Vt.x, Ua.l], null, {
        ionRefresh: "ionRefresh"
      }), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(3, 0, null, null, 2, "ion-refresher-content", [
        ["pullingIcon", "arrow-dropdown"],
        ["pullingText", ""],
        ["refreshingSpinner", "circles"],
        ["refreshingText", ""]
      ], [
        [1, "state", 0]
      ], null, null, pu.b, pu.a)), Vt._2(4, 114688, null, 0, gu.a, [hu.a, Ga.a], {
        pullingIcon: [0, "pullingIcon"],
        pullingText: [1, "pullingText"],
        refreshingSpinner: [2, "refreshingSpinner"],
        refreshingText: [3, "refreshingText"]
      }, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(7, 0, null, null, 2, "ion-refresher-content", [], [
        [1, "state", 0]
      ], null, null, pu.b, pu.a)), Vt._2(8, 114688, null, 0, gu.a, [hu.a, Ga.a], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "]))], function(l, n) {
        l(n, 1, 0);
        l(n, 4, 0, "arrow-dropdown", "", "circles", ""), l(n, 8, 0)
      }, function(l, n) {
        l(n, 0, 0, "inactive" !== Vt._15(n, 1).state, Vt._15(n, 1)._top);
        l(n, 3, 0, Vt._15(n, 4).r.state);
        l(n, 7, 0, Vt._15(n, 8).r.state)
      })
    }

    function nl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "span", [
        ["class", "font-size-2"]
      ], null, null, null, null, null)), (l()(), Vt._23(1, null, [" ", " "]))], null, function(l, n) {
        l(n, 1, 0, n.parent.context.$implicit.datetime)
      })
    }

    function tl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 25, "ion-row", [
        ["class", "hang row"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onItem(l.context.$implicit) && e
        }
        return e
      }, null, null)), Vt._2(1, 278528, null, 0, fu.g, [Vt.s, Vt.t, Vt.k, Vt.E], {
        klass: [0, "klass"],
        ngClass: [1, "ngClass"]
      }, null), Vt._18(2, {
        "bottom-border": 0
      }), Vt._2(3, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(5, 0, null, null, 4, "ion-col", [
        ["align-self-center", ""],
        ["class", "col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(6, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(8, 0, null, null, 0, "img", [
        ["alt", ""],
        ["class", "transfer-list-img"]
      ], [
        [8, "src", 4]
      ], null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(11, 0, null, null, 9, "ion-col", [
        ["align-self-center", ""],
        ["class", "text-left col"],
        ["col-5", ""]
      ], null, null, null, null, null)), Vt._2(12, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(14, 0, null, null, 2, "span", [
        ["class", "font-size-2"]
      ], null, null, null, null, null)), (l()(), Vt._23(15, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, [" "])), (l()(), Vt.Y(16777216, null, null, 1, null, nl)), Vt._2(19, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(22, 0, null, null, 2, "ion-col", [
        ["align-self-center", ""],
        ["class", "text-right font-size-1 col"],
        ["col-5", ""]
      ], null, null, null, null, null)), Vt._2(23, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(24, null, ["\n                    ", " ", "\n                "])), (l()(), Vt._23(-1, null, ["\n            "]))], function(l, n) {
        l(n, 1, 0, "hang", l(n, 2, 0, n.context.index == n.component.transferList.length - 1));
        l(n, 19, 0, "0" != n.context.$implicit.timestamp)
      }, function(l, n) {
        l(n, 8, 0, Vt._6(1, "", n.context.$implicit.payStatusIcon, ""));
        l(n, 15, 0, Vt._24(n, 15, 0, Vt._15(n, 16).transform(n.context.$implicit.status)));
        l(n, 24, 0, n.context.$implicit.resultAmount > 0 ? "+" : "", n.context.$implicit.resultAmount)
      })
    }

    function el(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "p", [
        ["class", "more"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.clickMore() && e
        }
        return e
      }, null, null)), (l()(), Vt._23(1, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 1, 0, Vt._24(n, 1, 0, Vt._15(n, 2).transform("click-to-load-more")))
      })
    }

    function al(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 36, "div", [
        ["class", "address-whole"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(2, 0, null, null, 6, "div", [
        ["class", "coin-info-top-box"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(4, 0, null, null, 0, "img", [
        ["src", "./assets/images/logo-maincolor.svg"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(6, 0, null, null, 1, "div", [
        ["style", "font-size: 1.6em;"]
      ], null, null, null, null, null)), (l()(), Vt._23(7, null, ["", " ", ""])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(10, 0, null, null, 25, "ion-grid", [
        ["class", "grid"],
        ["style", "margin-bottom: 60px"]
      ], null, null, null, null, null)), Vt._2(11, 16384, null, 0, mu.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(13, 0, null, null, 7, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(14, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(16, 0, null, null, 3, "ion-col", [
        ["class", "row-title col"],
        ["col-12", ""]
      ], null, null, null, null, null)), Vt._2(17, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(18, null, ["\n                    ", "\n                "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, tl)), Vt._2(23, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(25, 0, null, null, 9, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(26, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(28, 0, null, null, 5, "ion-col", [
        ["class", "col"],
        ["col-12", ""]
      ], null, null, null, null, null)), Vt._2(29, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt.Y(16777216, null, null, 1, null, el)), Vt._2(32, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._23(-1, null, ["\n\n    "]))], function(l, n) {
        var t = n.component;
        l(n, 23, 0, t.transferList);
        l(n, 32, 0, t.isShowMore)
      }, function(l, n) {
        var t = n.component;
        l(n, 7, 0, t.coinCount, t.coinName);
        l(n, 18, 0, Vt._24(n, 18, 0, Vt._15(n, 19).transform("coin-recent-transfer")))
      })
    }

    function ul(l) {
      return Vt._25(0, [Vt._21(402653184, 1, {
        navBar: 0
      }), (l()(), Vt._3(1, 0, null, null, 10, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(4, 0, null, null, 6, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, [
        [1, 4]
      ], 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 2, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(13, 0, null, null, 11, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt.Y(16777216, null, 1, 1, null, X)), Vt._2(17, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt.Y(16777216, null, 2, 1, null, ll)), Vt._2(20, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt.Y(16777216, null, 1, 1, null, al)), Vt._2(23, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(26, 0, null, null, 17, "ion-footer", [], null, null, null, null, null)), Vt._2(27, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(29, 0, null, null, 13, "div", [
        ["class", "coin-bottom"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(31, 0, null, null, 2, "div", [
        ["style", "font-size: 1.6em;"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(1) && e
        }
        return e
      }, null, null)), (l()(), Vt._23(32, null, ["\n            ", "\n        "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(35, 0, null, null, 2, "div", [
        ["style", "font-size: 1.6em;"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(3) && e
        }
        return e
      }, null, null)), (l()(), Vt._23(36, null, ["\n            ", "\n        "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(39, 0, null, null, 2, "div", [
        ["style", "font-size: 1.6em;"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(2) && e
        }
        return e
      }, null, null)), (l()(), Vt._23(40, null, ["\n            ", "\n        "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 17, 0, t.isNodata);
        l(n, 20, 0, !t.isNodata);
        l(n, 23, 0, !t.isNodata)
      }, function(l, n) {
        var t = n.component;
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, t.coinName);
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 32, 0, Vt._24(n, 32, 0, Vt._15(n, 33).transform("text-receive")));
        l(n, 36, 0, Vt._24(n, 36, 0, Vt._15(n, 37).transform(t.textShow)));
        l(n, 40, 0, Vt._24(n, 40, 0, Vt._15(n, 41).transform("text-transfer")))
      })
    }

    function il(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 22, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 18, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(11, 0, null, 2, 9, "ion-buttons", [
        ["end", ""]
      ], null, null, null, null, null)), Vt._2(12, 16384, null, 1, mi.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), Vt._21(603979776, 1, {
        _buttons: 1
      }), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(15, 0, null, null, 4, "button", [
        ["icon-only", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.rightHeader() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(16, 1097728, [
        [1, 4]
      ], 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 0, ["\n            "])), (l()(), Vt._3(18, 0, null, 0, 0, "img", [
        ["src", "assets/images/icon/ico-scan.svg"],
        ["style", "width: 40px;height:30px"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, 0, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(24, 0, null, null, 88, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(25, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(27, 0, null, 1, 84, "ion-grid", [
        ["class", "margin-top:10px grid"]
      ], null, null, null, null, null)), Vt._2(28, 16384, null, 0, mu.a, [], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(30, 0, null, null, 26, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(31, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(33, 0, null, null, 17, "ion-col", [
        ["align-self-center", ""],
        ["class", "font-size-1 col"],
        ["col-10", ""],
        ["col-auto", ""]
      ], null, null, null, null, null)), Vt._2(34, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(36, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(37, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 2, {
        contentLabel: 0
      }), Vt._21(603979776, 3, {
        _buttons: 1
      }), Vt._21(603979776, 4, {
        _icons: 1
      }), Vt._2(41, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(43, 0, null, 3, 5, "ion-input", [
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"],
        [null, "disabledChange"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("ngModelChange" === n) {
          e = !1 !== (a.transfer.toAddress = t) && e
        }
        if ("disabledChange" === n) {
          e = !1 !== (a.isInput = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(44, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        isDisabled: [0, "isDisabled"],
        model: [1, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(46, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(47, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        disabled: [0, "disabled"],
        type: [1, "type"],
        placeholder: [2, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(52, 0, null, null, 3, "ion-col", [
        ["align-self-center", ""],
        ["class", "col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(53, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, [" "])), (l()(), Vt._3(55, 0, null, null, 0, "img", [
        ["src", "./assets/images/icon/icon-account.svg"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onClick(1) && e
        }
        return e
      }, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(58, 0, null, null, 26, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(59, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(61, 0, null, null, 17, "ion-col", [
        ["align-self-center", ""],
        ["class", "font-size-1 col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(62, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(64, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(65, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 5, {
        contentLabel: 0
      }), Vt._21(603979776, 6, {
        _buttons: 1
      }), Vt._21(603979776, 7, {
        _icons: 1
      }), Vt._2(69, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(71, 0, null, 3, 5, "ion-input", [
        ["col-auto", ""],
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.transfer.amount = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(72, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(74, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(75, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(80, 0, null, null, 3, "ion-col", [
        ["align-self-center", ""],
        ["class", "text-right font-size-1 col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(81, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(82, null, ["\n                ", "：", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(86, 0, null, null, 24, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(87, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(89, 0, null, null, 20, "ion-col", [
        ["align-self-center", ""],
        ["class", "text-right font-size-1 col"],
        ["col-12", ""]
      ], null, null, null, null, null)), Vt._2(90, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(92, 0, null, null, 16, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(93, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 8, {
        contentLabel: 0
      }), Vt._21(603979776, 9, {
        _buttons: 1
      }), Vt._21(603979776, 10, {
        _icons: 1
      }), Vt._2(97, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(99, 0, null, 2, 8, "textarea", [
        ["maxlength", "20"],
        ["rows", "3"]
      ], [
        [8, "placeholder", 0],
        [1, "maxlength", 0],
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"],
        [null, "input"],
        [null, "blur"],
        [null, "compositionstart"],
        [null, "compositionend"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("input" === n) {
          e = !1 !== Vt._15(l, 100)._handleInput(t.target.value) && e
        }
        if ("blur" === n) {
          e = !1 !== Vt._15(l, 100).onTouched() && e
        }
        if ("compositionstart" === n) {
          e = !1 !== Vt._15(l, 100)._compositionStart() && e
        }
        if ("compositionend" === n) {
          e = !1 !== Vt._15(l, 100)._compositionEnd(t.target.value) && e
        }
        if ("ngModelChange" === n) {
          e = !1 !== (a.transfer.remark = t) && e
        }
        return e
      }, null, null)), Vt._2(100, 16384, null, 0, Ut.b, [Vt.E, Vt.k, [2, Ut.a]], null, null), Vt._2(101, 540672, null, 0, Ut.e, [], {
        maxlength: [0, "maxlength"]
      }, null), Vt._19(1024, null, Ut.f, function(l) {
        return [l]
      }, [Ut.e]), Vt._19(1024, null, Ut.g, function(l) {
        return [l]
      }, [Ut.b]), Vt._2(104, 671744, null, 0, Ut.j, [
        [8, null],
        [2, Ut.f],
        [8, null],
        [2, Ut.g]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(106, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(114, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(115, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(117, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onClick(2) && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(118, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(119, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 44, 0, t.isInput, t.transfer.toAddress);
        l(n, 47, 0, t.isInput, "text", Vt._6(1, "", Vt._24(n, 47, 2, Vt._15(n, 48).transform("text-receiver-address")), ""));
        l(n, 72, 0, t.transfer.amount);
        l(n, 75, 0, "text", Vt._6(1, "", Vt._24(n, 75, 1, Vt._15(n, 76).transform("text-price")), ""));
        l(n, 101, 0, "20");
        l(n, 104, 0, t.transfer.remark);
        l(n, 118, 0, "")
      }, function(l, n) {
        var t = n.component;
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-transfer")));
        l(n, 24, 0, Vt._15(n, 25).statusbarPadding, Vt._15(n, 25)._hasRefresher);
        l(n, 43, 0, Vt._15(n, 46).ngClassUntouched, Vt._15(n, 46).ngClassTouched, Vt._15(n, 46).ngClassPristine, Vt._15(n, 46).ngClassDirty, Vt._15(n, 46).ngClassValid, Vt._15(n, 46).ngClassInvalid, Vt._15(n, 46).ngClassPending);
        l(n, 71, 0, Vt._15(n, 74).ngClassUntouched, Vt._15(n, 74).ngClassTouched, Vt._15(n, 74).ngClassPristine, Vt._15(n, 74).ngClassDirty, Vt._15(n, 74).ngClassValid, Vt._15(n, 74).ngClassInvalid, Vt._15(n, 74).ngClassPending);
        l(n, 82, 0, Vt._24(n, 82, 0, Vt._15(n, 83).transform("text-balance")), t.balance / t.SELA);
        l(n, 99, 0, Vt._6(1, "", Vt._24(n, 99, 0, Vt._15(n, 107).transform("text-remark")), ""), Vt._15(n, 101).maxlength ? Vt._15(n, 101).maxlength : null, Vt._15(n, 106).ngClassUntouched, Vt._15(n, 106).ngClassTouched, Vt._15(n, 106).ngClassPristine, Vt._15(n, 106).ngClassDirty, Vt._15(n, 106).ngClassValid, Vt._15(n, 106).ngClassInvalid, Vt._15(n, 106).ngClassPending);
        l(n, 119, 0, Vt._24(n, 119, 0, Vt._15(n, 120).transform("text-transfer")))
      })
    }

    function sl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"],
        ["hideBackButton", "true"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], {
        hideBackButton: [0, "hideBackButton"]
      }, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(13, 0, null, null, 64, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 60, "ion-grid", [
        ["class", "grid"]
      ], null, null, null, null, null)), Vt._2(17, 16384, null, 0, mu.a, [], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(19, 0, null, null, 56, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(20, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(22, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-3", ""]
      ], null, null, null, null, null)), Vt._2(23, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(24, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(27, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(28, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(29, null, ["\n                - ", " ", "\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(31, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-3", ""]
      ], null, null, null, null, null)), Vt._2(32, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(33, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(36, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(37, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(38, null, ["\n                - ", " ", "\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(40, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-3", ""]
      ], null, null, null, null, null)), Vt._2(41, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(42, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(45, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(46, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(47, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(49, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-3", ""]
      ], null, null, null, null, null)), Vt._2(50, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(51, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(54, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(55, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(56, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(58, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-3", ""]
      ], null, null, null, null, null)), Vt._2(59, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(60, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(63, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(64, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(65, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(67, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-3", ""]
      ], null, null, null, null, null)), Vt._2(68, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(69, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(72, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(73, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(74, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(79, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(80, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(82, 0, null, null, 3, "button", [
        ["ion-button", ""],
        ["style", "width: 100%"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onClick(2) && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(83, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(84, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        l(n, 4, 0, "true")
      }, function(l, n) {
        var t = n.component;
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-payment-confirm")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 24, 0, Vt._24(n, 24, 0, Vt._15(n, 25).transform("transaction-price")));
        l(n, 29, 0, t.transfer.amount / t.SELA, t.chianId);
        l(n, 33, 0, Vt._24(n, 33, 0, Vt._15(n, 34).transform("text-to-address")));
        l(n, 38, 0, t.transfer.amount / t.SELA, t.chianId);
        l(n, 42, 0, Vt._24(n, 42, 0, Vt._15(n, 43).transform("text-to-address")));
        l(n, 47, 0, t.transfer.toAddress);
        l(n, 51, 0, Vt._24(n, 51, 0, Vt._15(n, 52).transform("text-memo")));
        l(n, 56, 0, t.transfer.memo);
        l(n, 60, 0, Vt._24(n, 60, 0, Vt._15(n, 61).transform("text-memo")));
        l(n, 65, 0, t.transfer.memo);
        l(n, 69, 0, Vt._24(n, 69, 0, Vt._15(n, 70).transform("text-information")));
        l(n, 74, 0, t.information);
        l(n, 84, 0, Vt._24(n, 84, 0, Vt._15(n, 85).transform("text-transfer")))
      })
    }

    function ol(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 10, "ion-item", [
        ["class", "item item-block"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onItem(l.context.$implicit.id) && e
        }
        return e
      }, wu.b, wu.a)), Vt._2(1, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(5, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(7, 0, null, 4, 2, "ion-note", [
        ["item-end", ""]
      ], null, null, null, null, null)), Vt._2(8, 16384, null, 0, xu.a, [Ga.a, Vt.k, Vt.D], null, null), (l()(), Vt._23(9, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, 2, ["\n        "]))], null, function(l, n) {
        l(n, 9, 0, n.context.$implicit.id)
      })
    }

    function rl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(13, 0, null, null, 9, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 5, "ion-list", [], null, null, null, null, null)), Vt._2(17, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, ol)), Vt._2(20, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        l(n, 20, 0, n.component.kycIdArr)
      }, function(l, n) {
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-did-login")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher)
      })
    }

    function cl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(13, 0, null, null, 19, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 15, "div", [
        ["class", "receive-box"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(18, 0, null, null, 1, "qrcode", [
        ["class", "receive-qrocde"]
      ], null, null, null, vi.b, vi.a)), Vt._2(19, 638976, null, 0, yi.a, [Vt.k], {
        level: [0, "level"],
        qrdata: [1, "qrdata"],
        size: [2, "size"]
      }, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(21, 0, null, null, 2, "p", [
        ["class", "receive-address"],
        ["style", "font-size: 1.2em;"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(0) && e
        }
        return e
      }, null, null)), (l()(), Vt._23(22, null, ["", " "])), (l()(), Vt._3(23, 0, null, null, 0, "img", [
        ["src", "./assets/images/icon/icon-copy.svg"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(25, 0, null, null, 5, "div", [
        ["class", "recevie-bottom"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(2) && e
        }
        return e
      }, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(27, 0, null, null, 2, "p", [
        ["style", "font-size: 1.6em;"]
      ], null, null, null, null, null)), (l()(), Vt._23(28, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        l(n, 19, 0, "M", n.component.qrcode, 200)
      }, function(l, n) {
        var t = n.component;
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-receive")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 22, 0, t.address);
        l(n, 28, 0, Vt._24(n, 28, 0, Vt._15(n, 29).transform("text-manager-address")))
      })
    }

    function _l(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 22, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 18, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(11, 0, null, 2, 9, "ion-buttons", [
        ["end", ""]
      ], null, null, null, null, null)), Vt._2(12, 16384, null, 1, mi.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), Vt._21(603979776, 1, {
        _buttons: 1
      }), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(15, 0, null, null, 4, "button", [
        ["icon-only", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.rightHeader() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(16, 1097728, [
        [1, 4]
      ], 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 0, ["\n            "])), (l()(), Vt._3(18, 0, null, 0, 0, "img", [
        ["src", "assets/images/icon/ico-scan.svg"],
        ["style", "width: 40px;height:30px"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, 0, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(24, 0, null, null, 84, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(25, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(27, 0, null, 1, 80, "ion-grid", [
        ["class", "margin-top:10px grid"]
      ], null, null, null, null, null)), Vt._2(28, 16384, null, 0, mu.a, [], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(30, 0, null, null, 21, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(31, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(33, 0, null, null, 17, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-12", ""],
        ["col-auto", ""]
      ], null, null, null, null, null)), Vt._2(34, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(36, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(37, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 2, {
        contentLabel: 0
      }), Vt._21(603979776, 3, {
        _buttons: 1
      }), Vt._21(603979776, 4, {
        _icons: 1
      }), Vt._2(41, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(43, 0, null, 3, 5, "ion-input", [
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.sidechain.accounts = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(44, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(46, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(47, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(53, 0, null, null, 27, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(54, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(56, 0, null, null, 17, "ion-col", [
        ["align-self-center", ""],
        ["class", "font-size-1 col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(57, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(59, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(60, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 5, {
        contentLabel: 0
      }), Vt._21(603979776, 6, {
        _buttons: 1
      }), Vt._21(603979776, 7, {
        _icons: 1
      }), Vt._2(64, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(66, 0, null, 3, 5, "ion-input", [
        ["col-auto", ""],
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.transfer.amount = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(67, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(69, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(70, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(75, 0, null, null, 4, "ion-col", [
        ["align-self-center", ""],
        ["class", "text-right font-size-1 col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(76, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(77, null, ["\n                ", "：", "(", "：1:", ")\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(82, 0, null, null, 24, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(83, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(85, 0, null, null, 20, "ion-col", [
        ["align-self-center", ""],
        ["class", "text-right font-size-1 col"],
        ["col-12", ""]
      ], null, null, null, null, null)), Vt._2(86, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(88, 0, null, null, 16, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(89, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 8, {
        contentLabel: 0
      }), Vt._21(603979776, 9, {
        _buttons: 1
      }), Vt._21(603979776, 10, {
        _icons: 1
      }), Vt._2(93, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(95, 0, null, 2, 8, "textarea", [
        ["maxlength", "20"],
        ["rows", "3"]
      ], [
        [8, "placeholder", 0],
        [1, "maxlength", 0],
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"],
        [null, "input"],
        [null, "blur"],
        [null, "compositionstart"],
        [null, "compositionend"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("input" === n) {
          e = !1 !== Vt._15(l, 96)._handleInput(t.target.value) && e
        }
        if ("blur" === n) {
          e = !1 !== Vt._15(l, 96).onTouched() && e
        }
        if ("compositionstart" === n) {
          e = !1 !== Vt._15(l, 96)._compositionStart() && e
        }
        if ("compositionend" === n) {
          e = !1 !== Vt._15(l, 96)._compositionEnd(t.target.value) && e
        }
        if ("ngModelChange" === n) {
          e = !1 !== (a.transfer.remark = t) && e
        }
        return e
      }, null, null)), Vt._2(96, 16384, null, 0, Ut.b, [Vt.E, Vt.k, [2, Ut.a]], null, null), Vt._2(97, 540672, null, 0, Ut.e, [], {
        maxlength: [0, "maxlength"]
      }, null), Vt._19(1024, null, Ut.f, function(l) {
        return [l]
      }, [Ut.e]), Vt._19(1024, null, Ut.g, function(l) {
        return [l]
      }, [Ut.b]), Vt._2(100, 671744, null, 0, Ut.j, [
        [8, null],
        [2, Ut.f],
        [8, null],
        [2, Ut.g]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(102, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(110, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(111, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(113, 0, null, null, 3, "button", [
        ["ion-button", ""],
        ["style", "width: 100%"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onClick(2) && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(114, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(115, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 44, 0, t.sidechain.accounts);
        l(n, 47, 0, "text", Vt._6(1, "", Vt._24(n, 47, 1, Vt._15(n, 48).transform("text-recharge-address")), ""));
        l(n, 67, 0, t.transfer.amount);
        l(n, 70, 0, "text", Vt._6(1, "", Vt._24(n, 70, 1, Vt._15(n, 71).transform("text-price")), ""));
        l(n, 97, 0, "20");
        l(n, 100, 0, t.transfer.remark)
      }, function(l, n) {
        var t = n.component;
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-recharge")));
        l(n, 24, 0, Vt._15(n, 25).statusbarPadding, Vt._15(n, 25)._hasRefresher);
        l(n, 43, 0, Vt._15(n, 46).ngClassUntouched, Vt._15(n, 46).ngClassTouched, Vt._15(n, 46).ngClassPristine, Vt._15(n, 46).ngClassDirty, Vt._15(n, 46).ngClassValid, Vt._15(n, 46).ngClassInvalid, Vt._15(n, 46).ngClassPending);
        l(n, 66, 0, Vt._15(n, 69).ngClassUntouched, Vt._15(n, 69).ngClassTouched, Vt._15(n, 69).ngClassPristine, Vt._15(n, 69).ngClassDirty, Vt._15(n, 69).ngClassValid, Vt._15(n, 69).ngClassInvalid, Vt._15(n, 69).ngClassPending);
        l(n, 77, 0, Vt._24(n, 77, 0, Vt._15(n, 78).transform("text-balance")), t.balance / t.SELA, Vt._24(n, 77, 2, Vt._15(n, 79).transform("text-rate")), t.sidechain.rate);
        l(n, 95, 0, Vt._6(1, "", Vt._24(n, 95, 0, Vt._15(n, 103).transform("text-remark")), ""), Vt._15(n, 97).maxlength ? Vt._15(n, 97).maxlength : null, Vt._15(n, 102).ngClassUntouched, Vt._15(n, 102).ngClassTouched, Vt._15(n, 102).ngClassPristine, Vt._15(n, 102).ngClassDirty, Vt._15(n, 102).ngClassValid, Vt._15(n, 102).ngClassInvalid, Vt._15(n, 102).ngClassPending);
        l(n, 115, 0, Vt._24(n, 115, 0, Vt._15(n, 116).transform("text-transfer")))
      })
    }

    function dl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "nodata", [
        ["keyText", "no-open-side-chain"]
      ], null, null, null, Q, wi)), Vt._2(1, 114688, null, 0, xi.a, [Bt.k], {
        keyText: [0, "keyText"]
      }, null)], function(l, n) {
        l(n, 1, 0, "no-open-side-chain")
      }, null)
    }

    function hl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 16, "ion-item", [
        ["class", "item item-block"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onItem(l.context.$implicit) && e
        }
        return e
      }, wu.b, wu.a)), Vt._2(1, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(5, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(7, 0, null, 0, 4, "ion-icon", [
        ["item-start", ""],
        ["role", "img"]
      ], [
        [2, "hide", null]
      ], null, null, null, null)), Vt._2(8, 147456, [
        [3, 4]
      ], 0, zu.a, [Ga.a, Vt.k, Vt.D], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(10, 0, null, null, 0, "img", [
        ["src", "./assets/images/logo-maincolor.svg"],
        ["width", "40"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(13, 0, null, 4, 2, "ion-note", [
        ["item-end", ""]
      ], null, null, null, null, null)), Vt._2(14, 16384, null, 0, xu.a, [Ga.a, Vt.k, Vt.D], null, null), (l()(), Vt._23(15, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, 2, ["\n        "]))], null, function(l, n) {
        l(n, 7, 0, Vt._15(n, 8)._hidden);
        l(n, 15, 0, n.context.$implicit.name)
      })
    }

    function pl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 5, "ion-list", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, hl)), Vt._2(4, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "]))], function(l, n) {
        l(n, 4, 0, n.component.coinList)
      }, null)
    }

    function gl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(13, 0, null, null, 8, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt.Y(16777216, null, 1, 1, null, dl)), Vt._2(17, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt.Y(16777216, null, 1, 1, null, pl)), Vt._2(20, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 17, 0, t.isNoData);
        l(n, 20, 0, !t.isNoData)
      }, function(l, n) {
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-coin-list")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher)
      })
    }

    function fl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 22, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 18, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(11, 0, null, 2, 9, "ion-buttons", [
        ["end", ""]
      ], null, null, null, null, null)), Vt._2(12, 16384, null, 1, mi.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), Vt._21(603979776, 1, {
        _buttons: 1
      }), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(15, 0, null, null, 4, "button", [
        ["icon-only", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.rightHeader() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(16, 1097728, [
        [1, 4]
      ], 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 0, ["\n            "])), (l()(), Vt._3(18, 0, null, 0, 0, "img", [
        ["src", "assets/images/icon/ico-scan.svg"],
        ["style", "width: 40px;height:30px"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, 0, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(24, 0, null, null, 84, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(25, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(27, 0, null, 1, 80, "ion-grid", [
        ["class", "margin-top:10px grid"]
      ], null, null, null, null, null)), Vt._2(28, 16384, null, 0, mu.a, [], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(30, 0, null, null, 21, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(31, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(33, 0, null, null, 17, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-12", ""],
        ["col-auto", ""]
      ], null, null, null, null, null)), Vt._2(34, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(36, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(37, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 2, {
        contentLabel: 0
      }), Vt._21(603979776, 3, {
        _buttons: 1
      }), Vt._21(603979776, 4, {
        _icons: 1
      }), Vt._2(41, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(43, 0, null, 3, 5, "ion-input", [
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.mainchain.accounts = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(44, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(46, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(47, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(53, 0, null, null, 27, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(54, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(56, 0, null, null, 17, "ion-col", [
        ["align-self-center", ""],
        ["class", "font-size-1 col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(57, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(59, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(60, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 5, {
        contentLabel: 0
      }), Vt._21(603979776, 6, {
        _buttons: 1
      }), Vt._21(603979776, 7, {
        _icons: 1
      }), Vt._2(64, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(66, 0, null, 3, 5, "ion-input", [
        ["col-auto", ""],
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.transfer.amount = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(67, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(69, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(70, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(75, 0, null, null, 4, "ion-col", [
        ["align-self-center", ""],
        ["class", "text-right font-size-1 col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(76, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(77, null, ["\n                ", "：", "(", "：1:", ")\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(82, 0, null, null, 24, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(83, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(85, 0, null, null, 20, "ion-col", [
        ["align-self-center", ""],
        ["class", "text-right font-size-1 col"],
        ["col-12", ""]
      ], null, null, null, null, null)), Vt._2(86, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(88, 0, null, null, 16, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(89, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 8, {
        contentLabel: 0
      }), Vt._21(603979776, 9, {
        _buttons: 1
      }), Vt._21(603979776, 10, {
        _icons: 1
      }), Vt._2(93, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(95, 0, null, 2, 8, "textarea", [
        ["maxlength", "20"],
        ["rows", "3"]
      ], [
        [8, "placeholder", 0],
        [1, "maxlength", 0],
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"],
        [null, "input"],
        [null, "blur"],
        [null, "compositionstart"],
        [null, "compositionend"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("input" === n) {
          e = !1 !== Vt._15(l, 96)._handleInput(t.target.value) && e
        }
        if ("blur" === n) {
          e = !1 !== Vt._15(l, 96).onTouched() && e
        }
        if ("compositionstart" === n) {
          e = !1 !== Vt._15(l, 96)._compositionStart() && e
        }
        if ("compositionend" === n) {
          e = !1 !== Vt._15(l, 96)._compositionEnd(t.target.value) && e
        }
        if ("ngModelChange" === n) {
          e = !1 !== (a.transfer.remark = t) && e
        }
        return e
      }, null, null)), Vt._2(96, 16384, null, 0, Ut.b, [Vt.E, Vt.k, [2, Ut.a]], null, null), Vt._2(97, 540672, null, 0, Ut.e, [], {
        maxlength: [0, "maxlength"]
      }, null), Vt._19(1024, null, Ut.f, function(l) {
        return [l]
      }, [Ut.e]), Vt._19(1024, null, Ut.g, function(l) {
        return [l]
      }, [Ut.b]), Vt._2(100, 671744, null, 0, Ut.j, [
        [8, null],
        [2, Ut.f],
        [8, null],
        [2, Ut.g]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(102, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(110, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(111, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(113, 0, null, null, 3, "button", [
        ["ion-button", ""],
        ["style", "width: 100%"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onClick(2) && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(114, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(115, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 44, 0, t.mainchain.accounts);
        l(n, 47, 0, "text", Vt._6(1, "", Vt._24(n, 47, 1, Vt._15(n, 48).transform("text-withdraw-address")), ""));
        l(n, 67, 0, t.transfer.amount);
        l(n, 70, 0, "text", Vt._6(1, "", Vt._24(n, 70, 1, Vt._15(n, 71).transform("text-price")), ""));
        l(n, 97, 0, "20");
        l(n, 100, 0, t.transfer.remark)
      }, function(l, n) {
        var t = n.component;
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-withdraw")));
        l(n, 24, 0, Vt._15(n, 25).statusbarPadding, Vt._15(n, 25)._hasRefresher);
        l(n, 43, 0, Vt._15(n, 46).ngClassUntouched, Vt._15(n, 46).ngClassTouched, Vt._15(n, 46).ngClassPristine, Vt._15(n, 46).ngClassDirty, Vt._15(n, 46).ngClassValid, Vt._15(n, 46).ngClassInvalid, Vt._15(n, 46).ngClassPending);
        l(n, 66, 0, Vt._15(n, 69).ngClassUntouched, Vt._15(n, 69).ngClassTouched, Vt._15(n, 69).ngClassPristine, Vt._15(n, 69).ngClassDirty, Vt._15(n, 69).ngClassValid, Vt._15(n, 69).ngClassInvalid, Vt._15(n, 69).ngClassPending);
        l(n, 77, 0, Vt._24(n, 77, 0, Vt._15(n, 78).transform("text-balance")), t.balance / t.SELA, Vt._24(n, 77, 2, Vt._15(n, 79).transform("text-rate")), t.mainchain.rate);
        l(n, 95, 0, Vt._6(1, "", Vt._24(n, 95, 0, Vt._15(n, 103).transform("text-remark")), ""), Vt._15(n, 97).maxlength ? Vt._15(n, 97).maxlength : null, Vt._15(n, 102).ngClassUntouched, Vt._15(n, 102).ngClassTouched, Vt._15(n, 102).ngClassPristine, Vt._15(n, 102).ngClassDirty, Vt._15(n, 102).ngClassValid, Vt._15(n, 102).ngClassInvalid, Vt._15(n, 102).ngClassPending);
        l(n, 115, 0, Vt._24(n, 115, 0, Vt._15(n, 116).transform("text-transfer")))
      })
    }

    function ml(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "nodata", [
        ["keyText", "no-add-contact"]
      ], null, null, null, Q, wi)), Vt._2(1, 114688, null, 0, xi.a, [Bt.k], {
        keyText: [0, "keyText"]
      }, null)], function(l, n) {
        l(n, 1, 0, "no-add-contact")
      }, null)
    }

    function vl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 6, "button", [
        ["class", "item item-block"],
        ["ion-item", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onclick(l.context.$implicit.id) && e
        }
        return e
      }, wu.b, wu.a)), Vt._2(1, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 2, {
        contentLabel: 0
      }), Vt._21(603979776, 3, {
        _buttons: 1
      }), Vt._21(603979776, 4, {
        _icons: 1
      }), Vt._2(5, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(6, 2, ["\n          ", "\n        "]))], null, function(l, n) {
        l(n, 6, 0, n.context.$implicit.name)
      })
    }

    function yl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 5, "ion-list", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, vl)), Vt._2(4, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "]))], function(l, n) {
        l(n, 4, 0, n.component.contactUsers)
      }, null)
    }

    function bl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 23, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 19, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(11, 0, null, 2, 10, "ion-buttons", [
        ["end", ""]
      ], null, null, null, null, null)), Vt._2(12, 16384, null, 1, mi.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), Vt._21(603979776, 1, {
        _buttons: 1
      }), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(15, 0, null, null, 5, "button", [
        ["icon-only", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.rightHeader() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(16, 1097728, [
        [1, 4]
      ], 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 0, ["\n              "])), (l()(), Vt._3(18, 0, null, 0, 1, "ion-icon", [
        ["name", "add"],
        ["role", "img"]
      ], [
        [2, "hide", null]
      ], null, null, null, null)), Vt._2(19, 147456, null, 0, zu.a, [Ga.a, Vt.k, Vt.D], {
        name: [0, "name"]
      }, null), (l()(), Vt._23(-1, 0, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(25, 0, null, null, 8, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(26, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt.Y(16777216, null, 1, 1, null, ml)), Vt._2(29, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt.Y(16777216, null, 1, 1, null, yl)), Vt._2(32, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 19, 0, "add");
        l(n, 29, 0, t.isnodata);
        l(n, 32, 0, !t.isnodata)
      }, function(l, n) {
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-contacts")));
        l(n, 18, 0, Vt._15(n, 19)._hidden);
        l(n, 25, 0, Vt._15(n, 26).statusbarPadding, Vt._15(n, 26)._hasRefresher)
      })
    }

    function kl(l) {
      return Vt._25(0, [(l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [
        ["style", "text-align: center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n\n\n"])), (l()(), Vt._3(14, 0, null, null, 11, "ion-content", [
        ["padding", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(17, 0, null, 1, 7, "div", [
        ["style", "text-align: center;width:100%;"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.copy() && e
        }
        return e
      }, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(19, 0, null, null, 1, "qrcode", [
        ["class", "receive-qrocde"],
        ["style", "display:inline-block;"]
      ], null, null, null, vi.b, vi.a)), Vt._2(20, 638976, null, 0, yi.a, [Vt.k], {
        level: [0, "level"],
        qrdata: [1, "qrdata"],
        size: [2, "size"]
      }, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(22, 0, null, null, 1, "p", [
        ["style", "text-align:left;margin-top: 10px;font-size:1.6em"]
      ], null, null, null, null, null)), (l()(), Vt._23(23, null, ["", ""])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        l(n, 20, 0, "M", n.component.qrcode, 200)
      }, function(l, n) {
        var t = n.component;
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("text-check-publickey")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher);
        l(n, 23, 0, t.qrcode)
      })
    }

    function xl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(13, 0, null, null, 106, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 102, "ion-list", [], null, null, null, null, null)), Vt._2(17, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(19, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(20, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(24, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(26, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(27, 16384, [
        [1, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(28, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(31, 0, null, 3, 5, "ion-input", [
        ["placeholder", ""],
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.name = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(32, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(34, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(35, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(39, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(40, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 4, {
        contentLabel: 0
      }), Vt._21(603979776, 5, {
        _buttons: 1
      }), Vt._21(603979776, 6, {
        _icons: 1
      }), Vt._2(44, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(46, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(47, 16384, [
        [4, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(48, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(51, 0, null, 3, 5, "ion-input", [
        ["placeholder", ""],
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.address = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(52, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(54, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(55, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(59, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(60, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 7, {
        contentLabel: 0
      }), Vt._21(603979776, 8, {
        _buttons: 1
      }), Vt._21(603979776, 9, {
        _icons: 1
      }), Vt._2(64, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(66, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(67, 16384, [
        [7, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(68, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(71, 0, null, 3, 5, "ion-input", [
        ["placeholder", ""],
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.phone = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(72, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(74, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(75, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(79, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(80, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 10, {
        contentLabel: 0
      }), Vt._21(603979776, 11, {
        _buttons: 1
      }), Vt._21(603979776, 12, {
        _icons: 1
      }), Vt._2(84, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(86, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(87, 16384, [
        [10, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(88, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(91, 0, null, 3, 5, "ion-input", [
        ["placeholder", ""],
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.email = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(92, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(94, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(95, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(99, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(100, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 13, {
        contentLabel: 0
      }), Vt._21(603979776, 14, {
        _buttons: 1
      }), Vt._21(603979776, 15, {
        _icons: 1
      }), Vt._2(104, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(106, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(107, 16384, [
        [13, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(108, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(111, 0, null, 3, 5, "ion-input", [
        ["placeholder", ""],
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.remark = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(112, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(114, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(115, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(121, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(122, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(124, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.add() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(125, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(126, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 32, 0, t.name);
        l(n, 35, 0, "text", "");
        l(n, 52, 0, t.address);
        l(n, 55, 0, "text", "");
        l(n, 72, 0, t.phone);
        l(n, 75, 0, "text", "");
        l(n, 92, 0, t.email);
        l(n, 95, 0, "text", "");
        l(n, 112, 0, t.remark);
        l(n, 115, 0, "text", "");
        l(n, 125, 0, "")
      }, function(l, n) {
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-contacts-add")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 28, 0, Vt._24(n, 28, 0, Vt._15(n, 29).transform("contacts-name-title")));
        l(n, 31, 0, Vt._15(n, 34).ngClassUntouched, Vt._15(n, 34).ngClassTouched, Vt._15(n, 34).ngClassPristine, Vt._15(n, 34).ngClassDirty, Vt._15(n, 34).ngClassValid, Vt._15(n, 34).ngClassInvalid, Vt._15(n, 34).ngClassPending);
        l(n, 48, 0, Vt._24(n, 48, 0, Vt._15(n, 49).transform("contacts-address-title")));
        l(n, 51, 0, Vt._15(n, 54).ngClassUntouched, Vt._15(n, 54).ngClassTouched, Vt._15(n, 54).ngClassPristine, Vt._15(n, 54).ngClassDirty, Vt._15(n, 54).ngClassValid, Vt._15(n, 54).ngClassInvalid, Vt._15(n, 54).ngClassPending);
        l(n, 68, 0, Vt._24(n, 68, 0, Vt._15(n, 69).transform("contacts-phone-title")));
        l(n, 71, 0, Vt._15(n, 74).ngClassUntouched, Vt._15(n, 74).ngClassTouched, Vt._15(n, 74).ngClassPristine, Vt._15(n, 74).ngClassDirty, Vt._15(n, 74).ngClassValid, Vt._15(n, 74).ngClassInvalid, Vt._15(n, 74).ngClassPending);
        l(n, 88, 0, Vt._24(n, 88, 0, Vt._15(n, 89).transform("contacts-email-title")));
        l(n, 91, 0, Vt._15(n, 94).ngClassUntouched, Vt._15(n, 94).ngClassTouched, Vt._15(n, 94).ngClassPristine, Vt._15(n, 94).ngClassDirty, Vt._15(n, 94).ngClassValid, Vt._15(n, 94).ngClassInvalid, Vt._15(n, 94).ngClassPending);
        l(n, 108, 0, Vt._24(n, 108, 0, Vt._15(n, 109).transform("contacts-remark-title")));
        l(n, 111, 0, Vt._15(n, 114).ngClassUntouched, Vt._15(n, 114).ngClassTouched, Vt._15(n, 114).ngClassPristine, Vt._15(n, 114).ngClassDirty, Vt._15(n, 114).ngClassValid, Vt._15(n, 114).ngClassInvalid, Vt._15(n, 114).ngClassPending);
        l(n, 126, 0, Vt._24(n, 126, 0, Vt._15(n, 127).transform("text-add")))
      })
    }

    function wl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 5, "ion-toggle", [], [
        [2, "toggle-disabled", null],
        [2, "toggle-checked", null],
        [2, "toggle-activated", null],
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"],
        [null, "ionChange"],
        [null, "keyup"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("keyup" === n) {
          e = !1 !== Vt._15(l, 1)._keyup(t) && e
        }
        if ("ngModelChange" === n) {
          e = !1 !== (l.parent.context.$implicit.open = t) && e
        }
        if ("ionChange" === n) {
          e = !1 !== a.onSelect(l.parent.context.$implicit) && e
        }
        return e
      }, ui.b, ui.a)), Vt._2(1, 1228800, null, 0, ii.a, [Iu.a, Ga.a, Ha.a, Vt.k, Vt.D, si.a, [2, Cu.a], Ua.l, Za.a, Vt.x], null, {
        ionChange: "ionChange"
      }), Vt._19(1024, null, Ut.g, function(l) {
        return [l]
      }, [ii.a]), Vt._2(3, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [2, Ut.g]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(5, 16384, null, 0, Ut.i, [Ut.h], null, null)], function(l, n) {
        l(n, 3, 0, n.parent.context.$implicit.open)
      }, function(l, n) {
        l(n, 0, 0, Vt._15(n, 1)._disabled, Vt._15(n, 1)._value, Vt._15(n, 1)._activated, Vt._15(n, 5).ngClassUntouched, Vt._15(n, 5).ngClassTouched, Vt._15(n, 5).ngClassPristine, Vt._15(n, 5).ngClassDirty, Vt._15(n, 5).ngClassValid, Vt._15(n, 5).ngClassInvalid, Vt._15(n, 5).ngClassPending)
      })
    }

    function Cl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(1, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 2, {
        contentLabel: 0
      }), Vt._21(603979776, 3, {
        _buttons: 1
      }), Vt._21(603979776, 4, {
        _icons: 1
      }), Vt._2(5, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(7, 0, null, 1, 2, "ion-label", [], null, null, null, null, null)), Vt._2(8, 16384, [
        [2, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(9, null, ["", ""])), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt.Y(16777216, null, 4, 1, null, wl)), Vt._2(12, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 2, ["\n        "]))], function(l, n) {
        l(n, 12, 0, "ELA" != n.context.$implicit.name)
      }, function(l, n) {
        l(n, 9, 0, n.context.$implicit.name)
      })
    }

    function Il(l) {
      return Vt._25(0, [Vt._21(402653184, 1, {
        navBar: 0
      }), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, [
        [1, 4]
      ], 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(14, 0, null, null, 9, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(17, 0, null, 1, 5, "ion-list", [], null, null, null, null, null)), Vt._2(18, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, Cl)), Vt._2(21, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        l(n, 21, 0, n.component.coinList)
      }, function(l, n) {
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("text-coin-list")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher)
      })
    }

    function Pl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(13, 0, null, null, 81, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 77, "ion-list", [], null, null, null, null, null)), Vt._2(17, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(19, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(20, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(24, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(26, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(27, 16384, [
        [1, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(28, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(31, 0, null, 3, 5, "ion-input", [
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.wallet.name = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(32, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(34, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(35, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(39, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(40, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 4, {
        contentLabel: 0
      }), Vt._21(603979776, 5, {
        _buttons: 1
      }), Vt._21(603979776, 6, {
        _icons: 1
      }), Vt._2(44, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(46, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(47, 16384, [
        [4, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(48, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(51, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.wallet.payPassword = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(52, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(54, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(55, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(59, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(60, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 7, {
        contentLabel: 0
      }), Vt._21(603979776, 8, {
        _buttons: 1
      }), Vt._21(603979776, 9, {
        _icons: 1
      }), Vt._2(64, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(66, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.wallet.rePayPassword = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(67, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(69, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(70, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(74, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(75, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 10, {
        contentLabel: 0
      }), Vt._21(603979776, 11, {
        _buttons: 1
      }), Vt._21(603979776, 12, {
        _icons: 1
      }), Vt._2(79, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(81, 0, null, 1, 3, "ion-label", [], null, null, null, null, null)), Vt._2(82, 16384, [
        [10, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(83, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(86, 0, null, 0, 5, "ion-checkbox", [], [
        [2, "checkbox-disabled", null],
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"],
        [null, "disabledChange"],
        [null, "click"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("click" === n) {
          e = !1 !== Vt._15(l, 87)._click(t) && e
        }
        if ("ngModelChange" === n) {
          e = !1 !== (a.wallet.singleAddress = t) && e
        }
        if ("disabledChange" === n) {
          e = !1 !== (a.isShow = t) && e
        }
        return e
      }, $u.b, $u.a)), Vt._2(87, 1228800, null, 0, Zu.a, [Ga.a, Iu.a, [2, Cu.a], Vt.k, Vt.D], {
        disabled: [0, "disabled"]
      }, null), Vt._19(1024, null, Ut.g, function(l) {
        return [l]
      }, [Zu.a]), Vt._2(89, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [2, Ut.g]
      ], {
        isDisabled: [0, "isDisabled"],
        model: [1, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(91, 16384, null, 0, Ut.i, [Ut.h], null, null), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(96, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(97, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(99, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onCreate() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(100, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(101, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 32, 0, t.wallet.name);
        l(n, 35, 0, "text", Vt._6(1, "", Vt._24(n, 35, 1, Vt._15(n, 36).transform("addwallet-walletname-placeholder")), ""));
        l(n, 52, 0, t.wallet.payPassword);
        l(n, 55, 0, "password", Vt._6(1, "", Vt._24(n, 55, 1, Vt._15(n, 56).transform("addwallet-paypassword1-placeholder")), ""));
        l(n, 67, 0, t.wallet.rePayPassword);
        l(n, 70, 0, "password", Vt._6(1, "", Vt._24(n, 70, 1, Vt._15(n, 71).transform("addwallet-paypassword2-placeholder")), ""));
        l(n, 87, 0, t.isShow);
        l(n, 89, 0, t.isShow, t.wallet.singleAddress);
        l(n, 100, 0, "")
      }, function(l, n) {
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("launcher-create-wallet")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 28, 0, Vt._24(n, 28, 0, Vt._15(n, 29).transform("addwallet-walletname-title")));
        l(n, 31, 0, Vt._15(n, 34).ngClassUntouched, Vt._15(n, 34).ngClassTouched, Vt._15(n, 34).ngClassPristine, Vt._15(n, 34).ngClassDirty, Vt._15(n, 34).ngClassValid, Vt._15(n, 34).ngClassInvalid, Vt._15(n, 34).ngClassPending);
        l(n, 48, 0, Vt._24(n, 48, 0, Vt._15(n, 49).transform("addwallet-paypassword1-title")));
        l(n, 51, 0, Vt._15(n, 54).ngClassUntouched, Vt._15(n, 54).ngClassTouched, Vt._15(n, 54).ngClassPristine, Vt._15(n, 54).ngClassDirty, Vt._15(n, 54).ngClassValid, Vt._15(n, 54).ngClassInvalid, Vt._15(n, 54).ngClassPending);
        l(n, 66, 0, Vt._15(n, 69).ngClassUntouched, Vt._15(n, 69).ngClassTouched, Vt._15(n, 69).ngClassPristine, Vt._15(n, 69).ngClassDirty, Vt._15(n, 69).ngClassValid, Vt._15(n, 69).ngClassInvalid, Vt._15(n, 69).ngClassPending);
        l(n, 83, 0, Vt._24(n, 83, 0, Vt._15(n, 84).transform("text-signaddress")));
        l(n, 86, 0, Vt._15(n, 87)._disabled, Vt._15(n, 91).ngClassUntouched, Vt._15(n, 91).ngClassTouched, Vt._15(n, 91).ngClassPristine, Vt._15(n, 91).ngClassDirty, Vt._15(n, 91).ngClassValid, Vt._15(n, 91).ngClassInvalid, Vt._15(n, 91).ngClassPending);
        l(n, 101, 0, Vt._24(n, 101, 0, Vt._15(n, 102).transform("confirm")))
      })
    }

    function Sl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-row", [
        ["class", "font-size-1 row"]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(3, 0, null, null, 3, "ion-col", [
        ["class", "col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(4, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(5, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(8, 0, null, null, 2, "ion-col", [
        ["class", "text-right col"],
        ["col-8", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("click" === n) {
          e = !1 !== a.onNext(a.transactionRecord.outcomingAddress) && e
        }
        return e
      }, null, null)), Vt._2(9, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(10, null, ["\n                ", " ", "\n            "])), (l()(), Vt._23(-1, null, ["\n        "]))], null, function(l, n) {
        var t = n.component;
        l(n, 5, 0, Vt._24(n, 5, 0, Vt._15(n, 6).transform("txinfo-send-amount")));
        l(n, 10, 0, t.transactionRecord.outcomingAmount, t.transactionRecord.name)
      })
    }

    function Dl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-row", [
        ["class", "font-size-1 row"]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(3, 0, null, null, 3, "ion-col", [
        ["class", "col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(4, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(5, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(8, 0, null, null, 2, "ion-col", [
        ["class", "text-right huan-hang col"],
        ["col-8", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("click" === n) {
          e = !1 !== a.onNext(a.transactionRecord.outcomingAddress) && e
        }
        return e
      }, null, null)), Vt._2(9, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(10, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n        "]))], null, function(l, n) {
        var t = n.component;
        l(n, 5, 0, Vt._24(n, 5, 0, Vt._15(n, 6).transform("txinfo-send-addr")));
        l(n, 10, 0, t.transactionRecord.outcomingAddress)
      })
    }

    function Ml(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-row", [
        ["class", "font-size-1 row"]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(3, 0, null, null, 3, "ion-col", [
        ["class", "col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(4, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(5, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(8, 0, null, null, 2, "ion-col", [
        ["class", "text-right col"],
        ["col-8", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("click" === n) {
          e = !1 !== a.onNext(a.transactionRecord.incomingAddress) && e
        }
        return e
      }, null, null)), Vt._2(9, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(10, null, ["\n                ", " ", "\n            "])), (l()(), Vt._23(-1, null, ["\n        "]))], null, function(l, n) {
        var t = n.component;
        l(n, 5, 0, Vt._24(n, 5, 0, Vt._15(n, 6).transform("txinfo-receive-amount")));
        l(n, 10, 0, t.transactionRecord.incomingAmount, t.transactionRecord.name)
      })
    }

    function jl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-row", [
        ["class", "font-size-1 row"]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(3, 0, null, null, 3, "ion-col", [
        ["class", "col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(4, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(5, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(8, 0, null, null, 2, "ion-col", [
        ["class", "text-right huan-hang col"],
        ["col-8", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("click" === n) {
          e = !1 !== a.onNext(a.transactionRecord.incomingAddress) && e
        }
        return e
      }, null, null)), Vt._2(9, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(10, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n        "]))], null, function(l, n) {
        var t = n.component;
        l(n, 5, 0, Vt._24(n, 5, 0, Vt._15(n, 6).transform("txinfo-receive-addr")));
        l(n, 10, 0, t.transactionRecord.incomingAddress)
      })
    }

    function Wl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "ion-col", [
        ["class", "text-right col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "]))], null, function(l, n) {
        l(n, 2, 0, n.component.transactionRecord.transactionTime)
      })
    }

    function Ol(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-row", [
        ["class", "font-size-1 row"]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(3, 0, null, null, 3, "ion-col", [
        ["class", "col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(4, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(5, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(8, 0, null, null, 2, "ion-col", [
        ["class", "text-right col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(9, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(10, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n        "]))], null, function(l, n) {
        var t = n.component;
        l(n, 5, 0, Vt._24(n, 5, 0, Vt._15(n, 6).transform("text-fees")));
        l(n, 10, 0, t.transactionRecord.payfees)
      })
    }

    function Nl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align: center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(13, 0, null, null, 109, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n\n    "])), (l()(), Vt._3(16, 0, null, 2, 10, "ion-refresher", [], [
        [2, "refresher-active", null],
        [4, "top", null]
      ], [
        [null, "ionRefresh"]
      ], function(l, n, t) {
        var e = !0;
        if ("ionRefresh" === n) {
          e = !1 !== l.component.doRefresh(t) && e
        }
        return e
      }, null, null)), Vt._2(17, 212992, null, 0, hu.a, [Ha.a, du.a, Vt.x, Ua.l], null, {
        ionRefresh: "ionRefresh"
      }), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(19, 0, null, null, 2, "ion-refresher-content", [
        ["pullingIcon", "arrow-dropdown"],
        ["pullingText", ""],
        ["refreshingSpinner", "circles"],
        ["refreshingText", ""]
      ], [
        [1, "state", 0]
      ], null, null, pu.b, pu.a)), Vt._2(20, 114688, null, 0, gu.a, [hu.a, Ga.a], {
        pullingIcon: [0, "pullingIcon"],
        pullingText: [1, "pullingText"],
        refreshingSpinner: [2, "refreshingSpinner"],
        refreshingText: [3, "refreshingText"]
      }, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(23, 0, null, null, 2, "ion-refresher-content", [], [
        [1, "state", 0]
      ], null, null, pu.b, pu.a)), Vt._2(24, 114688, null, 0, gu.a, [hu.a, Ga.a], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n\n\n    "])), (l()(), Vt._3(28, 0, null, 1, 7, "div", [
        ["class", "recordinfo-top"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(30, 0, null, null, 0, "img", [], [
        [8, "src", 4]
      ], null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(32, 0, null, null, 2, "p", [], null, null, null, null, null)), (l()(), Vt._23(33, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n\n    "])), (l()(), Vt._3(37, 0, null, 1, 84, "ion-grid", [
        ["class", "grid"]
      ], null, null, null, null, null)), Vt._2(38, 16384, null, 0, mu.a, [], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(40, 0, null, null, 11, "ion-row", [
        ["class", "font-size-1 row"]
      ], null, null, null, null, null)), Vt._2(41, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(43, 0, null, null, 3, "ion-col", [
        ["class", "col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(44, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(45, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(48, 0, null, null, 2, "ion-col", [
        ["class", "text-right col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(49, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(50, null, ["\n                ", " ", " ", "\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(53, 0, null, null, 14, "ion-row", [
        ["class", "font-size-1 row"]
      ], null, null, null, null, null)), Vt._2(54, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(56, 0, null, null, 3, "ion-col", [
        ["class", "col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(57, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(58, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(61, 0, null, null, 5, "ion-col", [
        ["class", "col"],
        ["col-8", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("click" === n) {
          e = !1 !== a.tiaozhuan(a.transactionRecord.txId) && e
        }
        return e
      }, null, null)), Vt._2(62, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(64, 0, null, null, 1, "a", [
        ["href", "#"]
      ], null, null, null, null, null)), (l()(), Vt._23(65, null, ["", ""])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n        \n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, Sl)), Vt._2(70, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, Dl)), Vt._2(73, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, Ml)), Vt._2(76, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, jl)), Vt._2(79, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(81, 0, null, null, 10, "ion-row", [
        ["class", "font-size-1 row"]
      ], null, null, null, null, null)), Vt._2(82, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(84, 0, null, null, 3, "ion-col", [
        ["class", "col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(85, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(86, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, Wl)), Vt._2(90, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, Ol)), Vt._2(94, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n\n        "])), (l()(), Vt._3(96, 0, null, null, 11, "ion-row", [
        ["class", "font-size-1 row"]
      ], null, null, null, null, null)), Vt._2(97, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(99, 0, null, null, 3, "ion-col", [
        ["class", "col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(100, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(101, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(104, 0, null, null, 2, "ion-col", [
        ["class", "text-right col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(105, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(106, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(109, 0, null, null, 11, "ion-row", [
        ["class", "font-size-1 row"]
      ], null, null, null, null, null)), Vt._2(110, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(112, 0, null, null, 3, "ion-col", [
        ["class", "col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(113, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(114, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(117, 0, null, null, 2, "ion-col", [
        ["class", "text-right col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(118, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(119, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 17, 0);
        l(n, 20, 0, "arrow-dropdown", "", "circles", ""), l(n, 24, 0);
        l(n, 70, 0, t.transactionRecord.balance <= 0);
        l(n, 73, 0, t.transactionRecord.balance <= 0);
        l(n, 76, 0, t.transactionRecord.balance >= 0);
        l(n, 79, 0, t.transactionRecord.balance >= 0);
        l(n, 90, 0, "0" != t.transactionRecord.timestamp);
        l(n, 94, 0, t.transactionRecord.balance <= 0)
      }, function(l, n) {
        var t = n.component;
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-record")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 16, 0, "inactive" !== Vt._15(n, 17).state, Vt._15(n, 17)._top);
        l(n, 19, 0, Vt._15(n, 20).r.state);
        l(n, 23, 0, Vt._15(n, 24).r.state);
        l(n, 30, 0, Vt._6(1, "", t.payStatusIcon, ""));
        l(n, 33, 0, Vt._24(n, 33, 0, Vt._15(n, 34).transform(t.transactionRecord.status)));
        l(n, 45, 0, Vt._24(n, 45, 0, Vt._15(n, 46).transform("transaction-price")));
        l(n, 50, 0, t.transactionRecord.resultAmount > 0 ? "+" : "", t.transactionRecord.resultAmount, t.transactionRecord.name);
        l(n, 58, 0, Vt._24(n, 58, 0, Vt._15(n, 59).transform("transaction-id")));
        l(n, 65, 0, t.transactionRecord.txId);
        l(n, 86, 0, Vt._24(n, 86, 0, Vt._15(n, 87).transform("transaction-time")));
        l(n, 101, 0, Vt._24(n, 101, 0, Vt._15(n, 102).transform("confirm-count")));
        l(n, 106, 0, t.transactionRecord.confirmCount);
        l(n, 114, 0, Vt._24(n, 114, 0, Vt._15(n, 115).transform("text-remark")));
        l(n, 119, 0, t.transactionRecord.remark)
      })
    }

    function Tl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 6, "ion-item", [
        ["class", "item item-block"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(l.context.$implicit.id) && e
        }
        return e
      }, wu.b, wu.a)), Vt._2(1, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(5, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(6, 2, ["\n            ", "\n        "]))], null, function(l, n) {
        l(n, 6, 0, n.context.$implicit.name)
      })
    }

    function Ll(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 9, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(1, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(3, 0, null, 1, 5, "ion-list", [], null, null, null, null, null)), Vt._2(4, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, Tl)), Vt._2(7, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        l(n, 7, 0, n.component.interfaces)
      }, function(l, n) {
        l(n, 0, 0, Vt._15(n, 1).statusbarPadding, Vt._15(n, 1)._hasRefresher)
      })
    }

    function Al(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(13, 0, null, null, 41, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 37, "div", [
        ["class", "id-box id-launcher-box"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(18, 0, null, null, 0, "img", [
        ["class", "id-logo"],
        ["src", "./assets/images/1.0logo.png"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(20, 0, null, null, 32, "div", [
        ["class", "content-id"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(22, 0, null, null, 29, "div", [
        ["class", "id-con"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(24, 0, null, null, 2, "p", [], null, null, null, null, null)), (l()(), Vt._23(25, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(28, 0, null, null, 10, "div", [
        ["class", "id-btn creat-id"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(30, 0, null, null, 7, "a", [], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(0) && e
        }
        return e
      }, null, null)), (l()(), Vt._23(-1, null, ["\n                        "])), (l()(), Vt._3(32, 0, null, null, 0, "i", [
        ["class", "icon"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                        "])), (l()(), Vt._3(34, 0, null, null, 2, "span", [], null, null, null, null, null)), (l()(), Vt._23(35, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(40, 0, null, null, 10, "div", [
        ["class", "id-btn import-id"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(42, 0, null, null, 7, "a", [], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(1) && e
        }
        return e
      }, null, null)), (l()(), Vt._23(-1, null, ["\n                        "])), (l()(), Vt._3(44, 0, null, null, 0, "i", [
        ["class", "icon"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                        "])), (l()(), Vt._3(46, 0, null, null, 2, "span", [], null, null, null, null, null)), (l()(), Vt._23(47, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"]))], null, function(l, n) {
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-id-my")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 25, 0, Vt._24(n, 25, 0, Vt._15(n, 26).transform("text-id-not")));
        l(n, 35, 0, Vt._24(n, 35, 0, Vt._15(n, 36).transform("text-id-create")));
        l(n, 47, 0, Vt._24(n, 47, 0, Vt._15(n, 48).transform("text-id-import")))
      })
    }

    function Rl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "p", [], null, null, null, null, null)), (l()(), Vt._23(1, null, ["\n                                ", "：", "   ", "/", "  ", "\n                            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 1, 0, Vt._24(n, 1, 0, Vt._15(n, 2).transform("text-update-time")), n.parent.context.$implicit.updateTiem, n.parent.context.$implicit.finshNumber, n.parent.context.$implicit.maxNumber, Vt._24(n, 1, 4, Vt._15(n, 3).transform("text-person")))
      })
    }

    function Jl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "p", [], null, null, null, null, null)), (l()(), Vt._23(1, null, ["\n                                ", "：", "   ", "/", "  ", "\n                            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 1, 0, Vt._24(n, 1, 0, Vt._15(n, 2).transform("text-update-time")), n.parent.context.$implicit.updateTiem, n.parent.context.$implicit.finshNumber, n.parent.context.$implicit.maxNumber, Vt._24(n, 1, 4, Vt._15(n, 3).transform("text-company")))
      })
    }

    function El(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 21, "li", [
        ["class", "item"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onItem(l.context.$implicit) && e
        }
        return e
      }, null, null)), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(2, 0, null, null, 18, "a", [
        ["class", "tiaozhuan"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                        "])), (l()(), Vt._3(4, 0, null, null, 1, "i", [
        ["class", "icon-i"]
      ], null, null, null, null, null)), (l()(), Vt._23(5, null, ["", ""])), (l()(), Vt._23(-1, null, ["\n                        "])), (l()(), Vt._3(7, 0, null, null, 10, "div", [
        ["class", "item-text"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                            "])), (l()(), Vt._3(9, 0, null, null, 1, "span", [
        ["class", "item-text-title huan-hang"]
      ], null, null, null, null, null)), (l()(), Vt._23(10, null, ["", ""])), (l()(), Vt._23(-1, null, ["\n                            "])), (l()(), Vt.Y(16777216, null, null, 1, null, Rl)), Vt._2(13, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n                            "])), (l()(), Vt.Y(16777216, null, null, 1, null, Jl)), Vt._2(16, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n                        "])), (l()(), Vt._23(-1, null, ["\n                        "])), (l()(), Vt._3(19, 0, null, null, 0, "i", [
        ["class", "to-right"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._23(-1, null, ["\n                "]))], function(l, n) {
        l(n, 13, 0, 1 === n.context.$implicit.createType);
        l(n, 16, 0, 2 === n.context.$implicit.createType)
      }, function(l, n) {
        l(n, 5, 0, n.context.index + 1);
        l(n, 10, 0, n.context.$implicit.id)
      })
    }

    function Vl(l) {
      return Vt._25(0, [Vt._21(402653184, 1, {
        navBar: 0
      }), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, [
        [1, 4]
      ], 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(14, 0, null, null, 68, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(17, 0, null, 1, 64, "div", [
        ["class", "id-box"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(19, 0, null, null, 7, "div", [
        ["class", "home-top1"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(21, 0, null, null, 0, "img", [
        ["class", "id-logo"],
        ["src", "./assets/images/1.0logo.png"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(23, 0, null, null, 2, "div", [], null, null, null, null, null)), (l()(), Vt._23(24, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._23(-1, null, ["\n\n\n\n        "])), (l()(), Vt._3(28, 0, null, null, 37, "ul", [
        ["class", "navID"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(30, 0, null, null, 10, "li", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(32, 0, null, null, 7, "a", [], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(0) && e
        }
        return e
      }, null, null)), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(34, 0, null, null, 0, "i", [
        ["class", "new"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(36, 0, null, null, 2, "span", [], null, null, null, null, null)), (l()(), Vt._23(37, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(42, 0, null, null, 10, "li", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(44, 0, null, null, 7, "a", [], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(1) && e
        }
        return e
      }, null, null)), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(46, 0, null, null, 0, "i", [
        ["class", "import"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(48, 0, null, null, 2, "span", [], null, null, null, null, null)), (l()(), Vt._23(49, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(54, 0, null, null, 10, "li", [
        ["class", "last-li"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(56, 0, null, null, 7, "a", [], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(2) && e
        }
        return e
      }, null, null)), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(58, 0, null, null, 0, "i", [
        ["class", "guanli"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(60, 0, null, null, 2, "span", [], null, null, null, null, null)), (l()(), Vt._23(61, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(67, 0, null, null, 11, "div", [
        ["class", "center-id"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(69, 0, null, null, 2, "h3", [], null, null, null, null, null)), (l()(), Vt._23(70, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(73, 0, null, null, 4, "ul", [
        ["class", "idList"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt.Y(16777216, null, null, 1, null, El)), Vt._2(76, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(80, 0, null, null, 0, "div", [
        ["style", "height: 100px;"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        l(n, 76, 0, n.component.kycIdArr)
      }, function(l, n) {
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("text-id-home")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher);
        l(n, 24, 0, Vt._24(n, 24, 0, Vt._15(n, 25).transform("text-id-home-prompt")));
        l(n, 37, 0, Vt._24(n, 37, 0, Vt._15(n, 38).transform("text-id-create")));
        l(n, 49, 0, Vt._24(n, 49, 0, Vt._15(n, 50).transform("text-id-import")));
        l(n, 61, 0, Vt._24(n, 61, 0, Vt._15(n, 62).transform("text-id-manager")));
        l(n, 70, 0, Vt._24(n, 70, 0, Vt._15(n, 71).transform("text-id-my")))
      })
    }

    function Fl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(13, 0, null, null, 32, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 28, "div", [
        ["class", "id-box import-box"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(18, 0, null, null, 0, "img", [
        ["class", "id-logo"],
        ["src", "assets/images/1.0logo.png"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(20, 0, null, null, 23, "div", [
        ["class", "content-id"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(22, 0, null, null, 20, "div", [
        ["class", "importid-box"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(24, 0, null, null, 2, "p", [], null, null, null, null, null)), (l()(), Vt._23(25, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(28, 0, null, null, 9, "div", [
        ["class", "kuangTextArea"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(30, 0, null, null, 6, "textarea", [
        ["class", "backupWalletTextArea"],
        ["rows", "4"]
      ], [
        [8, "placeholder", 0],
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"],
        [null, "input"],
        [null, "blur"],
        [null, "compositionstart"],
        [null, "compositionend"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("input" === n) {
          e = !1 !== Vt._15(l, 31)._handleInput(t.target.value) && e
        }
        if ("blur" === n) {
          e = !1 !== Vt._15(l, 31).onTouched() && e
        }
        if ("compositionstart" === n) {
          e = !1 !== Vt._15(l, 31)._compositionStart() && e
        }
        if ("compositionend" === n) {
          e = !1 !== Vt._15(l, 31)._compositionEnd(t.target.value) && e
        }
        if ("ngModelChange" === n) {
          e = !1 !== (a.keyStoreContent = t) && e
        }
        return e
      }, null, null)), Vt._2(31, 16384, null, 0, Ut.b, [Vt.E, Vt.k, [2, Ut.a]], null, null), Vt._19(1024, null, Ut.g, function(l) {
        return [l]
      }, [Ut.b]), Vt._2(33, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [2, Ut.g]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(35, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(39, 0, null, null, 2, "button", [
        ["class", "btn-commit btn1"],
        ["id", "btn-t"],
        ["style", "color: #fff;cursor: pointer;display: block"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onImport() && e
        }
        return e
      }, null, null)), (l()(), Vt._23(40, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        l(n, 33, 0, n.component.keyStoreContent)
      }, function(l, n) {
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-id-import")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 25, 0, Vt._24(n, 25, 0, Vt._15(n, 26).transform("text-id-import-file")));
        l(n, 30, 0, Vt._6(1, "", Vt._24(n, 30, 0, Vt._15(n, 36).transform("text-id-kyc-import-text-message")), ""), Vt._15(n, 35).ngClassUntouched, Vt._15(n, 35).ngClassTouched, Vt._15(n, 35).ngClassPristine, Vt._15(n, 35).ngClassDirty, Vt._15(n, 35).ngClassValid, Vt._15(n, 35).ngClassInvalid, Vt._15(n, 35).ngClassPending);
        l(n, 40, 0, Vt._24(n, 40, 0, Vt._15(n, 41).transform("confirm")))
      })
    }

    function zl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 8, "div", [
        ["class", "kuangTextArea"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(2, 0, null, null, 2, "p", [], null, null, null, null, null)), (l()(), Vt._23(3, null, ["", " "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(6, 0, null, null, 1, "textarea", [
        ["class", "backupWalletTextArea"],
        ["rows", "10"]
      ], null, null, null, null, null)), (l()(), Vt._23(7, null, ["", ""])), (l()(), Vt._23(-1, null, ["\n        "]))], null, function(l, n) {
        var t = n.component;
        l(n, 3, 0, Vt._24(n, 3, 0, Vt._15(n, 4).transform("text-keystroe-message")));
        l(n, 7, 0, t.backupWalletPlainText)
      })
    }

    function Kl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "button", [
        ["class", "button-footer"],
        ["full", ""],
        ["ion-button", ""],
        ["style", "width: 100%"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onCopay() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(1, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(2, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], function(l, n) {
        l(n, 1, 0, "")
      }, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("text-copy-to-clipboard")))
      })
    }

    function Bl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 14, "li", [
        ["class", "item"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onItem(l.context.$implicit.id) && e
        }
        return e
      }, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(2, 0, null, null, 11, "a", [
        ["class", "tiaozhuan"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(4, 0, null, null, 2, "div", [], null, null, null, null, null)), Vt._2(5, 278528, null, 0, fu.g, [Vt.s, Vt.t, Vt.k, Vt.E], {
        ngClass: [0, "ngClass"]
      }, null), Vt._18(6, {
        radio: 0,
        "per-select": 1
      }), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(8, 0, null, null, 4, "div", [
        ["class", "item-text"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                        "])), (l()(), Vt._3(10, 0, null, null, 1, "span", [
        ["class", "item-text-title huan-hang"]
      ], null, null, null, null, null)), (l()(), Vt._23(11, null, ["", ""])), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "]))], function(l, n) {
        l(n, 5, 0, l(n, 6, 0, !0, n.component.isSelectObj[n.context.$implicit.id]))
      }, function(l, n) {
        l(n, 11, 0, n.context.$implicit.id)
      })
    }

    function Yl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 4, "ul", [
        ["class", "idList"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, Bl)), Vt._2(3, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n        "]))], function(l, n) {
        l(n, 3, 0, n.component.kycIdArr)
      }, null)
    }

    function Gl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 20, "div", [
        ["class", "chooseAll"],
        ["style", "background: white;"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(2, 0, null, null, 2, "div", [
        ["style", "margin: 0px 16px;"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(3) && e
        }
        return e
      }, null, null)), Vt._2(3, 278528, null, 0, fu.g, [Vt.s, Vt.t, Vt.k, Vt.E], {
        ngClass: [0, "ngClass"]
      }, null), Vt._18(4, {
        radio: 0,
        "per-select": 1
      }), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(6, 0, null, null, 2, "span", [], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(3) && e
        }
        return e
      }, null, null)), (l()(), Vt._23(7, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(10, 0, null, null, 9, "div", [
        ["class", "btns"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(12, 0, null, null, 2, "a", [
        ["class", "importBtn"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(1) && e
        }
        return e
      }, null, null)), (l()(), Vt._23(13, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(16, 0, null, null, 2, "a", [
        ["class", "delBtn"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(2) && e
        }
        return e
      }, null, null)), (l()(), Vt._23(17, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "]))], function(l, n) {
        l(n, 3, 0, l(n, 4, 0, !0, n.component.selectAll))
      }, function(l, n) {
        l(n, 7, 0, Vt._24(n, 7, 0, Vt._15(n, 8).transform("text-select-all")));
        l(n, 13, 0, Vt._24(n, 13, 0, Vt._15(n, 14).transform("text-export")));
        l(n, 17, 0, Vt._24(n, 17, 0, Vt._15(n, 18).transform("text-delete")))
      })
    }

    function Hl(l) {
      return Vt._25(0, [Vt._21(402653184, 1, {
        navBar: 0
      }), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, [
        [1, 4]
      ], 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(14, 0, null, null, 17, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(17, 0, null, 1, 13, "div", [
        ["class", "per-certified"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, zl)), Vt._2(20, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, Kl)), Vt._2(23, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, Yl)), Vt._2(26, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, Gl)), Vt._2(29, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 20, 0, t.backupWalletPlainText);
        l(n, 23, 0, t.backupWalletPlainText);
        l(n, 26, 0, !t.backupWalletPlainText);
        l(n, 29, 0, !t.backupWalletPlainText)
      }, function(l, n) {
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("text-id-manager")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher)
      })
    }

    function Ul(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(13, 0, null, null, 90, "ion-content", [
        ["no-bounce", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 86, "ion-grid", [
        ["class", "grid"]
      ], null, null, null, null, null)), Vt._2(17, 16384, null, 0, mu.a, [], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(19, 0, null, null, 26, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(20, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(22, 0, null, null, 3, "ion-col", [
        ["align-self-center", ""],
        ["class", "font-size-1 text-left col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(23, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(24, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(27, 0, null, null, 17, "ion-col", [
        ["align-self-center", ""],
        ["class", "col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(28, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(30, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(31, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(35, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(37, 0, null, 3, 5, "ion-input", [
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.businessObj.word = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(38, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(40, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(41, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(47, 0, null, null, 26, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(48, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(50, 0, null, null, 3, "ion-col", [
        ["align-self-center", ""],
        ["class", "font-size-1 text-left col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(51, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(52, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(55, 0, null, null, 17, "ion-col", [
        ["align-self-center", ""],
        ["class", "col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(56, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(58, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(59, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 4, {
        contentLabel: 0
      }), Vt._21(603979776, 5, {
        _buttons: 1
      }), Vt._21(603979776, 6, {
        _icons: 1
      }), Vt._2(63, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(65, 0, null, 3, 5, "ion-input", [
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.businessObj.legalPerson = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(66, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(68, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(69, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(75, 0, null, null, 26, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(76, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(78, 0, null, null, 3, "ion-col", [
        ["align-self-center", ""],
        ["class", "font-size-1 text-left col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(79, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(80, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(83, 0, null, null, 17, "ion-col", [
        ["align-self-center", ""],
        ["class", "col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(84, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(86, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(87, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 7, {
        contentLabel: 0
      }), Vt._21(603979776, 8, {
        _buttons: 1
      }), Vt._21(603979776, 9, {
        _icons: 1
      }), Vt._2(91, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(93, 0, null, 3, 5, "ion-input", [
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.businessObj.registrationNum = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(94, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(96, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(97, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(105, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(106, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(108, 0, null, null, 3, "button", [
        ["class", "button-footer"],
        ["full", ""],
        ["ion-button", ""],
        ["style", "width: 100%"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onCommit() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(109, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(110, 0, ["", "", "", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 38, 0, t.businessObj.word);
        l(n, 41, 0, "text", Vt._6(1, "", Vt._24(n, 41, 1, Vt._15(n, 42).transform("text-input-please")), ""));
        l(n, 66, 0, t.businessObj.legalPerson);
        l(n, 69, 0, "text", Vt._6(1, "", Vt._24(n, 69, 1, Vt._15(n, 70).transform("text-input-please")), ""));
        l(n, 94, 0, t.businessObj.registrationNum);
        l(n, 97, 0, "text", Vt._6(1, "", Vt._24(n, 97, 1, Vt._15(n, 98).transform("text-input-please")), ""));
        l(n, 109, 0, "")
      }, function(l, n) {
        var t = n.component;
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-certified-company")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 24, 0, Vt._24(n, 24, 0, Vt._15(n, 25).transform("text-company-name")));
        l(n, 37, 0, Vt._15(n, 40).ngClassUntouched, Vt._15(n, 40).ngClassTouched, Vt._15(n, 40).ngClassPristine, Vt._15(n, 40).ngClassDirty, Vt._15(n, 40).ngClassValid, Vt._15(n, 40).ngClassInvalid, Vt._15(n, 40).ngClassPending);
        l(n, 52, 0, Vt._24(n, 52, 0, Vt._15(n, 53).transform("text-company-legal")));
        l(n, 65, 0, Vt._15(n, 68).ngClassUntouched, Vt._15(n, 68).ngClassTouched, Vt._15(n, 68).ngClassPristine, Vt._15(n, 68).ngClassDirty, Vt._15(n, 68).ngClassValid, Vt._15(n, 68).ngClassInvalid, Vt._15(n, 68).ngClassPending);
        l(n, 80, 0, Vt._24(n, 80, 0, Vt._15(n, 81).transform("text-company-code")));
        l(n, 93, 0, Vt._15(n, 96).ngClassUntouched, Vt._15(n, 96).ngClassTouched, Vt._15(n, 96).ngClassPristine, Vt._15(n, 96).ngClassDirty, Vt._15(n, 96).ngClassValid, Vt._15(n, 96).ngClassInvalid, Vt._15(n, 96).ngClassPending);
        l(n, 110, 0, Vt._24(n, 110, 0, Vt._15(n, 111).transform("text-pay")), t.payMoney, t.unit)
      })
    }

    function ql(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "div", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(2, 0, null, null, 0, "img", [
        ["class", "result-img"],
        ["src", "./assets/images/icon/icon-success.svg"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(4, 0, null, null, 2, "p", [
        ["class", "result-wenzi color-main "]
      ], null, null, null, null, null)), (l()(), Vt._23(5, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(8, 0, null, null, 2, "p", [
        ["class", "result-wenzi1 color-main "]
      ], null, null, null, null, null)), (l()(), Vt._23(9, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "]))], null, function(l, n) {
        l(n, 5, 0, Vt._24(n, 5, 0, Vt._15(n, 6).transform("text-commit-success")));
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("text-commit-wait")))
      })
    }

    function $l(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 7, "div", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(2, 0, null, null, 0, "img", [
        ["class", "result-img"],
        ["src", "./assets/images/icon/icon-failure.svg"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(4, 0, null, null, 2, "p", [
        ["class", "result-wenzi-color color-main "]
      ], null, null, null, null, null)), (l()(), Vt._23(5, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "]))], null, function(l, n) {
        l(n, 5, 0, Vt._24(n, 5, 0, Vt._15(n, 6).transform("text-browsing-failure")))
      })
    }

    function Zl(l) {
      return Vt._25(0, [Vt._21(402653184, 1, {
        navBar: 0
      }), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, [
        [1, 4]
      ], 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(14, 0, null, null, 15, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(17, 0, null, 1, 11, "div", [
        ["class", "result"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, ql)), Vt._2(20, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, $l)), Vt._2(23, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(25, 0, null, null, 2, "button", [
        ["class", "button-default"],
        ["style", "margin-top: 40px;"],
        ["tappable", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.check() && e
        }
        return e
      }, null, null)), (l()(), Vt._23(26, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 20, 0, "0" === t.type);
        l(n, 23, 0, "1" === t.type)
      }, function(l, n) {
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("text-commit-result")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher);
        l(n, 26, 0, Vt._24(n, 26, 0, Vt._15(n, 27).transform("text-id-kyc-check")))
      })
    }

    function Ql(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 6, "div", [
        ["class", "result-title"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(2, 0, null, null, 3, "p", [], null, null, null, null, null)), (l()(), Vt._23(3, null, ["", " "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._3(5, 0, null, null, 0, "img", [
        ["class", "result-img"],
        ["src", "./assets/images/icon/icon-success.svg"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "]))], null, function(l, n) {
        l(n, 3, 0, Vt._24(n, 3, 0, Vt._15(n, 4).transform("text-kyc-success")))
      })
    }

    function Xl(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 6, "div", [
        ["class", "result-title"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(2, 0, null, null, 3, "p", [], null, null, null, null, null)), (l()(), Vt._23(3, null, ["", " "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._3(5, 0, null, null, 0, "img", [
        ["class", "result-img"],
        ["src", "./assets/images/icon/icon-failure.svg"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "]))], null, function(l, n) {
        l(n, 3, 0, Vt._24(n, 3, 0, Vt._15(n, 4).transform("text-kyc-failure")))
      })
    }

    function ln(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""],
        ["style", "width: 100%"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onCommit() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(1, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(2, 0, [" ", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], function(l, n) {
        l(n, 1, 0, "")
      }, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("text-data-chain")))
      })
    }

    function nn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""],
        ["style", "width: 100%"]
      ], null, null, null, Ju.b, Ju.a)), Vt._2(1, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(2, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], function(l, n) {
        l(n, 1, 0, "")
      }, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("text-data-chain1")))
      })
    }

    function tn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""],
        ["style", "width: 100%"]
      ], null, null, null, Ju.b, Ju.a)), Vt._2(1, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(2, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], function(l, n) {
        l(n, 1, 0, "")
      }, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("text-data-chain2")))
      })
    }

    function en(l) {
      return Vt._25(0, [Vt._21(402653184, 1, {
        navBar: 0
      }), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, [
        [1, 4]
      ], 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(14, 0, null, null, 46, "ion-content", [
        ["no-bounce", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(17, 0, null, 1, 42, "div", [
        ["class", "company-result"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, Ql)), Vt._2(20, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, Xl)), Vt._2(23, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(25, 0, null, null, 33, "ion-grid", [
        ["class", "grid"]
      ], null, null, null, null, null)), Vt._2(26, 16384, null, 0, mu.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(28, 0, null, null, 29, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(29, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(31, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(32, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(33, null, ["\n                    ", "\n                "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n\n                "])), (l()(), Vt._3(36, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(37, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(38, null, ["\n                    ", "\n                "])), (l()(), Vt._23(-1, null, ["\n\n                "])), (l()(), Vt._3(40, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(41, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(42, null, ["\n                    ", "\n                "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n\n                "])), (l()(), Vt._3(45, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(46, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(47, null, ["\n                    ", "\n                "])), (l()(), Vt._23(-1, null, ["\n\n                "])), (l()(), Vt._3(49, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(50, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(51, null, ["\n                    ", "\n                "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n\n                "])), (l()(), Vt._3(54, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(55, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(56, null, ["\n                    ", "\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(62, 0, null, null, 18, "ion-footer", [], null, null, null, null, null)), Vt._2(63, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(65, 0, null, null, 5, "div", [
        ["class", "title"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(67, 0, null, null, 2, "p", [
        ["class", "text-person-agreement-wenzi"]
      ], null, null, null, null, null)), (l()(), Vt._23(68, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt.Y(16777216, null, null, 1, null, ln)), Vt._2(73, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt.Y(16777216, null, null, 1, null, nn)), Vt._2(76, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt.Y(16777216, null, null, 1, null, tn)), Vt._2(79, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 20, 0, "0" === t.type);
        l(n, 23, 0, "1" === t.type);
        l(n, 73, 0, 2 === t.orderStatus);
        l(n, 76, 0, 4 === t.orderStatus);
        l(n, 79, 0, 5 === t.orderStatus)
      }, function(l, n) {
        var t = n.component;
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("text-kyc-result")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher);
        l(n, 33, 0, Vt._24(n, 33, 0, Vt._15(n, 34).transform("text-company-name")));
        l(n, 38, 0, t.businessObj.word);
        l(n, 42, 0, Vt._24(n, 42, 0, Vt._15(n, 43).transform("text-company-legal")));
        l(n, 47, 0, t.businessObj.legalPerson);
        l(n, 51, 0, Vt._24(n, 51, 0, Vt._15(n, 52).transform("text-company-code")));
        l(n, 56, 0, t.businessObj.registrationNum);
        l(n, 68, 0, Vt._24(n, 68, 0, Vt._15(n, 69).transform("text-id-chain-prompt1")))
      })
    }

    function an(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 6, "div", [
        ["class", "result-title"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(2, 0, null, null, 3, "p", [], null, null, null, null, null)), (l()(), Vt._23(3, null, ["", " "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._3(5, 0, null, null, 0, "img", [
        ["class", "result-img"],
        ["src", "./assets/images/icon/icon-success.svg"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "]))], null, function(l, n) {
        l(n, 3, 0, Vt._24(n, 3, 0, Vt._15(n, 4).transform("text-kyc-success")))
      })
    }

    function un(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 6, "div", [
        ["class", "result-title"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(2, 0, null, null, 3, "p", [], null, null, null, null, null)), (l()(), Vt._23(3, null, ["", " "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._3(5, 0, null, null, 0, "img", [
        ["class", "result-img"],
        ["src", "./assets/images/icon/icon-failure.svg"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "]))], null, function(l, n) {
        l(n, 3, 0, Vt._24(n, 3, 0, Vt._15(n, 4).transform("text-kyc-failure")))
      })
    }

    function sn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("text-certified-phone")))
      })
    }

    function on(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "]))], null, function(l, n) {
        l(n, 2, 0, n.component.pageObj.phone.mobile)
      })
    }

    function rn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("text-card-debit")))
      })
    }

    function cn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "]))], null, function(l, n) {
        l(n, 2, 0, n.component.pageObj.bankCard.cardMobile)
      })
    }

    function _n(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "button", [
        ["class", "button-footer"],
        ["full", ""],
        ["ion-button", ""],
        ["style", "width: 100%"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onCommit() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(1, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(2, 0, [" ", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], function(l, n) {
        l(n, 1, 0, "")
      }, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("text-data-chain")))
      })
    }

    function dn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "button", [
        ["class", "button-footer"],
        ["full", ""],
        ["ion-button", ""],
        ["style", "width: 100%"]
      ], null, null, null, Ju.b, Ju.a)), Vt._2(1, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(2, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], function(l, n) {
        l(n, 1, 0, "")
      }, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("text-data-chain1")))
      })
    }

    function hn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "button", [
        ["class", "button-footer"],
        ["full", ""],
        ["ion-button", ""],
        ["style", "width: 100%"]
      ], null, null, null, Ju.b, Ju.a)), Vt._2(1, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(2, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], function(l, n) {
        l(n, 1, 0, "")
      }, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("text-data-chain2")))
      })
    }

    function pn(l) {
      return Vt._25(0, [Vt._21(402653184, 1, {
        navBar: 0
      }), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, [
        [1, 4]
      ], 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(14, 0, null, null, 54, "ion-content", [
        ["no-bounce", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(17, 0, null, 1, 50, "div", [
        ["class", "company-result"],
        ["style", "height:100%;overflow: auto;"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, an)), Vt._2(20, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, un)), Vt._2(23, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(25, 0, null, null, 41, "ion-grid", [
        ["class", "grid"]
      ], null, null, null, null, null)), Vt._2(26, 16384, null, 0, mu.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(28, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(29, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(30, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(33, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(34, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(35, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(37, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(38, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(39, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(42, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(43, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(44, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, sn)), Vt._2(47, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, on)), Vt._2(50, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, rn)), Vt._2(53, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, cn)), Vt._2(56, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n\n            "])), (l()(), Vt._3(58, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(59, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(60, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(63, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(64, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(65, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._3(70, 0, null, null, 18, "ion-footer", [], null, null, null, null, null)), Vt._2(71, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(73, 0, null, null, 5, "div", [
        ["class", "title"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(75, 0, null, null, 2, "p", [
        ["class", "text-person-agreement-wenzi"]
      ], null, null, null, null, null)), (l()(), Vt._23(76, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt.Y(16777216, null, null, 1, null, _n)), Vt._2(81, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt.Y(16777216, null, null, 1, null, dn)), Vt._2(84, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt.Y(16777216, null, null, 1, null, hn)), Vt._2(87, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 20, 0, "0" === t.type);
        l(n, 23, 0, "1" === t.type);
        l(n, 47, 0, t.pageObj.phone);
        l(n, 50, 0, t.pageObj.phone);
        l(n, 53, 0, t.pageObj.bankCard);
        l(n, 56, 0, t.pageObj.bankCard);
        l(n, 81, 0, 2 === t.orderStatus);
        l(n, 84, 0, 4 === t.orderStatus);
        l(n, 87, 0, 5 === t.orderStatus)
      }, function(l, n) {
        var t = n.component;
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("text-kyc-result")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher);
        l(n, 30, 0, Vt._24(n, 30, 0, Vt._15(n, 31).transform("text-name")));
        l(n, 35, 0, t.pageObj.identityCard.fullName);
        l(n, 39, 0, Vt._24(n, 39, 0, Vt._15(n, 40).transform("text-identity")));
        l(n, 44, 0, t.pageObj.identityCard.identityNumber);
        l(n, 60, 0, Vt._24(n, 60, 0, Vt._15(n, 61).transform("text-card")));
        l(n, 65, 0, t.pageObj.bankCard.cardNumber);
        l(n, 76, 0, Vt._24(n, 76, 0, Vt._15(n, 77).transform("text-id-chain-prompt1")))
      })
    }

    function gn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 7, "button", [
        ["class", "item item-block"],
        ["ion-item", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(l.context.$implicit) && e
        }
        return e
      }, wu.b, wu.a)), Vt._2(1, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(5, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(6, 2, ["\n            ", "\n          "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 6, 0, Vt._24(n, 6, 0, Vt._15(n, 7).transform(n.context.$implicit.name)))
      })
    }

    function fn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._3(13, 0, null, null, 9, "ion-content", [
        ["no-bounce", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 5, "ion-list", [], null, null, null, null, null)), Vt._2(17, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, gn)), Vt._2(20, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        l(n, 20, 0, n.component.pathList)
      }, function(l, n) {
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-path-list")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher)
      })
    }

    function mn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("path-status-no-pay")))
      })
    }

    function vn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("path-status-authing")))
      })
    }

    function yn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("path-status-authed")))
      })
    }

    function bn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("text-data-chain1")))
      })
    }

    function kn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("text-data-chain2")))
      })
    }

    function xn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 51, "ion-row", [
        ["class", "hang row"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(l.context.$implicit) && e
        }
        return e
      }, null, null)), Vt._2(1, 278528, null, 0, fu.g, [Vt.s, Vt.t, Vt.k, Vt.E], {
        klass: [0, "klass"],
        ngClass: [1, "ngClass"]
      }, null), Vt._18(2, {
        "bottom-border": 0
      }), Vt._2(3, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(5, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(6, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(7, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(10, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(11, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(12, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(14, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(15, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(16, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(19, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(20, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(21, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(23, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(24, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(25, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(28, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-8", ""]
      ], null, null, null, null, null)), Vt._2(29, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(30, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(32, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(33, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(34, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, mn)), Vt._2(38, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, vn)), Vt._2(41, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, yn)), Vt._2(44, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, bn)), Vt._2(47, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, kn)), Vt._2(50, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n        "]))], function(l, n) {
        l(n, 1, 0, "hang", l(n, 2, 0, n.context.index == n.component.companyPathList.length - 1));
        l(n, 38, 0, 0 === n.context.$implicit.pathStatus);
        l(n, 41, 0, 1 === n.context.$implicit.pathStatus);
        l(n, 44, 0, 2 === n.context.$implicit.pathStatus);
        l(n, 47, 0, 4 === n.context.$implicit.pathStatus);
        l(n, 50, 0, 5 === n.context.$implicit.pathStatus)
      }, function(l, n) {
        l(n, 7, 0, Vt._24(n, 7, 0, Vt._15(n, 8).transform("text-company-name")));
        l(n, 12, 0, n.context.$implicit.payObj.parms.word);
        l(n, 16, 0, Vt._24(n, 16, 0, Vt._15(n, 17).transform("text-company-legal")));
        l(n, 21, 0, n.context.$implicit.payObj.parms.legalPerson);
        l(n, 25, 0, Vt._24(n, 25, 0, Vt._15(n, 26).transform("text-company-code")));
        l(n, 30, 0, n.context.$implicit.payObj.parms.registrationNum);
        l(n, 34, 0, Vt._24(n, 34, 0, Vt._15(n, 35).transform("path-status")))
      })
    }

    function wn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._3(13, 0, null, null, 9, "ion-content", [
        ["no-bounce", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 5, "ion-grid", [
        ["class", "grid"]
      ], null, null, null, null, null)), Vt._2(17, 16384, null, 0, mu.a, [], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, xn)), Vt._2(20, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(24, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(25, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(27, 0, null, null, 3, "button", [
        ["class", "button-footer"],
        ["full", ""],
        ["ion-button", ""],
        ["style", "width: 100%"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onCommit() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(28, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(29, 0, [" ", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        l(n, 20, 0, n.component.companyPathList);
        l(n, 28, 0, "")
      }, function(l, n) {
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-company-path-deatils")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 29, 0, Vt._24(n, 29, 0, Vt._15(n, 30).transform("add-path")))
      })
    }

    function Cn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("path-status-no-pay")))
      })
    }

    function In(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("path-status-authing")))
      })
    }

    function Pn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("path-status-authed")))
      })
    }

    function Sn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("text-data-chain1")))
      })
    }

    function Dn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("text-data-chain2")))
      })
    }

    function Mn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 60, "ion-row", [
        ["class", "hang row"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(l.context.$implicit) && e
        }
        return e
      }, null, null)), Vt._2(1, 278528, null, 0, fu.g, [Vt.s, Vt.t, Vt.k, Vt.E], {
        klass: [0, "klass"],
        ngClass: [1, "ngClass"]
      }, null), Vt._18(2, {
        "bottom-border": 0
      }), Vt._2(3, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(5, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(6, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(7, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(10, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(11, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(12, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(14, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(15, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(16, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(19, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(20, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(21, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(23, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(24, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(25, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(28, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(29, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(30, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(32, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(33, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(34, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(37, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(38, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(39, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(41, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(42, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(43, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, Cn)), Vt._2(47, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, In)), Vt._2(50, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, Pn)), Vt._2(53, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, Sn)), Vt._2(56, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, Dn)), Vt._2(59, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n        "]))], function(l, n) {
        l(n, 1, 0, "hang", l(n, 2, 0, n.context.index == n.component.backcardList.length - 1));
        l(n, 47, 0, 0 === n.context.$implicit.pathStatus);
        l(n, 50, 0, 1 === n.context.$implicit.pathStatus);
        l(n, 53, 0, 2 === n.context.$implicit.pathStatus);
        l(n, 56, 0, 4 === n.context.$implicit.pathStatus);
        l(n, 59, 0, 5 === n.context.$implicit.pathStatus)
      }, function(l, n) {
        l(n, 7, 0, Vt._24(n, 7, 0, Vt._15(n, 8).transform("text-name")));
        l(n, 12, 0, n.context.$implicit.payObj.parms.fullName);
        l(n, 16, 0, Vt._24(n, 16, 0, Vt._15(n, 17).transform("text-identity")));
        l(n, 21, 0, n.context.$implicit.payObj.parms.identityNumber);
        l(n, 25, 0, Vt._24(n, 25, 0, Vt._15(n, 26).transform("text-phone")));
        l(n, 30, 0, n.context.$implicit.payObj.parms.cardMobile);
        l(n, 34, 0, Vt._24(n, 34, 0, Vt._15(n, 35).transform("text-card")));
        l(n, 39, 0, n.context.$implicit.payObj.parms.cardNumber);
        l(n, 43, 0, Vt._24(n, 43, 0, Vt._15(n, 44).transform("path-status")))
      })
    }

    function jn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._3(13, 0, null, null, 9, "ion-content", [
        ["no-bounce", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 5, "ion-grid", [
        ["class", "grid"]
      ], null, null, null, null, null)), Vt._2(17, 16384, null, 0, mu.a, [], null, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, Mn)), Vt._2(20, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(24, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(25, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(27, 0, null, null, 3, "button", [
        ["class", "button-footer"],
        ["full", ""],
        ["ion-button", ""],
        ["style", "width: 100%"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onCommit() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(28, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(29, 0, [" ", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        l(n, 20, 0, n.component.backcardList);
        l(n, 28, 0, "")
      }, function(l, n) {
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-bankcard-path-deatils")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 29, 0, Vt._24(n, 29, 0, Vt._15(n, 30).transform("add-path")))
      })
    }

    function Wn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("path-status-no-pay")))
      })
    }

    function On(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("path-status-authing")))
      })
    }

    function Nn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("path-status-authed")))
      })
    }

    function Tn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("text-data-chain1")))
      })
    }

    function Ln(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("text-data-chain2")))
      })
    }

    function An(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 51, "ion-row", [
        ["class", "hang row"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(l.context.$implicit) && e
        }
        return e
      }, null, null)), Vt._2(1, 278528, null, 0, fu.g, [Vt.s, Vt.t, Vt.k, Vt.E], {
        klass: [0, "klass"],
        ngClass: [1, "ngClass"]
      }, null), Vt._18(2, {
        "bottom-border": 0
      }), Vt._2(3, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(5, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(6, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(7, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(10, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(11, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(12, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(14, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(15, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(16, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(19, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(20, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(21, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(23, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(24, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(25, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(28, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(29, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(30, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(32, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(33, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(34, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, Wn)), Vt._2(38, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, On)), Vt._2(41, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, Nn)), Vt._2(44, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, Tn)), Vt._2(47, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, Ln)), Vt._2(50, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n        "]))], function(l, n) {
        l(n, 1, 0, "hang", l(n, 2, 0, n.context.index == n.component.phonepathlist.length - 1));
        l(n, 38, 0, 0 === n.context.$implicit.pathStatus);
        l(n, 41, 0, 1 === n.context.$implicit.pathStatus);
        l(n, 44, 0, 2 === n.context.$implicit.pathStatus);
        l(n, 47, 0, 4 === n.context.$implicit.pathStatus);
        l(n, 50, 0, 5 === n.context.$implicit.pathStatus)
      }, function(l, n) {
        l(n, 7, 0, Vt._24(n, 7, 0, Vt._15(n, 8).transform("text-name")));
        l(n, 12, 0, n.context.$implicit.payObj.parms.fullName);
        l(n, 16, 0, Vt._24(n, 16, 0, Vt._15(n, 17).transform("text-identity")));
        l(n, 21, 0, n.context.$implicit.payObj.parms.identityNumber);
        l(n, 25, 0, Vt._24(n, 25, 0, Vt._15(n, 26).transform("text-phone")));
        l(n, 30, 0, n.context.$implicit.payObj.parms.mobile);
        l(n, 34, 0, Vt._24(n, 34, 0, Vt._15(n, 35).transform("path-status")))
      })
    }

    function Rn(l) {
      return Vt._25(0, [(l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._3(14, 0, null, null, 9, "ion-content", [
        ["no-bounce", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(17, 0, null, 1, 5, "ion-grid", [
        ["class", "grid"]
      ], null, null, null, null, null)), Vt._2(18, 16384, null, 0, mu.a, [], null, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, An)), Vt._2(21, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(25, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(26, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(28, 0, null, null, 3, "button", [
        ["class", "button-footer"],
        ["full", ""],
        ["ion-button", ""],
        ["style", "width: 100%"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onCommit() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(29, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(30, 0, [" ", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        l(n, 21, 0, n.component.phonepathlist);
        l(n, 29, 0, "")
      }, function(l, n) {
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("phone-path-deatils")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher);
        l(n, 30, 0, Vt._24(n, 30, 0, Vt._15(n, 31).transform("add-path")))
      })
    }

    function Jn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("path-status-no-pay")))
      })
    }

    function En(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("path-status-authing")))
      })
    }

    function Vn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("path-status-authed")))
      })
    }

    function Fn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("text-data-chain1")))
      })
    }

    function zn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(2, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("text-data-chain2")))
      })
    }

    function Kn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 42, "ion-row", [
        ["class", "hang row"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext(l.context.$implicit) && e
        }
        return e
      }, null, null)), Vt._2(1, 278528, null, 0, fu.g, [Vt.s, Vt.t, Vt.k, Vt.E], {
        klass: [0, "klass"],
        ngClass: [1, "ngClass"]
      }, null), Vt._18(2, {
        "bottom-border": 0
      }), Vt._2(3, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(5, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(6, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(7, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(10, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(11, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(12, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(14, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(15, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(16, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(19, 0, null, null, 2, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(20, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(21, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(23, 0, null, null, 3, "ion-col", [
        ["class", "font-size-1 col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(24, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(25, null, ["\n                ", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, Jn)), Vt._2(29, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, En)), Vt._2(32, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, Vn)), Vt._2(35, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, Fn)), Vt._2(38, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, zn)), Vt._2(41, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n        "]))], function(l, n) {
        l(n, 1, 0, "hang", l(n, 2, 0, n.context.index == n.component.identitypathlist.length - 1));
        l(n, 29, 0, 0 === n.context.$implicit.pathStatus);
        l(n, 32, 0, 1 === n.context.$implicit.pathStatus);
        l(n, 35, 0, 2 === n.context.$implicit.pathStatus);
        l(n, 38, 0, 4 === n.context.$implicit.pathStatus);
        l(n, 41, 0, 5 === n.context.$implicit.pathStatus)
      }, function(l, n) {
        l(n, 7, 0, Vt._24(n, 7, 0, Vt._15(n, 8).transform("text-name")));
        l(n, 12, 0, n.context.$implicit.payObj.parms.fullName);
        l(n, 16, 0, Vt._24(n, 16, 0, Vt._15(n, 17).transform("text-identity")));
        l(n, 21, 0, n.context.$implicit.payObj.parms.identityNumber);
        l(n, 25, 0, Vt._24(n, 25, 0, Vt._15(n, 26).transform("path-status")))
      })
    }

    function Bn(l) {
      return Vt._25(0, [(l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._3(14, 0, null, null, 9, "ion-content", [
        ["no-bounce", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(17, 0, null, 1, 5, "ion-grid", [
        ["class", "grid"]
      ], null, null, null, null, null)), Vt._2(18, 16384, null, 0, mu.a, [], null, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, Kn)), Vt._2(21, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(25, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(26, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(28, 0, null, null, 3, "button", [
        ["class", "button-footer"],
        ["full", ""],
        ["ion-button", ""],
        ["style", "width: 100%"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onCommit() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(29, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(30, 0, [" ", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        l(n, 21, 0, n.component.identitypathlist);
        l(n, 29, 0, "")
      }, function(l, n) {
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("text-identity-path-deatils")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher);
        l(n, 30, 0, Vt._24(n, 30, 0, Vt._15(n, 31).transform("add-path")))
      })
    }

    function Yn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(13, 0, null, null, 62, "ion-content", [
        ["no-bounce", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n\n    "])), (l()(), Vt._3(16, 0, null, 1, 58, "ion-grid", [
        ["class", "grid"]
      ], null, null, null, null, null)), Vt._2(17, 16384, null, 0, mu.a, [], null, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(19, 0, null, null, 26, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(20, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(22, 0, null, null, 3, "ion-col", [
        ["align-self-center", ""],
        ["class", "font-size-1 text-left col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(23, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(24, null, ["", " "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(27, 0, null, null, 17, "ion-col", [
        ["align-self-center", ""],
        ["class", "col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(28, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(30, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(31, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(35, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(37, 0, null, 3, 5, "ion-input", [
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.personValidate.fullName = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(38, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(40, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(41, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(47, 0, null, null, 26, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(48, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(50, 0, null, null, 3, "ion-col", [
        ["align-self-center", ""],
        ["class", "font-size-1 text-left col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(51, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(52, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(55, 0, null, null, 17, "ion-col", [
        ["align-self-center", ""],
        ["class", "col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(56, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(58, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(59, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 4, {
        contentLabel: 0
      }), Vt._21(603979776, 5, {
        _buttons: 1
      }), Vt._21(603979776, 6, {
        _icons: 1
      }), Vt._2(63, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(65, 0, null, 3, 5, "ion-input", [
        ["type", "tel"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.personValidate.identityNumber = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(66, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(68, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(69, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._3(77, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(78, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(80, 0, null, null, 3, "button", [
        ["class", "button-footer"],
        ["full", ""],
        ["ion-button", ""],
        ["style", "width: 100%"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onCommit() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(81, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(82, 0, ["", "", "", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 38, 0, t.personValidate.fullName);
        l(n, 41, 0, "text", Vt._6(1, "", Vt._24(n, 41, 1, Vt._15(n, 42).transform("text-input-please")), ""));
        l(n, 66, 0, t.personValidate.identityNumber);
        l(n, 69, 0, "tel", Vt._6(1, "", Vt._24(n, 69, 1, Vt._15(n, 70).transform("text-input-please")), ""));
        l(n, 81, 0, "")
      }, function(l, n) {
        var t = n.component;
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-certified-identity")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 24, 0, Vt._24(n, 24, 0, Vt._15(n, 25).transform("text-name")));
        l(n, 37, 0, Vt._15(n, 40).ngClassUntouched, Vt._15(n, 40).ngClassTouched, Vt._15(n, 40).ngClassPristine, Vt._15(n, 40).ngClassDirty, Vt._15(n, 40).ngClassValid, Vt._15(n, 40).ngClassInvalid, Vt._15(n, 40).ngClassPending);
        l(n, 52, 0, Vt._24(n, 52, 0, Vt._15(n, 53).transform("text-identity")));
        l(n, 65, 0, Vt._15(n, 68).ngClassUntouched, Vt._15(n, 68).ngClassTouched, Vt._15(n, 68).ngClassPristine, Vt._15(n, 68).ngClassDirty, Vt._15(n, 68).ngClassValid, Vt._15(n, 68).ngClassInvalid, Vt._15(n, 68).ngClassPending);
        l(n, 82, 0, Vt._24(n, 82, 0, Vt._15(n, 83).transform("text-pay")), t.payMoney, t.unit)
      })
    }

    function Gn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(13, 0, null, null, 127, "ion-content", [
        ["no-bounce", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 122, "ion-grid", [
        ["class", "grid"]
      ], null, null, null, null, null)), Vt._2(17, 16384, null, 0, mu.a, [], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(19, 0, null, null, 26, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(20, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(22, 0, null, null, 3, "ion-col", [
        ["align-self-center", ""],
        ["class", "font-size-1 text-left col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(23, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(24, null, ["", " "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(27, 0, null, null, 17, "ion-col", [
        ["align-self-center", ""],
        ["class", "col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(28, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(30, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(31, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(35, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(37, 0, null, 3, 5, "ion-input", [
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.phoneValidate.fullName = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(38, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(40, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(41, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(47, 0, null, null, 26, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(48, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(50, 0, null, null, 3, "ion-col", [
        ["align-self-center", ""],
        ["class", "font-size-1 text-left col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(51, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(52, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(55, 0, null, null, 17, "ion-col", [
        ["align-self-center", ""],
        ["class", "col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(56, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(58, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(59, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 4, {
        contentLabel: 0
      }), Vt._21(603979776, 5, {
        _buttons: 1
      }), Vt._21(603979776, 6, {
        _icons: 1
      }), Vt._2(63, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(65, 0, null, 3, 5, "ion-input", [
        ["type", "tel"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.phoneValidate.identityNumber = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(66, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(68, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(69, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(75, 0, null, null, 26, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(76, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(78, 0, null, null, 3, "ion-col", [
        ["align-self-center", ""],
        ["class", "font-size-1 text-left col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(79, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(80, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(83, 0, null, null, 17, "ion-col", [
        ["align-self-center", ""],
        ["class", "col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(84, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(86, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(87, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 7, {
        contentLabel: 0
      }), Vt._21(603979776, 8, {
        _buttons: 1
      }), Vt._21(603979776, 9, {
        _icons: 1
      }), Vt._2(91, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(93, 0, null, 3, 5, "ion-input", [
        ["type", "tel"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.phoneValidate.mobile = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(94, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(96, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(97, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(103, 0, null, null, 34, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(104, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(106, 0, null, null, 3, "ion-col", [
        ["align-self-center", ""],
        ["class", "font-size-1 text-left col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(107, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(108, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(111, 0, null, null, 17, "ion-col", [
        ["align-self-center", ""],
        ["class", "col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(112, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(114, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(115, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 10, {
        contentLabel: 0
      }), Vt._21(603979776, 11, {
        _buttons: 1
      }), Vt._21(603979776, 12, {
        _icons: 1
      }), Vt._2(119, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(121, 0, null, 3, 5, "ion-input", [
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.phoneValidate.code = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(122, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(124, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(125, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(130, 0, null, null, 6, "ion-col", [
        ["align-self-center", ""],
        ["class", "text-center col"],
        ["col-6", ""]
      ], null, null, null, null, null)), Vt._2(131, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(133, 0, null, null, 2, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], [
        [8, "disabled", 0]
      ], [
        [null, "disabledChange"],
        [null, "click"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("disabledChange" === n) {
          e = !1 !== (a.verifyCode.disabled = t) && e
        }
        if ("click" === n) {
          e = !1 !== a.getCode(a.phoneValidate.mobile) && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(134, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(135, 0, ["", ""])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._3(142, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(143, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(145, 0, null, null, 3, "button", [
        ["class", "button-footer"],
        ["full", ""],
        ["ion-button", ""],
        ["style", "width: 100%"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onCommit() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(146, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(147, 0, ["", "", "", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 38, 0, t.phoneValidate.fullName);
        l(n, 41, 0, "text", Vt._6(1, "", Vt._24(n, 41, 1, Vt._15(n, 42).transform("text-input-please")), ""));
        l(n, 66, 0, t.phoneValidate.identityNumber);
        l(n, 69, 0, "tel", Vt._6(1, "", Vt._24(n, 69, 1, Vt._15(n, 70).transform("text-input-please")), ""));
        l(n, 94, 0, t.phoneValidate.mobile);
        l(n, 97, 0, "tel", Vt._6(1, "", Vt._24(n, 97, 1, Vt._15(n, 98).transform("text-input-please")), ""));
        l(n, 122, 0, t.phoneValidate.code);
        l(n, 125, 0, "text", Vt._6(1, "", Vt._24(n, 125, 1, Vt._15(n, 126).transform("text-input-please")), ""));
        l(n, 134, 0, "");
        l(n, 146, 0, "")
      }, function(l, n) {
        var t = n.component;
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-certified-phone")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 24, 0, Vt._24(n, 24, 0, Vt._15(n, 25).transform("text-name")));
        l(n, 37, 0, Vt._15(n, 40).ngClassUntouched, Vt._15(n, 40).ngClassTouched, Vt._15(n, 40).ngClassPristine, Vt._15(n, 40).ngClassDirty, Vt._15(n, 40).ngClassValid, Vt._15(n, 40).ngClassInvalid, Vt._15(n, 40).ngClassPending);
        l(n, 52, 0, Vt._24(n, 52, 0, Vt._15(n, 53).transform("text-identity")));
        l(n, 65, 0, Vt._15(n, 68).ngClassUntouched, Vt._15(n, 68).ngClassTouched, Vt._15(n, 68).ngClassPristine, Vt._15(n, 68).ngClassDirty, Vt._15(n, 68).ngClassValid, Vt._15(n, 68).ngClassInvalid, Vt._15(n, 68).ngClassPending);
        l(n, 80, 0, Vt._24(n, 80, 0, Vt._15(n, 81).transform("text-phone")));
        l(n, 93, 0, Vt._15(n, 96).ngClassUntouched, Vt._15(n, 96).ngClassTouched, Vt._15(n, 96).ngClassPristine, Vt._15(n, 96).ngClassDirty, Vt._15(n, 96).ngClassValid, Vt._15(n, 96).ngClassInvalid, Vt._15(n, 96).ngClassPending);
        l(n, 108, 0, Vt._24(n, 108, 0, Vt._15(n, 109).transform("text-check-code")));
        l(n, 121, 0, Vt._15(n, 124).ngClassUntouched, Vt._15(n, 124).ngClassTouched, Vt._15(n, 124).ngClassPristine, Vt._15(n, 124).ngClassDirty, Vt._15(n, 124).ngClassValid, Vt._15(n, 124).ngClassInvalid, Vt._15(n, 124).ngClassPending);
        l(n, 133, 0, t.verifyCode.disabled);
        l(n, 135, 0, t.verifyCode.verifyCodeTips);
        l(n, 147, 0, Vt._24(n, 147, 0, Vt._15(n, 148).transform("text-pay")), t.payMoney, t.unit)
      })
    }

    function Hn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(13, 0, null, null, 155, "ion-content", [
        ["no-bounce", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 150, "ion-grid", [
        ["class", "grid"]
      ], null, null, null, null, null)), Vt._2(17, 16384, null, 0, mu.a, [], null, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(19, 0, null, null, 26, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(20, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(22, 0, null, null, 3, "ion-col", [
        ["align-self-center", ""],
        ["class", "font-size-1 text-left col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(23, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(24, null, ["", " "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(27, 0, null, null, 17, "ion-col", [
        ["align-self-center", ""],
        ["class", "col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(28, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(30, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(31, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(35, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(37, 0, null, 3, 5, "ion-input", [
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.debitCard.fullName = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(38, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(40, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(41, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(47, 0, null, null, 26, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(48, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(50, 0, null, null, 3, "ion-col", [
        ["align-self-center", ""],
        ["class", "font-size-1 text-left col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(51, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(52, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(55, 0, null, null, 17, "ion-col", [
        ["align-self-center", ""],
        ["class", "col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(56, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(58, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(59, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 4, {
        contentLabel: 0
      }), Vt._21(603979776, 5, {
        _buttons: 1
      }), Vt._21(603979776, 6, {
        _icons: 1
      }), Vt._2(63, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(65, 0, null, 3, 5, "ion-input", [
        ["type", "tel"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.debitCard.identityNumber = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(66, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(68, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(69, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(75, 0, null, null, 26, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(76, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(78, 0, null, null, 3, "ion-col", [
        ["align-self-center", ""],
        ["class", "font-size-1 text-left col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(79, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(80, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(83, 0, null, null, 17, "ion-col", [
        ["align-self-center", ""],
        ["class", "col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(84, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(86, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(87, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 7, {
        contentLabel: 0
      }), Vt._21(603979776, 8, {
        _buttons: 1
      }), Vt._21(603979776, 9, {
        _icons: 1
      }), Vt._2(91, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(93, 0, null, 3, 5, "ion-input", [
        ["type", "tel"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.debitCard.cardNumber = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(94, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(96, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(97, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(103, 0, null, null, 26, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(104, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(106, 0, null, null, 3, "ion-col", [
        ["align-self-center", ""],
        ["class", "font-size-1 text-left col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(107, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(108, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(111, 0, null, null, 17, "ion-col", [
        ["align-self-center", ""],
        ["class", "col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(112, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(114, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(115, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 10, {
        contentLabel: 0
      }), Vt._21(603979776, 11, {
        _buttons: 1
      }), Vt._21(603979776, 12, {
        _icons: 1
      }), Vt._2(119, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(121, 0, null, 3, 5, "ion-input", [
        ["type", "tel"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.debitCard.cardMobile = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(122, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(124, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(125, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(131, 0, null, null, 34, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(132, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(134, 0, null, null, 3, "ion-col", [
        ["align-self-center", ""],
        ["class", "font-size-1 text-left col"],
        ["col-2", ""]
      ], null, null, null, null, null)), Vt._2(135, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(136, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(139, 0, null, null, 17, "ion-col", [
        ["align-self-center", ""],
        ["class", "col"],
        ["col-4", ""]
      ], null, null, null, null, null)), Vt._2(140, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(142, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(143, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 13, {
        contentLabel: 0
      }), Vt._21(603979776, 14, {
        _buttons: 1
      }), Vt._21(603979776, 15, {
        _icons: 1
      }), Vt._2(147, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(149, 0, null, 3, 5, "ion-input", [
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.debitCard.cardCode = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(150, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(152, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(153, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(158, 0, null, null, 6, "ion-col", [
        ["align-self-center", ""],
        ["class", "text-center col"],
        ["col-6", ""]
      ], null, null, null, null, null)), Vt._2(159, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(161, 0, null, null, 2, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], [
        [8, "disabled", 0]
      ], [
        [null, "disabledChange"],
        [null, "click"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("disabledChange" === n) {
          e = !1 !== (a.verifyCode.disabled = t) && e
        }
        if ("click" === n) {
          e = !1 !== a.getCode(a.debitCard.cardMobile) && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(162, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(163, 0, ["", ""])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._3(170, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(171, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(173, 0, null, null, 3, "button", [
        ["class", "button-footer"],
        ["full", ""],
        ["ion-button", ""],
        ["style", "width: 100%"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onCommit() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(174, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(175, 0, ["", "", "", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 38, 0, t.debitCard.fullName);
        l(n, 41, 0, "text", Vt._6(1, "", Vt._24(n, 41, 1, Vt._15(n, 42).transform("text-input-please")), ""));
        l(n, 66, 0, t.debitCard.identityNumber);
        l(n, 69, 0, "tel", Vt._6(1, "", Vt._24(n, 69, 1, Vt._15(n, 70).transform("text-input-please")), ""));
        l(n, 94, 0, t.debitCard.cardNumber);
        l(n, 97, 0, "tel", Vt._6(1, "", Vt._24(n, 97, 1, Vt._15(n, 98).transform("text-input-please")), ""));
        l(n, 122, 0, t.debitCard.cardMobile);
        l(n, 125, 0, "tel", Vt._6(1, "", Vt._24(n, 125, 1, Vt._15(n, 126).transform("text-input-please")), ""));
        l(n, 150, 0, t.debitCard.cardCode);
        l(n, 153, 0, "text", Vt._6(1, "", Vt._24(n, 153, 1, Vt._15(n, 154).transform("text-input-please")), ""));
        l(n, 162, 0, "");
        l(n, 174, 0, "")
      }, function(l, n) {
        var t = n.component;
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-card-debit")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 24, 0, Vt._24(n, 24, 0, Vt._15(n, 25).transform("text-name")));
        l(n, 37, 0, Vt._15(n, 40).ngClassUntouched, Vt._15(n, 40).ngClassTouched, Vt._15(n, 40).ngClassPristine, Vt._15(n, 40).ngClassDirty, Vt._15(n, 40).ngClassValid, Vt._15(n, 40).ngClassInvalid, Vt._15(n, 40).ngClassPending);
        l(n, 52, 0, Vt._24(n, 52, 0, Vt._15(n, 53).transform("text-identity")));
        l(n, 65, 0, Vt._15(n, 68).ngClassUntouched, Vt._15(n, 68).ngClassTouched, Vt._15(n, 68).ngClassPristine, Vt._15(n, 68).ngClassDirty, Vt._15(n, 68).ngClassValid, Vt._15(n, 68).ngClassInvalid, Vt._15(n, 68).ngClassPending);
        l(n, 80, 0, Vt._24(n, 80, 0, Vt._15(n, 81).transform("text-card-debit")));
        l(n, 93, 0, Vt._15(n, 96).ngClassUntouched, Vt._15(n, 96).ngClassTouched, Vt._15(n, 96).ngClassPristine, Vt._15(n, 96).ngClassDirty, Vt._15(n, 96).ngClassValid, Vt._15(n, 96).ngClassInvalid, Vt._15(n, 96).ngClassPending);
        l(n, 108, 0, Vt._24(n, 108, 0, Vt._15(n, 109).transform("text-phone")));
        l(n, 121, 0, Vt._15(n, 124).ngClassUntouched, Vt._15(n, 124).ngClassTouched, Vt._15(n, 124).ngClassPristine, Vt._15(n, 124).ngClassDirty, Vt._15(n, 124).ngClassValid, Vt._15(n, 124).ngClassInvalid, Vt._15(n, 124).ngClassPending);
        l(n, 136, 0, Vt._24(n, 136, 0, Vt._15(n, 137).transform("text-check-code")));
        l(n, 149, 0, Vt._15(n, 152).ngClassUntouched, Vt._15(n, 152).ngClassTouched, Vt._15(n, 152).ngClassPristine, Vt._15(n, 152).ngClassDirty, Vt._15(n, 152).ngClassValid, Vt._15(n, 152).ngClassInvalid, Vt._15(n, 152).ngClassPending);
        l(n, 161, 0, t.verifyCode.disabled);
        l(n, 163, 0, t.verifyCode.verifyCodeTips);
        l(n, 175, 0, Vt._24(n, 175, 0, Vt._15(n, 176).transform("text-pay")), t.payMoney, t.unit)
      })
    }

    function Un(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(1, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 2, {
        contentLabel: 0
      }), Vt._21(603979776, 3, {
        _buttons: 1
      }), Vt._21(603979776, 4, {
        _icons: 1
      }), Vt._2(5, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(7, 0, null, 1, 2, "ion-label", [], null, null, null, null, null)), Vt._2(8, 16384, [
        [2, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(9, null, ["\n                ", "\n            "])), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(11, 0, null, 4, 1, "ion-radio", [], [
        [2, "radio-disabled", null]
      ], [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("click" === n) {
          e = !1 !== Vt._15(l, 12)._click(t) && e
        }
        if ("click" === n) {
          e = !1 !== a.save(l.context.$implicit.isoCode) && e
        }
        return e
      }, Ns.b, Ns.a)), Vt._2(12, 245760, null, 0, Ts.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Cu.a],
        [2, Ls.a]
      ], {
        value: [0, "value"]
      }, null), (l()(), Vt._23(-1, 2, ["\n        "]))], function(l, n) {
        l(n, 12, 0, n.context.$implicit.isoCode)
      }, function(l, n) {
        l(n, 9, 0, n.context.$implicit.name);
        l(n, 11, 0, Vt._15(n, 12)._disabled)
      })
    }

    function qn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [
        ["style", "text-align: center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._3(13, 0, null, null, 15, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 11, "ion-list", [
        ["radio-group", ""],
        ["role", "radiogroup"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.currentLanguage = t) && e
        }
        return e
      }, null, null)), Vt._2(17, 1064960, null, 1, Ls.a, [Vt.D, Vt.k, Vt.g], null, null), Vt._21(335544320, 1, {
        _header: 0
      }), Vt._19(1024, null, Ut.g, function(l) {
        return [l]
      }, [Ls.a]), Vt._2(20, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [2, Ut.g]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(22, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(23, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, Un)), Vt._2(26, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 20, 0, t.currentLanguage);
        l(n, 26, 0, t.languages)
      }, function(l, n) {
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("text-language-message")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 16, 0, Vt._15(n, 22).ngClassUntouched, Vt._15(n, 22).ngClassTouched, Vt._15(n, 22).ngClassPristine, Vt._15(n, 22).ngClassDirty, Vt._15(n, 22).ngClassValid, Vt._15(n, 22).ngClassInvalid, Vt._15(n, 22).ngClassPending)
      })
    }

    function $n(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 6, "span", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(2, 0, null, null, 0, "br", [], null, null, null, null, null)), (l()(), Vt._3(3, 0, null, null, 2, "span", [
        ["style", "font-size:12px"]
      ], null, null, null, null, null)), (l()(), Vt._23(4, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n                "]))], null, function(l, n) {
        l(n, 4, 0, Vt._24(n, 4, 0, Vt._15(n, 5).transform("text-standard-wallte")))
      })
    }

    function Zn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 6, "span", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(2, 0, null, null, 0, "br", [], null, null, null, null, null)), (l()(), Vt._3(3, 0, null, null, 2, "span", [
        ["style", "font-size:12px"]
      ], null, null, null, null, null)), (l()(), Vt._23(4, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n                "]))], null, function(l, n) {
        l(n, 4, 0, Vt._24(n, 4, 0, Vt._15(n, 5).transform("text-multi-wallte")))
      })
    }

    function Qn(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 22, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(1, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 2, {
        contentLabel: 0
      }), Vt._21(603979776, 3, {
        _buttons: 1
      }), Vt._21(603979776, 4, {
        _icons: 1
      }), Vt._2(5, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(7, 0, null, 1, 11, "ion-label", [], null, null, null, null, null)), Vt._2(8, 16384, [
        [2, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(10, 0, null, null, 1, "span", [
        ["style", "font-size:16px"]
      ], null, null, null, null, null)), (l()(), Vt._23(11, null, ["", ""])), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt.Y(16777216, null, null, 1, null, $n)), Vt._2(14, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt.Y(16777216, null, null, 1, null, Zn)), Vt._2(17, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(20, 0, null, 4, 1, "ion-radio", [], [
        [2, "radio-disabled", null]
      ], [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("click" === n) {
          e = !1 !== Vt._15(l, 21)._click(t) && e
        }
        if ("click" === n) {
          e = !1 !== a.itemSelected(l.context.$implicit) && e
        }
        return e
      }, Ns.b, Ns.a)), Vt._2(21, 245760, null, 0, Ts.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Cu.a],
        [2, Ls.a]
      ], {
        value: [0, "value"]
      }, null), (l()(), Vt._23(-1, 2, ["\n        "]))], function(l, n) {
        l(n, 14, 0, "Standard" === n.context.$implicit.Account.Type);
        l(n, 17, 0, "Multi-Sign" === n.context.$implicit.Account.Type);
        l(n, 21, 0, n.context.$implicit.id)
      }, function(l, n) {
        l(n, 11, 0, n.context.$implicit.wallname);
        l(n, 20, 0, Vt._15(n, 21)._disabled)
      })
    }

    function Xn(l) {
      return Vt._25(0, [(l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n\n\n"])), (l()(), Vt._3(14, 0, null, null, 15, "ion-content", [
        ["no-bounce", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(17, 0, null, 1, 11, "ion-list", [
        ["radio-group", ""],
        ["role", "radiogroup"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.masterWalletId = t) && e
        }
        return e
      }, null, null)), Vt._2(18, 1064960, null, 1, Ls.a, [Vt.D, Vt.k, Vt.g], null, null), Vt._21(335544320, 1, {
        _header: 0
      }), Vt._19(1024, null, Ut.g, function(l) {
        return [l]
      }, [Ls.a]), Vt._2(21, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [2, Ut.g]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(23, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(24, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, Qn)), Vt._2(27, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._3(31, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(32, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(34, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.nextPage() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(35, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(36, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 21, 0, t.masterWalletId);
        l(n, 27, 0, t.items);
        l(n, 35, 0, "")
      }, function(l, n) {
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("text-wallte-list")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher);
        l(n, 17, 0, Vt._15(n, 23).ngClassUntouched, Vt._15(n, 23).ngClassTouched, Vt._15(n, 23).ngClassPristine, Vt._15(n, 23).ngClassDirty, Vt._15(n, 23).ngClassValid, Vt._15(n, 23).ngClassInvalid, Vt._15(n, 23).ngClassPending);
        l(n, 36, 0, Vt._24(n, 36, 0, Vt._15(n, 37).transform("text-add-wallet")))
      })
    }

    function lt(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "ion-option", [], null, null, null, null, null)), Vt._2(1, 16384, [
        [4, 4]
      ], 0, Vs.a, [Vt.k], {
        value: [0, "value"]
      }, null), (l()(), Vt._23(2, null, ["", ""]))], function(l, n) {
        l(n, 1, 0, n.context.$implicit)
      }, function(l, n) {
        l(n, 2, 0, n.context.$implicit)
      })
    }

    function nt(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "ion-option", [], null, null, null, null, null)), Vt._2(1, 16384, [
        [8, 4]
      ], 0, Vs.a, [Vt.k], {
        value: [0, "value"]
      }, null), (l()(), Vt._23(2, null, ["", ""]))], function(l, n) {
        l(n, 1, 0, n.context.$implicit)
      }, function(l, n) {
        l(n, 2, 0, n.context.$implicit)
      })
    }

    function tt(l) {
      return Vt._25(0, [(l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [
        ["style", "text-align: center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n\n\n"])), (l()(), Vt._3(14, 0, null, null, 52, "ion-content", [
        ["no-bounce", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(17, 0, null, 1, 23, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(18, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(22, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._3(24, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(25, 16384, [
        [1, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(26, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._3(29, 0, null, 3, 10, "ion-select", [], [
        [2, "select-disabled", null],
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"],
        [null, "ionChange"],
        [null, "click"],
        [null, "keyup.space"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("click" === n) {
          e = !1 !== Vt._15(l, 30)._click(t) && e
        }
        if ("keyup.space" === n) {
          e = !1 !== Vt._15(l, 30)._keyup() && e
        }
        if ("ngModelChange" === n) {
          e = !1 !== (a.totalCopayers = t) && e
        }
        if ("ionChange" === n) {
          e = !1 !== a.setTotalCopayers() && e
        }
        return e
      }, Fs.b, Fs.a)), Vt._2(30, 1228800, null, 1, zs.a, [Ya.a, Iu.a, Ga.a, Vt.k, Vt.D, [2, Cu.a], $a.a], null, {
        ionChange: "ionChange"
      }), Vt._21(603979776, 4, {
        options: 1
      }), Vt._19(1024, null, Ut.g, function(l) {
        return [l]
      }, [zs.a]), Vt._2(33, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [2, Ut.g]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(35, 16384, null, 0, Ut.i, [Ut.h], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, lt)), Vt._2(38, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, 2, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n\n    "])), (l()(), Vt._3(42, 0, null, 1, 23, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(43, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 5, {
        contentLabel: 0
      }), Vt._21(603979776, 6, {
        _buttons: 1
      }), Vt._21(603979776, 7, {
        _icons: 1
      }), Vt._2(47, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._3(49, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(50, 16384, [
        [5, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(51, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._3(54, 0, null, 3, 10, "ion-select", [], [
        [2, "select-disabled", null],
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"],
        [null, "click"],
        [null, "keyup.space"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("click" === n) {
          e = !1 !== Vt._15(l, 55)._click(t) && e
        }
        if ("keyup.space" === n) {
          e = !1 !== Vt._15(l, 55)._keyup() && e
        }
        if ("ngModelChange" === n) {
          e = !1 !== (a.requiredCopayers = t) && e
        }
        return e
      }, Fs.b, Fs.a)), Vt._2(55, 1228800, null, 1, zs.a, [Ya.a, Iu.a, Ga.a, Vt.k, Vt.D, [2, Cu.a], $a.a], null, null), Vt._21(603979776, 8, {
        options: 1
      }), Vt._19(1024, null, Ut.g, function(l) {
        return [l]
      }, [zs.a]), Vt._2(58, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [2, Ut.g]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(60, 16384, null, 0, Ut.i, [Ut.h], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, nt)), Vt._2(63, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, 2, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(68, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(69, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(71, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.nextPage() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(72, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(73, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 33, 0, t.totalCopayers);
        l(n, 38, 0, t.copayers);
        l(n, 58, 0, t.requiredCopayers);
        l(n, 63, 0, t.signatures);
        l(n, 72, 0, "")
      }, function(l, n) {
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("signature-wallet")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher);
        l(n, 26, 0, Vt._24(n, 26, 0, Vt._15(n, 27).transform("text-multi-title1")));
        l(n, 29, 0, Vt._15(n, 30)._disabled, Vt._15(n, 35).ngClassUntouched, Vt._15(n, 35).ngClassTouched, Vt._15(n, 35).ngClassPristine, Vt._15(n, 35).ngClassDirty, Vt._15(n, 35).ngClassValid, Vt._15(n, 35).ngClassInvalid, Vt._15(n, 35).ngClassPending);
        l(n, 51, 0, Vt._24(n, 51, 0, Vt._15(n, 52).transform("text-multi-title2")));
        l(n, 54, 0, Vt._15(n, 55)._disabled, Vt._15(n, 60).ngClassUntouched, Vt._15(n, 60).ngClassTouched, Vt._15(n, 60).ngClassPristine, Vt._15(n, 60).ngClassDirty, Vt._15(n, 60).ngClassValid, Vt._15(n, 60).ngClassInvalid, Vt._15(n, 60).ngClassPending);
        l(n, 73, 0, Vt._24(n, 73, 0, Vt._15(n, 74).transform("text-next-step")))
      })
    }

    function et(l) {
      return Vt._25(0, [(l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [
        ["style", "text-align: center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n\n\n"])), (l()(), Vt._3(14, 0, null, null, 40, "ion-content", [
        ["padding", ""],
        ["style", "text-align: center;"]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(17, 0, null, 1, 36, "div", [
        ["id", "wrapper"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(19, 0, null, null, 33, "div", [
        ["id", "cell"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(21, 0, null, null, 6, "div", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(23, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.wayOne() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(24, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(25, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(29, 0, null, null, 6, "div", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(31, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.wayTwo() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(32, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(33, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(37, 0, null, null, 6, "div", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(39, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.wayThree() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(40, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(41, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(45, 0, null, null, 6, "div", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(47, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.wayFour() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(48, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(49, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        l(n, 24, 0, "");
        l(n, 32, 0, "");
        l(n, 40, 0, "");
        l(n, 48, 0, "")
      }, function(l, n) {
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("text-select-type")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher);
        l(n, 25, 0, Vt._24(n, 25, 0, Vt._15(n, 26).transform("text-create-privatekey")));
        l(n, 33, 0, Vt._24(n, 33, 0, Vt._15(n, 34).transform("text-import-privatekey")));
        l(n, 41, 0, Vt._24(n, 41, 0, Vt._15(n, 42).transform("text-observe-wallte")));
        l(n, 49, 0, Vt._24(n, 49, 0, Vt._15(n, 50).transform("create-multi-by-mnes")))
      })
    }

    function at(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 27, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(3, 0, null, null, 17, "ion-col", [
        ["align-self-center", ""],
        ["class", "col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(4, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(6, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(7, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(11, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(13, 0, null, 3, 5, "ion-input", [
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.context.$implicit.publicKey = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(14, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(16, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(17, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(22, 0, null, null, 4, "ion-col", [
        ["align-self-center", ""],
        ["class", "col"],
        ["col-2", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.saomiao(l.context.$implicit.index) && e
        }
        return e
      }, null, null)), Vt._2(23, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(25, 0, null, null, 0, "img", [
        ["src", "assets/images/icon/ico-scan.svg"],
        ["style", "width: 40px;height:30px"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "]))], function(l, n) {
        l(n, 14, 0, n.context.$implicit.publicKey);
        l(n, 17, 0, "text", Vt._6(1, "", Vt._24(n, 17, 1, Vt._15(n, 18).transform("text-publickey-placeholder")), ""))
      }, function(l, n) {
        l(n, 13, 0, Vt._15(n, 16).ngClassUntouched, Vt._15(n, 16).ngClassTouched, Vt._15(n, 16).ngClassPristine, Vt._15(n, 16).ngClassDirty, Vt._15(n, 16).ngClassValid, Vt._15(n, 16).ngClassInvalid, Vt._15(n, 16).ngClassPending)
      })
    }

    function ut(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 8, "div", [
        ["style", "text-align: center;width:100%;margin-top:20px"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.copy() && e
        }
        return e
      }, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(2, 0, null, null, 1, "qrcode", [
        ["class", "receive-qrocde"],
        ["style", "display:inline-block;"]
      ], null, null, null, vi.b, vi.a)), Vt._2(3, 638976, null, 0, yi.a, [Vt.k], {
        level: [0, "level"],
        qrdata: [1, "qrdata"],
        size: [2, "size"]
      }, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(5, 0, null, null, 2, "p", [
        ["style", "text-align:left;margin-top: 10px;font-size:14px;padding:0px 10px"]
      ], null, null, null, null, null)), (l()(), Vt._23(6, null, ["", "：", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n    "]))], function(l, n) {
        l(n, 3, 0, "M", n.component.qrcode, 200)
      }, function(l, n) {
        var t = n.component;
        l(n, 6, 0, Vt._24(n, 6, 0, Vt._15(n, 7).transform("my-publickey")), t.qrcode)
      })
    }

    function it(l) {
      return Vt._25(0, [(l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [
        ["style", "text-align: center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n\n\n"])), (l()(), Vt._3(14, 0, null, null, 9, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt.Y(16777216, null, 1, 1, null, at)), Vt._2(19, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, 1, ["\n\n    "])), (l()(), Vt.Y(16777216, null, 1, 1, null, ut)), Vt._2(22, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 1, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(25, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(26, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(28, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.nextPage() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(29, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(30, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 19, 0, t.publicKeyArr);
        l(n, 22, 0, !t.isOnly);
        l(n, 29, 0, "")
      }, function(l, n) {
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("text-add-publickey-title")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher);
        l(n, 30, 0, Vt._24(n, 30, 0, Vt._15(n, 31).transform("text-next-step")))
      })
    }

    function st(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 27, "ion-row", [
        ["class", "row"]
      ], null, null, null, null, null)), Vt._2(1, 16384, null, 0, su.a, [], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(3, 0, null, null, 17, "ion-col", [
        ["align-self-center", ""],
        ["class", "col"],
        ["col-10", ""]
      ], null, null, null, null, null)), Vt._2(4, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(6, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(7, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(11, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(13, 0, null, 3, 5, "ion-input", [
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.context.$implicit.publicKey = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(14, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(16, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(17, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(22, 0, null, null, 4, "ion-col", [
        ["align-self-center", ""],
        ["class", "col"],
        ["col-2", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.saomiao(l.context.$implicit.index) && e
        }
        return e
      }, null, null)), Vt._2(23, 16384, null, 0, ou.a, [], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(25, 0, null, null, 0, "img", [
        ["src", "assets/images/icon/ico-scan.svg"],
        ["style", "width: 40px;height:30px"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "]))], function(l, n) {
        l(n, 14, 0, n.context.$implicit.publicKey);
        l(n, 17, 0, "text", Vt._6(1, "", Vt._24(n, 17, 1, Vt._15(n, 18).transform("text-publickey-placeholder")), ""))
      }, function(l, n) {
        l(n, 13, 0, Vt._15(n, 16).ngClassUntouched, Vt._15(n, 16).ngClassTouched, Vt._15(n, 16).ngClassPristine, Vt._15(n, 16).ngClassDirty, Vt._15(n, 16).ngClassValid, Vt._15(n, 16).ngClassInvalid, Vt._15(n, 16).ngClassPending)
      })
    }

    function ot(l) {
      return Vt._25(0, [(l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [
        ["style", "text-align: center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n\n\n\n"])), (l()(), Vt._3(14, 0, null, null, 16, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt.Y(16777216, null, 1, 1, null, st)), Vt._2(19, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, 1, ["\n\n    "])), (l()(), Vt._3(21, 0, null, 1, 8, "div", [
        ["style", "text-align: center;width:100%;margin-top:20px"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.copy() && e
        }
        return e
      }, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(23, 0, null, null, 1, "qrcode", [
        ["class", "receive-qrocde"],
        ["style", "display:inline-block;"]
      ], null, null, null, vi.b, vi.a)), Vt._2(24, 638976, null, 0, yi.a, [Vt.k], {
        level: [0, "level"],
        qrdata: [1, "qrdata"],
        size: [2, "size"]
      }, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(26, 0, null, null, 2, "p", [
        ["style", "text-align:left;margin-top: 10px;font-size:14px;padding:0px 10px"]
      ], null, null, null, null, null)), (l()(), Vt._23(27, null, ["", "：", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(32, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(33, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(35, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.nextPage() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(36, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(37, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 19, 0, t.publicKeyArr);
        l(n, 24, 0, "M", t.qrcode, 200);
        l(n, 36, 0, "")
      }, function(l, n) {
        var t = n.component;
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("text-add-publickey-title")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher);
        l(n, 27, 0, Vt._24(n, 27, 0, Vt._15(n, 28).transform("my-publickey")), t.qrcode);
        l(n, 37, 0, Vt._24(n, 37, 0, Vt._15(n, 38).transform("text-next-step")))
      })
    }

    function rt(l) {
      return Vt._25(0, [(l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [
        ["style", "text-align: center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n\n\n"])), (l()(), Vt._3(14, 0, null, null, 79, "ion-content", [
        ["no-bounce", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(17, 0, null, 1, 2, "p", [
        ["class", "des"]
      ], null, null, null, null, null)), (l()(), Vt._23(18, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(21, 0, null, 1, 9, "div", [
        ["class", "importDiv"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(23, 0, null, null, 6, "textarea", [
        ["class", "importTextArea"],
        ["rows", "4"]
      ], [
        [8, "placeholder", 0],
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"],
        [null, "input"],
        [null, "blur"],
        [null, "compositionstart"],
        [null, "compositionend"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("input" === n) {
          e = !1 !== Vt._15(l, 24)._handleInput(t.target.value) && e
        }
        if ("blur" === n) {
          e = !1 !== Vt._15(l, 24).onTouched() && e
        }
        if ("compositionstart" === n) {
          e = !1 !== Vt._15(l, 24)._compositionStart() && e
        }
        if ("compositionend" === n) {
          e = !1 !== Vt._15(l, 24)._compositionEnd(t.target.value) && e
        }
        if ("ngModelChange" === n) {
          e = !1 !== (a.importText = t) && e
        }
        return e
      }, null, null)), Vt._2(24, 16384, null, 0, Ut.b, [Vt.E, Vt.k, [2, Ut.a]], null, null), Vt._19(1024, null, Ut.g, function(l) {
        return [l]
      }, [Ut.b]), Vt._2(26, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [2, Ut.g]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(28, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(32, 0, null, 1, 60, "div", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(34, 0, null, null, 57, "ion-list", [], null, null, null, null, null)), Vt._2(35, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(37, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(38, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(42, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(44, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(45, 16384, [
        [1, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(46, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(49, 0, null, 3, 5, "ion-input", [
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.name = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(50, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(52, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(53, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(57, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(58, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 4, {
        contentLabel: 0
      }), Vt._21(603979776, 5, {
        _buttons: 1
      }), Vt._21(603979776, 6, {
        _icons: 1
      }), Vt._2(62, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(64, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(65, 16384, [
        [4, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(66, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(69, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.passWord = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(70, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(72, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(73, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(77, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(78, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 7, {
        contentLabel: 0
      }), Vt._21(603979776, 8, {
        _buttons: 1
      }), Vt._21(603979776, 9, {
        _icons: 1
      }), Vt._2(82, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(84, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.rePassWorld = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(85, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(87, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(88, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(95, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(96, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(98, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.import() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(99, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(100, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 26, 0, t.importText);
        l(n, 50, 0, t.name);
        l(n, 53, 0, "text", Vt._6(1, "", Vt._24(n, 53, 1, Vt._15(n, 54).transform("addwallet-walletname-placeholder")), ""));
        l(n, 70, 0, t.passWord);
        l(n, 73, 0, "password", Vt._6(1, "", Vt._24(n, 73, 1, Vt._15(n, 74).transform("addwallet-paypassword1-placeholder")), ""));
        l(n, 85, 0, t.rePassWorld);
        l(n, 88, 0, "password", Vt._6(1, "", Vt._24(n, 88, 1, Vt._15(n, 89).transform("addwallet-paypassword2-placeholder")), ""));
        l(n, 99, 0, "")
      }, function(l, n) {
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("text-import-privatekey")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher);
        l(n, 18, 0, Vt._24(n, 18, 0, Vt._15(n, 19).transform("text-import-privatekey-des")));
        l(n, 23, 0, Vt._6(1, "", Vt._24(n, 23, 0, Vt._15(n, 29).transform("text-import-privatekey-placeholder")), ""), Vt._15(n, 28).ngClassUntouched, Vt._15(n, 28).ngClassTouched, Vt._15(n, 28).ngClassPristine, Vt._15(n, 28).ngClassDirty, Vt._15(n, 28).ngClassValid, Vt._15(n, 28).ngClassInvalid, Vt._15(n, 28).ngClassPending);
        l(n, 46, 0, Vt._24(n, 46, 0, Vt._15(n, 47).transform("addwallet-walletname-title")));
        l(n, 49, 0, Vt._15(n, 52).ngClassUntouched, Vt._15(n, 52).ngClassTouched, Vt._15(n, 52).ngClassPristine, Vt._15(n, 52).ngClassDirty, Vt._15(n, 52).ngClassValid, Vt._15(n, 52).ngClassInvalid, Vt._15(n, 52).ngClassPending);
        l(n, 66, 0, Vt._24(n, 66, 0, Vt._15(n, 67).transform("addwallet-paypassword1-title")));
        l(n, 69, 0, Vt._15(n, 72).ngClassUntouched, Vt._15(n, 72).ngClassTouched, Vt._15(n, 72).ngClassPristine, Vt._15(n, 72).ngClassDirty, Vt._15(n, 72).ngClassValid, Vt._15(n, 72).ngClassInvalid, Vt._15(n, 72).ngClassPending);
        l(n, 84, 0, Vt._15(n, 87).ngClassUntouched, Vt._15(n, 87).ngClassTouched, Vt._15(n, 87).ngClassPristine, Vt._15(n, 87).ngClassDirty, Vt._15(n, 87).ngClassValid, Vt._15(n, 87).ngClassInvalid, Vt._15(n, 87).ngClassPending);
        l(n, 100, 0, Vt._24(n, 100, 0, Vt._15(n, 101).transform("text-next-step")))
      })
    }

    function ct(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 53, "div", [
        ["class", "juzhong"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(2, 0, null, null, 0, "div", [
        ["class", "arrow_mask"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.click_close() && e
        }
        return e
      }, null, null)), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(4, 0, null, null, 48, "div", [
        ["class", "kuang"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(6, 0, null, null, 37, "ion-list", [], null, null, null, null, null)), Vt._2(7, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(9, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(10, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(14, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(16, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.payPassword = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(17, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(19, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(20, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(24, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(25, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 4, {
        contentLabel: 0
      }), Vt._21(603979776, 5, {
        _buttons: 1
      }), Vt._21(603979776, 6, {
        _icons: 1
      }), Vt._2(29, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(31, 0, null, 1, 3, "ion-label", [], null, null, null, null, null)), Vt._2(32, 16384, [
        [4, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(33, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._3(36, 0, null, 0, 5, "ion-checkbox", [], [
        [2, "checkbox-disabled", null],
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"],
        [null, "click"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("click" === n) {
          e = !1 !== Vt._15(l, 37)._click(t) && e
        }
        if ("ngModelChange" === n) {
          e = !1 !== (a.singleAddress = t) && e
        }
        return e
      }, $u.b, $u.a)), Vt._2(37, 1228800, null, 0, Zu.a, [Ga.a, Iu.a, [2, Cu.a], Vt.k, Vt.D], null, null), Vt._19(1024, null, Ut.g, function(l) {
        return [l]
      }, [Zu.a]), Vt._2(39, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [2, Ut.g]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(41, 16384, null, 0, Ut.i, [Ut.h], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(45, 0, null, null, 6, "div", [
        ["style", "text-align: center"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(47, 0, null, null, 3, "button", [
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.click_button() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(48, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(49, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 17, 0, t.payPassword);
        l(n, 20, 0, "password", Vt._6(1, "", Vt._24(n, 20, 1, Vt._15(n, 21).transform("text-pay-passworld-input")), ""));
        l(n, 39, 0, t.singleAddress)
      }, function(l, n) {
        l(n, 16, 0, Vt._15(n, 19).ngClassUntouched, Vt._15(n, 19).ngClassTouched, Vt._15(n, 19).ngClassPristine, Vt._15(n, 19).ngClassDirty, Vt._15(n, 19).ngClassValid, Vt._15(n, 19).ngClassInvalid, Vt._15(n, 19).ngClassPending);
        l(n, 33, 0, Vt._24(n, 33, 0, Vt._15(n, 34).transform("text-signaddress")));
        l(n, 36, 0, Vt._15(n, 37)._disabled, Vt._15(n, 41).ngClassUntouched, Vt._15(n, 41).ngClassTouched, Vt._15(n, 41).ngClassPristine, Vt._15(n, 41).ngClassDirty, Vt._15(n, 41).ngClassValid, Vt._15(n, 41).ngClassInvalid, Vt._15(n, 41).ngClassPending);
        l(n, 49, 0, Vt._24(n, 49, 0, Vt._15(n, 50).transform("confirm")))
      })
    }

    function _t(l) {
      return Vt._25(0, [(l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [
        ["style", "text-align: center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n\n\n"])), (l()(), Vt._3(14, 0, null, null, 39, "ion-content", [
        ["padding", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(17, 0, null, 1, 4, "div", [
        ["style", "text-align: center;width:100%;"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(19, 0, null, null, 1, "qrcode", [
        ["class", "receive-qrocde"],
        ["style", "display:inline-block;"]
      ], null, null, null, vi.b, vi.a)), Vt._2(20, 638976, null, 0, yi.a, [Vt.k], {
        level: [0, "level"],
        qrdata: [1, "qrdata"],
        size: [2, "size"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(23, 0, null, 1, 29, "ul", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(25, 0, null, null, 2, "li", [], null, null, null, null, null)), (l()(), Vt._23(26, null, ["\n            ", "\n        "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(29, 0, null, null, 1, "li", [
        ["class", "bottom-border"]
      ], null, null, null, null, null)), (l()(), Vt._23(30, null, ["\n            ", "\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(32, 0, null, null, 2, "li", [], null, null, null, null, null)), (l()(), Vt._23(33, null, ["\n            ", "\n        "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(36, 0, null, null, 1, "li", [
        ["class", "bottom-border"]
      ], null, null, null, null, null)), (l()(), Vt._23(37, null, ["\n            ", "\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(39, 0, null, null, 2, "li", [], null, null, null, null, null)), (l()(), Vt._23(40, null, ["\n            ", "\n        "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(43, 0, null, null, 1, "li", [
        ["class", "bottom-border"]
      ], null, null, null, null, null)), (l()(), Vt._23(44, null, ["\n            ", "\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(46, 0, null, null, 2, "li", [], null, null, null, null, null)), (l()(), Vt._23(47, null, ["\n            ", "\n        "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(50, 0, null, null, 1, "li", [
        ["class", "bottom-border"]
      ], null, null, null, null, null)), (l()(), Vt._23(51, null, ["\n            ", "\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        l(n, 20, 0, "M", n.component.qrcode, 6e3)
      }, function(l, n) {
        var t = n.component;
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("text-scan-code")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher);
        l(n, 26, 0, Vt._24(n, 26, 0, Vt._15(n, 27).transform("transaction-id")));
        l(n, 30, 0, t.txHash);
        l(n, 33, 0, Vt._24(n, 33, 0, Vt._15(n, 34).transform("transfer-address")));
        l(n, 37, 0, t.toAddress);
        l(n, 40, 0, Vt._24(n, 40, 0, Vt._15(n, 41).transform("text-price")));
        l(n, 44, 0, t.amount);
        l(n, 47, 0, Vt._24(n, 47, 0, Vt._15(n, 48).transform("text-fees")));
        l(n, 51, 0, t.fee)
      })
    }

    function dt(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "li", [], null, null, null, null, null)), (l()(), Vt._23(1, null, ["\n            ", "\n        "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 1, 0, Vt._24(n, 1, 0, Vt._15(n, 2).transform("already-signed-publickey")))
      })
    }

    function ht(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "li", [], null, null, null, null, null)), Vt._2(1, 278528, null, 0, fu.g, [Vt.s, Vt.t, Vt.k, Vt.E], {
        ngClass: [0, "ngClass"]
      }, null), Vt._18(2, {
        "bottom-border": 0
      }), (l()(), Vt._23(3, null, ["\n            ", ".", "\n        "]))], function(l, n) {
        l(n, 1, 0, l(n, 2, 0, n.context.index == n.component.singPublickey.length - 1))
      }, function(l, n) {
        l(n, 3, 0, n.context.index + 1, n.context.$implicit)
      })
    }

    function pt(l) {
      return Vt._25(0, [(l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [
        ["style", "text-align: center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n\n\n"])), (l()(), Vt._3(14, 0, null, null, 39, "ion-content", [
        ["padding", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(17, 0, null, 1, 35, "ul", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(19, 0, null, null, 2, "li", [], null, null, null, null, null)), (l()(), Vt._23(20, null, ["\n            ", "\n        "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(23, 0, null, null, 1, "li", [
        ["class", "bottom-border"]
      ], null, null, null, null, null)), (l()(), Vt._23(24, null, ["\n            ", "\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(26, 0, null, null, 2, "li", [], null, null, null, null, null)), (l()(), Vt._23(27, null, ["\n            ", "\n        "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(30, 0, null, null, 1, "li", [
        ["class", "bottom-border"]
      ], null, null, null, null, null)), (l()(), Vt._23(31, null, ["\n            ", "\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(33, 0, null, null, 2, "li", [], null, null, null, null, null)), (l()(), Vt._23(34, null, ["\n            ", "\n        "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(37, 0, null, null, 1, "li", [
        ["class", "bottom-border"]
      ], null, null, null, null, null)), (l()(), Vt._23(38, null, ["\n            ", "\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(40, 0, null, null, 2, "li", [], null, null, null, null, null)), (l()(), Vt._23(41, null, ["\n            ", "\n        "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(44, 0, null, null, 1, "li", [
        ["class", "bottom-border"]
      ], null, null, null, null, null)), (l()(), Vt._23(45, null, ["\n            ", "\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, dt)), Vt._2(48, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt.Y(16777216, null, null, 1, null, ht)), Vt._2(51, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(55, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(56, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(58, 0, null, null, 3, "button", [
        ["ion-button", ""],
        ["style", "width: 100%"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.nextPage() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(59, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(60, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 48, 0, t.singPublickey.length > 0);
        l(n, 51, 0, t.singPublickey)
      }, function(l, n) {
        var t = n.component;
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("text-tx-details")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher);
        l(n, 20, 0, Vt._24(n, 20, 0, Vt._15(n, 21).transform("transaction-id")));
        l(n, 24, 0, t.txHash);
        l(n, 27, 0, Vt._24(n, 27, 0, Vt._15(n, 28).transform("transfer-address")));
        l(n, 31, 0, t.txDetails.address);
        l(n, 34, 0, Vt._24(n, 34, 0, Vt._15(n, 35).transform("text-price")));
        l(n, 38, 0, t.txDetails.amount);
        l(n, 41, 0, Vt._24(n, 41, 0, Vt._15(n, 42).transform("text-fees")));
        l(n, 45, 0, t.txDetails.fee);
        l(n, 60, 0, Vt._24(n, 60, 0, Vt._15(n, 61).transform("text-next-step")))
      })
    }

    function gt(l) {
      return Vt._25(0, [Vt._21(402653184, 1, {
        tabs: 0
      }), (l()(), Vt._3(1, 0, null, null, 2, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(2, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n\n"]))], null, function(l, n) {
        l(n, 1, 0, Vt._15(n, 2).statusbarPadding, Vt._15(n, 2)._hasRefresher)
      })
    }

    function ft(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 8, "tr", [
        ["class", "item"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(2, 0, null, null, 2, "td", [
        ["class", "left"]
      ], null, null, null, null, null)), (l()(), Vt._23(3, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(6, 0, null, null, 1, "td", [
        ["class", "right"]
      ], null, null, null, null, null)), (l()(), Vt._23(7, null, ["1 : ", ""])), (l()(), Vt._23(-1, null, ["\n            "]))], null, function(l, n) {
        var t = n.component;
        l(n, 3, 0, Vt._24(n, 3, 0, Vt._15(n, 4).transform("text-rate")));
        l(n, 7, 0, t.transfer.rate)
      })
    }

    function mt(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 16, "tr", [
        ["class", "font-size-1"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(2, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(3, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(7, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n                    "])), (l()(), Vt._3(9, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.transfer.payPassword = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(10, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(12, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(13, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "]))], function(l, n) {
        l(n, 10, 0, n.component.transfer.payPassword);
        l(n, 13, 0, "password", Vt._6(1, "", Vt._24(n, 13, 1, Vt._15(n, 14).transform("text-pay-passworld-input")), ""))
      }, function(l, n) {
        l(n, 9, 0, Vt._15(n, 12).ngClassUntouched, Vt._15(n, 12).ngClassTouched, Vt._15(n, 12).ngClassPristine, Vt._15(n, 12).ngClassDirty, Vt._15(n, 12).ngClassValid, Vt._15(n, 12).ngClassInvalid, Vt._15(n, 12).ngClassPending)
      })
    }

    function vt(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 60, "div", [
        ["class", "juzhong"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(2, 0, null, null, 0, "div", [
        ["class", "arrow_mask"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.click_close() && e
        }
        return e
      }, null, null)), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(4, 0, null, null, 55, "div", [
        ["class", "kuang"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(6, 0, null, null, 4, "p", [
        ["class", "pay-box-title"]
      ], null, null, null, null, null)), (l()(), Vt._23(7, null, ["", "\n            "])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._3(9, 0, null, null, 0, "img", [
        ["class", "close"],
        ["src", "./assets/images/icon/icon-close.svg"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.click_close() && e
        }
        return e
      }, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(12, 0, null, null, 38, "table", [
        ["border", "0"],
        ["style", "width: 100%"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(14, 0, null, null, 36, "tbody", [], null, null, null, null, null)), (l()(), Vt._3(15, 0, null, null, 8, "tr", [
        ["class", "item"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(17, 0, null, null, 2, "td", [
        ["class", "left"]
      ], null, null, null, null, null)), (l()(), Vt._23(18, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(21, 0, null, null, 1, "td", [
        ["class", "right1"]
      ], null, null, null, null, null)), (l()(), Vt._23(22, null, ["", ""])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(25, 0, null, null, 8, "tr", [
        ["class", "item"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(27, 0, null, null, 2, "td", [
        ["class", "left"]
      ], null, null, null, null, null)), (l()(), Vt._23(28, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(31, 0, null, null, 1, "td", [
        ["class", "right"]
      ], null, null, null, null, null)), (l()(), Vt._23(32, null, ["", ""])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(35, 0, null, null, 8, "tr", [
        ["class", "item"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(37, 0, null, null, 2, "td", [
        ["class", "left"]
      ], null, null, null, null, null)), (l()(), Vt._23(38, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(41, 0, null, null, 1, "td", [
        ["class", "right"]
      ], null, null, null, null, null)), (l()(), Vt._23(42, null, ["", ""])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, ft)), Vt._2(46, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, mt)), Vt._2(49, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(52, 0, null, null, 6, "div", [
        ["style", "text-align: center"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(54, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.click_button() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(55, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(56, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 46, 0, t.transfer.rate);
        l(n, 49, 0, t.walltype);
        l(n, 55, 0, "")
      }, function(l, n) {
        var t = n.component;
        l(n, 7, 0, Vt._24(n, 7, 0, Vt._15(n, 8).transform("transfer-info")));
        l(n, 18, 0, Vt._24(n, 18, 0, Vt._15(n, 19).transform("transfer-address")));
        l(n, 22, 0, t.toAddress);
        l(n, 28, 0, Vt._24(n, 28, 0, Vt._15(n, 29).transform("text-price")));
        l(n, 32, 0, t.transfer.amount);
        l(n, 38, 0, Vt._24(n, 38, 0, Vt._15(n, 39).transform("text-fees")));
        l(n, 42, 0, t.transfer.fee / t.SELA);
        l(n, 56, 0, Vt._24(n, 56, 0, Vt._15(n, 57).transform("confirm")))
      })
    }

    function yt(l) {
      return Vt._25(0, [(l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [
        ["style", "text-align: center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n\n\n"])), (l()(), Vt._3(14, 0, null, null, 26, "ion-content", [
        ["no-bounce", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(17, 0, null, 1, 22, "ion-list", [], null, null, null, null, null)), Vt._2(18, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(20, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(21, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(25, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(27, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(28, 16384, [
        [1, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(29, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(32, 0, null, 3, 5, "ion-input", [
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.name = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(33, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(35, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(36, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._3(42, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(43, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(45, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.import() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(46, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(47, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        l(n, 33, 0, n.component.name);
        l(n, 36, 0, "text", Vt._6(1, "", Vt._24(n, 36, 1, Vt._15(n, 37).transform("addwallet-walletname-placeholder")), ""));
        l(n, 46, 0, "")
      }, function(l, n) {
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("text-observe-wallte")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher);
        l(n, 29, 0, Vt._24(n, 29, 0, Vt._15(n, 30).transform("addwallet-walletname-title")));
        l(n, 32, 0, Vt._15(n, 35).ngClassUntouched, Vt._15(n, 35).ngClassTouched, Vt._15(n, 35).ngClassPristine, Vt._15(n, 35).ngClassDirty, Vt._15(n, 35).ngClassValid, Vt._15(n, 35).ngClassInvalid, Vt._15(n, 35).ngClassPending);
        l(n, 47, 0, Vt._24(n, 47, 0, Vt._15(n, 48).transform("text-next-step")))
      })
    }

    function bt(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._3(3, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 3, "ion-title", [], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(8, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._3(13, 0, null, null, 20, "ion-content", [
        ["padding", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(14, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(16, 0, null, 1, 16, "ion-list", [], null, null, null, null, null)), Vt._2(17, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(19, 0, null, null, 12, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(20, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(24, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(26, 0, null, 3, 4, "ion-input", [
        ["placeholder", ""],
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.walletname = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(27, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(29, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(30, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(35, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(36, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(38, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.modify() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(39, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(40, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        l(n, 27, 0, n.component.walletname);
        l(n, 30, 0, "text", "");
        l(n, 39, 0, "")
      }, function(l, n) {
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 8, 0, Vt._24(n, 8, 0, Vt._15(n, 9).transform("modify-wallet-name")));
        l(n, 13, 0, Vt._15(n, 14).statusbarPadding, Vt._15(n, 14)._hasRefresher);
        l(n, 26, 0, Vt._15(n, 29).ngClassUntouched, Vt._15(n, 29).ngClassTouched, Vt._15(n, 29).ngClassPristine, Vt._15(n, 29).ngClassDirty, Vt._15(n, 29).ngClassValid, Vt._15(n, 29).ngClassInvalid, Vt._15(n, 29).ngClassPending);
        l(n, 40, 0, Vt._24(n, 40, 0, Vt._15(n, 41).transform("confirm")))
      })
    }

    function kt(l) {
      return Vt._25(0, [(l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [
        ["style", "text-align: center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n\n\n"])), (l()(), Vt._3(14, 0, null, null, 11, "ion-content", [
        ["padding", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(17, 0, null, 1, 7, "div", [
        ["style", "text-align: center;width:100%;"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.copy() && e
        }
        return e
      }, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(19, 0, null, null, 1, "qrcode", [
        ["class", "receive-qrocde"],
        ["style", "display:inline-block;"]
      ], null, null, null, vi.b, vi.a)), Vt._2(20, 638976, null, 0, yi.a, [Vt.k], {
        level: [0, "level"],
        qrdata: [1, "qrdata"],
        size: [2, "size"]
      }, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(22, 0, null, null, 1, "p", [
        ["style", "text-align:left;margin-top: 10px;font-size:1.6em"]
      ], null, null, null, null, null)), (l()(), Vt._23(23, null, ["", ""])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(27, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(28, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(30, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.nextPage() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(31, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(32, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        l(n, 20, 0, "M", n.component.qrcode, 200);
        l(n, 31, 0, "")
      }, function(l, n) {
        var t = n.component;
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("text-check-publickey")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher);
        l(n, 23, 0, t.qrcode);
        l(n, 32, 0, Vt._24(n, 32, 0, Vt._15(n, 33).transform("text-next-step")))
      })
    }

    function xt(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-label", [], null, null, null, null, null)), Vt._2(1, 16384, [
        [13, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(2, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("show-advanced-options")))
      })
    }

    function wt(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "ion-label", [], null, null, null, null, null)), Vt._2(1, 16384, [
        [13, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(2, null, [" ", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("hide-advanced-options")))
      })
    }

    function Ct(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(1, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 16, {
        contentLabel: 0
      }), Vt._21(603979776, 17, {
        _buttons: 1
      }), Vt._21(603979776, 18, {
        _icons: 1
      }), Vt._2(5, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._3(7, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(8, 16384, [
        [16, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(9, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._3(12, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.mnemonicObj.phrasePassword = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(13, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(15, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(16, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n    "]))], function(l, n) {
        l(n, 13, 0, n.component.mnemonicObj.phrasePassword);
        l(n, 16, 0, "password", Vt._6(1, "", Vt._24(n, 16, 1, Vt._15(n, 17).transform("importmnes-optionalpassword-placeholder")), ""))
      }, function(l, n) {
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("importmnes-optionalpassword-title")));
        l(n, 12, 0, Vt._15(n, 15).ngClassUntouched, Vt._15(n, 15).ngClassTouched, Vt._15(n, 15).ngClassPristine, Vt._15(n, 15).ngClassDirty, Vt._15(n, 15).ngClassValid, Vt._15(n, 15).ngClassInvalid, Vt._15(n, 15).ngClassPending)
      })
    }

    function It(l) {
      return Vt._25(0, [(l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n\n\n"])), (l()(), Vt._3(14, 0, null, null, 109, "ion-content", [
        ["padding", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(17, 0, null, 1, 9, "div", [
        ["class", "kuangTextArea"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(19, 0, null, null, 6, "textarea", [
        ["class", "backupWalletTextArea"],
        ["rows", "4"]
      ], [
        [8, "placeholder", 0],
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"],
        [null, "input"],
        [null, "blur"],
        [null, "compositionstart"],
        [null, "compositionend"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("input" === n) {
          e = !1 !== Vt._15(l, 20)._handleInput(t.target.value) && e
        }
        if ("blur" === n) {
          e = !1 !== Vt._15(l, 20).onTouched() && e
        }
        if ("compositionstart" === n) {
          e = !1 !== Vt._15(l, 20)._compositionStart() && e
        }
        if ("compositionend" === n) {
          e = !1 !== Vt._15(l, 20)._compositionEnd(t.target.value) && e
        }
        if ("ngModelChange" === n) {
          e = !1 !== (a.mnemonicObj.mnemonic = t) && e
        }
        return e
      }, null, null)), Vt._2(20, 16384, null, 0, Ut.b, [Vt.E, Vt.k, [2, Ut.a]], null, null), Vt._19(1024, null, Ut.g, function(l) {
        return [l]
      }, [Ut.b]), Vt._2(22, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [2, Ut.g]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(24, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(28, 0, null, 1, 77, "ion-list", [], null, null, null, null, null)), Vt._2(29, 16384, null, 0, Mu.a, [Ga.a, Vt.k, Vt.D, Ha.a, Ua.l, Za.a], null, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(31, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(32, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(36, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(38, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(39, 16384, [
        [1, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(40, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(43, 0, null, 3, 5, "ion-input", [
        ["type", "text"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.mnemonicObj.name = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(44, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(46, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(47, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(51, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(52, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 4, {
        contentLabel: 0
      }), Vt._21(603979776, 5, {
        _buttons: 1
      }), Vt._21(603979776, 6, {
        _icons: 1
      }), Vt._2(56, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(58, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(59, 16384, [
        [4, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(60, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(63, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.mnemonicObj.payPassword = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(64, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(66, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(67, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(71, 0, null, null, 13, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(72, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 7, {
        contentLabel: 0
      }), Vt._21(603979776, 8, {
        _buttons: 1
      }), Vt._21(603979776, 9, {
        _icons: 1
      }), Vt._2(76, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(78, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.mnemonicObj.rePayPassword = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(79, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(81, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(82, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(86, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(87, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 10, {
        contentLabel: 0
      }), Vt._21(603979776, 11, {
        _buttons: 1
      }), Vt._21(603979776, 12, {
        _icons: 1
      }), Vt._2(91, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(93, 0, null, 1, 3, "ion-label", [], null, null, null, null, null)), Vt._2(94, 16384, [
        [10, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(95, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n            "])), (l()(), Vt._3(98, 0, null, 0, 5, "ion-checkbox", [
        ["disabled", "true"]
      ], [
        [2, "checkbox-disabled", null],
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"],
        [null, "click"]
      ], function(l, n, t) {
        var e = !0,
          a = l.component;
        if ("click" === n) {
          e = !1 !== Vt._15(l, 99)._click(t) && e
        }
        if ("ngModelChange" === n) {
          e = !1 !== (a.mnemonicObj.singleAddress = t) && e
        }
        return e
      }, $u.b, $u.a)), Vt._2(99, 1228800, null, 0, Zu.a, [Ga.a, Iu.a, [2, Cu.a], Vt.k, Vt.D], {
        disabled: [0, "disabled"]
      }, null), Vt._19(1024, null, Ut.g, function(l) {
        return [l]
      }, [Zu.a]), Vt._2(101, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [2, Ut.g]
      ], {
        isDisabled: [0, "isDisabled"],
        model: [1, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(103, 16384, null, 0, Ut.i, [Ut.h], null, null), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n\n    "])), (l()(), Vt._3(107, 0, null, 1, 12, "ion-item", [
        ["class", "item item-block"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.toggleShowAdvOpts() && e
        }
        return e
      }, wu.b, wu.a)), Vt._2(108, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(603979776, 13, {
        contentLabel: 0
      }), Vt._21(603979776, 14, {
        _buttons: 1
      }), Vt._21(603979776, 15, {
        _icons: 1
      }), Vt._2(112, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt.Y(16777216, null, 1, 1, null, xt)), Vt._2(115, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt.Y(16777216, null, 1, 1, null, wt)), Vt._2(118, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 2, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n\n    "])), (l()(), Vt.Y(16777216, null, 1, 1, null, Ct)), Vt._2(122, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(125, 0, null, null, 7, "ion-footer", [], null, null, null, null, null)), Vt._2(126, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(128, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.nextPage() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(129, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(130, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 22, 0, t.mnemonicObj.mnemonic);
        l(n, 44, 0, t.mnemonicObj.name);
        l(n, 47, 0, "text", Vt._6(1, "", Vt._24(n, 47, 1, Vt._15(n, 48).transform("addwallet-walletname-placeholder")), ""));
        l(n, 64, 0, t.mnemonicObj.payPassword);
        l(n, 67, 0, "password", Vt._6(1, "", Vt._24(n, 67, 1, Vt._15(n, 68).transform("addwallet-paypassword1-placeholder")), ""));
        l(n, 79, 0, t.mnemonicObj.rePayPassword);
        l(n, 82, 0, "password", Vt._6(1, "", Vt._24(n, 82, 1, Vt._15(n, 83).transform("addwallet-paypassword2-placeholder")), ""));
        l(n, 99, 0, "true");
        l(n, 101, 0, "true", t.mnemonicObj.singleAddress);
        l(n, 115, 0, !t.showAdvOpts);
        l(n, 118, 0, t.showAdvOpts);
        l(n, 122, 0, t.showAdvOpts);
        l(n, 129, 0, "")
      }, function(l, n) {
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("text-mnemonic")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher);
        l(n, 19, 0, Vt._6(1, "", Vt._24(n, 19, 0, Vt._15(n, 25).transform("text-mnemonic-format")), ""), Vt._15(n, 24).ngClassUntouched, Vt._15(n, 24).ngClassTouched, Vt._15(n, 24).ngClassPristine, Vt._15(n, 24).ngClassDirty, Vt._15(n, 24).ngClassValid, Vt._15(n, 24).ngClassInvalid, Vt._15(n, 24).ngClassPending);
        l(n, 40, 0, Vt._24(n, 40, 0, Vt._15(n, 41).transform("addwallet-walletname-title")));
        l(n, 43, 0, Vt._15(n, 46).ngClassUntouched, Vt._15(n, 46).ngClassTouched, Vt._15(n, 46).ngClassPristine, Vt._15(n, 46).ngClassDirty, Vt._15(n, 46).ngClassValid, Vt._15(n, 46).ngClassInvalid, Vt._15(n, 46).ngClassPending);
        l(n, 60, 0, Vt._24(n, 60, 0, Vt._15(n, 61).transform("unlock-paypassword-title")));
        l(n, 63, 0, Vt._15(n, 66).ngClassUntouched, Vt._15(n, 66).ngClassTouched, Vt._15(n, 66).ngClassPristine, Vt._15(n, 66).ngClassDirty, Vt._15(n, 66).ngClassValid, Vt._15(n, 66).ngClassInvalid, Vt._15(n, 66).ngClassPending);
        l(n, 78, 0, Vt._15(n, 81).ngClassUntouched, Vt._15(n, 81).ngClassTouched, Vt._15(n, 81).ngClassPristine, Vt._15(n, 81).ngClassDirty, Vt._15(n, 81).ngClassValid, Vt._15(n, 81).ngClassInvalid, Vt._15(n, 81).ngClassPending);
        l(n, 95, 0, Vt._24(n, 95, 0, Vt._15(n, 96).transform("text-signaddress")));
        l(n, 98, 0, Vt._15(n, 99)._disabled, Vt._15(n, 103).ngClassUntouched, Vt._15(n, 103).ngClassTouched, Vt._15(n, 103).ngClassPristine, Vt._15(n, 103).ngClassDirty, Vt._15(n, 103).ngClassValid, Vt._15(n, 103).ngClassInvalid, Vt._15(n, 103).ngClassPending);
        l(n, 130, 0, Vt._24(n, 130, 0, Vt._15(n, 131).transform("text-next-step")))
      })
    }

    function Pt(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "span", [
        ["style", "font-size: 1.3px"]
      ], null, null, null, null, null)), (l()(), Vt._23(1, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 1, 0, Vt._24(n, 1, 0, Vt._15(n, 2).transform("text-standard-wallte")))
      })
    }

    function St(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "span", [
        ["style", "font-size: 1.3px"]
      ], null, null, null, null, null)), (l()(), Vt._23(1, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], null, function(l, n) {
        l(n, 1, 0, Vt._24(n, 1, 0, Vt._15(n, 2).transform("text-multi-wallte")))
      })
    }

    function Dt(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 18, "ion-item", [
        ["class", "item item-block"]
      ], null, null, null, wu.b, wu.a)), Vt._2(1, 1097728, null, 3, Cu.a, [Iu.a, Ga.a, Vt.k, Vt.D, [2, Pu.a]], null, null), Vt._21(335544320, 1, {
        contentLabel: 0
      }), Vt._21(603979776, 2, {
        _buttons: 1
      }), Vt._21(603979776, 3, {
        _icons: 1
      }), Vt._2(5, 16384, null, 0, Su.a, [], null, null), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._3(7, 0, null, 1, 3, "ion-label", [
        ["stacked", ""]
      ], null, null, null, null, null)), Vt._2(8, 16384, [
        [1, 4]
      ], 0, Du.a, [Ga.a, Vt.k, Vt.D, [8, null],
        [8, ""],
        [8, null],
        [8, null]
      ], null, null), (l()(), Vt._23(9, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n        "])), (l()(), Vt._3(12, 0, null, 3, 5, "ion-input", [
        ["type", "password"]
      ], [
        [2, "ng-untouched", null],
        [2, "ng-touched", null],
        [2, "ng-pristine", null],
        [2, "ng-dirty", null],
        [2, "ng-valid", null],
        [2, "ng-invalid", null],
        [2, "ng-pending", null]
      ], [
        [null, "ngModelChange"]
      ], function(l, n, t) {
        var e = !0;
        if ("ngModelChange" === n) {
          e = !1 !== (l.component.payPassword = t) && e
        }
        return e
      }, Yu.b, Yu.a)), Vt._2(13, 671744, null, 0, Ut.j, [
        [8, null],
        [8, null],
        [8, null],
        [8, null]
      ], {
        model: [0, "model"]
      }, {
        update: "ngModelChange"
      }), Vt._19(2048, null, Ut.h, null, [Ut.j]), Vt._2(15, 16384, null, 0, Ut.i, [Ut.h], null, null), Vt._2(16, 5423104, null, 0, Gu.a, [Ga.a, Ha.a, Iu.a, Ya.a, Vt.k, Vt.D, [2, du.a],
        [2, Cu.a],
        [2, Ut.h], Za.a
      ], {
        type: [0, "type"],
        placeholder: [1, "placeholder"]
      }, null), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 2, ["\n    "]))], function(l, n) {
        l(n, 13, 0, n.component.payPassword);
        l(n, 16, 0, "password", Vt._6(1, "", Vt._24(n, 16, 1, Vt._15(n, 17).transform("unlock-paypassword-placeholder")), ""))
      }, function(l, n) {
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("unlock-paypassword-title")));
        l(n, 12, 0, Vt._15(n, 15).ngClassUntouched, Vt._15(n, 15).ngClassTouched, Vt._15(n, 15).ngClassPristine, Vt._15(n, 15).ngClassDirty, Vt._15(n, 15).ngClassValid, Vt._15(n, 15).ngClassInvalid, Vt._15(n, 15).ngClassPending)
      })
    }

    function Mt(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 4, "span", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                      "])), (l()(), Vt._3(2, 0, null, null, 1, "span", [], null, null, null, null, null)), (l()(), Vt._23(3, null, ["", ""])), (l()(), Vt._23(-1, null, ["\n                        "]))], null, function(l, n) {
        l(n, 3, 0, n.context.$implicit.text)
      })
    }

    function jt(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 20, "div", [
        ["class", "mnemonic"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(2, 0, null, null, 17, "div", [
        ["class", "slide-container"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(4, 0, null, null, 2, "div", [
        ["class", "slide-title"]
      ], null, null, null, null, null)), (l()(), Vt._23(5, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(8, 0, null, null, 10, "div", [
        ["class", "slide-body"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(10, 0, null, null, 7, "div", [
        ["class", "phrase-container"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(12, 0, null, null, 4, "div", [
        ["class", "phrase"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                        "])), (l()(), Vt.Y(16777216, null, null, 1, null, Mt)), Vt._2(15, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "]))], function(l, n) {
        l(n, 15, 0, n.component.mnemonicList)
      }, function(l, n) {
        l(n, 5, 0, Vt._24(n, 5, 0, Vt._15(n, 6).transform("text-mnemonic-prompt")))
      })
    }

    function Wt(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onExport() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(1, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(2, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], function(l, n) {
        l(n, 1, 0, "")
      }, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("text-down")))
      })
    }

    function Ot(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 3, "button", [
        ["full", ""],
        ["ion-button", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.onNext() && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(1, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        full: [0, "full"]
      }, null), (l()(), Vt._23(2, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g])], function(l, n) {
        l(n, 1, 0, "")
      }, function(l, n) {
        l(n, 2, 0, Vt._24(n, 2, 0, Vt._15(n, 3).transform("text-memory")))
      })
    }

    function Nt(l) {
      return Vt._25(0, [(l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n\n\n"])), (l()(), Vt._3(14, 0, null, null, 22, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(17, 0, null, 1, 12, "div", [
        ["class", "coin-info-top-box"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(19, 0, null, null, 0, "img", [
        ["src", "./assets/images/logo-maincolor.svg"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._3(21, 0, null, null, 7, "div", [
        ["style", "font-size: 1.6em;"]
      ], null, null, null, null, null)), (l()(), Vt._23(22, null, ["", "\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, Pt)), Vt._2(24, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt.Y(16777216, null, null, 1, null, St)), Vt._2(27, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt.Y(16777216, null, 1, 1, null, Dt)), Vt._2(32, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt.Y(16777216, null, 1, 1, null, jt)), Vt._2(35, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, 1, ["\n"])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(38, 0, null, null, 8, "ion-footer", [], null, null, null, null, null)), Vt._2(39, 16384, null, 0, Hu.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt.Y(16777216, null, null, 1, null, Wt)), Vt._2(42, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt.Y(16777216, null, null, 1, null, Ot)), Vt._2(45, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 24, 0, "Standard" === t.account.Type);
        l(n, 27, 0, "Multi-Sign" === t.account.Type);
        l(n, 32, 0, t.isShow);
        l(n, 35, 0, !t.isShow);
        l(n, 42, 0, t.isShow);
        l(n, 45, 0, !t.isShow)
      }, function(l, n) {
        var t = n.component;
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("text-export-mnemomic")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher);
        l(n, 22, 0, t.walltename)
      })
    }

    function Tt(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "button", [
        ["ion-button", ""],
        ["outline", ""],
        ["style", "text-transform: none"]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.removeButton(l.context.index, l.context.$implicit) && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(1, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        outline: [0, "outline"]
      }, null), (l()(), Vt._23(2, 0, ["", ""]))], function(l, n) {
        l(n, 1, 0, "")
      }, function(l, n) {
        l(n, 2, 0, n.context.$implicit.text)
      })
    }

    function Lt(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 2, "button", [
        ["ion-button", ""],
        ["outline", ""],
        ["style", "text-transform: none"]
      ], [
        [8, "disabled", 0]
      ], [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.addButton(l.context.index, l.context.$implicit) && e
        }
        return e
      }, Ju.b, Ju.a)), Vt._2(1, 1097728, null, 0, Eu.a, [
        [8, ""], Ga.a, Vt.k, Vt.D
      ], {
        outline: [0, "outline"]
      }, null), (l()(), Vt._23(2, 0, ["", "\n                    "]))], function(l, n) {
        l(n, 1, 0, "")
      }, function(l, n) {
        l(n, 0, 0, n.context.$implicit.selected);
        l(n, 2, 0, n.context.$implicit.text)
      })
    }

    function At(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 7, "div", [], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(2, 0, null, null, 4, "div", [
        ["class", "words"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                        "])), (l()(), Vt.Y(16777216, null, null, 1, null, Lt)), Vt._2(5, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._23(-1, null, ["\n                "]))], function(l, n) {
        l(n, 5, 0, n.component.mnemonicList)
      }, null)
    }

    function Rt(l) {
      return Vt._25(0, [(l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._3(1, 0, null, null, 11, "ion-header", [], null, null, null, null, null)), Vt._2(2, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n\n    "])), (l()(), Vt._3(4, 0, null, null, 7, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(5, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(7, 0, null, 3, 3, "ion-title", [
        ["style", "text-align:center"]
      ], null, null, null, Lu.b, Lu.a)), Vt._2(8, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(9, 0, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._23(-1, null, ["\n\n\n"])), (l()(), Vt._3(14, 0, null, null, 30, "ion-content", [], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(17, 0, null, 1, 26, "div", [
        ["class", "mnemonic-write"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n\n        "])), (l()(), Vt._3(19, 0, null, null, 23, "div", [
        ["class", "slide-container"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._3(21, 0, null, null, 14, "div", [
        ["class", "slide-body"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(23, 0, null, null, 2, "div", [
        ["class", "slide-title"]
      ], null, null, null, null, null)), (l()(), Vt._23(24, null, ["", ""])), Vt._17(131072, Bt.j, [Bt.k, Vt.g]), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._3(27, 0, null, null, 7, "div", [
        ["class", "phrase-container"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._3(29, 0, null, null, 4, "div", [
        ["class", "phrase"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                        "])), (l()(), Vt.Y(16777216, null, null, 1, null, Tt)), Vt._2(32, 802816, null, 0, fu.h, [Vt.M, Vt.J, Vt.s], {
        ngForOf: [0, "ngForOf"]
      }, null), (l()(), Vt._23(-1, null, ["\n                    "])), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n\n            "])), (l()(), Vt._3(37, 0, null, null, 4, "div", [
        ["class", "bottom-phrase"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, ["\n                "])), (l()(), Vt.Y(16777216, null, null, 1, null, At)), Vt._2(40, 16384, null, 0, fu.i, [Vt.M, Vt.J], {
        ngIf: [0, "ngIf"]
      }, null), (l()(), Vt._23(-1, null, ["\n            "])), (l()(), Vt._23(-1, null, ["\n        "])), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 32, 0, t.selectList);
        l(n, 40, 0, !t.selectComplete)
      }, function(l, n) {
        l(n, 4, 0, Vt._15(n, 5)._hidden, Vt._15(n, 5)._sbPadding);
        l(n, 9, 0, Vt._24(n, 9, 0, Vt._15(n, 10).transform("text-mnemonic-check")));
        l(n, 14, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher);
        l(n, 24, 0, Vt._24(n, 24, 0, Vt._15(n, 25).transform("text-mnemonic-prompt2")))
      })
    }

    function Jt(l) {
      return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 10, "ion-header", [], null, null, null, null, null)), Vt._2(1, 16384, null, 0, Ou.a, [Ga.a, Vt.k, Vt.D, [2, Ka.a]], null, null), (l()(), Vt._23(-1, null, ["\n    "])), (l()(), Vt._3(3, 0, null, null, 6, "ion-navbar", [
        ["class", "toolbar"]
      ], [
        [8, "hidden", 0],
        [2, "statusbar-padding", null]
      ], null, null, Nu.b, Nu.a)), Vt._2(4, 49152, null, 0, Tu.a, [Ya.a, [2, Ka.a],
        [2, Ba.a], Ga.a, Vt.k, Vt.D
      ], null, null), (l()(), Vt._23(-1, 3, ["\n        "])), (l()(), Vt._3(6, 0, null, 3, 2, "ion-title", [], null, null, null, Lu.b, Lu.a)), Vt._2(7, 49152, null, 0, Au.a, [Ga.a, Vt.k, Vt.D, [2, Ru.a],
        [2, Tu.a]
      ], null, null), (l()(), Vt._23(-1, 0, ["扫描中……"])), (l()(), Vt._23(-1, 3, ["\n    "])), (l()(), Vt._23(-1, null, ["\n"])), (l()(), Vt._23(-1, null, ["\n\n"])), (l()(), Vt._3(12, 0, null, null, 30, "ion-content", [
        ["no-scroll", ""]
      ], [
        [2, "statusbar-padding", null],
        [2, "has-refresher", null]
      ], null, null, _u.b, _u.a)), Vt._2(13, 278528, null, 0, fu.g, [Vt.s, Vt.t, Vt.k, Vt.E], {
        ngClass: [0, "ngClass"]
      }, null), Vt._18(14, {
        qrscanner: 0
      }), Vt._2(15, 4374528, null, 0, du.a, [Ga.a, Ha.a, Za.a, Vt.k, Vt.D, Ya.a, tu.a, Vt.x, [2, Ka.a],
        [2, Ba.a]
      ], null, null), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(17, 0, null, 1, 3, "div", [], null, null, null, null, null)), Vt._2(18, 278528, null, 0, fu.g, [Vt.s, Vt.t, Vt.k, Vt.E], {
        ngClass: [0, "ngClass"]
      }, null), Vt._18(19, {
        "qrscanner-area": 0
      }), (l()(), Vt._23(-1, null, [" "])), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(22, 0, null, 1, 2, "div", [], null, null, null, null, null)), Vt._2(23, 278528, null, 0, fu.g, [Vt.s, Vt.t, Vt.k, Vt.E], {
        ngClass: [0, "ngClass"]
      }, null), Vt._18(24, {
        "through-line": 0
      }), (l()(), Vt._23(-1, 1, ["\n    "])), (l()(), Vt._3(26, 0, null, 1, 15, "div", [
        ["class", "button-bottom"]
      ], null, null, null, null, null)), (l()(), Vt._23(-1, null, [" "])), (l()(), Vt._3(28, 0, null, null, 5, "button", [
        ["class", "icon-camera"],
        ["ion-fab", ""],
        ["margin-right", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.toggleLight() && e
        }
        return e
      }, xo.b, xo.a)), Vt._2(29, 49152, null, 0, wo.a, [Ga.a, Vt.k, Vt.D], null, null), (l()(), Vt._23(-1, 0, [" "])), (l()(), Vt._3(31, 0, null, 0, 1, "ion-icon", [
        ["name", "flash"],
        ["role", "img"]
      ], [
        [2, "hide", null]
      ], null, null, null, null)), Vt._2(32, 147456, null, 0, zu.a, [Ga.a, Vt.k, Vt.D], {
        name: [0, "name"]
      }, null), (l()(), Vt._23(-1, 0, [" "])), (l()(), Vt._23(-1, null, [" "])), (l()(), Vt._3(35, 0, null, null, 5, "button", [
        ["class", "icon-camera"],
        ["ion-fab", ""]
      ], null, [
        [null, "click"]
      ], function(l, n, t) {
        var e = !0;
        if ("click" === n) {
          e = !1 !== l.component.toggleCamera() && e
        }
        return e
      }, xo.b, xo.a)), Vt._2(36, 49152, null, 0, wo.a, [Ga.a, Vt.k, Vt.D], null, null), (l()(), Vt._23(-1, 0, [" "])), (l()(), Vt._3(38, 0, null, 0, 1, "ion-icon", [
        ["name", "reverse-camera"],
        ["role", "img"]
      ], [
        [2, "hide", null]
      ], null, null, null, null)), Vt._2(39, 147456, null, 0, zu.a, [Ga.a, Vt.k, Vt.D], {
        name: [0, "name"]
      }, null), (l()(), Vt._23(-1, 0, [" "])), (l()(), Vt._23(-1, null, [" "])), (l()(), Vt._23(-1, 1, ["\n"]))], function(l, n) {
        var t = n.component;
        l(n, 13, 0, l(n, 14, 0, t.isShow));
        l(n, 18, 0, l(n, 19, 0, t.isShow));
        l(n, 23, 0, l(n, 24, 0, t.isShow));
        l(n, 32, 0, "flash");
        l(n, 39, 0, "reverse-camera")
      }, function(l, n) {
        l(n, 3, 0, Vt._15(n, 4)._hidden, Vt._15(n, 4)._sbPadding);
        l(n, 12, 0, Vt._15(n, 15).statusbarPadding, Vt._15(n, 15)._hasRefresher);
        l(n, 31, 0, Vt._15(n, 32)._hidden);
        l(n, 38, 0, Vt._15(n, 39)._hidden)
      })
    }
    Object.defineProperty(n, "__esModule", {
      value: !0
    });
    var Et = t(71),
      Vt = t(0),
      Ft = (t(1), t(14), t(163)),
      zt = t(164),
      Kt = t(227),
      Bt = t(11),
      Yt = t(2),
      Gt = {
        welcome: "欢迎使用本应用",
        hello: "你好",
        "get-lang": "获取语言类型",
        "tab-home": "首页",
        "tab-setting": "设置",
        "launcher-create-wallet": "创建钱包",
        "launcher-backup-import": "导入钱包",
        "text-wallet-export": "导出钱包",
        "text-down": "导出钱包",
        "text-wallet-manager": "钱包管理",
        "coin-recent-transfer": "最近转账记录",
        "text-receive": "接收",
        "text-transfer": "转账",
        "text-recharge": "侧链充值",
        "text-withdraw": "主链提现",
        "text-recharge-address": "侧链充值地址",
        "text-withdraw-address": "主链提现地址",
        "text-rate": "汇率",
        "text-memory": "已经记下了",
        "text-memo": "备注",
        "text-information": "说明信息",
        "text-mnemonic": "助记词",
        "text-mnemonic-prompt": "请在纸上抄下您的助记词，助记词丢失您将永远失去自己的钱包",
        "text-mnemonic-prompt2": "请按照顺序点击您的助记词",
        "text-mnemonic-ok": "助记词验证成功",
        "text-mnemonic-prompt3": "助记词错误，请重新录入助记词",
        "text-mnemonic-format": "助记词之间使用空格隔开",
        "text-from-mnemonic": "来自助记词",
        "text-from-keystore": "来自Keystore",
        "text-mnemonic-check": "验证助记词",
        "text-mnemonic-label": "添加助记词密码",
        "text-mnemonic-pwd": "请设置助记词密码",
        "text-mnemonic-repwd": "请再次设置助记词密码",
        "text-password-error": "密码错误",
        "text-coin-list": "币种列表",
        "text-fees-pay": "手续费支付方",
        "text-fees-pay-sender": "我来支付",
        "text-fees-receiver": "对方支付",
        "text-fees": "手续费",
        "text-price": "金额",
        "text-balance": "余额",
        "text-record": "交易记录",
        "text-select-file": "选择文件",
        "text-reselect-file": "重新选择文件",
        "text-select-file-error": "选择文件失败",
        "text-receiver-address": "收款人钱包地址",
        "text-create-address": "我要新地址",
        "text-contacts": "联系人",
        "text-contacts-add": "添加联系人",
        "contacts-name-title": "姓名",
        "contacts-phone-title": "手机",
        "contacts-email-title": "邮箱",
        "contacts-address-title": "钱包地址",
        "contacts-remark-title": "备注",
        "text-contacts-info": "联系人详情",
        "text-manager-address": "地址列表",
        "text-setting": "设置",
        "text-about": "关于我们",
        "text-help": "使用帮助",
        "text-notice": "消息通知",
        "text-remark": "备注",
        "text-add": "添加",
        "addwallet-walletname-title": "钱包名称",
        "addwallet-walletname-placeholder": "设置钱包名称",
        "text-wallet-name-validator": "钱包名不能为空",
        "addwallet-paypassword1-title": "支付密码",
        "addwallet-paypassword1-placeholder": "请设置钱包支付密码",
        "addwallet-paypassword2-placeholder": "请再次设置钱包支付密码",
        "text-pwd-validator": "密码最少8位，建议数字与字母组合",
        "text-repwd-validator": "两次密码不一致",
        "showmnes-optionalpassword1-title": "助记词密码（可选）",
        "showmnes-optionalpassword1-placeholder": "请设置助记词密码",
        "showmnes-optionalpassword2-placeholder": "请重复已输入的助记词密码",
        "importmnes-optionalpassword-title": "助记词密码",
        "importmnes-optionalpassword-placeholder": "请输入当前钱包的助记词密码",
        "importkeystore-keystorepassword-title": "Keystore密码",
        "importkeystore-optionalpassword-placeholder": "请输入Keystore密码",
        "unlock-paypassword-title": "支付密码",
        "unlock-paypassword-placeholder": "请输入当前钱包的支付密码",
        "exportwallet-keystorepassword1-title": "Keystore密码",
        "exportwallet-keystorepassword1-placeholder": "请设置Keystore密码",
        "exportwallet-keystorepassword2-placeholder": "请重复已输入的Keystore密码",
        "updatepaypassword-origin_paypassword1-title": "原支付密码",
        "updatepaypassword-origin_paypassword1-placeholder": "请输入原支付密码",
        "updatepaypassword-paypassword1-title": "新支付密码",
        "updatepaypassword-paypassword1-placeholder": "请设置新的支付密码",
        "updatepaypassword-paypassword2-placeholder": "请重复已输入的新的支付密码",
        "text-pwd": "输入密码",
        "text-wallet-pwd": "请设置私钥文件密码",
        "text-wallet-repwd": "请再次设置私钥文件密码",
        "text-signaddress": "单地址钱包",
        "text-pwd-repeat": "再次输入密码",
        "text-old-pay-password": "请输入原支付密码",
        "reset-pwd-success": "修改密码成功",
        "text-keystore-pwd": "请设置私钥文件密码",
        "text-wallet-create-ok": "钱包创建成功",
        "text-select-key": "请选择私钥文件",
        "text-to-address": "支付地址",
        "text-input-mnemonic": "请输入助记词",
        "text-wait": "正在处理",
        "text-pay-failure": "支付失败",
        "text-pwd-success": "支付成功",
        "text-back-home": "返回首页",
        "text-gesture-pwd": "手势密码",
        "text-language": "语言",
        confirm: "确定",
        confirmTitle: "提示",
        confirmTransaction: "交易已确认",
        confirmSubTitle: "确定要退出钱包吗？<br/>在退出钱包前，请确认已安全备份助记词及可选加密密码。恢复钱包需要助记词及可选加密密码。任何人无法帮助您恢复钱包",
        cancel: "取消",
        "copy-ok": "复制成功",
        "correct-amount": "请输入正确的金额",
        "correct-address": "请输入正确的地址",
        "error-address": "无法解析该地址",
        "error-amount": "您的余额不足",
        "transfer-info": "转账详情",
        "text-payment-confirm": "确认转账",
        "text-did-login": "选择DID登录",
        "transfer-address": "转账地址",
        "send-raw-transaction": "交易已发送",
        "transfer-more": "查看更多交易记录",
        "send-info": "发款方",
        "record-info": "收款方",
        "receive-address": "收款地址",
        "utxo-info": "转入转出详情",
        "utxo-incoming": "交易输入",
        "utxo-incoming-address": "输入地址",
        "utxo-outcoming": "交易输出",
        "utxo-outcoming-address": "输出地址",
        "transaction-price": "交易金额",
        "transaction-time": "确认时间",
        "transaction-id": "交易号",
        "confirm-count": "确认次数",
        "transaction-ok": "交易成功",
        "loader-more": "加载更多",
        "update-ok": "刷新成功",
        Confirmed: "已完成",
        Pending: "确认中",
        Unconfirmed: "未确认",
        "contact-name-notnull": "联系人姓名不能为空",
        "contact-address-notnull": "联系人地址不能为空",
        "contact-address-digits": "不正确的钱包地址",
        "amount-null": "金额不能为空",
        "contact-phone-check": "无效的手机号",
        "text-mnemonic-validator": "助记词必须是12个",
        "wallet-name": "钱包名",
        "text-wallet-info": "钱包详情",
        "wallet-export": "导出钱包",
        "wallet-delete": "删除钱包",
        "text-submit": "确认",
        "wallet-password-reset": "更改支付密码",
        "text-id-my": "我的ID",
        "text-id-create": "创建ID",
        "text-id-import": "导入ID",
        "text-id-not": "您还没有ID，请先新建ID或者导入ID",
        "text-id-reimport": "重新导入ID",
        "text-id-home": "ID中心首页",
        "text-id-home-prompt": "您可以创建多个ID地址，每个ID代表不同的认证身份",
        "text-pwd-please": "请输入密码",
        "text-pwd-rePlease": "请再次输入密码",
        "text-person": "个人",
        "text-company": "企业",
        "text-id-type": "选择认证类型",
        "text-id-import-file": "导入ID文件",
        "text-browsing": "浏览",
        "text-id-manager": "ID管理",
        "text-update-time": "更新时间",
        "text-export": "导出",
        "text-delete": "删除",
        "text-select-all": "全选",
        "text-kyc-certified": "KYC认证",
        "text-name": "姓名",
        "text-identity": "身份证",
        "text-certified-identity": "身份认证",
        "text-certified-card": "银行卡认证",
        "text-certified-phone": "手机认证",
        "text-certified-person": "个人认证",
        "text-certified-company": "企业认证",
        "text-phone": "手机",
        "text-card": "银行卡",
        "text-card-debit": "储蓄卡",
        "text-check-code": "验证码",
        "text-get-check-code": "获取验证码",
        "text-phone-reserve": "预留手机",
        "text-pay": "支付",
        "text-company-name": "企业全称",
        "text-company-legal": "企业法人",
        "text-company-code": "社会信用代码",
        "text-id-app-list-name": "ID应用列表",
        "text-commit-result": "提交结果",
        "text-commit-success": "提交成功",
        "text-commit-wait": "信息已提交，等待认证",
        "text-browsing-failure": "提交失败",
        "text-kyc-result": "认证结果",
        "text-kyc-success": "认证成功",
        "text-kyc-failure": "认证失败",
        "text-kyc-message": "信息如下",
        "show-advanced-options": "显示高级选项",
        "hide-advanced-options": "隐藏高级选项",
        "text-pay-passworld-input": "请输入支付密码",
        "text-passworld-compare": "两次输入内容不一样",
        "text-keystroe-message": "将此文本复制到一个安全的地方（记事本）",
        "text-copy-to-clipboard": "复制到剪贴板",
        "text-copied-to-clipboard": "已复制到剪贴板",
        "text-backup-passworld-input": "请输入私钥文件密码",
        "text-phrase-passworld-input": "请输入助记词密码",
        "import-text-keystroe-message": "将密钥文件复制到文本框",
        "import-text-keystroe-sucess": "导入私钥成功",
        "import-text-world-sucess": "导入助记词成功",
        "text-down-sucess-message": "导出成功",
        "text-down-fail-message": "导出失败",
        "text-down-please-message": "请选择要导出的ID",
        "text-exprot-sucess-message": "导出成功",
        "text-id-chain-prompt1": "您可以将信息写入到ID链，做个有身份的人",
        "text-id-chain-prompt2": "您输入的信息将永久保存到ID链",
        "text-data-chain": "数据上链",
        "text-id-kyc-add": "新增订单",
        "text-id-kyc-check": "查看订单",
        "text-id-kyc-check-operate": "操作记录",
        "text-id-kyc-operation": "操作",
        "text-id-kyc-order-list": "订单列表",
        "text-id-kyc-auth-uncompleted": "认证未完成",
        "text-id-kyc-no-order": "暂无订单",
        "text-id-kyc-import-no-message": "导入内容不能为空",
        "text-id-kyc-import-text-message": "将导入文本复制到文本框",
        "text-id-kyc-import-text-del-message": "删除id成功",
        "text-id-kyc-import-text-del-please-message": "请选择要删除的ID",
        "text-id-kyc-auth-query-timeout": "付费查询失败",
        "text-id-kyc-auth-fee-fail": "付款失败",
        "text-input-please": "请输入",
        "text-debitCard-message-1": "银行卡号不能为空",
        "text-debitCard-message-2": "银行卡号不合法",
        "text-cardNo-message-1": "身份证不能为空",
        "text-cardNo-message-2": "身份证不合法",
        "text-phone-message-1": "手机号不能为空",
        "text-phone-message-2": "手机号不合法",
        "text-sendcode-message-1": "验证码不能为空",
        "text-word-message": "请输入企业全称",
        "text-legalPerson-message": "请输入企业法人",
        "text-registrationN-message": "社会信用代码",
        "text-id-kyc-prompt-title": "确认",
        "text-id-kyc-prompt-password": "输入钱包支付密码",
        Ok: "确定",
        "text-id-kyc-cochain": "上链需要花费",
        "text-id-kyc-china": "上链提交成功",
        "text-Jpush-kyc-message-1": "交易单号为：",
        "text-Jpush-kyc-message-2": "已认证成功，请去订单列表查看",
        "text-data-chain1": "上链中请耐心等待",
        "text-data-chain2": "上链成功",
        "text-exit-message": "再按一次退出应用",
        "text-path-list": "path列表",
        "text-path-deatils": "path详情",
        "add-path": "添加",
        "text-company-path-deatils": "企业详情",
        "text-bankcard-path-deatils": "银行卡详情",
        "path-status": "状态",
        "path-status-no-pay": "未支付",
        "text-identity-path-deatils": "身份证详情",
        "path-status-authing": "认证中",
        "path-status-authed": "认证通过",
        "phone-path-deatils": "手机认证详情",
        "text-ela-per-message": "正在同步中，同步完成再用",
        "text-sycn-message": "同步状态",
        "text-language-message": "语言",
        "text-wallte-list": "钱包列表",
        "text-add-wallet": "添加钱包",
        "signature-wallet": "创建多签钱包",
        "text-next-step": "下一步",
        "text-select-type": "选择类型",
        "text-publickey-placeholder": "请输入参与者的公钥",
        "text-add-publickey-title": "添加公钥",
        "text-add-private-title": "添加私钥",
        "text-create-privatekey": "创建种子",
        "text-observe-wallte": "只读钱包",
        "text-import-privatekey": "导入私钥",
        "text-import-privatekey-des": "输入Private Key文件内容至输入框。请留意字符大小写",
        "text-import-privatekey-placeholder": "输入明文私钥",
        "text-check-publickey": "查看公钥",
        "text-send-tx": "发送交易",
        "text-sing-tx": "签名交易",
        "text-scan-code": "查看二维码",
        "text-tx-details": "交易详情",
        "text-multi-title1": "拥有者数量",
        "text-multi-title2": "签名数量",
        "text-multi-error": "签名数不能大于拥有者数量",
        "text-delete-contact-confirm": "确定要删除吗？",
        "click-to-load-more": "点击加载更多",
        "error-10000": "(ERR-10000)Action参数Json格式错误",
        "error-10001": "(ERR-10001)Action参数错误",
        "error-10002": "(ERR-10002)无效主钱包",
        "error-10003": "(ERR-10003)无效子钱包",
        "error-10004": "(ERR-10004)创建主钱包错误",
        "error-10005": "(ERR-10005)创建子钱包错误",
        "error-10006": "(ERR-10006)恢复子钱包错误",
        "error-10007": "(ERR-10007)无效的钱包管理器",
        "error-10008": "(ERR-10008)Keystore导入钱包错误",
        "error-10009": "(ERR-10009)助记词导入钱包错误",
        "error-10010": "(ERR-10010)子钱包实例错误",
        "error-10011": "(ERR-10011)无效DID管理器",
        "error-10012": "(ERR-10012)无效DID",
        "error-10013": "(ERR-10013)Action无效",
        "error-20000": "(ERR-20000)SPV未收集异常",
        "error-20001": "(ERR-20001)无效参数",
        "error-20002": "(ERR-20002)无效密码",
        "error-20003": "(ERR-20003)密码错误",
        "error-20004": "(ERR-20004)无效ID",
        "error-20005": "(ERR-20005)SPV创建主钱包错误",
        "error-20006": "(ERR-20006)SPV创建子钱包错误",
        "error-20007": "(ERR-20007)解析JSON数组错误",
        "error-20008": "(ERR-20008)无效助记词",
        "error-20009": "(ERR-20009)公钥格式错误",
        "error-20010": "(ERR-20010)公钥长度错误",
        "error-20011": "(ERR-20011)侧链充值参数错误",
        "error-20012": "(ERR-20012)侧链提现参数错误",
        "error-20013": "(ERR-20013)创建交易过大",
        "error-20014": "(ERR-20014)创建交易错误",
        "error-20015": "(ERR-20015)交易错误",
        "error-20016": "(ERR-20016)目录不存在",
        "error-20017": "(ERR-20017)注册ID payload错误",
        "error-20018": "(ERR-20018)数据库操作错误",
        "error-20019": "(ERR-20019)衍生purpose错误",
        "error-20020": "(ERR-20020)错误账户类型",
        "error-20021": "(ERR-20021)错误网络类型",
        "error-20022": "(ERR-20022)无效币种",
        "error-20023": "(ERR-20023)无当前多签账户",
        "error-20024": "(ERR-20024)多签参与者数量错误",
        "error-20025": "(ERR-20025)多签错误",
        "error-20026": "(ERR-20026)keystore错误",
        "error-20027": "(ERR-20027)limit gap错误",
        "error-20028": "(ERR-20028)私钥错误",
        "error-20029": "(ERR-20029)二进制转字符串错误",
        "error-20030": "(ERR-20030)签名类型错误",
        "error-20031": "(ERR-20031)地址错误",
        "error-20032": "(ERR-20032)签名错误",
        "error-20035": "(ERR-20035)余额不足",
        "modify-wallet-name": "修改钱包名字",
        "load-more": "加载更多",
        "txinfo-receive-amount": "接收金额",
        "txinfo-send-amount": "发送金额",
        "txinfo-receive-addr": "接收地址",
        "txinfo-send-addr": "发送地址",
        "no-open-side-chain": "没有打开测链",
        "no-tx-record": "没有交易记录",
        "no-add-contact": "没有添加联系人",
        "suggest-amount": "金额应小于",
        "text-wallet-name-validator1": "钱包名长度超过30字",
        "text-wallet-name-validator2": "钱包名已存在",
        "text-multi-wallte": "(多签钱包)",
        "text-standard-wallte": "(普通钱包)",
        "text-export-mnemomic": "导出助记词",
        "text-export-menmonic-sucess": "助记词验证成功",
        "create-multi-by-mnes": "导入助记词",
        "already-signed-publickey": "已签过的公钥",
        "super-point": "超级节点选举",
        "sign-up-for-election": "报名选举",
        "i-want-to-vote": "我要投票",
        "sing-up": "报名参选",
        "confirmation-of-participation": "确认参选",
        "lock-details": "锁仓详情",
        "input-password": "输入密码",
        "join-vote-list": "节点选举列表",
        "node-information": "节点信息",
        "node-name": "节点名称",
        "node-address": "节点地址",
        "node-declaration": "节点宣言",
        "current-votes": "当前票数",
        "share-voting": "投票占比",
        "country-region": "国家/地区",
        "add-in-list": "加入候选列表",
        "look-over-list": "查看候选列表",
        "please-input-votes": "请输入票数",
        "number-of-votes": "投票数量",
        "maximum-voting-right": "最大表决票权",
        "vote-manage": "选举管理",
        "log-out": "注销",
        "log-out-subTitle": "是否确认注销候选资格？<br/>候选资格一旦注销，所有投票清零且不可恢复。",
        "vote-edit": "编辑",
        "my-vote": "我的投票",
        "electoral-management": "选举管理",
        "please-enter-node-name": "请输入节点名称",
        "please-enter-node-url": "请输入节点官网URL",
        "please-enter-node-declaration": "请输入节点宣言",
        "lock-number": "锁仓数量",
        "remarks-bond": "备注：保证金",
        "I-want-to-vote": "我要投票",
        "voting-rules": "投票规则",
        "voting-rules-text-1": "参与ELA超级节点投票，需锁仓ELA。投票不消耗ELA数量;",
        "voting-rules-text-2": "每次投票最多可选择 30 个超级节点，撤销或更改再次投票生效有一定的延迟。;",
        "change-vote": "变更投票",
        "last-voting-record": "上次投票纪录",
        "this-vote": "本次投票",
        "please-wallet-address": "请输入钱包地址",
        "proportion-of-voting": "全网投票占比",
        "present-quorum-votes": "当前票数",
        "number-of-voting-addresses": "投票地址数量",
        about: "关于",
        Version: "版本号",
        "my-publickey": "我的公钥"
      },
      Ht = {
        welcome: "Welcome!",
        hello: "Hello!",
        "get-lang": "s_get_Lang",
        "tab-home": "Home",
        "tab-setting": "Settings",
        "launcher-create-wallet": "Create Wallet",
        "launcher-backup-import": "Import Wallet",
        "text-wallet-export": "Export Wallet",
        "text-down": "backup wallet",
        "text-wallet-manager": "Wallet Setting",
        "coin-recent-transfer": "Recent Transfers",
        "text-receive": "Receive",
        "text-transfer": "Send",
        "text-recharge": "Recharge",
        "text-withdraw": "Withdraw",
        "text-recharge-address": "Withdraw to (Address)",
        "text-withdraw-address": "Recharge From (Address)",
        "text-rate": "Exchange Rage",
        "text-memory": "I have written it down",
        "text-memo": "Memo",
        "text-information": "s_info",
        "text-mnemonic": "Backup Phrase",
        "text-mnemonic-prompt": "Please carefully write down this phrase",
        "text-mnemonic-prompt2": "Please tap each word in the correct order",
        "text-mnemonic-ok": "Mnemonics Verified",
        "text-mnemonic-prompt3": "Backup phrase or password incorrectly, Please review your backup and try again.",
        "text-mnemonic-format": "Spaces are required between characters",
        "text-from-mnemonic": "from Mnemonics",
        "text-from-keystore": "from KeyStore",
        "text-mnemonic-check": "Mnemonics Verification",
        "text-mnemonic-label": "Add Optional Password",
        "text-mnemonic-pwd": "Set Mnemonic Password",
        "text-mnemonic-repwd": "Repeat Mnemonic Password",
        "text-password-error": "Wrong Password",
        "text-coin-list": "Coin List",
        "text-fees-pay": "transaction fee payer",
        "text-fees-pay-sender": "transaction fee excluded",
        "text-fees-receiver": "transaction fee included",
        "text-fees": "Transaction fee",
        "text-price": "Amount",
        "text-balance": "Balance",
        "text-record": "Transaction records",
        "text-select-file": "Select file",
        "text-reselect-file": "Reselect file",
        "text-select-file-error": "File error",
        "text-receiver-address": "Target Address",
        "text-create-address": "Get new address",
        "text-contacts": "Contacts",
        "text-contacts-add": "Add contacts",
        "contacts-name-title": "Name",
        "contacts-phone-title": "Phone Number",
        "contacts-email-title": "Email Address",
        "contacts-address-title": "Wallet Address",
        "contacts-remark-title": "Remark",
        "text-contacts-info": "Contacts Information",
        "text-manager-address": "Wallet Addresses",
        "text-setting": "Settings",
        "text-about": "About",
        "text-help": "Help",
        "text-notice": "Notification",
        "text-remark": "Remark",
        "text-add": "Add",
        "addwallet-walletname-title": "Wallet Name",
        "addwallet-walletname-placeholder": "Set an alias for this wallet",
        "text-wallet-name-validator": "Wallet name can not be empty",
        "addwallet-paypassword1-title": "Pay Password",
        "addwallet-paypassword1-placeholder": "Set Pay Password",
        "addwallet-paypassword2-placeholder": "Repeat Pay Password",
        "text-pwd-validator": "the length must be 8 or more characters, a mix of letters and numbers are bettter",
        "text-repwd-validator": "password do not match",
        "showmnes-optionalpassword1-title": "Mnemonic Optional Passphrase",
        "showmnes-optionalpassword1-placeholder": "Set an optional passphrase for your mnemonics",
        "showmnes-optionalpassword2-placeholder": "Repeat the optional passphrase you set",
        "importmnes-optionalpassword-title": "Mnemonic Optional Passphrase",
        "importmnes-optionalpassword-placeholder": "Enter the optional passphrase of your mnemonics",
        "importkeystore-keystorepassword-title": "Keystore Password",
        "importkeystore-optionalpassword-placeholder": "Enter the password of the keystore you entered above",
        "unlock-paypassword-title": "Pay Password",
        "unlock-paypassword-placeholder": "Enter the pay password of current wallet",
        "exportwallet-keystorepassword1-title": "Keystore Password",
        "exportwallet-keystorepassword1-placeholder": "Set a Keystore password for your wallet",
        "exportwallet-keystorepassword2-placeholder": "Repeat the Keystore password you set",
        "updatepaypassword-origin_paypassword1-title": "Original Pay Password",
        "updatepaypassword-origin_paypassword1-placeholder": "Enter the original pay password of current wallet",
        "updatepaypassword-paypassword1-title": "New Pay Password",
        "updatepaypassword-paypassword1-placeholder": "Set a new pay password for your wallet",
        "updatepaypassword-paypassword2-placeholder": "Repeat the new pay password you set",
        "text-pwd": "Input Password",
        "text-wallet-pwd": "Set SecretKey Password",
        "text-wallet-repwd": "Repeat SecretKey Password",
        "text-signaddress": "Single Address Wallet",
        "text-pwd-repeat": "Repeat Password",
        "text-old-pay-password": "Input Original Pay Password",
        "reset-pwd-success": "Password Updated Successfully",
        "text-keystore-pwd": "Set KeyStore Password",
        "text-wallet-create-ok": "Wallet Created and Backuped",
        "text-select-key": "Select SecretKey File",
        "text-to-address": "Target Address",
        "text-input-mnemonic": "Type in Mnemonics",
        "text-wait": "Processing",
        "text-pay-failure": "Payment Failed",
        "text-pwd-success": "Payment Sent",
        "text-back-home": "Back to Home Page",
        "text-gesture-pwd": "Guesture Password",
        "text-language": "Language",
        confirm: "Confirm",
        confirmTitle: "confirm",
        confirmTransaction: "Transaction Confirmed",
        confirmSubTitle: "Are you sure you want to log out this wallet? <br/>Before logging out, confirm that you have recorded your backup phrase and optional passphrase securely.To restore your account, both the backup phrase and optional passphrase will be required.Nobody can assist in restoring your account.",
        cancel: "Cancel",
        "copy-ok": "Copied to Clipboard",
        "correct-amount": "Wrong Amount",
        "correct-address": "Wrong Address",
        "error-address": "Address Error",
        "error-amount": "Amount Error",
        "transfer-info": "Transfer Info",
        "text-payment-confirm": "Confirm Payment",
        "text-did-login": "select DID",
        "transfer-address": "transfer address",
        "send-raw-transaction": "transfer sent_",
        "transfer-more": "transfer Info",
        "send-info": "sender",
        "record-info": "receiver",
        "receive-address": "receive address",
        "utxo-info": "tx information",
        "utxo-incoming": "tx input",
        "utxo-incoming-address": "input address",
        "utxo-outcoming": "tx output",
        "utxo-outcoming-address": "output address",
        "transaction-price": "tx amount",
        "transaction-time": "confirm time",
        "transaction-id": "tx id",
        "confirm-count": "confirm count",
        "transaction-ok": "tx success",
        "loader-more": "load more",
        "update-ok": "updated",
        Confirmed: "complete",
        Pending: "pending",
        Unconfirmed: "unconfirmed",
        "contact-name-notnull": "contacts name empty",
        "contact-address-notnull": "contacts address empty",
        "contact-address-digits": "wrong wallet address",
        "amount-null": "amount empty",
        "contact-phone-check": "invalid phone number",
        "text-mnemonic-validator": "mnemonics is 12 word phrase",
        "wallet-name": "Wallet Name",
        "text-wallet-info": "wallet information",
        "wallet-export": "Export Wallet",
        "wallet-delete": "Delete Wallet",
        "text-submit": "submit",
        "wallet-password-reset": "Change Payment Password",
        "text-id-my": "my ID",
        "text-id-create": "create ID",
        "text-id-import": "import ID",
        "text-id-not": "ID not found, please create an ID or import one",
        "text-id-reimport": "reimport ID",
        "text-id-home": "ID Home",
        "text-id-home-prompt": "multiple ID address are allowed to create representing multiple authentication",
        "text-pwd-please": "please input password",
        "text-pwd-rePlease": "please repeat password",
        "text-person": "personal",
        "text-company": "corporate",
        "text-id-type": "ID type",
        "text-id-import-file": "import ID file",
        "text-browsing": "browsing",
        "text-id-manager": "ID management",
        "text-update-time": "update time",
        "text-export": "export",
        "text-delete": "delete",
        "text-select-all": "select all",
        "text-kyc-certified": "KYC",
        "text-name": "name",
        "text-identity": "Personal ID Number",
        "text-certified-identity": "ID authentication",
        "text-certified-card": "bank card authentication",
        "text-certified-phone": "mobile phone authenticaiton",
        "text-certified-person": "personal authentication",
        "text-certified-company": "corporate authentication",
        "text-phone": "mobile phone number",
        "text-card": "bank card number",
        "text-card-debit": "debit card number",
        "text-check-code": "verification code",
        "text-get-check-code": "get verification code",
        "text-phone-reserve": "bank reserved phone number",
        "text-pay": "pay",
        "text-company-name": "company name",
        "text-company-legal": "enterprise legal person",
        "text-company-code": "social credit code",
        "text-id-app-list-name": "ID app list",
        "text-commit-result": "commit result",
        "text-commit-success": "commit success",
        "text-commit-wait": "wait for approvement",
        "text-browsing-failure": "commit failed",
        "text-kyc-result": "kyc result",
        "text-kyc-success": "kyc success",
        "text-kyc-failure": "kyc failed",
        "text-kyc-message": "kyc message",
        "show-advanced-options": "show advanced option",
        "hide-advanced-options": "hide advanced option",
        "text-pay-passworld-input": "input paypassword",
        "text-passworld-compare": "inconformity password",
        "text-keystroe-message": "please save keystore properly",
        "text-copy-to-clipboard": "copy to Clipboard",
        "text-copied-to-clipboard": "copied to Clipboard",
        "text-backup-passworld-input": "input SecretKey Password",
        "text-phrase-passworld-input": "input Mnemonics Password",
        "import-text-keystroe-message": "Paste keystore text in",
        "import-text-keystroe-sucess": "Wallet imported from SecretKey ",
        "import-text-world-sucess": "Wallet imported from Mnemonics",
        "text-down-sucess-message": "Export Successfully",
        "text-down-fail-message": "Export Failed",
        "text-down-please-message": "select ID to export",
        "text-exprot-sucess-message": "export successfully",
        "text-id-chain-prompt1": "write your information to id chain",
        "text-id-chain-prompt2": "your info will store to id chain permenently",
        "text-data-chain": "data update to chain",
        "text-id-kyc-add": "add",
        "text-id-kyc-check": "view",
        "text-id-kyc-check-operate": "opration history",
        "text-id-kyc-operation": "oprate",
        "text-id-kyc-order-list": "order list",
        "text-id-kyc-auth-uncompleted": "authentication unfinished",
        "text-id-kyc-no-order": "no order yet",
        "text-id-kyc-import-no-message": "import content empty",
        "text-id-kyc-import-text-message": "import text copy to textfield",
        "text-id-kyc-import-text-del-message": "id deleted",
        "text-id-kyc-import-text-del-please-message": "select ID to delete",
        "text-id-kyc-auth-query-timeout": "auth query timeout",
        "text-id-kyc-auth-fee-fail": "auth fee fail",
        "text-input-please": "please input",
        "text-debitCard-message-1": "debit card number empty",
        "text-debitCard-message-2": "debit card number invalid",
        "text-cardNo-message-1": "id card number empty",
        "text-cardNo-message-2": "id card number invalid",
        "text-phone-message-1": "mobile phone number empty",
        "text-phone-message-2": "mobile phone number invalid",
        "text-sendcode-message-1": "verification code empty",
        "text-word-message": "type in enterprise name",
        "text-legalPerson-message": "type in enterprise legal person",
        "text-registrationN-message": "social credit code",
        "text-id-kyc-prompt-title": "Confirm",
        "text-id-kyc-prompt-password": "input wallet pay password",
        Ok: "Confirm",
        "text-id-kyc-cochain": "need service fee",
        "text-id-kyc-china": "submit success",
        "text-Jpush-kyc-message-1": "Tx. No.",
        "text-Jpush-kyc-message-2": "auth success check at order list",
        "text-data-chain1": "please wait",
        "text-data-chain2": "success",
        "text-exit-message": "repeat to exit application",
        "text-path-list": "path list",
        "text-path-deatils": "path details",
        "add-path": "add",
        "text-company-path-deatils": "company details",
        "text-bankcard-path-deatils": "bank card details",
        "path-status": "status",
        "path-status-no-pay": "unpaid",
        "text-identity-path-deatils": "id details",
        "path-status-authing": "authenticating",
        "path-status-authed": "authenticated",
        "phone-path-deatils": "mobile authentication detail",
        "text-ela-per-message": "Synchronizing, Please Wait",
        "text-sycn-message": "Sync Status",
        "text-language-message": "Language",
        "text-wallte-list": "Wallet List",
        "text-add-wallet": "Add Wallet",
        "signature-wallet": "Create Multi-sign wallet",
        "text-next-step": "Next Step",
        "text-select-type": "Select Type",
        "text-publickey-placeholder": "Input Public Key of Participants",
        "text-add-publickey-title": "Add Public Key",
        "text-add-private-title": "Add Private Key",
        "text-create-privatekey": "Create a new seed",
        "text-observe-wallte": "Observer wallet (Public Key Only)",
        "text-import-privatekey": "Import Private Key",
        "text-import-privatekey-des": "Input Private Key Text",
        "text-import-privatekey-placeholder": "Input Privkey",
        "text-check-publickey": "Check Public Key",
        "text-send-tx": "Send transaction",
        "text-sing-tx": "Sign transaction",
        "text-scan-code": "Scan QR Code",
        "text-tx-details": "Transaction Details",
        "text-multi-title1": "Total number of owners",
        "text-multi-title2": "Required number of signatures",
        "text-multi-error": "Number of signatures should less than number of public-keys",
        "text-delete-contact-confirm": "Delete this contact ?",
        "click-to-load-more": "click to load more",
        "error-10000": "(ERR-10000)Json parse error of action parameters",
        "error-10001": "(ERR-10001)Parameters error of action",
        "error-10002": "(ERR-10002)Invalid master wallet",
        "error-10003": "(ERR-10003)Invalid sub wallet",
        "error-10004": "(ERR-10004)Create master wallet error",
        "error-10005": "(ERR-10005)Create sub wallet error",
        "error-10006": "(ERR-10006)Recover sub wallet error",
        "error-10007": "(ERR-10007)Invalid master wallet manager",
        "error-10008": "(ERR-10008)Import wallet with keystore error",
        "error-10009": "(ERR-10009)Import wallet with mnemonic error",
        "error-10010": "(ERR-10010)Instance of sub wallet error",
        "error-10011": "(ERR-10011)Invalid DID manager",
        "error-10012": "(ERR-10012)Invalid DID",
        "error-10013": "(ERR-10013)Invalid action",
        "error-20000": "(ERR-20000)SPV other exception",
        "error-20001": "(ERR-20001)Invalid parameters",
        "error-20002": "(ERR-20002)Invalid password",
        "error-20003": "(ERR-20003)Wrong password",
        "error-20004": "(ERR-20004)ID not found",
        "error-20005": "(ERR-20005)SPV create master wallet error",
        "error-20006": "(ERR-20006)SPV create sub wallet error",
        "error-20007": "(ERR-20007)Parse json array error",
        "error-20008": "(ERR-20008)Invalid mnemonic",
        "error-20009": "(ERR-20009)Public key format error",
        "error-20010": "(ERR-20010)Public key length error",
        "error-20011": "(ERR-20011)Side chain deposit parameters error",
        "error-20012": "(ERR-20012)Side chain withdraw parameters error",
        "error-20013": "(ERR-20013)Tx size too large",
        "error-20014": "(ERR-20014)Create tx error",
        "error-20015": "(ERR-20015)Invalid tx",
        "error-20016": "(ERR-20016)Path do not exist",
        "error-20017": "(ERR-20017)Register ID payload error",
        "error-20018": "(ERR-20018)Sqlite error",
        "error-20019": "(ERR-20019)Derive purpose error",
        "error-20020": "(ERR-20020)Wrong account type",
        "error-20021": "(ERR-20021)Wrong net type",
        "error-20022": "(ERR-20022)Invalid coin type",
        "error-20023": "(ERR-20023)No current multi sign account",
        "error-20024": "(ERR-20024)Cosigner count error",
        "error-20025": "(ERR-20025)Multi sign error",
        "error-20026": "(ERR-20026)Key store error",
        "error-20027": "(ERR-20027)Limit gap error",
        "error-20028": "(ERR-20028)Key error",
        "error-20029": "(ERR-20029)Hex to string error",
        "error-20030": "(ERR-20030)Sign type error",
        "error-20031": "(ERR-20031)Address error",
        "error-20032": "(ERR-20032)Sign error",
        "error-20035": "(ERR-20035)Balance is not enough",
        "modify-wallet-name": "Editt Wallet Name",
        "load-more": "Load More",
        "txinfo-receive-amount": "Receive Amount",
        "txinfo-send-amount": "Send Amount",
        "txinfo-receive-addr": "Receive Address",
        "txinfo-send-addr": "Send Address",
        "no-open-side-chain": "Sidechain not opened",
        "no-tx-record": "No transaction record",
        "no-add-contact": "No Contact Added",
        "suggest-amount": "amount should less than",
        "text-wallet-name-validator1": "Wallet Name with more than 30 characters",
        "text-wallet-name-validator2": "Wallet Name exist",
        "text-multi-wallte": "(Multi-Sign Wallet)",
        "text-standard-wallte": "(Standard Wallet)",
        "text-export-mnemomic": "Backup Mnemomics",
        "text-export-menmonic-sucess": "Check Mnemonics Success",
        "create-multi-by-mnes": "Use Existing Seed (Import Mnemonics) ",
        "already-signed-publickey": "already singed publickey",
        "super-point": "super node election",
        "sign-up-for-election": "sing up for election",
        "i-want-to-vote": "i want to vote",
        "sing-up": "sing up",
        "confirmation-of-participation": "confirmation of participation",
        "lock-details": "lock details",
        "input-password": "input password",
        "join-vote-list": "join vote list",
        "node-information": "node information",
        "node-name": "node name",
        "node-address": "node address",
        "node-declaration": "node declaration",
        "current-votes": "current votes",
        "share-voting": "share voting",
        "country-region": "country / region",
        "add-in-list": "add in list",
        "look-over-list": "look over list",
        "please-input-votes": "please input votes",
        "number-of-votes": "number of votes",
        "maximum-voting-right": "maximum voting right",
        "vote-manage": "vote manage",
        "log-out": "log out",
        "log-out-subTitle": "Do you confirm the cancellation of candidature？<br/>Once the candidature is cancelled, all polls are cleared and cannot be resumed。",
        "vote-edit": "edit",
        "my-vote": "my vote",
        "electoral-management": "electoral management",
        "please-enter-node-name": "please enter node name",
        "please-enter-node-url": "please enter node url",
        "please-enter-node-declaration": "please enter node declaration",
        "lock-number": "lock number",
        "remarks-bond": "remarks:bond",
        "I-want-to-vote": "I want to vote",
        "voting-rules": "voting rules",
        "voting-rules-text-1": "To participate in ELA super node voting, we need to lock ELA. Voting does not consume ELA;",
        "voting-rules-text-2": "Up to 30 super nodes can be selected for each vote, and there is a certain delay in voting for revocation or change. ;",
        "change-vote": "change vote",
        "last-voting-record": "last voting record",
        "this-vote": "this vote",
        "please-wallet-address": "please enter the wallet address",
        "proportion-of-voting": "Proportion of voting",
        "present-quorum-votes": "present quorum votes",
        "number-of-voting-addresses": "number of voting addresses",
        about: "About",
        Version: "Version",
        "my-publickey": "my publickey"
      },
      Ut = (t(735), t(30)),
      qt = t(229),
      $t = t(36),
      Zt = function() {
        function l(l) {
          this.storage = l
        }
        return l.prototype.add = function(l, n) {
          var t = this;
          return this.get(l).then(function(e) {
            var a = n.id;
            if (null === e) {
              var u = {};
              return u[a] = n, t.storage.set(l, JSON.stringify(u))
            }
            var i = JSON.parse(e);
            return i[a] = n, t.storage.set(l, JSON.stringify(i))
          })
        }, l.prototype.set = function(l, n) {
          return this.storage.set(l, JSON.stringify(n))
        }, l.prototype.get = function(l) {
          return this.storage.get(l)
        }, l.prototype.getSeqNumObj = function(l, n, t, e) {
          console.info("ElastosJs localstorage getSeqNumObj begin sign " + l + " id " + n + " authType " + t), this.get("kycId").then(function(a) {
            var u = JSON.parse(a);
            console.info("ElastosJs getSeqNumObj total     valObj " + JSON.stringify(u));
            var i, s = u[n];
            if (s && s[t]) {
              var o = s[t];
              console.info("ElastosJs localstorage getSeqNumObj order " + JSON.stringify(o));
              for (var r in o) o[r].adata && o[r].adata.forEach(function(n) {
                n && n.resultSign && (console.info('ElastosJs value["retdata"] ' + JSON.stringify(n.retdata)), l == n.resultSign && (i = o[r], console.info("ElastosJs localstorage getSeqNumObj ok  seqNumObj " + JSON.stringify(i))))
              })
            }
            e(i)
          })
        }, l.prototype.remove = function(l) {
          return this.storage.remove(l)
        }, l.prototype.clear = function() {
          return this.storage.clear()
        }, l.prototype.setWallet = function(l) {
          return this.storage.set("ELA-Wallet", JSON.stringify(l))
        }, l.prototype.getWallet = function() {
          return this.storage.get("ELA-Wallet")
        }, l.prototype.addKyc = function(l, n) {
          return this.storage.set(l, JSON.stringify(n))
        }, l.prototype.getKycList = function(l) {
          return this.storage.get(l)
        }, l.prototype.getLanguage = function(l) {
          return this.storage.get(l)
        }, l.prototype.saveCurMasterId = function(l) {
          return this.storage.set("cur-masterId", JSON.stringify(l))
        }, l.prototype.getCurMasterId = function() {
          return this.storage.get("cur-masterId")
        }, l.prototype.saveMappingTable = function(l) {
          return this.add("map-table", l)
        }, l.prototype.getMappingTable = function() {
          return this.storage.get("map-table")
        }, l.prototype.setProgress = function(l) {
          this.storage.set("map-Progress", JSON.stringify(l))
        }, l.prototype.getProgress = function() {
          return this.storage.get("map-Progress")
        }, l
      }(),
      Qt = t(214),
      Xt = t(396),
      le = function() {
        function l() {}
        return l.prototype.idsDownload = function(l, n) {
          var t = this;
          return new Promise(function(e, a) {
            t._download(l, n).then(function() {
              return e()
            })
          })
        }, l.prototype._download = function(l, n) {
          var t = this;
          return new Promise(function(e, a) {
            var u = document.createElement("a"),
              i = t.NewBlob(l, "text/plain;charset=utf-8"),
              s = window.URL.createObjectURL(i);
            return document.body.appendChild(u), u.href = s, u.download = n, u.click(), window.URL.revokeObjectURL(s), e()
          })
        }, l.prototype.NewBlob = function(l, n) {
          var t;
          try {
            t = new Blob([l], {
              type: n
            })
          } catch (e) {
            "InvalidStateError" == e.name && (t = new Blob([l], {
              type: n
            }))
          }
          return t
        }, l
      }(),
      ne = t(215),
      te = t(54),
      ee = function() {
        function l() {
          this.SignSeqNumObjetMap = {}, this.idPathJson = {}, this.kycSignCont = {}
        }
        return l.prototype.addIdPathJson = function(l, n, t) {
          this.idPathJson[l] || (this.idPathJson[l] = {}), console.info("ElastosJs DataManager addIdPathJson Id " + l + " Path" + n + "objJson " + JSON.stringify(t)), this.idPathJson[l][n] || (this.idPathJson[l][n] = []), this.idPathJson[l][n].push(t), console.info("ElastosJs DataManager addIdPathJson end Id " + l + " Path" + n + "objJson " + JSON.stringify(t))
        }, l.prototype.getIdPathJson = function(l, n) {
          var t = {};
          return console.info("ElastosJs DataManager getIdPathJson begin Id " + l + " Path" + n), this.idPathJson[l] && (t = this.idPathJson[l][n]), console.info("ElastosJs DataManager getIdPathJson end jsonObj " + JSON.stringify(t)), t
        }, l.prototype.OutPutIDJson = function(l, n, t) {
          var e = {},
            a = this.getIdPathJson(l, n),
            u = this.getSignCont(t);
          return e.Id = l, e.Path = n, e.SignContent = u, e.DataHash = a, console.info("Elastjs OutPutIDJson " + JSON.stringify(e)), e
        }, l.prototype.addSignCont = function(l, n) {
          console.info("ElastosJs DataManager addSignCont sign " + l + "cont " + JSON.stringify(n)), this.kycSignCont[l] = n
        }, l.prototype.getSignCont = function(l) {
          return console.info("ElastosJs DataManager getSignCont sign " + l + "obj " + JSON.stringify(this.kycSignCont[l])), this.kycSignCont[l]
        }, l.prototype.addSeqNumObj = function(l, n) {
          console.info("ElastosJs DataManager addSeqNumObj sign " + l + "obj " + JSON.stringify(n)), this.SignSeqNumObjetMap[l] = n
        }, l.prototype.getSeqNumObj = function(l) {
          return console.info("ElastosJs DataManager getSeqNumObj sign " + l + "obj " + JSON.stringify(this.SignSeqNumObjetMap[l])), this.SignSeqNumObjetMap[l]
        }, l
      }(),
      ae = t(165),
      ue = t(4),
      ie = t(31),
      se = function() {
        function l(l, n, t) {
          this.native = l, this.event = n, this.popupProvider = t, this.wallet = cordova.plugins.Wallet
        }
        return n = l, l.prototype.createSubWallet = function(l, n, t, e) {
          var a = this;
          this.wallet.createSubWallet([l, n, t], e, function(l) {
            a.errorFun(l)
          })
        }, l.prototype.recoverSubWallet = function(l, n, t, e, a) {
          var u = this;
          this.wallet.recoverSubWallet([l, n, t, e], a, function(l) {
            u.errorFun(l)
          })
        }, l.prototype.createMasterWallet = function(l, n, t, e, a, u) {
          var i = this;
          this.wallet.createMasterWallet([l, n, t, e, a], u, function(l) {
            i.errorFun(l)
          })
        }, l.prototype.importWalletWithKeystore = function(l, n, t, e, a) {
          var u = this;
          this.wallet.importWalletWithKeystore([l, n, t, e], a, function(l) {
            u.errorFun(l)
          })
        }, l.prototype.importWalletWithMnemonic = function(l, n, t, e, a, u) {
          var i = this;
          this.wallet.importWalletWithMnemonic([l, n, t, e, a], u, function(l) {
            i.errorFun(l)
          })
        }, l.prototype.exportWalletWithKeystore = function(l, n, t, e) {
          var a = this;
          this.wallet.exportWalletWithKeystore([l, n, t], e, function(l) {
            a.errorFun(l)
          })
        }, l.prototype.exportWalletWithMnemonic = function(l, n, t) {
          var e = this;
          this.wallet.exportWalletWithMnemonic([l, n], t, function(l) {
            e.errorFun(l)
          })
        }, l.prototype.getBalance = function(l, n, t) {
          var e = this;
          this.wallet.getBalance([l, n], t, function(l) {
            e.errorFun(l)
          })
        }, l.prototype.createAddress = function(l, n, t) {
          var e = this;
          this.wallet.createAddress([l, n], t, function(l) {
            e.errorFun(l)
          })
        }, l.prototype.getAllAddress = function(l, n, t, e) {
          var a = this;
          this.wallet.getAllAddress([l, n, t, 20], e, function(l) {
            a.errorFun(l)
          })
        }, l.prototype.getBalanceWithAddress = function(l, n, t, e) {
          var a = this;
          this.wallet.getBalanceWithAddress([l, n, t], e, function(l) {
            a.errorFun(l)
          })
        }, l.prototype.createMultiSignTransaction = function(l, n, t, e, a, u, i) {
          var s = this;
          this.wallet.createMultiSignTransaction([l, n, t, e, a, u], i, function(l) {
            s.errorFun(l)
          })
        }, l.prototype.getAllTransaction = function(l, t, e, a, u) {
          var i = this;
          this.wallet.getAllTransaction([l, t, e, n.PAGECOUNT, a], u, function(l) {
            i.errorFun(l)
          })
        }, l.prototype.registerWalletListener = function(l, n, t) {
          var e = this;
          this.wallet.registerWalletListener([l, n], t, function(l) {
            e.errorFun(l)
          })
        }, l.prototype.registerIdListener = function(l, n) {
          var t = this;
          this.wallet.registerIdListener([l], n, function(l) {
            t.errorFun(l)
          })
        }, l.prototype.sign = function(l, n, t, e, a) {
          var u = this;
          this.wallet.sign([l, n, t, e], a, function(l) {
            u.errorFun(l)
          })
        }, l.prototype.checkSign = function(l, n, t, e, a, u) {
          var i = this;
          this.wallet.checkSign([l, n, t, e, a], u, function(l) {
            i.errorFun(l)
          })
        }, l.prototype.destroyWallet = function(l, n) {
          var t = this;
          this.wallet.destroyWallet([l], n, function(l) {
            t.errorFun(l)
          })
        }, l.prototype.deriveIdAndKeyForPurpose = function(l, n, t, e) {
          var a = this;
          this.wallet.deriveIdAndKeyForPurpose([l, n, t], e, function(l) {
            a.errorFun(l)
          })
        }, l.prototype.getAllMasterWallets = function(l) {
          var n = this;
          this.wallet.getAllMasterWallets([], l, function(l) {
            n.errorFun(l)
          })
        }, l.prototype.getBalanceInfo = function(l, n, t) {
          var e = this;
          this.wallet.getBalanceInfo([l, n], t, function(l) {
            e.errorFun(l)
          })
        }, l.prototype.isAddressValid = function(l, n, t) {
          var e = this;
          this.wallet.isAddressValid([l, n], t, function(l) {
            e.errorFun(l)
          })
        }, l.prototype.generateMnemonic = function(l, n) {
          var t = this;
          this.wallet.generateMnemonic([l], n, function(l) {
            t.errorFun(l)
          })
        }, l.prototype.saveConfigs = function(l) {
          var n = this;
          this.wallet.saveConfigs([], l, function(l) {
            n.errorFun(l)
          })
        }, l.prototype.getAllChainIds = function(l) {
          var n = this;
          this.wallet.getAllChainIds([], l, function(l) {
            n.errorFun(l)
          })
        }, l.prototype.getSupportedChains = function(l, n) {
          var t = this;
          this.wallet.getSupportedChains([l], n, function(l) {
            t.errorFun(l)
          })
        }, l.prototype.getAllSubWallets = function(l, n) {
          var t = this;
          this.wallet.getAllSubWallets([l], n, function(l) {
            t.errorFun(l)
          })
        }, l.prototype.changePassword = function(l, n, t, e) {
          var a = this;
          this.wallet.changePassword([l, n, t], e, function(l) {
            a.errorFun(l)
          })
        }, l.prototype.createTransaction = function(l, n, t, e, a, u, i, s) {
          var o = this;
          this.wallet.createTransaction([l, n, t, e, a, u, i], s, function(l) {
            o.errorFun(l)
          })
        }, l.prototype.calculateTransactionFee = function(l, n, t, e, a) {
          var u = this;
          this.wallet.calculateTransactionFee([l, n, t, e], a, function(l) {
            u.errorFun(l)
          })
        }, l.prototype.createDID = function(l, n) {
          var t = this;
          this.wallet.createDID([l], n, function(l) {
            t.errorFun(l)
          })
        }, l.prototype.getDIDList = function(l) {
          var n = this;
          this.wallet.getDIDList([], l, function(l) {
            n.errorFun(l)
          })
        }, l.prototype.destoryDID = function(l, n) {
          var t = this;
          this.wallet.destoryDID([l], n, function(l) {
            t.errorFun(l)
          })
        }, l.prototype.didSetValue = function(l, n, t, e) {
          var a = this;
          this.wallet.didSetValue([l, n, t], e, function(l) {
            a.errorFun(l)
          })
        }, l.prototype.didGetValue = function(l, n, t) {
          var e = this;
          this.wallet.didGetValue([l, n], t, function(l) {
            e.errorFun(l)
          })
        }, l.prototype.didGetHistoryValue = function(l, n, t) {
          var e = this;
          this.wallet.didGetValue([l, n], t, function(l) {
            e.errorFun(l)
          })
        }, l.prototype.didGetAllKeys = function(l, n, t, e) {
          var a = this;
          this.wallet.didGetAllKeys([l, n, t], e, function(l) {
            a.errorFun(l)
          })
        }, l.prototype.didSign = function(l, n, t, e) {
          var a = this;
          this.wallet.didSign([l, n, t], e, function(l) {
            a.errorFun(l)
          })
        }, l.prototype.didCheckSign = function(l, n, t, e) {
          var a = this;
          this.wallet.didCheckSign([l, n, t], e, function(l) {
            a.errorFun(l)
          })
        }, l.prototype.didGetPublicKey = function(l, n) {
          var t = this;
          this.wallet.didGetPublicKey([l], n, function(l) {
            t.errorFun(l)
          })
        }, l.prototype.createIdTransaction = function(l, n, t, e, a, u, i, s) {
          var o = this;
          this.wallet.createIdTransaction([l, n, t, e, a, u, i], s, function(l) {
            o.errorFun(l)
          })
        }, l.prototype.createDepositTransaction = function(l, n, t, e, a, u, i, s, o, r, c) {
          var _ = this;
          this.wallet.createDepositTransaction([l, n, t, e, a, u, i, s, o, r], c, function(l) {
            _.errorFun(l)
          })
        }, l.prototype.createWithdrawTransaction = function(l, n, t, e, a, u, i, s, o, r) {
          var c = this;
          this.wallet.createWithdrawTransaction([l, n, t, e, a, u, i, s, o], r, function(l) {
            c.errorFun(l)
          })
        }, l.prototype.getGenesisAddress = function(l, n, t) {
          var e = this;
          this.wallet.getGenesisAddress([l, n], t, function(l) {
            e.errorFun(l)
          })
        }, l.prototype.didGenerateProgram = function(l, n, t, e) {
          var a = this;
          this.wallet.didGenerateProgram([l, n, t], e, function(l) {
            a.errorFun(l)
          })
        }, l.prototype.getMasterWalletBasicInfo = function(l, n) {
          var t = this;
          this.wallet.getMasterWalletBasicInfo([l], n, function(l) {
            t.errorFun(l)
          })
        }, l.prototype.createMultiSignMasterWallet = function(l, n, t, e) {
          var a = this;
          this.wallet.createMultiSignMasterWallet([l, n, t], e, function(l) {
            a.errorFun(l)
          })
        }, l.prototype.createMultiSignMasterWalletWithPrivKey = function(l, n, t, e, a, u) {
          var i = this;
          this.wallet.createMultiSignMasterWalletWithPrivKey([l, n, t, e, a], u, function(l) {
            i.errorFun(l)
          })
        }, l.prototype.updateTransactionFee = function(l, n, t, e, a) {
          var u = this;
          this.wallet.updateTransactionFee([l, n, t, e], a, function(l) {
            u.errorFun(l)
          })
        }, l.prototype.signTransaction = function(l, n, t, e, a) {
          var u = this;
          this.wallet.signTransaction([l, n, t, e], a, function(l) {
            u.errorFun(l)
          })
        }, l.prototype.publishTransaction = function(l, n, t, e) {
          var a = this;
          this.wallet.publishTransaction([l, n, t], e, function(l) {
            a.errorFun(l)
          })
        }, l.prototype.getMasterWalletPublicKey = function(l, n) {
          var t = this;
          this.wallet.getMasterWalletPublicKey([l], n, function(l) {
            t.errorFun(l)
          })
        }, l.prototype.getSubWalletPublicKey = function(l, n, t) {
          var e = this;
          this.wallet.getSubWalletPublicKey([l, n], t, function(l) {
            e.errorFun(l)
          })
        }, l.prototype.createMultiSignMasterWalletWithMnemonic = function(l, n, t, e, a, u, i) {
          var s = this;
          this.wallet.createMultiSignMasterWalletWithMnemonic([l, n, t, e, a, u], i, function(l) {
            s.errorFun(l)
          })
        }, l.prototype.encodeTransactionToString = function(l, n) {
          var t = this;
          this.wallet.encodeTransactionToString([l], n, function(l) {
            t.errorFun(l)
          })
        }, l.prototype.decodeTransactionFromString = function(l, n) {
          var t = this;
          this.wallet.decodeTransactionFromString([l], n, function(l) {
            t.errorFun(l)
          })
        }, l.prototype.removeWalletListener = function(l, n, t) {
          var e = this;
          this.wallet.removeWalletListener([l, n], t, function(l) {
            e.errorFun(l)
          })
        }, l.prototype.disposeNative = function(l) {
          var n = this;
          this.wallet.disposeNative([], l, function(l) {
            n.errorFun(l)
          })
        }, l.prototype.getMultiSignPubKeyWithMnemonic = function(l, n, t) {
          var e = this;
          this.wallet.getMultiSignPubKeyWithMnemonic([l, n], t, function(l) {
            e.errorFun(l)
          })
        }, l.prototype.getMultiSignPubKeyWithPrivKey = function(l, n) {
          var t = this;
          this.wallet.getMultiSignPubKeyWithPrivKey([l], n, function(l) {
            t.errorFun(l)
          })
        }, l.prototype.getTransactionSignedSigners = function(l, n, t, e) {
          var a = this;
          this.wallet.getTransactionSignedSigners([l, n, t], e, function(l) {
            a.errorFun(l)
          })
        }, l.prototype.importWalletWithOldKeystore = function(l, n, t, e, a, u) {
          var i = this;
          this.wallet.importWalletWithOldKeystore([l, n, t, e, a], u, function(l) {
            i.errorFun(l)
          })
        }, l.prototype.errorFun = function(l) {
          this.native.info(l);
          var n = l.error.code;
          if (n && (n = "error-" + n), this.native.hideLoading(), 20013 === l.error.code) {
            this.popupProvider.ionicAlert_data("confirmTitle", n, l.error.Data / $t.a.SELA)
          } else 20036 === l.error.code || this.popupProvider.ionicAlert("confirmTitle", n);
          20036 === l.error.code ? this.event.publish("error:update", l) : this.event.publish("error:update")
        }, l.COINTYPE_ELA = 0, l.COINTYPE_ID = 1, l.LIMITGAP = 500, l.FEEPERKb = 500, l.PAGECOUNT = 20, l;
        var n
      }(),
      oe = function() {
        function l(l, n, t, e, a, u) {
          this.navCtrl = l, this.navParams = n, this.walletManager = t, this.native = e, this.localStorage = a, this.events = u
        }
        return l.prototype.add = function() {
          var l = this,
            n = {
              id: this.name,
              name: this.name,
              address: this.address,
              phone: this.phone,
              email: this.email,
              remark: this.remark
            };
          ie.a.isNull(this.name) ? this.native.toast_trans("contact-name-notnull") : ie.a.isNull(this.address) ? this.native.toast_trans("contact-address-notnull") : ie.a.isAddressValid(this.address) ? this.phone && ie.a.checkCellphone(this.phone.toString()) ? this.native.toast_trans("contact-phone-check") : this.localStorage.add("contactUsers", n).then(function(n) {
            l.events.publish("contanctList:update"), l.navCtrl.pop()
          }) : this.native.toast_trans("contact-address-digits")
        }, l
      }(),
      re = function() {
        function l(l, n, t, e, a, u) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.localStorage = e, this.events = a, this.popupProvider = u, this.contactUser = {}, this.qrcode = null, this.masterId = "1", this.isShow = !1, this.isShow = this.navParams.get("exatOption").hideButton || !1, this.init()
        }
        return l.prototype.init = function() {
          var l = this;
          this.localStorage.get("contactUsers").then(function(n) {
            if (n) {
              var t = l.navParams.get("id");
              l.contactUser = JSON.parse(n)[t], l.qrcode = l.contactUser.address.toString()
            }
          })
        }, l.prototype.rightHeader = function() {
          var l = this;
          this.popupProvider.ionicConfirm("confirmTitle", "text-delete-contact-confirm").then(function(n) {
            n && l.localStorage.get("contactUsers").then(function(n) {
              var t = JSON.parse(n);
              delete t[l.contactUser.id], l.localStorage.set("contactUsers", t), l.events.publish("contanctList:update"), l.navCtrl.pop()
            })
          })
        }, l.prototype.pay = function(l) {
          this.events.publish("address:update", l), this.navCtrl.popTo(this.navCtrl.getByIndex(this.navCtrl.length() - 3))
        }, l
      }(),
      ce = function() {
        function l(l, n, t, e, a, u) {
          this.navCtrl = l, this.navParams = n, this.walletManager = t, this.native = e, this.localStorage = a, this.events = u, this.isnodata = !1, this.contactUsers = [], this.params = {}, this.init()
        }
        return l.prototype.init = function() {
          var l = this;
          this.params = this.navParams.data || {}, this.events.subscribe("contanctList:update", function() {
            l.localStorage.get("contactUsers").then(function(n) {
              if (n) {
                if (ie.a.isEmptyObject(JSON.parse(n))) return void(l.isnodata = !0);
                l.isnodata = !1, l.contactUsers = ie.a.objtoarr(JSON.parse(n))
              } else l.isnodata = !0
            })
          }), this.localStorage.get("contactUsers").then(function(n) {
            if (n) {
              if (ie.a.isEmptyObject(JSON.parse(n))) return void(l.isnodata = !0);
              l.isnodata = !1, l.contactUsers = ie.a.objtoarr(JSON.parse(n))
            } else l.isnodata = !0
          })
        }, l.prototype.rightHeader = function() {
          this.native.Go(this.navCtrl, oe)
        }, l.prototype.onclick = function(l) {
          this.native.Go(this.navCtrl, re, {
            id: l,
            exatOption: this.params
          })
        }, l.prototype.ionViewDidLeave = function() {}, l
      }(),
      _e = t(739),
      de = t(823),
      he = t.n(de),
      pe = t(60),
      ge = t.n(pe),
      fe = function() {
        function l() {}
        return n = l, l.test = function() {
          var l, n = Object(_e.randomBytes)(32);
          do {
            l = Object(_e.randomBytes)(32)
          } while (!he.a.privateKeyVerify(l));
          he.a.publicKeyCreate(l), this.sign(n, l)
        }, l.sign = function(l, n) {
          var t = new(0, ge.a.ec)("p256"),
            e = this.hash(l);
          return t.keyFromPrivate(n, "hex").sign(e).toDER("hex")
        }, l.sign1 = function(l, n) {
          var t = new(0, ge.a.ec)("p256"),
            e = this.hash(l);
          return t.sign(e, n, 16).toDER("hex")
        }, l.verify = function(l, n, t) {
          return he.a.verify(l, n, t)
        }, l.hash = function(l) {
          return Object(_e.createHash)("sha256").update(l).digest("hex")
        }, l.getInfoSign = function(l) {
          var t = n.getObjKeys(l, "asc"),
            e = "";
          for (var a in t) e += l[t[a]];
          return this.sign1(e, "")
        }, l.getCheckSum = function(l, t) {
          var e = n.getObjKeys(l, t),
            a = "";
          for (var u in e) a += l[e[u]];
          return this.hash(a)
        }, l.getObjKeys = function(l, t) {
          void 0 === t && (t = "");
          var e = [];
          for (var a in l) ie.a.isNull(l[a]) || e.push(a);
          return "asc" === t ? n.asc(e) : "des" === t && n.des(e), e
        }, l.asc = function(l) {
          l.sort(function(l, n) {
            var t = l.toUpperCase(),
              e = n.toUpperCase();
            return t < e ? -1 : t > e ? 1 : 0
          })
        }, l.des = function(l) {
          l.sort(function(l, n) {
            var t = l.toUpperCase(),
              e = n.toUpperCase();
            return t > e ? -1 : t < e ? 1 : 0
          })
        }, l.getPublicKey = function(l) {
          return "111111"
        }, l.getPriKey = function() {
          return "sssss"
        }, l;
        var n
      }(),
      me = function() {
        function l() {}
        return l.SERVER = "https://39.106.96.168:8446/api", l.GET_PRICE = l.SERVER + "/getPrice", l.SEND_CODE = l.SERVER + "/sendCode", l.AUTH = l.SERVER + "/authreqstatus/auth", l.APP_AUTH = l.SERVER + "/app/auth", l
      }(),
      ve = function() {
        function l(l, n, t, e, a) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.localStorage = e, this.dataManager = a, this.kycObj = {}, this.keyStoreContent = "", this.init()
        }
        return l.prototype.init = function() {
          var l = this;
          this.localStorage.get("kycId").then(function(n) {
            l.kycObj = ie.a.isNull(n) ? {} : JSON.parse(n)
          })
        }, l.prototype.onImport = function() {
          var l = this;
          if (ie.a.isNull(this.keyStoreContent)) this.native.toast_trans("text-id-kyc-import-no-message");
          else {
            var n = JSON.parse(this.keyStoreContent);
            for (var t in n) this.kycObj[t] = n[t];
            this.localStorage.set("kycId", this.kycObj).then(function() {
              l.native.toast_trans("text-exprot-sucess-message"), l.native.Go(l.navCtrl, We)
            })
          }
        }, l
      }(),
      ye = function() {
        function l(l, n, t, e, a, u, i) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.walletManager = e, this.localStorage = a, this.events = u, this.dataManager = i, this.kycIdArr = [], this.isSelectObj = {}, this.selectAll = !1, this.init()
        }
        return l.prototype.ionViewDidLoad = function() {
          var l = this;
          this.navBar.backButtonClick = function(n) {
            l.events.publish("idhome:update"), l.navCtrl.pop()
          }
        }, l.prototype.init = function() {
          var l = this;
          this.localStorage.get("kycId").then(function(n) {
            null === n ? l.kycIdArr = [] : (l.kycIdArr = ie.a.objtoarr(JSON.parse(n)), l.idsObj = JSON.parse(n))
          })
        }, l.prototype.onItem = function(l) {
          if (ie.a.isNull(this.isSelectObj[l])) return this.isSelectObj[l] = !0, void(this.selectAll = this.setAllButton());
          this.isSelectObj[l] = !this.isSelectObj[l], this.selectAll = this.setAllButton()
        }, l.prototype.onNext = function(l) {
          switch (l) {
            case 1:
              var n = this.getSelsetId();
              this.downButton(n);
              break;
            case 2:
              var t = this.getSelsetId();
              console.log(JSON.stringify(t)), this.delIds(t);
              break;
            case 3:
              this.selectAll = !this.selectAll, this.setSelectAll(this.selectAll)
          }
        }, l.prototype.setSelectAll = function(l) {
          for (var n in this.idsObj) this.isSelectObj[n] = l
        }, l.prototype.getSelsetId = function() {
          var l = [];
          for (var n in this.isSelectObj) this.isSelectObj[n] && l.push(n);
          return l
        }, l.prototype.setAllButton = function() {
          var l = !0;
          if (Object.keys(this.isSelectObj).length < this.kycIdArr.length) return l = !1;
          for (var n in this.isSelectObj)
            if (!this.isSelectObj[n]) return l = !1;
          return l
        }, l.prototype.downButton = function(l) {
          if (0 !== l.length) {
            var n = {},
              t = this.idsObj;
            for (var e in l) {
              var a = l[e];
              n[a] = t[a]
            }
            this.backupWalletPlainText = JSON.stringify(n)
          } else this.native.toast_trans("text-down-please-message")
        }, l.prototype.onCopay = function() {
          var l = this;
          this.native.copyClipboard(this.backupWalletPlainText).then(function() {
            l.native.toast_trans("text-copied-to-clipboard")
          }).catch(function() {})
        }, l.prototype.delIds = function(l) {
          var n = this;
          if (0 !== l.length) {
            for (var t in l) {
              delete this.idsObj[l[t]]
            }
            this.localStorage.set("kycId", this.idsObj).then(function() {
              n.kycIdArr = ie.a.objtoarr(n.idsObj), n.native.toast_trans("text-id-kyc-import-text-del-message")
            })
          } else this.native.toast_trans("text-id-kyc-import-text-del-please-message")
        }, l
      }(),
      be = function() {
        function l(l, n, t, e, a, u, i) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.walletManager = e, this.localStorage = a, this.events = u, this.dataManager = i, this.businessObj = {
            type: "enterprise",
            word: "北京比特大陆科技有限公司",
            legalPerson: "詹克团",
            registrationNum: "911101080804655794"
          }, this.priceObj = {}, this.payMoney = 0, this.unit = "ELA", this.path = "", this.init()
        }
        return l.prototype.init = function() {
          this.parms = this.navParams.data, this.did = this.parms.id, this.path = this.parms.path || "", this.getPrice()
        }, l.prototype.onCommit = function() {
          this.checkParms() && (this.businessObj.serialNum = this.serialNum, this.saveKycSerialNum(this.serialNum))
        }, l.prototype.saveKycSerialNum = function(l) {
          var n = this;
          this.localStorage.get("kycId").then(function(t) {
            var e = JSON.parse(t);
            e[n.did][n.path][l] = {
              serialNum: l,
              pathStatus: 0,
              payObj: {
                did: n.did,
                addr: "EKZCcfqBP1YXiDtJVNdnLQR74QRHKrgFYD",
                money: n.payMoney,
                appType: "kyc",
                chianId: "ELA",
                selectType: n.path,
                parms: n.businessObj
              }
            }, n.localStorage.set("kycId", e).then(function(l) {
              n.native.Go(n.navCtrl, Re, {
                did: n.did,
                addr: "EKZCcfqBP1YXiDtJVNdnLQR74QRHKrgFYD",
                money: n.payMoney,
                appType: "kyc",
                chianId: "ELA",
                selectType: n.path,
                parms: n.businessObj
              })
            })
          })
        }, l.prototype.checkParms = function() {
          return ie.a.isNull(this.businessObj.word) ? (this.native.toast_trans("text-word-message"), !1) : ie.a.isNull(this.businessObj.legalPerson) ? (this.native.toast_trans("text-legalPerson-message"), !1) : !ie.a.isNull(this.businessObj.registrationNum) || (this.native.toast_trans("text-registrationN-message"), !1)
        }, l.prototype.getPrice = function() {
          var l = this,
            n = {
              appid: "elastid",
              timestamp: this.native.getTimestamp()
            },
            t = fe.getCheckSum(n, "asc");
          n.checksum = t, this.native.getHttp().postByAuth(me.GET_PRICE, n).toPromise().then().then(function(n) {
            200 === n.status && (l.priceObj = JSON.parse(n._body), l.payMoney = l.priceObj.price || .1, l.unit = l.priceObj.unit || "ELA", l.serialNum = l.priceObj.serialNum)
          }).catch(function(l) {})
        }, l
      }(),
      ke = function() {
        function l(l, n, t, e, a, u, i, s, o) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.walletManager = e, this.localStorage = a, this.events = u, this.dataManager = i, this.popupProvider = s, this.ngzone = o, this.masterWalletId = "1", this.approdType = "enterprise", this.businessObj = {
            word: "xxxxx",
            legalPerson: "xxxxx",
            registrationNum: "xxxxxxxx"
          }, this.message = {
            Id: "",
            Path: "",
            Proof: "",
            DataHash: "",
            Sign: ""
          }, this.passworld = "", this.idObj = {}, this.orderStatus = 0, this.serialNum = "", this.init()
        }
        return l.prototype.init = function() {
          var l = this;
          this.events.subscribe("order:update", function(n, t) {
            "enterprise" === t && l.ngzone.run(function() {
              l.orderStatus = n
            })
          }), this.idObj = this.navParams.data, this.orderStatus = this.idObj.pathStatus, this.serialNum = this.idObj.serialNum, this.native.info(this.idObj), this.did = this.idObj.payObj.did, this.getCompany(), this.type = ie.a.isNull(status) ? "0" : status
        }, l.prototype.ionViewDidLoad = function() {
          var l = this;
          this.navBar.backButtonClick = function(n) {
            l.navCtrl.pop(), l.native.Go(l.navCtrl, We)
          }
        }, l.prototype.getCompany = function() {
          var l = this.idObj.adata[0],
            n = l.retdata;
          this.message.Path = l.type, this.approdType = l.type, this.businessObj.word = n.word, this.businessObj.legalPerson = n.legalPerson, this.businessObj.registrationNum = n.RegistrationNum, this.signature = n.signature
        }, l.prototype.onCommit = function() {
          var l = this;
          this.popupProvider.presentPrompt().then(function(n) {
            ie.a.isNull(n) ? l.native.toast_trans("text-id-kyc-prompt-password") : (l.passworld = n.toString(), l.caulmessageNew())
          }).catch(function() {})
        }, l.prototype.didGenerateProgram = function() {
          var l = this;
          this.native.info(this.message), this.native.info(this.passworld), this.walletManager.didGenerateProgram(this.did, JSON.stringify(this.message), this.passworld, function(n) {
            l.programJson = n.value, l.native.info(l.programJson), l.createfromAddress()
          })
        }, l.prototype.createfromAddress = function() {
          var l = this;
          this.walletManager.createAddress(this.masterWalletId, "IdChain", function(n) {
            l.fromAddress = n.address, l.cauFee()
          })
        }, l.prototype.cauFee = function() {
          var l = this;
          this.walletManager.createIdTransaction(this.masterWalletId, "IdChain", "", this.message, this.programJson, "", "", function(n) {
            l.native.info(l.fromAddress), l.native.info(l.message), l.native.info(l.programJson);
            var t = n.json.toString();
            l.native.info(t), l.calculateTransactionFee(t)
          })
        }, l.prototype.calculateTransactionFee = function(l) {
          var n = this;
          this.walletManager.calculateTransactionFee(this.masterWalletId, "IdChain", l, 1e4, function(t) {
            n.fee = t.fee, n.native.info(l), n.native.info(n.fee), n.popupProvider.presentConfirm(n.fee / $t.a.SELA).then(function() {
              n.sendRawTransaction(l)
            })
          })
        }, l.prototype.getKycContent = function(l) {
          var n = {};
          switch (l.type) {
            case "identityCard":
              n.fullName = l.retdata.fullName, n.identityNumber = l.retdata.identityNumber;
              break;
            case "phone":
              n.fullName = l.retdata.fullName, n.identityNumber = l.retdata.identityNumber, n.mobile = l.retdata.mobile;
              break;
            case "bankCard":
              n.fullName = l.retdata.fullName, n.identityNumber = l.retdata.identityNumber, n.cardNumber = l.retdata.cardNumber, n.cardMobile = l.retdata.mobile;
              break;
            case "enterprise":
              n.word = l.retdata.word, n.legalPerson = l.retdata.legalPerson, n.registrationNum = l.retdata.RegistrationNum
          }
          return n
        }, l.prototype.getcontent = function(l) {
          var n = {};
          n.Path = "kyc/" + l.type, n.Values = [];
          var t = {
              signature: l.resultSign,
              notary: "COOIX"
            },
            e = {};
          e.Proof = JSON.stringify(t);
          var a = this.getKycContent(l);
          console.info("ElastJs company getcontent kycContent " + JSON.stringify(a)), console.info("ElastJs company getcontent Proof " + e.Proof);
          var u = fe.hash(JSON.stringify(a) + e.Proof);
          e.DataHash = fe.hash(u + e.Proof);
          var i = {};
          return i.hash = e.DataHash, i.KycContent = a, i.Proof = e.Proof, this.dataManager.addIdPathJson(this.did, n.Path, i), n.Values.push(e), console.info("ElastJs company getcontent retContent " + JSON.stringify(n)), n
        }, l.prototype.caulmessageNew = function() {
          var l = this,
            n = {};
          n.Id = this.did, n.Contents = [];
          for (var t, e = 0, a = this.idObj.adata; e < a.length; e++) {
            t = this.getcontent(a[e]), n.Contents.push(t)
          }
          this.native.info(n), this.walletManager.didSign(this.did, JSON.stringify(n), this.passworld, function(t) {
            l.message = {
              Id: l.did,
              Sign: t.value,
              Contents: n.Contents
            }, l.didGenerateProgram()
          })
        }, l.prototype.caulmessage = function() {
          var l = this,
            n = {};
          n = this.businessObj, this.message.Path = "kyc|company|enterprise";
          var t = {
            signature: this.signature,
            notary: "COOIX"
          };
          this.native.info(this.signature);
          var e = fe.hash(JSON.stringify(n) + JSON.stringify(t)),
            a = fe.hash(e + JSON.stringify(t));
          this.native.info(a.length);
          var u = {
            Id: this.did,
            Path: this.message.Path,
            Proof: t,
            DataHash: a
          };
          this.walletManager.didSign(this.did, JSON.stringify(u), this.passworld, function(n) {
            l.native.info(n);
            var e = JSON.stringify(t);
            l.message = {
              Id: l.did,
              Path: l.message.Path,
              Proof: e,
              DataHash: a,
              Sign: n.value
            }, l.didGenerateProgram()
          })
        }, l.prototype.sendRawTransaction = function(l) {}, l.prototype.getDepositTransaction = function() {
          var l = this;
          this.walletManager.calculateTransactionFee(this.masterWalletId, "ELA", this.depositTransaction, 1e4, function(n) {
            l.depositTransactionFee = n.fee
          })
        }, l.prototype.setOrderStatus = function(l) {
          var n = this;
          console.info("ElastJs setOrderStatus status begin" + l);
          var t = $t.a.getSerIds()[this.serialNum],
            e = t.id,
            a = t.path,
            u = {};
          this.localStorage.getKycList("kycId").then(function(t) {
            null != t && void 0 !== t && t !== {} && "" !== t ? ((u = JSON.parse(t))[e][a][n.serialNum].pathStatus = l, n.localStorage.set("kycId", u).then(function() {
              console.info("ElastJs setOrderStatus  end  status " + l), n.orderStatus = l
            })) : console.info("setOrderStatus val == null return ")
          })
        }, l
      }(),
      xe = function() {
        function l(l, n, t, e, a, u, i) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.walletManager = e, this.localStorage = a, this.events = u, this.dataManager = i, this.companyPathList = [], this.parmar = {}, this.idsObj = {}, this.init()
        }
        return l.prototype.init = function() {
          var l = this;
          this.parmar = this.navParams.data, this.native.info(this.parmar), this.localStorage.get("kycId").then(function(n) {
            if (null != n && void 0 !== n && n !== {} && "" !== n) {
              l.idsObj = JSON.parse(n);
              var t = l.idsObj[l.parmar.id][l.parmar.path];
              for (var e in t) l.companyPathList.push(t[e])
            }
          })
        }, l.prototype.onNext = function(l) {
          this.jumpPage(l)
        }, l.prototype.onCommit = function() {
          this.native.Go(this.navCtrl, be, this.parmar)
        }, l.prototype.jumpPage = function(l) {
          switch (l.pathStatus) {
            case 0:
              break;
            case 1:
              this.getAppAuth(l);
              break;
            case 2:
              this.native.Go(this.navCtrl, ke, l)
          }
        }, l.prototype.getAppAuth = function(l) {
          var n = this,
            t = l.serialNum,
            e = l.txHash;
          this.native.info(typeof e), this.native.info(t), this.native.info(e);
          var a = this.native.getTimestamp(),
            u = {
              serialNum: t,
              txHash: e,
              timestamp: a
            },
            i = fe.getCheckSum(u, "asc");
          u.checksum = i, this.native.getHttp().postByAuth(me.APP_AUTH, u).toPromise().then().then(function(e) {
            if (200 === e.status) {
              n.native.info(e);
              var a = JSON.parse(e._body);
              if (n.native.info(a), "1" === a.errorCode) return void n.native.toast_trans("text-id-kyc-auth-fee-fail");
              if ("2" === a.errorCode) return void n.native.toast_trans("text-id-kyc-auth-query-timeout");
              if ("4" === a.errorCode) return void n.native.toast_trans("text-id-kyc-auth-uncompleted");
              if ("0" === a.errorCode && (l.adata = a.data, n.saveSerialNumParm(t, l), n.native.info(a.data.length), a.data.length > 0)) {
                var u = JSON.parse(JSON.stringify(a.data[0])),
                  i = u.resultSign;
                delete u.resultSign, n.dataManager.addSignCont(i, u)
              }
            }
          }).catch(function(l) {})
        }, l.prototype.saveSerialNumParm = function(l, n) {
          var t = this;
          n.pathStatus = 2, this.idsObj[this.parmar.id][this.parmar.path][l] = n, this.localStorage.set("kycId", this.idsObj).then(function() {
            t.native.Go(t.navCtrl, ke, n)
          })
        }, l
      }(),
      we = function() {
        function l(l, n, t, e, a, u, i) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.walletManager = e, this.localStorage = a, this.events = u, this.dataManager = i, this.debitCard = {
            fullName: "宋家准",
            identityNumber: "410426198811151012",
            cardNumber: "6225880167820399",
            cardMobile: "18210230496",
            cardCode: "",
            type: "bankCard"
          }, this.payMoney = 0, this.unit = "ELA", this.priceObj = {}, this.verifyCode = {
            verifyCodeTips: "获取验证码",
            countdown: 60,
            disable: !0
          }, this.init()
        }
        return l.prototype.init = function() {
          this.parms = this.navParams.data, this.did = this.parms.id, this.path = this.parms.path || "", this.getPrice()
        }, l.prototype.getPrice = function() {
          var l = this,
            n = {
              appid: "elastid",
              timestamp: this.native.getTimestamp()
            },
            t = fe.getCheckSum(n, "asc");
          n.checksum = t, this.native.getHttp().postByAuth(me.GET_PRICE, n).toPromise().then().then(function(n) {
            200 === n.status && (l.priceObj = JSON.parse(n._body), l.payMoney = l.priceObj.price || .1, l.unit = l.priceObj.unit || "ELA", l.serialNum = l.priceObj.serialNum)
          }).catch(function(l) {})
        }, l.prototype.sendCodeHttp = function(l) {
          var n = (1e15 * Math.random()).toString().substring(0, 6),
            t = this.native.getTimestamp(),
            e = {
              mobile: l,
              code: n,
              serialNum: this.serialNum,
              timestamp: t
            },
            a = fe.getCheckSum(e, "asc");
          e.checksum = a, this.native.getHttp().postByAuth(me.SEND_CODE, e).toPromise().then(function(l) {}).catch(function(l) {})
        }, l.prototype.onCommit = function() {
          this.checkParms() && this.saveKycSerialNum(this.serialNum)
        }, l.prototype.saveKycSerialNum = function(l) {
          var n = this;
          this.localStorage.get("kycId").then(function(t) {
            var e = JSON.parse(t);
            e[n.did][n.path][l] = {
              serialNum: l,
              pathStatus: 0,
              payObj: {
                did: n.did,
                addr: "EKZCcfqBP1YXiDtJVNdnLQR74QRHKrgFYD",
                money: n.payMoney,
                appType: "kyc",
                chianId: "ELA",
                selectType: n.path,
                parms: n.debitCard
              }
            }, n.localStorage.set("kycId", e).then(function(t) {
              n.debitCard.serialNum = l, n.native.Go(n.navCtrl, Re, {
                did: n.did,
                addr: "EKZCcfqBP1YXiDtJVNdnLQR74QRHKrgFYD",
                money: n.payMoney,
                appType: "kyc",
                chianId: "ELA",
                selectType: n.path,
                parms: n.debitCard
              })
            })
          })
        }, l.prototype.checkParms = function() {
          if (ie.a.isNull(this.debitCard.fullName)) this.native.toast_trans("text-realname-message");
          else if (ie.a.isNull(this.debitCard.identityNumber)) this.native.toast_trans("text-cardNo-message-1");
          else if (ie.a.isCardNo(this.debitCard.identityNumber)) this.native.toast_trans("text-cardNo-message-2");
          else if (ie.a.isNull(this.debitCard.cardNumber)) this.native.toast_trans("text-debitCard-message-1");
          else if (ie.a.isBankCard(this.debitCard.cardNumber)) this.native.toast_trans("text-debitCard-message-2");
          else if (ie.a.isNull(this.debitCard.cardMobile)) this.native.toast_trans("text-phone-message-1");
          else if (ie.a.checkCellphone(this.debitCard.cardMobile)) this.native.toast_trans("text-phone-message-2");
          else {
            if (!ie.a.isNull(this.debitCard.cardCode)) return !0;
            this.native.toast_trans("text-sendcode-message-1")
          }
        }, l.prototype.getCode = function(l) {
          ie.a.isNull(l) ? this.native.toast_trans("text-phone-message-1") : ie.a.checkCellphone(l) ? this.native.toast_trans("text-phone-message-2") : this.verifyCode.disable && (this.verifyCode.disable = !1, this.settime(), this.sendCodeHttp(l))
        }, l.prototype.settime = function() {
          var l = this;
          if (0 == this.verifyCode.countdown) return this.verifyCode.verifyCodeTips = "获取验证码", this.verifyCode.disable = !0, void(this.verifyCode.countdown = 60);
          this.verifyCode.countdown--, setTimeout(function() {
            l.verifyCode.verifyCodeTips = "重新获取" + l.verifyCode.countdown + "秒", l.settime()
          }, 1e3)
        }, l
      }(),
      Ce = function() {
        function l(l, n, t, e, a, u, i, s, o) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.walletManager = e, this.localStorage = a, this.events = u, this.dataManager = i, this.popupProvider = s, this.ngzone = o, this.masterWalletId = "1", this.pageObj = {}, this.personObj = {
            fullName: "sss",
            identityNumber: "410426198811151012",
            mobile: "18210230496",
            cardNumber: "6225260167820399",
            cardMobile: "18210230496"
          }, this.phoneObj = {
            fullName: "sss",
            identityNumber: "410426198811151012",
            mobile: "18210230496"
          }, this.debitObj = {
            fullName: "sss",
            identityNumber: "410426198811151012",
            cardNumber: "6225260167820399",
            cardMobile: "18210230496"
          }, this.message = {
            Id: "",
            Path: "",
            Proof: "",
            DataHash: "",
            Sign: ""
          }, this.passworld = "", this.idObj = {}, this.orderStatus = 0, this.serialNum = "", this.init()
        }
        return l.prototype.init = function() {
          var l = this;
          this.events.subscribe("order:update", function(n, t) {
            l.native.info(n), l.native.info(t), "enterprise" != t && l.ngzone.run(function() {
              l.orderStatus = n
            })
          }), this.idObj = this.navParams.data, this.native.info(this.idObj), this.did = this.idObj.payObj.did, this.native.info(this.idObj.pathStatus), this.orderStatus = this.idObj.pathStatus, this.serialNum = this.idObj.serialNum, this.getPerson(), this.type = ie.a.isNull(status) ? "0" : status
        }, l.prototype.ionViewDidLoad = function() {
          var l = this;
          this.navBar.backButtonClick = function(n) {
            l.navCtrl.pop(), l.native.Go(l.navCtrl, We)
          }
        }, l.prototype.getPerson = function() {
          this.pageObj = this.getPageObj(this.idObj.adata);
          this.message.Path = this.idObj.adata[this.idObj.adata.length - 1].type
        }, l.prototype.onCommit = function() {
          var l = this;
          this.popupProvider.presentPrompt().then(function(n) {
            ie.a.isNull(n) ? l.native.toast_trans("text-id-kyc-prompt-password") : (l.passworld = n.toString(), l.caulmessageNew())
          }).catch(function() {})
        }, l.prototype.didGenerateProgram = function() {
          var l = this;
          this.native.info(this.message), this.native.info(this.passworld), this.walletManager.didGenerateProgram(this.did, JSON.stringify(this.message), this.passworld, function(n) {
            l.programJson = n.value, l.native.info(l.didGenerateProgram), l.createfromAddress()
          })
        }, l.prototype.createfromAddress = function() {
          var l = this;
          this.walletManager.createAddress(this.masterWalletId, "IdChain", function(n) {
            l.fromAddress = n.address, l.cauFee()
          })
        }, l.prototype.cauFee = function() {
          var l = this;
          this.walletManager.createIdTransaction(this.masterWalletId, "IdChain", "", this.message, this.programJson, "", "", function(n) {
            l.native.info(l.fromAddress), l.native.info(l.message), l.native.info(l.programJson);
            var t = n.json.toString();
            l.native.info(t), l.calculateTransactionFee(t)
          })
        }, l.prototype.calculateTransactionFee = function(l) {
          var n = this;
          this.walletManager.calculateTransactionFee(this.masterWalletId, "IdChain", l, 1e4, function(t) {
            n.fee = t.fee, n.native.info(l), n.native.info(n.fee), n.popupProvider.presentConfirm(n.fee / $t.a.SELA).then(function() {
              n.sendRawTransaction(l)
            })
          })
        }, l.prototype.getKycContent = function(l) {
          var n = {};
          switch (l.type) {
            case "identityCard":
              n.fullName = l.retdata.fullName, n.identityNumber = l.retdata.identityNumber;
              break;
            case "phone":
              n.fullName = l.retdata.fullName, n.identityNumber = l.retdata.identityNumber, n.mobile = l.retdata.mobile;
              break;
            case "bankCard":
              n.fullName = l.retdata.fullName, n.identityNumber = l.retdata.identityNumber, n.cardNumber = l.retdata.cardNumber, n.cardMobile = l.retdata.mobile;
              break;
            case "enterprise":
              n.word = l.retdata.word, n.legalPerson = l.retdata.legalPerson, n.registrationNum = l.retdata.RegistrationNum
          }
          return n
        }, l.prototype.getcontent = function(l, n) {
          var t = {};
          t.Path = "kyc/" + n.type, t.Values = [];
          var e = {
              signature: n.resultSign,
              notary: "COOIX"
            },
            a = {};
          a.Proof = JSON.stringify(e);
          var u = this.getKycContent(n);
          console.info("ElastJs company getcontent kycContent " + JSON.stringify(u)), console.info("ElastJs company getcontent Proof " + a.Proof);
          var i = fe.hash(JSON.stringify(u) + a.Proof);
          a.DataHash = fe.hash(i + a.Proof);
          var s = {};
          return s.hash = a.DataHash, s.KycContent = u, s.Proof = a.Proof, this.dataManager.addIdPathJson(this.did, t.Path, s), console.info("ElastJs company getcontent retContent before push "), t.Values.push(a), console.info("ElastJs company getcontent retContent " + JSON.stringify(t)), t
        }, l.prototype.caulmessageNew = function() {
          var l = this,
            n = {};
          n.Id = this.did, n.Contents = [];
          for (var t, e = this.idObj, a = 0, u = e.adata; a < u.length; a++) {
            t = this.getcontent(e.type, u[a]), n.Contents.push(t)
          }
          this.native.info(n), this.walletManager.didSign(this.did, JSON.stringify(n), this.passworld, function(t) {
            l.message = {
              Id: l.did,
              Sign: t.value,
              Contents: n.Contents
            }, l.didGenerateProgram()
          })
        }, l.prototype.sendRawTransaction = function(l) {}, l.prototype.getPageObj = function(l) {
          var n = {};
          for (var t in l) {
            var e = l[t],
              a = e.retdata;
            "identityCard" === e.type ? n.identityCard = {
              identityNumber: a.identityNumber,
              fullName: a.fullName
            } : "phone" === e.type ? n.phone = {
              mobile: a.mobile
            } : "bankCard" === e.type && (n.bankCard = {
              cardMobile: a.mobile,
              cardNumber: a.cardNumber
            })
          }
          return n
        }, l.prototype.setOrderStatus = function(l) {
          var n = this;
          console.info("ElastJs setOrderStatus status begin" + l);
          var t = $t.a.getSerIds();
          console.info("ElastJs setOrderStatus status serids" + JSON.stringify(t));
          var e = t[this.serialNum],
            a = e.id,
            u = e.path,
            i = {};
          this.localStorage.getKycList("kycId").then(function(t) {
            null != t && void 0 !== t && t !== {} && "" !== t ? ((i = JSON.parse(t))[a][u][n.serialNum].pathStatus = l, n.localStorage.set("kycId", i).then(function() {
              console.info("ElastJs setOrderStatus  end  status " + l), n.orderStatus = l
            })) : console.info("ElastJs setOrderStatus val == null return ")
          })
        }, l
      }(),
      Ie = function() {
        function l(l, n, t, e, a, u, i) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.walletManager = e, this.localStorage = a, this.events = u, this.dataManager = i, this.backcardList = [], this.parmar = {}, this.idsObj = {}, this.init()
        }
        return l.prototype.init = function() {
          var l = this;
          this.parmar = this.navParams.data, this.native.info(this.parmar), this.localStorage.get("kycId").then(function(n) {
            if (null != n && void 0 !== n && n !== {} && "" !== n) {
              l.idsObj = JSON.parse(n);
              var t = l.idsObj[l.parmar.id][l.parmar.path];
              for (var e in t) l.backcardList.push(t[e])
            }
          })
        }, l.prototype.onNext = function(l) {
          this.jumpPage(l)
        }, l.prototype.onCommit = function() {
          this.native.Go(this.navCtrl, we, this.parmar)
        }, l.prototype.jumpPage = function(l) {
          switch (l.pathStatus) {
            case 0:
              break;
            case 1:
              this.getAppAuth(l);
              break;
            case 2:
              this.native.Go(this.navCtrl, Ce, l)
          }
        }, l.prototype.getAppAuth = function(l) {
          var n = this,
            t = l.serialNum,
            e = l.txHash;
          this.native.info(typeof e), this.native.info(t), this.native.info(e);
          var a = this.native.getTimestamp(),
            u = {
              serialNum: t,
              txHash: e,
              timestamp: a
            },
            i = fe.getCheckSum(u, "asc");
          u.checksum = i, this.native.getHttp().postByAuth(me.APP_AUTH, u).toPromise().then().then(function(e) {
            if (200 === e.status) {
              n.native.info(e);
              var a = JSON.parse(e._body);
              if ("1" === a.errorCode) return void n.native.toast_trans("text-id-kyc-auth-fee-fail");
              if ("2" === a.errorCode) return void n.native.toast_trans("text-id-kyc-auth-query-timeout");
              if ("4" === a.errorCode) return void n.native.toast_trans("text-id-kyc-auth-uncompleted");
              if ("0" === a.errorCode && (l.adata = a.data, n.saveSerialNumParm(t, l), a.data.length > 0)) {
                var u = JSON.parse(JSON.stringify(a.data[0])),
                  i = u.resultSign;
                delete u.resultSign, n.dataManager.addSignCont(i, u)
              }
            }
          }).catch(function(l) {})
        }, l.prototype.saveSerialNumParm = function(l, n) {
          var t = this;
          n.pathStatus = 2, this.idsObj[this.parmar.id][this.parmar.path][l] = n, this.localStorage.set("kycId", this.idsObj).then(function() {
            t.native.Go(t.navCtrl, Ce, n)
          })
        }, l
      }(),
      Pe = function() {
        function l(l, n, t, e, a, u, i) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.walletManager = e, this.localStorage = a, this.events = u, this.dataManager = i, this.phoneValidate = {
            fullName: "宋家准",
            identityNumber: "410426198811151012",
            mobile: "18210230496",
            code: "",
            type: "phone"
          }, this.payMoney = 0, this.unit = "ELA", this.priceObj = {}, this.verifyCode = {
            verifyCodeTips: "获取验证码",
            countdown: 60,
            disable: !0
          }, this.init()
        }
        return l.prototype.init = function() {
          this.parms = this.navParams.data, this.did = this.parms.id, this.path = this.parms.path || "", this.getPrice()
        }, l.prototype.getPrice = function() {
          var l = this,
            n = {
              appid: "elastid",
              timestamp: this.native.getTimestamp()
            },
            t = fe.getCheckSum(n, "asc");
          n.checksum = t, this.native.getHttp().postByAuth(me.GET_PRICE, n).toPromise().then().then(function(n) {
            200 === n.status && (l.priceObj = JSON.parse(n._body), l.payMoney = l.priceObj.price || .1, l.unit = l.priceObj.unit || "ELA", l.serialNum = l.priceObj.serialNum)
          }).catch(function(l) {})
        }, l.prototype.onCommit = function() {
          this.saveKycSerialNum(this.serialNum)
        }, l.prototype.saveKycSerialNum = function(l) {
          var n = this;
          this.localStorage.get("kycId").then(function(t) {
            var e = JSON.parse(t);
            e[n.did][n.path][l] = {
              serialNum: l,
              pathStatus: 0,
              payObj: {
                did: n.did,
                addr: "EKZCcfqBP1YXiDtJVNdnLQR74QRHKrgFYD",
                money: n.payMoney,
                appType: "kyc",
                chianId: "ELA",
                selectType: n.path,
                parms: n.phoneValidate
              }
            }, n.localStorage.set("kycId", e).then(function(t) {
              n.phoneValidate.serialNum = l, n.native.Go(n.navCtrl, Re, {
                did: n.did,
                addr: "EKZCcfqBP1YXiDtJVNdnLQR74QRHKrgFYD",
                money: n.payMoney,
                appType: "kyc",
                chianId: "ELA",
                selectType: n.path,
                parms: n.phoneValidate
              })
            })
          })
        }, l.prototype.checkIdentity = function() {
          if (ie.a.isNull(this.phoneValidate.fullName)) this.native.toast_trans("text-realname-message");
          else if (ie.a.isNull(this.phoneValidate.identityNumber)) this.native.toast_trans("text-cardNo-message-1");
          else if (ie.a.isCardNo(this.phoneValidate.identityNumber)) this.native.toast_trans("text-cardNo-message-2");
          else if (ie.a.isNull(this.phoneValidate.mobile)) this.native.toast_trans("text-phone-message-1");
          else if (ie.a.checkCellphone(this.phoneValidate.mobile)) this.native.toast_trans("text-phone-message-2");
          else {
            if (!ie.a.isNull(this.phoneValidate.code)) return !0;
            this.native.toast_trans("text-sendcode-message-1")
          }
        }, l.prototype.sendCodeHttp = function(l) {
          var n = (1e15 * Math.random()).toString().substring(0, 6),
            t = this.native.getTimestamp(),
            e = {
              mobile: l,
              code: n,
              serialNum: this.serialNum,
              timestamp: t
            },
            a = fe.getCheckSum(e, "asc");
          e.checksum = a, this.native.getHttp().postByAuth(me.SEND_CODE, e).toPromise().then(function(l) {}).catch(function(l) {})
        }, l.prototype.getCode = function(l) {
          ie.a.isNull(l) ? this.native.toast_trans("text-phone-message-1") : ie.a.checkCellphone(l) ? this.native.toast_trans("text-phone-message-2") : this.verifyCode.disable && (this.verifyCode.disable = !1, this.settime(), this.sendCodeHttp(l))
        }, l.prototype.settime = function() {
          var l = this;
          if (0 == this.verifyCode.countdown) return this.verifyCode.verifyCodeTips = "获取验证码", this.verifyCode.disable = !0, void(this.verifyCode.countdown = 60);
          this.verifyCode.countdown--, setTimeout(function() {
            l.verifyCode.verifyCodeTips = "重新获取" + l.verifyCode.countdown + "秒", l.settime()
          }, 1e3)
        }, l
      }(),
      Se = function() {
        function l(l, n, t, e, a) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.localStorage = e, this.dataManager = a, this.phonepathlist = [], this.parmar = {}, this.idsObj = {}, this.init()
        }
        return l.prototype.init = function() {
          var l = this;
          this.parmar = this.navParams.data, this.native.info(this.parmar), this.localStorage.get("kycId").then(function(n) {
            if (null != n && void 0 !== n && n !== {} && "" !== n) {
              l.idsObj = JSON.parse(n);
              var t = l.idsObj[l.parmar.id][l.parmar.path];
              for (var e in t) l.phonepathlist.push(t[e])
            }
          })
        }, l.prototype.onNext = function(l) {
          this.jumpPage(l)
        }, l.prototype.onCommit = function() {
          this.native.Go(this.navCtrl, Pe, this.parmar)
        }, l.prototype.jumpPage = function(l) {
          switch (l.pathStatus) {
            case 0:
              break;
            case 1:
              this.getAppAuth(l);
              break;
            case 2:
              this.native.Go(this.navCtrl, Ce, l)
          }
        }, l.prototype.getAppAuth = function(l) {
          var n = this,
            t = l.serialNum,
            e = l.txHash;
          this.native.info(typeof e), this.native.info(t), this.native.info(e);
          var a = this.native.getTimestamp(),
            u = {
              serialNum: t,
              txHash: e,
              timestamp: a
            },
            i = fe.getCheckSum(u, "asc");
          u.checksum = i, this.native.getHttp().postByAuth(me.APP_AUTH, u).toPromise().then().then(function(e) {
            if (200 === e.status) {
              n.native.info(e);
              var a = JSON.parse(e._body);
              if ("1" === a.errorCode) return void n.native.toast_trans("text-id-kyc-auth-fee-fail");
              if ("2" === a.errorCode) return void n.native.toast_trans("text-id-kyc-auth-query-timeout");
              if ("4" === a.errorCode) return void n.native.toast_trans("text-id-kyc-auth-uncompleted");
              if ("0" === a.errorCode && (l.adata = a.data, n.saveSerialNumParm(t, l), a.data.length > 0)) {
                var u = JSON.parse(JSON.stringify(a.data[0])),
                  i = u.resultSign;
                delete u.resultSign, n.dataManager.addSignCont(i, u)
              }
            }
          }).catch(function(l) {})
        }, l.prototype.saveSerialNumParm = function(l, n) {
          var t = this;
          n.pathStatus = 2, this.idsObj[this.parmar.id][this.parmar.path][l] = n, this.localStorage.set("kycId", this.idsObj).then(function() {
            t.native.Go(Ce, n)
          })
        }, l
      }(),
      De = function() {
        function l(l, n, t, e, a, u, i) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.walletManager = e, this.localStorage = a, this.events = u, this.dataManager = i, this.personValidate = {
            fullName: "宋家准",
            identityNumber: "410426198811151012",
            type: "identityCard"
          }, this.payMoney = 0, this.unit = "ELA", this.priceObj = {}, this.init()
        }
        return l.prototype.init = function() {
          this.parms = this.navParams.data, this.did = this.parms.id, this.path = this.parms.path || "", this.getPrice()
        }, l.prototype.onCommit = function() {
          this.checkIdentity() && this.saveKycSerialNum(this.serialNum)
        }, l.prototype.saveKycSerialNum = function(l) {
          var n = this;
          this.localStorage.get("kycId").then(function(t) {
            var e = JSON.parse(t);
            e[n.did][n.path][l] = {
              serialNum: l,
              pathStatus: 0,
              payObj: {
                did: n.did,
                addr: "EKZCcfqBP1YXiDtJVNdnLQR74QRHKrgFYD",
                money: n.payMoney,
                appType: "kyc",
                chianId: "ELA",
                selectType: n.path,
                parms: n.personValidate
              }
            }, n.localStorage.set("kycId", e).then(function(t) {
              n.personValidate.serialNum = l, n.native.Go(n.navCtrl, Re, {
                did: n.did,
                addr: "EKZCcfqBP1YXiDtJVNdnLQR74QRHKrgFYD",
                money: n.payMoney,
                appType: "kyc",
                chianId: "ELA",
                selectType: n.path,
                parms: n.personValidate
              })
            })
          })
        }, l.prototype.checkIdentity = function() {
          if (ie.a.isNull(this.personValidate.fullName)) this.native.toast_trans("text-realname-message");
          else if (ie.a.isNull(this.personValidate.identityNumber)) this.native.toast_trans("text-cardNo-message-1");
          else {
            if (!ie.a.isCardNo(this.personValidate.identityNumber)) return !0;
            this.native.toast_trans("text-cardNo-message-2")
          }
        }, l.prototype.getPrice = function() {
          var l = this,
            n = {
              appid: "elastid",
              timestamp: this.native.getTimestamp()
            },
            t = fe.getCheckSum(n, "asc");
          n.checksum = t, this.native.getHttp().postByAuth(me.GET_PRICE, n).toPromise().then().then(function(n) {
            200 === n.status && (l.priceObj = JSON.parse(n._body), l.payMoney = l.priceObj.price || .1, l.unit = l.priceObj.unit || "ELA", l.serialNum = l.priceObj.serialNum)
          }).catch(function(l) {})
        }, l
      }(),
      Me = function() {
        function l(l, n, t, e, a) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.localStorage = e, this.dataManager = a, this.identitypathlist = [], this.parmar = {}, this.idsObj = {}, this.init()
        }
        return l.prototype.init = function() {
          var l = this;
          this.parmar = this.navParams.data, this.native.info(this.parmar), this.localStorage.get("kycId").then(function(n) {
            if (null != n && void 0 !== n && n !== {} && "" !== n) {
              l.idsObj = JSON.parse(n);
              var t = l.idsObj[l.parmar.id][l.parmar.path];
              for (var e in t) l.identitypathlist.push(t[e])
            }
          })
        }, l.prototype.onNext = function(l) {
          this.jumpPage(l)
        }, l.prototype.onCommit = function() {
          this.native.Go(this.navCtrl, De, this.parmar)
        }, l.prototype.jumpPage = function(l) {
          switch (l.pathStatus) {
            case 0:
              break;
            case 1:
              this.getAppAuth(l);
              break;
            case 2:
              this.native.Go(this.navCtrl, Ce, l)
          }
        }, l.prototype.getAppAuth = function(l) {
          var n = this,
            t = l.serialNum,
            e = l.txHash;
          this.native.info(typeof e), this.native.info(t), this.native.info(e);
          var a = this.native.getTimestamp(),
            u = {
              serialNum: t,
              txHash: e,
              timestamp: a
            },
            i = fe.getCheckSum(u, "asc");
          u.checksum = i, this.native.getHttp().postByAuth(me.APP_AUTH, u).toPromise().then().then(function(e) {
            if (200 === e.status) {
              n.native.info(e);
              var a = JSON.parse(e._body);
              if ("1" === a.errorCode) return void n.native.toast_trans("text-id-kyc-auth-fee-fail");
              if ("2" === a.errorCode) return void n.native.toast_trans("text-id-kyc-auth-query-timeout");
              if ("4" === a.errorCode) return void n.native.toast_trans("text-id-kyc-auth-uncompleted");
              if ("0" === a.errorCode && (l.adata = a.data, n.saveSerialNumParm(t, l), a.data.length > 0)) {
                var u = JSON.parse(JSON.stringify(a.data[0])),
                  i = u.resultSign;
                delete u.resultSign, n.dataManager.addSignCont(i, u)
              }
            }
          }).catch(function(l) {})
        }, l.prototype.saveSerialNumParm = function(l, n) {
          var t = this;
          n.pathStatus = 2, this.idsObj[this.parmar.id][this.parmar.path][l] = n, this.localStorage.set("kycId", this.idsObj).then(function() {
            t.native.Go(t.navCtrl, Ce, n)
          })
        }, l
      }(),
      je = function() {
        function l(l, n, t, e, a, u, i) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.walletManager = e, this.localStorage = a, this.events = u, this.dataManager = i, this.parmar = {}, this.pathList = [{
            name: "text-identity",
            path: "identityCard"
          }, {
            name: "text-certified-phone",
            path: "phone"
          }, {
            name: "text-certified-card",
            path: "bankCard"
          }, {
            name: "text-certified-company",
            path: "enterprise"
          }], this.init()
        }
        return l.prototype.init = function() {
          this.parmar = this.navParams.data
        }, l.prototype.onNext = function(l) {
          this.parmar.path = l.path, this.native.info(this.parmar), this.nextPage()
        }, l.prototype.nextPage = function() {
          var l = this;
          this.localStorage.get("kycId").then(function(n) {
            var t = JSON.parse(n),
              e = l.parmar.path,
              a = t[l.parmar.id];
            ie.a.isNull(a[e]) ? (a[e] = {}, l.localStorage.set("kycId", t).then(function() {
              l.jumpPage(e)
            })) : l.jumpPage(e)
          })
        }, l.prototype.jumpPage = function(l) {
          switch (l) {
            case "enterprise":
              this.native.Go(this.navCtrl, xe, this.parmar);
              break;
            case "identityCard":
              this.native.Go(this.navCtrl, Me, this.parmar);
              break;
            case "phone":
              this.native.Go(this.navCtrl, Se, this.parmar);
              break;
            case "bankCard":
              this.native.Go(this.navCtrl, Ie, this.parmar)
          }
        }, l
      }(),
      We = function() {
        function l(l, n, t, e, a, u, i) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.walletManager = e, this.localStorage = a, this.events = u, this.dataManager = i, this.init()
        }
        return l.prototype.ionViewDidLoad = function() {
          var l = this;
          this.navBar.backButtonClick = function(n) {
            l.native.setRootRouter(ua)
          }
        }, l.prototype.init = function() {
          var l = this,
            n = this;
          this.localStorage.get("kycId").then(function(t) {
            var e = JSON.parse(t);
            l.kycIdArr = ie.a.objtoarr(e), console.info("ElastosJs IdHomeComponent val" + t), n.initSeqObj(e), l.kycIdArr.forEach(function(l) {
              console.info("ElastosJs IdHomeComponent e.id registerIdListener begin  " + l.id), n.walletManager.registerIdListener(l.id, function(l) {
                if (console.info("home.ts ElastosJs ngOnInit registerIdListener data " + JSON.stringify(l)), "Added" == l.path) {
                  var t = JSON.parse(l.value);
                  if (console.info("home.ts ElastosJs ngOnInit registerIdListener valueObj " + JSON.stringify(t)), t.Contents.length > 0 && t.Contents[0].Values.length > 0 && t.Contents[0].Values[0].Proof) {
                    var e = JSON.parse(t.Contents[0].Values[0].Proof);
                    console.info('home.ts ElastosJs ngOnInit proofObj["signature"]  ' + e.signature);
                    var a = n.dataManager.getSeqNumObj(e.signature).serialNum;
                    console.info("home.ts ElastosJs ngOnInit serialNum " + a), n.setOrderStatus(5, a);
                    var u = n.dataManager.OutPutIDJson(l.id, t.Contents[0].Path, e.signature);
                    n.testDataHash(u)
                  }
                }
                console.info("home.ts ElastosJs ngOnInit registerIdListener  data  callback !!!!!" + JSON.stringify(l))
              }), console.info("ElastosJs IdHomeComponent e.id  end registerIdListener" + l.id)
            })
          }), this.events.subscribe("idhome:update", function() {
            l.localStorage.get("kycId").then(function(n) {
              l.kycIdArr = ie.a.objtoarr(JSON.parse(n))
            })
          })
        }, l.prototype.testDataHash = function(l) {
          var n = l.DataHash[0];
          console.info("Elastjs testDataHash DataHashElement " + JSON.stringify(n));
          var t = {};
          t.Proof = n.Proof;
          var e = n.KycContent;
          console.info("Elastjs testDataHash kycContent " + JSON.stringify(e)), console.info('Elastjs testDataHash valueObj["proof"] ' + t.Proof);
          var a = fe.hash(JSON.stringify(e) + t.Proof);
          t.DataHash = fe.hash(a + t.Proof), console.info("ElastJs testDataHash DataHash " + t.DataHash + " targetHash " + l.DataHash[0].hash)
        }, l.prototype.initSeqObj = function(l) {
          console.info("ElastosJs initSeqObj begin allStoreSeqNumJsonObj" + JSON.stringify(l));
          var n = this,
            t = l;
          for (var e in t) {
            var a = t[e];
            if (a.kyc) {
              var u = function(l) {
                if (!a.kyc[l].order) return "continue";
                var t = a.kyc[l].order,
                  e = function(l) {
                    t[l].params && t[l].params.adata && ([], t[l].params.adata.forEach(function(e) {
                      if (e && e.retdata && e.retdata.signature) {
                        n.dataManager.addSeqNumObj(e.retdata.signature, t[l])
                      }
                    }))
                  };
                for (var u in t) e(u)
              };
              for (var i in a.kyc) u(i)
            }
          }
          console.info("ElastosJs initSeqObj end ")
        }, l.prototype.onNext = function(l) {
          switch (l) {
            case 0:
              this.createDID();
              break;
            case 1:
              this.native.Go(this.navCtrl, ve);
              break;
            case 2:
              this.native.Go(this.navCtrl, ye)
          }
        }, l.prototype.onItem = function(l) {
          this.native.Go(this.navCtrl, je, {
            id: l.id
          })
        }, l.prototype.createDID = function() {
          var l = this;
          this.walletManager.createDID("s12345678", function(n) {
            var t = {
                id: n.didname
              },
              e = l;
            l.walletManager.registerIdListener(n.didname, function(l) {
              if (console.info("home.ts ElastosJs createDID registerIdListener " + JSON.stringify(l)), "Added" == l.path) {
                var n = JSON.parse(l.value);
                if (n.Contents.length > 0 && n.Contents[0].Values.length > 0 && n.Contents[0].Values[0].Proof) {
                  var t = JSON.parse(n.Contents[0].Values[0].Proof);
                  console.info('home.ts ElastosJs createDID proofObj["signature"]  ' + t.signature);
                  var a = e.dataManager.getSeqNumObj(t.signature).serialNum;
                  console.info("home.ts ElastosJs createDID serialNum " + a), e.setOrderStatus(5, a);
                  var u = e.dataManager.OutPutIDJson(l.id, n.Contents[0].Path, t.signature);
                  e.testDataHash(u)
                }
              }
              console.info("home.ts ElastosJs createDID registerIdListener  data  callback !!!!!" + JSON.stringify(l))
            }), l.localStorage.add("kycId", t).then(function() {
              l.kycIdArr.push({
                id: n.didname
              })
            })
          })
        }, l.prototype.getDID = function() {
          var l = this;
          this.walletManager.getDIDList(function(n) {
            l.kycIdArr = JSON.parse(n.list)
          })
        }, l.prototype.setOrderStatus = function(l, n) {
          var t = this;
          console.info("ElastJs setOrderStatus begin status " + l + " serialNum " + n);
          var e = $t.a.getSerIds(),
            a = e[n];
          console.info("ElastJs setOrderStatus serid " + JSON.stringify(a)), console.info("ElastJs setOrderStatus serids " + JSON.stringify(e));
          var u = a.id,
            i = a.path;
          console.info("ElastJs setOrderStatus appr " + i);
          var s = {};
          this.localStorage.getKycList("kycId").then(function(e) {
            console.info("ElastJs setOrderStatus getKycList " + e), null != e && void 0 !== e && e !== {} && "" !== e ? (s = JSON.parse(e), console.info("ElastJs setOrderStatus before chg status did " + u + " path " + i + " serialNum " + n + " status " + l), s[u][i][n].pathStatus = l, t.localStorage.set("kycId", s).then(function() {
              t.events.publish("order:update", l, i), console.info("ElastJs setOrderStatus pulish order ")
            })) : console.info("ElastJs setOrderStatus getKycList err return ")
          })
        }, l
      }(),
      Oe = function() {
        function l(l, n, t, e, a, u, i) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.walletManager = e, this.localStorage = a, this.events = u, this.dataManager = i, this.init()
        }
        return l.prototype.init = function() {
          this.parms = this.navParams.data;
          var l = this.parms.status;
          this.type = ie.a.isNull(l) ? "0" : l
        }, l.prototype.ionViewDidLoad = function() {
          var l = this;
          this.navBar.backButtonClick = function(n) {
            l.native.setRootRouter(We)
          }
        }, l.prototype.check = function() {
          this.native.Go(this.navCtrl, je, this.parms)
        }, l
      }(),
      Ne = function() {
        function l(l, n, t, e) {
          var a = this;
          this.navCtrl = l, this.navParams = n, this.native = t, this.walletManager = e, this.qrcode = null, this.txHash = "", this.toAddress = "";
          var u = this.navParams.data;
          this.fee = u.tx.fee;
          this.walletManager.decodeTransactionFromString(u.tx.raw, function(l) {
            l.success && (a.native.info(l), a.txHash = JSON.parse(l.success).TxHash, a.toAddress = JSON.parse(l.success).Outputs[0].Address, a.amount = JSON.parse(l.success).Outputs[0].Amount / $t.a.SELA)
          }), this.qrcode = JSON.stringify(u), this.native.info(this.navParams.data)
        }
        return l.prototype.ionViewDidLoad = function() {}, l
      }(),
      Te = function() {
        function l(l, n, t, e) {
          this.navCtrl = l, this.navParams = n, this.viewCtrl = t, this.native = e, this.SELA = $t.a.SELA, this.toAddress = "", this.walltype = !1, this.transfer = {
            toAddress: "",
            amount: "",
            memo: "",
            fee: 0,
            payPassword: "",
            remark: "",
            rate: ""
          };
          var a = $t.a.getCurMasterWalletId(),
            u = $t.a.getAccountType(a);
          this.walltype = "Multi-Sign" !== u.Type || "Readonly" !== u.InnerType, this.transfer = this.navParams.data, this.toAddress = this.transfer.rate ? this.transfer.accounts : this.transfer.toAddress
        }
        return l.prototype.ionViewDidLoad = function() {}, l.prototype.ionViewWillEnter = function() {
          this.transfer.payPassword = ""
        }, l.prototype.click_close = function() {
          this.viewCtrl.dismiss(null)
        }, l.prototype.click_button = function() {
          this.walltype ? this.transfer.payPassword ? this.viewCtrl.dismiss(this.transfer) : this.native.toast_trans("text-pwd-validator") : this.viewCtrl.dismiss(this.transfer)
        }, l
      }(),
      Le = function() {
        function l(l, n, t, e, a) {
          var u = this;
          this.navCtrl = l, this.navParams = n, this.popupProvider = t, this.native = e, this.walletManager = a, this.masterWalletId = "1", this.singPublickey = [], this.type = this.navParams.data.type, this.txDetails = JSON.parse(this.navParams.data.content).tx, this.masterWalletId = $t.a.getCurMasterWalletId(), this.native.info(this.txDetails), this.walletManager.decodeTransactionFromString(this.txDetails.raw, function(l) {
            l.success && (u.native.info(l), u.raw = l.success, u.txHash = JSON.parse(l.success).TxHash, u.txDetails.address = JSON.parse(l.success).Outputs[0].Address, u.txDetails.amount = JSON.parse(l.success).Outputs[0].Amount / $t.a.SELA, u.getTransactionSignedSigners(u.masterWalletId, u.txDetails.chianId, u.raw))
          })
        }
        return l.prototype.ionViewDidLoad = function() {
          console.log("ionViewDidLoad TxdetailsPage")
        }, l.prototype.nextPage = function() {
          var l = this;
          4 === this.type ? this.getPassWord() : 3 === this.type && this.native.showLoading().then(function() {
            l.sendTx(l.masterWalletId, l.txDetails.chianId, l.raw)
          })
        }, l.prototype.getPassWord = function() {
          var l = this;
          this.popupProvider.presentPrompt().then(function(n) {
            ie.a.isNull(n) ? l.native.toast_trans("text-id-kyc-prompt-password") : l.singTx(l.masterWalletId, l.txDetails.chianId, l.raw, n.toString())
          }).catch(function(l) {
            alert(JSON.stringify(l))
          })
        }, l.prototype.singTx = function(l, n, t, e) {
          var a = this;
          this.walletManager.signTransaction(l, n, t, e, function(l) {
            l.success && (a.native.info(l), a.walletManager.encodeTransactionToString(l.success, function(l) {
              l.success && a.native.Go(a.navCtrl, Ne, {
                tx: {
                  chianId: a.txDetails.chianId,
                  fee: a.txDetails.fee,
                  raw: l.success
                }
              })
            }))
          })
        }, l.prototype.sendTx = function(l, n, t) {
          var e = this;
          this.walletManager.publishTransaction(l, n, t, function(l) {
            l.success && (e.native.info(l), e.native.hideLoading(), e.native.toast_trans("send-raw-transaction"), e.navCtrl.pop())
          })
        }, l.prototype.getTransactionSignedSigners = function(l, n, t) {
          var e = this;
          this.walletManager.getTransactionSignedSigners(l, n, t, function(l) {
            e.native.info(l), l.success && (e.native.info(l.success), e.singPublickey = JSON.parse(l.success).Signers, e.native.info(e.singPublickey))
          })
        }, l
      }(),
      Ae = function() {
        function l(l, n, t, e, a, u) {
          this.navCtrl = l, this.navParams = n, this.qrScanner = t, this.viewCtrl = e, this.events = a, this.native = u, this.isShow = !1, this.light = !1, this.frontCamera = !1, this.pageType = this.navParams.get("pageType")
        }
        return l.prototype.ionViewDidLoad = function() {
          var l = this;
          this.qrScanner.prepare().then(function(n) {
            if (n.authorized) {
              l.qrScanner.scan().subscribe(function(n) {
                switch (l.pageType) {
                  case "1":
                    var t = "";
                    t = -1 != n.indexOf("elastos") ? n.split(":")[1] : n.split(":")[0], l.events.publish("address:update", t), l.hideCamera(), l.navCtrl.pop();
                    break;
                  case "3":
                    l.hideCamera(), l.navCtrl.pop();
                    l.native.Go(l.navCtrl, Le, {
                      content: n,
                      type: 4
                    });
                    break;
                  case "4":
                    l.hideCamera(), l.navCtrl.pop();
                    l.native.Go(l.navCtrl, Le, {
                      content: n,
                      type: 3
                    });
                    break;
                  case "5":
                    l.events.publish("publickey:update", n), l.hideCamera(), l.navCtrl.pop();
                    break;
                  case "6":
                    l.events.publish("privatekey:update", n), l.hideCamera(), l.navCtrl.pop()
                }
              });
              l.qrScanner.show()
            }
          }).catch(function(l) {
            return console.log("Error is", l)
          })
        }, l.prototype.ionViewDidEnter = function() {
          this.showCamera(), this.isShow = !0
        }, l.prototype.toggleLight = function() {
          this.light ? this.qrScanner.disableLight() : this.qrScanner.enableLight(), this.light = !this.light
        }, l.prototype.toggleCamera = function() {
          this.frontCamera ? this.qrScanner.useBackCamera() : this.qrScanner.useFrontCamera(), this.frontCamera = !this.frontCamera
        }, l.prototype.showCamera = function() {
          window.document.querySelector("ion-app").classList.add("cameraView")
        }, l.prototype.hideCamera = function() {
          window.document.querySelector("ion-app").classList.remove("cameraView"), this.qrScanner.hide(), this.qrScanner.destroy()
        }, l.prototype.ionViewWillLeave = function() {
          this.hideCamera()
        }, l
      }(),
      Re = function() {
        function l(l, n, t, e, a, u, i) {
          this.navCtrl = l, this.navParams = n, this.walletManager = t, this.native = e, this.localStorage = a, this.modalCtrl = u, this.events = i, this.masterWalletId = "1", this.walletType = "", this.transfer = {
            toAddress: "",
            amount: "",
            memo: "",
            fee: 0,
            payPassword: "",
            remark: ""
          }, this.balance = 0, this.feePerKb = 1e4, this.SELA = $t.a.SELA, this.appType = "", this.selectType = "", this.isInput = !1, this.walletInfo = {}, this.init()
        }
        return l.prototype.init = function() {
          var l = this;
          this.events.subscribe("address:update", function(n) {
            l.transfer.toAddress = n
          }), this.masterWalletId = $t.a.getCurMasterWalletId();
          var n = this.navParams.data;
          this.chianId = n.chianId, this.transfer.toAddress = n.addr || "", this.transfer.amount = n.money || "", this.appType = n.appType || "", this.isInput = "" != this.appType, this.selectType = n.selectType || "", this.parms = n.parms || "", this.did = n.did || "", this.walletInfo = n.walletInfo || {}, this.initData()
        }, l.prototype.rightHeader = function() {
          this.native.Go(this.navCtrl, Ae, {
            pageType: "1"
          })
        }, l.prototype.initData = function() {
          var l = this;
          this.walletManager.getBalance(this.masterWalletId, this.chianId, function(n) {
            ie.a.isNull(n.success) ? alert("===getBalance===error" + JSON.stringify(n)) : l.balance = n.success
          })
        }, l.prototype.onClick = function(l) {
          switch (l) {
            case 1:
              this.native.Go(this.navCtrl, ce, {
                hideButton: !0
              });
              break;
            case 2:
              this.checkValue()
          }
        }, l.prototype.checkValue = function() {
          var l = this;
          ie.a.isNull(this.transfer.toAddress) ? this.native.toast_trans("correct-address") : ie.a.isNull(this.transfer.amount) ? this.native.toast_trans("amount-null") : ie.a.number(this.transfer.amount) ? this.transfer.amount > this.balance ? this.native.toast_trans("error-amount") : this.transfer.amount * $t.a.SELA >= 1 ? this.walletManager.isAddressValid(this.masterWalletId, this.transfer.toAddress, function(n) {
            n.success ? l.native.showLoading().then(function() {
              "Standard" === l.walletInfo.Type ? l.createTransaction() : "Multi-Sign" === l.walletInfo.Type && l.createMultTx()
            }) : l.native.toast_trans("contact-address-digits")
          }) : this.native.toast_trans("error-amount") : this.native.toast_trans("correct-amount")
        }, l.prototype.createTransaction = function() {
          var l = this,
            n = 0;
          n = this.transfer.amount < 1 ? parseInt((this.transfer.amount * $t.a.SELA).toPrecision(8)) : this.transfer.amount * $t.a.SELA, this.walletManager.createTransaction(this.masterWalletId, this.chianId, "", this.transfer.toAddress, n, this.transfer.memo, this.transfer.remark, function(n) {
            n.success ? (l.native.info(n), l.rawTransaction = n.success, l.getFee()) : l.native.info(n)
          })
        }, l.prototype.getFee = function() {
          var l = this;
          this.walletManager.calculateTransactionFee(this.masterWalletId, this.chianId, this.rawTransaction, this.feePerKb, function(n) {
            n.success ? (l.native.hideLoading(), l.native.info(n), l.transfer.fee = n.success, l.openPayModal(l.transfer)) : l.native.info(n)
          })
        }, l.prototype.sendRawTransaction = function() {
          this.updateTxFee()
        }, l.prototype.updateTxFee = function() {
          var l = this;
          this.walletManager.updateTransactionFee(this.masterWalletId, this.chianId, this.rawTransaction, this.transfer.fee, function(n) {
            if (n.success) {
              if (l.native.info(n), "Multi-Sign" === l.walletInfo.Type && "Readonly" === l.walletInfo.InnerType) return void l.readWallet(n.success);
              l.singTx(n.success)
            } else l.native.info(n)
          })
        }, l.prototype.singTx = function(l) {
          var n = this;
          this.walletManager.signTransaction(this.masterWalletId, this.chianId, l, this.transfer.payPassword, function(l) {
            l.success ? (n.native.info(l), "Standard" === n.walletInfo.Type ? n.sendTx(l.success) : "Multi-Sign" === n.walletInfo.Type && n.walletManager.encodeTransactionToString(l.success, function(l) {
              l.success ? (n.native.hideLoading(), n.native.Go(n.navCtrl, Ne, {
                tx: {
                  chianId: n.chianId,
                  fee: n.transfer.fee / $t.a.SELA,
                  raw: l.success
                }
              })) : n.native.info(l)
            })) : n.native.info(l)
          })
        }, l.prototype.sendTx = function(l) {
          var n = this;
          this.native.info(l), this.walletManager.publishTransaction(this.masterWalletId, this.chianId, l, function(l) {
            l.success ? (n.native.hideLoading(), n.native.info(l), n.txId = JSON.parse(l.success).TxHash, ie.a.isNull(n.appType) ? (n.native.toast_trans("send-raw-transaction"), n.native.setRootRouter(ua)) : "kyc" === n.appType && ("enterprise" === n.selectType ? n.company() : n.person())) : n.native.info(l)
          })
        }, l.prototype.company = function() {
          this.sendCompanyHttp(this.parms)
        }, l.prototype.person = function() {
          this.sendPersonAuth(this.parms)
        }, l.prototype.sendCompanyHttp = function(l) {
          var n = this,
            t = this.native.getTimestamp();
          l.timestamp = t, l.txHash = this.txId, l.deviceID = $t.a.getdeviceID();
          var e = fe.getCheckSum(l, "asc");
          l.checksum = e, console.info("ElastJs sendCompanyHttp params " + JSON.stringify(l)), this.native.getHttp().postByAuth(me.AUTH, l).toPromise().then(function(l) {
            if (200 === l.status) {
              var t = JSON.parse(l._body);
              if (console.info("Elastjs sendCompanyHttp authData" + JSON.stringify(t)), "0" === t.errorCode) {
                var e = t.serialNum,
                  a = $t.a.getSerIds();
                a[e] = {
                  id: n.did,
                  path: n.selectType,
                  serialNum: e,
                  txHash: n.txId
                }, $t.a.setSerIds(a), n.saveKycSerialNum(e)
              } else alert("sendCompanyHttp 错误码:" + t.errorCode)
            }
          }).catch(function(l) {
            alert("错误码:" + JSON.stringify(l)), n.native.Go(n.navCtrl, Oe, {
              status: "1"
            })
          })
        }, l.prototype.sendPersonAuth = function(l) {
          var n = this,
            t = this.native.getTimestamp();
          l.timestamp = t, l.txHash = this.txId, l.deviceID = $t.a.getdeviceID();
          var e = fe.getCheckSum(l, "asc");
          l.checksum = e, this.native.info(l), this.native.getHttp().postByAuth(me.AUTH, l).toPromise().then(function(l) {
            if (200 === l.status) {
              var t = JSON.parse(l._body);
              if (console.log("ElastJs sendPersonAuth return data ---authData---" + JSON.stringify(t)), "0" === t.errorCode) {
                console.log("ElastJs sendPersonAuth errorCode == 0");
                var e = t.serialNum,
                  a = $t.a.getSerIds();
                a[e] = {
                  id: n.did,
                  path: n.selectType,
                  serialNum: e,
                  txHash: n.txId
                }, console.log("ElastJs sendPersonAuth selectType " + n.selectType + " serialNum " + e), $t.a.setSerIds(a), n.saveKycSerialNum(e)
              } else alert("错误码:" + t.errorCode)
            }
          }).catch(function(l) {}), this.native.Go(this.navCtrl, Oe, {
            status: "0"
          })
        }, l.prototype.saveKycSerialNum = function(l) {
          var n = this;
          console.log("ElastJs saveKycSerialNum serialNum begin" + l), this.localStorage.get("kycId").then(function(t) {
            var e = JSON.parse(t),
              a = e[n.did][n.selectType][l];
            a.txHash = n.txId, a.pathStatus = 1, n.localStorage.set("kycId", e).then(function(l) {
              n.native.Go(n.navCtrl, Oe, {
                status: "0",
                id: n.did,
                path: n.selectType
              })
            })
          })
        }, l.prototype.createMultTx = function() {
          var l = this,
            n = 0;
          n = this.transfer.amount < 1 ? parseInt((this.transfer.amount * $t.a.SELA).toPrecision(8)) : this.transfer.amount * $t.a.SELA, this.walletManager.createMultiSignTransaction(this.masterWalletId, this.chianId, "", this.transfer.toAddress, n, this.transfer.memo, function(n) {
            n.success ? (l.native.info(n), l.rawTransaction = n.success, l.getFee()) : l.native.info(n)
          })
        }, l.prototype.readWallet = function(l) {
          var n = this;
          this.walletManager.encodeTransactionToString(l, function(l) {
            l.success ? (n.native.hideLoading(), n.native.Go(n.navCtrl, Ne, {
              tx: {
                chianId: n.chianId,
                fee: n.transfer.fee / $t.a.SELA,
                raw: l.success
              }
            })) : alert("=====encodeTransactionToString===error===" + JSON.stringify(l))
          })
        }, l.prototype.openPayModal = function(l) {
          var n = this,
            t = this.native.clone(l),
            e = this.modalCtrl.create(Te, t);
          e.onDidDismiss(function(l) {
            l && n.native.showLoading().then(function() {
              n.transfer = n.native.clone(l), n.sendRawTransaction()
            })
          }), e.present()
        }, l
      }(),
      Je = function() {
        function l(l, n, t, e, a, u, i) {
          this.navCtrl = l, this.navParams = n, this.walletManager = t, this.native = e, this.localStorage = a, this.modalCtrl = u, this.events = i, this.masterWalletId = "1", this.transfer = {
            toAddress: "",
            amount: "",
            memo: "",
            fee: 1e4,
            payPassword: "",
            remark: ""
          }, this.sidechain = {
            accounts: "",
            amounts: 0,
            index: 0,
            rate: 1
          }, this.balance = 0, this.feePerKb = 1e4, this.SELA = $t.a.SELA, this.walletInfo = {}, this.init()
        }
        return l.prototype.init = function() {
          var l = this;
          this.events.subscribe("address:update", function(n) {
            l.sidechain.accounts = n
          }), this.masterWalletId = $t.a.getCurMasterWalletId();
          var n = this.navParams.data;
          this.walletInfo = n.walletInfo || {}, this.chianId = n.chianId, this.getGenesisAddress(), this.initData()
        }, l.prototype.rightHeader = function() {
          this.native.Go(this.navCtrl, Ae, {
            pageType: "1"
          })
        }, l.prototype.initData = function() {
          var l = this;
          this.walletManager.getBalance(this.masterWalletId, "ELA", function(n) {
            ie.a.isNull(n.success) ? l.native.info(n) : (l.native.info(n), l.balance = n.success)
          })
        }, l.prototype.onClick = function(l) {
          switch (l) {
            case 2:
              this.checkValue()
          }
        }, l.prototype.checkValue = function() {
          var l = this;
          ie.a.isNull(this.sidechain.accounts) ? this.native.toast_trans("correct-address") : ie.a.isNull(this.transfer.amount) ? this.native.toast_trans("amount-null") : ie.a.number(this.transfer.amount) ? this.transfer.amount > this.balance ? this.native.toast_trans("error-amount") : this.transfer.amount * $t.a.SELA >= 1 ? this.walletManager.isAddressValid(this.masterWalletId, this.sidechain.accounts, function(n) {
            n.success ? l.native.showLoading().then(function() {
              l.createDepositTransaction()
            }) : l.native.toast_trans("contact-address-digits")
          }) : this.native.toast_trans("error-amount") : this.native.toast_trans("correct-amount")
        }, l.prototype.createDepositTransaction = function() {
          var l = this,
            n = 0;
          n = this.transfer.amount < 1 ? parseInt((this.transfer.amount * $t.a.SELA).toPrecision(8)) : this.transfer.amount * $t.a.SELA;
          var t = JSON.stringify([this.sidechain.accounts]),
            e = JSON.stringify([parseInt((this.transfer.amount * $t.a.SELA).toPrecision(8)) - this.transfer.fee]),
            a = JSON.stringify([this.sidechain.index]);
          this.walletManager.createDepositTransaction(this.masterWalletId, "ELA", "", this.transfer.toAddress, n, t, e, a, this.transfer.memo, this.transfer.remark, function(n) {
            n.success ? (l.native.info(n), l.rawTransaction = n.success, l.getFee()) : l.native.info(n)
          })
        }, l.prototype.getGenesisAddress = function() {
          var l = this;
          this.walletManager.getGenesisAddress(this.masterWalletId, this.chianId, function(n) {
            l.transfer.toAddress = n.success
          })
        }, l.prototype.getFee = function() {
          var l = this;
          this.walletManager.calculateTransactionFee(this.masterWalletId, "ELA", this.rawTransaction, this.feePerKb, function(n) {
            n.success ? (l.native.hideLoading(), l.native.info(n), l.transfer.fee = n.success, l.transfer.rate = l.sidechain.rate, l.openPayModal(l.transfer)) : l.native.info(n)
          })
        }, l.prototype.sendRawTransaction = function() {
          this.updateTxFee()
        }, l.prototype.updateTxFee = function() {
          var l = this;
          this.walletManager.updateTransactionFee(this.masterWalletId, "ELA", this.rawTransaction, this.transfer.fee, function(n) {
            if (n.success) {
              if (l.native.info(n), "Multi-Sign" === l.walletInfo.Type && "Readonly" === l.walletInfo.InnerType) return void l.readWallet(n.success);
              l.singTx(n.success)
            } else l.native.info(n)
          })
        }, l.prototype.singTx = function(l) {
          var n = this;
          this.walletManager.signTransaction(this.masterWalletId, "ELA", l, this.transfer.payPassword, function(l) {
            l.success ? (n.native.info(l), "Standard" === n.walletInfo.Type ? n.sendTx(l.success) : "Multi-Sign" === n.walletInfo.Type && n.walletManager.encodeTransactionToString(l.success, function(l) {
              l.success ? (n.native.hideLoading(), n.native.Go(n.navCtrl, Ne, {
                tx: {
                  chianId: "ELA",
                  fee: n.transfer.fee / $t.a.SELA,
                  raw: l.success
                }
              })) : n.native.info(l)
            })) : n.native.info(l)
          })
        }, l.prototype.sendTx = function(l) {
          var n = this;
          this.walletManager.publishTransaction(this.masterWalletId, "ELA", l, function(l) {
            l.success ? (n.native.hideLoading(), n.native.info(l), n.native.setRootRouter(ua)) : n.native.info(l)
          })
        }, l.prototype.openPayModal = function(l) {
          var n = this,
            t = this.native.clone(l);
          t.accounts = this.sidechain.accounts;
          var e = this.modalCtrl.create(Te, t);
          e.onDidDismiss(function(l) {
            l && n.native.showLoading().then(function() {
              n.transfer = n.native.clone(l), n.sendRawTransaction()
            })
          }), e.present()
        }, l.prototype.readWallet = function(l) {
          var n = this;
          this.walletManager.encodeTransactionToString(l, function(l) {
            l.success ? (n.native.hideLoading(), n.native.Go(n.navCtrl, Ne, {
              tx: {
                chianId: "ELA",
                fee: n.transfer.fee / $t.a.SELA,
                raw: l.success
              }
            })) : alert("=====encodeTransactionToString===error===" + JSON.stringify(l))
          })
        }, l
      }(),
      Ee = function() {
        function l(l, n, t) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.isNoData = !1, this.coinList = [], this.masterWalletInfo = {}, this.init()
        }
        return l.prototype.init = function() {
          this.masterWalletInfo = this.navParams.get("walletInfo");
          var l = $t.a.getCurMasterWalletId(),
            n = $t.a.getSubWallet(l);
          if (n) {
            if (ie.a.isEmptyObject(n)) return this.coinList = [], void(this.isNoData = !0);
            this.isNoData = !1;
            for (var t in n) "ELA" != t && this.coinList.push({
              name: t
            })
          } else this.isNoData = !0, this.coinList = []
        }, l.prototype.onItem = function(l) {
          this.native.Go(this.navCtrl, Je, {
            chianId: l.name,
            walletInfo: this.masterWalletInfo
          })
        }, l
      }(),
      Ve = function() {
        function l(l, n, t, e, a, u, i) {
          this.navCtrl = l, this.navParams = n, this.walletManager = t, this.native = e, this.localStorage = a, this.modalCtrl = u, this.events = i, this.masterWalletId = "1", this.transfer = {
            toAddress: "",
            amount: "",
            memo: "",
            fee: 1e4,
            payPassword: "",
            remark: ""
          }, this.mainchain = {
            accounts: "",
            amounts: 0,
            index: 0,
            rate: 1
          }, this.balance = 0, this.feePerKb = 1e4, this.SELA = $t.a.SELA, this.walletInfo = {}, this.init()
        }
        return l.prototype.init = function() {
          var l = this;
          this.events.subscribe("address:update", function(n) {
            l.mainchain.accounts = n
          }), this.masterWalletId = $t.a.getCurMasterWalletId();
          var n = this.navParams.data;
          this.chianId = n.chianId, this.walletInfo = n.walletInfo, this.initData()
        }, l.prototype.rightHeader = function() {
          this.native.Go(this.navCtrl, Ae, {
            pageType: "1"
          })
        }, l.prototype.initData = function() {
          var l = this;
          this.walletManager.getBalance(this.masterWalletId, this.chianId, function(n) {
            ie.a.isNull(n.success) ? l.native.info(n) : (l.native.info(n), l.balance = n.success)
          })
        }, l.prototype.onClick = function(l) {
          switch (l) {
            case 2:
              this.checkValue()
          }
        }, l.prototype.checkValue = function() {
          var l = this;
          ie.a.isNull(this.mainchain.accounts) ? this.native.toast_trans("correct-address") : ie.a.isNull(this.transfer.amount) ? this.native.toast_trans("amount-null") : ie.a.number(this.transfer.amount) ? this.transfer.amount > this.balance ? this.native.toast_trans("error-amount") : this.transfer.amount * $t.a.SELA >= 1 ? this.walletManager.isAddressValid(this.masterWalletId, this.mainchain.accounts, function(n) {
            n.success ? l.native.showLoading().then(function() {
              l.createWithdrawTransaction()
            }) : l.native.toast_trans("contact-address-digits")
          }) : this.native.toast_trans("error-amount") : this.native.toast_trans("correct-amount")
        }, l.prototype.createWithdrawTransaction = function() {
          var l = this,
            n = 0;
          n = this.transfer.amount < 1 ? parseInt((this.transfer.amount * $t.a.SELA).toPrecision(8)) : this.transfer.amount * $t.a.SELA;
          var t = JSON.stringify([this.mainchain.accounts]),
            e = JSON.stringify([parseInt((this.transfer.amount * $t.a.SELA).toPrecision(8)) - this.transfer.fee]),
            a = JSON.stringify([this.mainchain.index]);
          this.walletManager.createWithdrawTransaction(this.masterWalletId, this.chianId, "", n, t, e, a, this.transfer.memo, this.transfer.remark, function(n) {
            n.success ? (l.native.info(n), l.rawTransaction = n.success, l.getFee()) : l.native.info(n)
          })
        }, l.prototype.getFee = function() {
          var l = this;
          this.walletManager.calculateTransactionFee(this.masterWalletId, this.chianId, this.rawTransaction, this.feePerKb, function(n) {
            n.success ? (l.native.hideLoading(), l.native.info(n), l.transfer.fee = n.success, l.transfer.rate = l.mainchain.rate, l.openPayModal(l.transfer)) : l.native.info(n)
          })
        }, l.prototype.sendRawTransaction = function() {
          this.updateTxFee()
        }, l.prototype.updateTxFee = function() {
          var l = this;
          this.walletManager.updateTransactionFee(this.masterWalletId, this.chianId, this.rawTransaction, this.transfer.fee, function(n) {
            if (n.success) {
              if (l.native.info(n), "Multi-Sign" === l.walletInfo.Type && "Readonly" === l.walletInfo.InnerType) return void l.readWallet(n.success);
              l.singTx(n.success)
            } else l.native.info(n)
          })
        }, l.prototype.singTx = function(l) {
          var n = this;
          this.walletManager.signTransaction(this.masterWalletId, this.chianId, l, this.transfer.payPassword, function(l) {
            l.success ? (n.native.info(l), "Standard" === n.walletInfo.Type ? n.sendTx(l.success) : "Multi-Sign" === n.walletInfo.Type && n.walletManager.encodeTransactionToString(l.success, function(l) {
              l.success ? (n.native.hideLoading(), n.native.Go(n.navCtrl, Ne, {
                tx: {
                  chianId: n.chianId,
                  fee: n.transfer.fee / $t.a.SELA,
                  raw: l.success
                }
              })) : n.native.info(l)
            })) : n.native.info(l)
          })
        }, l.prototype.sendTx = function(l) {
          var n = this;
          this.walletManager.publishTransaction(this.masterWalletId, this.chianId, l, function(l) {
            l.success ? (n.native.hideLoading(), n.native.info(l), n.native.setRootRouter(ua)) : n.native.info(l)
          })
        }, l.prototype.openPayModal = function(l) {
          var n = this,
            t = this.native.clone(l);
          t.accounts = this.mainchain.accounts;
          var e = this.modalCtrl.create(Te, t);
          e.onDidDismiss(function(l) {
            l && n.native.showLoading().then(function() {
              n.transfer = l, n.sendRawTransaction()
            })
          }), e.present()
        }, l.prototype.readWallet = function(l) {
          var n = this;
          this.walletManager.encodeTransactionToString(l, function(l) {
            l.success ? (n.native.hideLoading(), n.native.Go(n.navCtrl, Ne, {
              tx: {
                chianId: n.chianId,
                fee: n.transfer.fee / $t.a.SELA,
                raw: l.success
              }
            })) : alert("=====encodeTransactionToString===error===" + JSON.stringify(l))
          })
        }, l
      }(),
      Fe = function() {
        function l(l, n, t, e, a) {
          this.navCtrl = l, this.navParams = n, this.walletManager = t, this.events = e, this.native = a, this.masterWalletId = "1", this.addrList = [], this.pageNo = 0, this.start = 0, this.init()
        }
        return l.prototype.init = function() {
          this.masterWalletId = $t.a.getCurMasterWalletId(), this.chinaId = this.navParams.get("chinaId"), this.getAddressList()
        }, l.prototype.getAddressList = function() {
          var l = this;
          this.walletManager.getAllAddress(this.masterWalletId, this.chinaId, this.start, function(n) {
            if (n.success) {
              l.native.info(n);
              var t = JSON.parse(n.success).Addresses;
              if (l.MaxCount = JSON.parse(n.success).MaxCount, !t) return void l.infinites.enable(!1);
              l.addrList = 0 != l.pageNo ? l.addrList.concat(JSON.parse(n.success).Addresses) : JSON.parse(n.success).Addresses
            } else alert("==getAllAddress==error" + JSON.stringify(n))
          })
        }, l.prototype.onItem = function(l) {
          this.native.copyClipboard(l), this.native.toast_trans("copy-ok")
        }, l.prototype.doInfinite = function(l) {
          var n = this;
          this.infinites = l, setTimeout(function() {
            n.pageNo++, n.start = 20 * n.pageNo, n.start >= n.MaxCount ? n.infinites.enable(!1) : (n.getAddressList(), l.complete())
          }, 500)
        }, l
      }(),
      ze = function() {
        function l(l, n, t, e) {
          this.navCtrl = l, this.navParams = n, this.walletManager = t, this.native = e, this.masterWalletId = "1", this.qrcode = null, this.init()
        }
        return l.prototype.init = function() {
          this.masterWalletId = $t.a.getCurMasterWalletId(), this.chinaId = this.navParams.get("chianId"), this.createAddress()
        }, l.prototype.onChange = function() {
          ie.a.number(this.amount) || this.native.toast_trans("correct-amount")
        }, l.prototype.onNext = function(l) {
          switch (l) {
            case 0:
              this.native.copyClipboard(this.qrcode), this.native.toast_trans("copy-ok");
              break;
            case 1:
              this.createAddress();
              break;
            case 2:
              this.native.Go(this.navCtrl, Fe, {
                chinaId: this.chinaId
              })
          }
        }, l.prototype.createAddress = function() {
          var l = this;
          this.walletManager.createAddress(this.masterWalletId, this.chinaId, function(n) {
            n.success ? (l.qrcode = n.success, l.address = n.success) : alert("===createAddress===error" + JSON.stringify(n))
          })
        }, l
      }(),
      Ke = function() {
        function l(l, n, t, e) {
          this.navCtrl = l, this.navParams = n, this.walletManager = t, this.native = e, this.masterWalletId = "1", this.transactionRecord = {}, this.start = 0, this.payStatusIcon = "", this.blockchain_url = $t.a.BLOCKCHAIN_URL
        }
        return l.prototype.ionViewWillEnter = function() {
          this.init()
        }, l.prototype.ionViewDidLeave = function() {}, l.prototype.init = function() {
          var l = this;
          this.masterWalletId = $t.a.getCurMasterWalletId();
          var n = this.navParams.get("txId"),
            t = this.navParams.get("chainId");
          this.walletManager.getAllTransaction(this.masterWalletId, t, this.start, n, function(e) {
            if (e.success) {
              l.native.info(e);
              var a = JSON.parse(e.success).Transactions[0].Summary,
                u = 1e3 * a.Timestamp,
                i = ie.a.dateFormat(new Date(u), "yyyy-MM-dd HH:mm:ss"),
                s = a.Incoming.Amount,
                o = a.Outcoming.Amount,
                r = a.Incoming.ToAddress,
                c = a.Outcoming.ToAddress,
                _ = s - o,
                d = 0;
              d = 0 === o && "" === c ? _ : _ - a.Fee;
              var h = "";
              switch (a.Status) {
                case "Confirmed":
                  h = "Confirmed";
                  break;
                case "Pending":
                  h = "Pending";
                  break;
                case "Unconfirmed":
                  h = "Unconfirmed"
              }
              _ > 0 ? l.payStatusIcon = "./assets/images/tx-state/icon-tx-received-outline.svg" : _ < 0 ? l.payStatusIcon = "./assets/images/tx-state/icon-tx-sent.svg" : 0 == _ && (l.payStatusIcon = "./assets/images/tx-state/icon-tx-moved.svg"), l.transactionRecord = {
                name: t,
                status: h,
                balance: ie.a.scientificToNumber(_ / $t.a.SELA),
                incomingAmount: ie.a.scientificToNumber(s / $t.a.SELA),
                outcomingAmount: ie.a.scientificToNumber(o / $t.a.SELA),
                resultAmount: ie.a.scientificToNumber(d / $t.a.SELA),
                incomingAddress: r,
                outcomingAddress: c,
                txId: n,
                transactionTime: i,
                timestamp: u,
                payfees: ie.a.scientificToNumber(a.Fee / $t.a.SELA),
                confirmCount: a.ConfirmStatus,
                remark: a.Remark
              }
            } else alert("======getAllTransaction====error" + JSON.stringify(e))
          })
        }, l.prototype.onNext = function(l) {
          this.native.copyClipboard(l), this.native.toast_trans("copy-ok")
        }, l.prototype.tiaozhuan = function(l) {
          self.location.href = this.blockchain_url + "tx/" + l
        }, l.prototype.doRefresh = function(l) {
          this.init(), setTimeout(function() {
            l.complete()
          }, 1e3)
        }, l
      }(),
      Be = function() {
        function l(l, n, t, e, a) {
          this.navCtrl = l, this.navParams = n, this.walletManager = t, this.native = e, this.events = a, this.masterWalletInfo = {}, this.masterWalletId = "1", this.transferList = [], this.coinCount = 0, this.coinId = 0, this.coinName = "", this.pageNo = 0, this.start = 0, this.textShow = "", this.isShowMore = !1, this.MaxCount = 0, this.isNodata = !1
        }
        return l.prototype.ionViewWillEnter = function() {
          this.init()
        }, l.prototype.ionViewDidLeave = function() {}, l.prototype.init = function() {
          var l = this;
          this.masterWalletId = $t.a.getCurMasterWalletId(), this.walletManager.getMasterWalletBasicInfo(this.masterWalletId, function(n) {
            if (n.success) {
              l.native.info(n);
              var t = JSON.parse(n.success).Account;
              l.masterWalletInfo = t
            } else alert("=======getMasterWalletBasicInfo====error=====" + JSON.stringify(n))
          }), this.coinName = this.navParams.get("name"), this.elaPer = this.navParams.get("elaPer") || 0, this.idChainPer = this.navParams.get("idChainPer") || 0, this.textShow = "ELA" == this.coinName ? "text-recharge" : "text-withdraw", this.initData()
        }, l.prototype.ionViewDidLoad = function() {
          var l = this;
          this.navBar.backButtonClick = function(n) {
            l.navCtrl.pop()
          }
        }, l.prototype.initData = function() {
          var l = this;
          this.walletManager.getBalance(this.masterWalletId, this.coinName, function(n) {
            ie.a.isNull(n.success) ? l.native.info(n) : (l.native.info(n), l.coinCount = n.success / $t.a.SELA)
          }), this.getAllTx()
        }, l.prototype.getAllTx = function() {
          var l = this;
          this.walletManager.getAllTransaction(this.masterWalletId, this.coinName, this.start, "", function(n) {
            if (n.success) {
              var t = JSON.parse(n.success),
                e = t.Transactions;
              if (l.MaxCount = t.MaxCount, l.isNodata = !(l.MaxCount > 0), !e) return void(l.isShowMore = !1);
              for (var a in e) {
                var u = e[a].Summary,
                  i = 1e3 * u.Timestamp,
                  s = ie.a.dateFormat(new Date(i)),
                  o = u.Outcoming.Amount,
                  r = u.Incoming.Amount - o,
                  c = 0;
                c = 0 === o && "" === u.Outcoming.ToAddress ? r : r - u.Fee;
                var _ = "";
                r > 0 ? _ = "./assets/images/tx-state/icon-tx-received-outline.svg" : r < 0 ? _ = "./assets/images/tx-state/icon-tx-sent.svg" : 0 == r && (_ = "./assets/images/tx-state/icon-tx-moved.svg");
                var d = "";
                switch (u.Status) {
                  case "Confirmed":
                    d = "Confirmed";
                    break;
                  case "Pending":
                    d = "Pending";
                    break;
                  case "Unconfirmed":
                    d = "Unconfirmed"
                }
                l.transferList.push({
                  name: l.coinName,
                  status: d,
                  type: u.Type,
                  balance: r / $t.a.SELA,
                  resultAmount: c / $t.a.SELA,
                  datetime: s,
                  timestamp: i,
                  payfees: u.Fee / $t.a.SELA,
                  txId: u.TxHash,
                  payStatusIcon: _
                })
              }
            } else alert("====getAllTransaction====error")
          })
        }, l.prototype.onItem = function(l) {
          this.native.Go(this.navCtrl, Ke, {
            chainId: this.coinName,
            txId: l.txId
          })
        }, l.prototype.onNext = function(l) {
          switch (l) {
            case 1:
              this.native.Go(this.navCtrl, ze, {
                id: this.coinId,
                chianId: this.coinName
              });
              break;
            case 2:
              this.native.Go(this.navCtrl, Re, {
                id: this.coinId,
                chianId: this.coinName,
                walletInfo: this.masterWalletInfo
              });
              break;
            case 3:
              this.native.Go(this.navCtrl, "ELA" == this.coinName ? Ee : Ve, {
                chianId: this.coinName,
                walletInfo: this.masterWalletInfo
              })
          }
        }, l.prototype.clickMore = function() {
          this.pageNo++, this.start = 20 * this.pageNo, this.start >= this.MaxCount ? this.isShowMore = !1 : (this.isShowMore = !0, this.getAllTx())
        }, l.prototype.doRefresh = function(l) {
          this.pageNo = 0, this.transferList = [], this.getAllTx(), setTimeout(function() {
            l.complete()
          }, 1e3)
        }, l
      }(),
      Ye = function() {
        function l(l, n, t, e, a, u, i) {
          this.navCtrl = l, this.navParams = n, this.walletManager = t, this.native = e, this.localStorage = a, this.modalCtrl = u, this.events = i, this.masterWalletId = "1", this.coinList = [], this.coinListCache = {}, this.payPassword = "", this.singleAddress = !1, this.init()
        }
        return l.prototype.ionViewDidLoad = function() {
          var l = this;
          this.navBar.backButtonClick = function(n) {
            l.navCtrl.pop()
          }
        }, l.prototype.onSelect = function(l) {
          var n = this;
          if (this.native.info(l), l.open) this.currentCoin = l, this.native.showLoading().then(function() {
            n.createSubWallet()
          });
          else {
            var t = $t.a.getSubWallet(this.masterWalletId);
            delete t[l.name];
            var e = this.native.clone($t.a.masterWallObj);
            e.id = this.masterWalletId, e.wallname = $t.a.getWalletName(this.masterWalletId), e.Account = $t.a.getAccountType(this.masterWalletId), e.coinListCache = t, this.localStorage.saveMappingTable(e).then(function(l) {
              var t = n.native.clone($t.a.getMappingList());
              t[n.masterWalletId] = e, n.native.info(t), $t.a.setMappingList(t)
            })
          }
        }, l.prototype.init = function() {
          var l = this;
          this.events.subscribe("error:update", function() {
            l.currentCoin.open = !1
          }), this.masterWalletId = $t.a.getCurMasterWalletId();
          var n = $t.a.getSubWallet(this.masterWalletId);
          this.walletManager.getSupportedChains(this.masterWalletId, function(t) {
            if (t.success) {
              l.native.info(t);
              var e = t.success;
              for (var a in e) {
                var u = e[a],
                  i = !1;
                n && (i = u in n), "ELA" == u && (i = !0), l.coinList.push({
                  name: u,
                  open: i
                })
              }
            } else l.native.info(t)
          })
        }, l.prototype.createSubWallet = function() {
          var l = this,
            n = this.currentCoin.name;
          this.walletManager.createSubWallet(this.masterWalletId, n, 0, function(t) {
            if (t.success) {
              $t.a.isResregister(l.masterWalletId, n) || l.registerWalletListener(l.masterWalletId, n), l.native.hideLoading();
              var e = l.native.clone($t.a.getSubWallet(l.masterWalletId));
              e ? e[n] = {
                id: n
              } : (e = {})[n] = {
                id: n
              };
              var a = l.native.clone($t.a.masterWallObj);
              a.id = l.masterWalletId, a.wallname = $t.a.getWalletName(l.masterWalletId), a.Account = $t.a.getAccountType(l.masterWalletId), a.coinListCache = e, l.localStorage.saveMappingTable(a).then(function(n) {
                var t = l.native.clone($t.a.getMappingList());
                t[l.masterWalletId] = a, $t.a.setMappingList(t)
              })
            } else l.currentCoin.open = !1, l.native.info(t)
          })
        }, l.prototype.ionViewDidLeave = function() {
          this.events.unsubscribe("error:update")
        }, l.prototype.registerWalletListener = function(l, n) {
          var t = this;
          this.walletManager.registerWalletListener(l, n, function(e) {
            $t.a.setResregister(l, n, !0), t.events.publish("register:update", l, n, e)
          })
        }, l
      }(),
      Ge = function() {
        function l(l, n, t, e, a, u, i) {
          this.navCtrl = l, this.navParams = n, this.walletManager = t, this.native = e, this.localStorage = a, this.modalCtrl = u, this.events = i, this.masterWalletId = "1", this.transfer = {
            toAddress: "",
            amount: "",
            memo: "",
            fee: 0,
            payPassword: "",
            remark: ""
          }, this.chianId = "ELA", this.feePerKb = 1e4, this.SELA = $t.a.SELA, this.init()
        }
        return l.prototype.init = function() {
          this.masterWalletId = $t.a.getCurMasterWalletId(), this.getAllSubWallets();
          var l = this.GetQueryString("account") || this.navParams.get("account"),
            n = this.GetQueryString("address") || this.navParams.get("address"),
            t = this.GetQueryString("memo") || this.navParams.get("memo"),
            e = this.GetQueryString("information");
          this.transfer.amount = l, this.transfer.toAddress = n, this.transfer.memo = t, this.information = e
        }, l.prototype.getAllSubWallets = function() {
          var l = this;
          this.walletManager.getAllSubWallets(this.masterWalletId, function(n) {
            l.native.info(n)
          })
        }, l.prototype.GetQueryString = function(l) {
          var n = new RegExp("(^|&)" + l + "=([^&]*)(&|$)"),
            t = window.location.search.substr(1).match(n);
          return null != t ? decodeURI(t[2]) : null
        }, l.prototype.onClick = function(l) {
          switch (l) {
            case 1:
              break;
            case 2:
              this.checkValue()
          }
        }, l.prototype.checkValue = function() {
          var l = this;
          ie.a.isNull(this.transfer.toAddress) ? this.native.toast_trans("correct-address") : ie.a.isNull(this.transfer.amount) ? this.native.toast_trans("amount-null") : ie.a.number(this.transfer.amount) ? this.transfer.amount > this.balance ? this.native.toast_trans("error-amount") : this.walletManager.isAddressValid(this.masterWalletId, this.transfer.toAddress, function(n) {
            n.success ? l.native.showLoading().then(function() {
              l.createTransaction()
            }) : l.native.toast_trans("contact-address-digits")
          }) : this.native.toast_trans("correct-amount")
        }, l.prototype.createTransaction = function() {
          var l = this;
          this.walletManager.createTransaction(this.masterWalletId, this.chianId, "", this.transfer.toAddress, this.transfer.amount, this.transfer.memo, this.transfer.remark, function(n) {
            n.success ? (l.native.info(n), l.rawTransaction = n.success, l.getFee()) : l.native.info(n)
          })
        }, l.prototype.getFee = function() {
          var l = this;
          this.walletManager.calculateTransactionFee(this.masterWalletId, this.chianId, this.rawTransaction, this.feePerKb, function(n) {
            n.success ? (l.native.info(n), l.native.hideLoading(), l.transfer.fee = n.success, l.openPayModal(l.transfer)) : l.native.info(n)
          })
        }, l.prototype.sendRawTransaction = function() {
          this.updateTxFee()
        }, l.prototype.updateTxFee = function() {
          var l = this;
          this.walletManager.updateTransactionFee(this.masterWalletId, this.chianId, this.rawTransaction, this.transfer.fee, function(n) {
            n.success ? (l.native.info(n), l.singTx(n.success)) : l.native.info(n)
          })
        }, l.prototype.singTx = function(l) {
          var n = this;
          this.walletManager.signTransaction(this.masterWalletId, this.chianId, l, this.transfer.payPassword, function(l) {
            l.success ? (n.native.info(l), n.sendTx(l.success)) : n.native.info(l)
          })
        }, l.prototype.sendTx = function(l) {
          var n = this;
          this.native.info(l), this.walletManager.publishTransaction(this.masterWalletId, this.chianId, l, function(l) {
            if (l.success) {
              n.native.hideLoading(), n.native.info(l), n.txId = JSON.parse(l.success).TxHash;
              return {
                txId: n.txId
              }
            }
            n.native.info(l), n.native.setRootRouter(ua)
          })
        }, l.prototype.openPayModal = function(l) {
          var n = this,
            t = this.native.clone(l),
            e = this.modalCtrl.create(Te, t);
          e.onDidDismiss(function(l) {
            l && n.native.showLoading().then(function() {
              n.transfer = n.native.clone(l), n.sendRawTransaction()
            })
          }), e.present()
        }, l
      }(),
      He = function() {
        function l(l, n, t, e, a, u, i) {
          this.navCtrl = l, this.navParams = n, this.events = t, this.localStorage = e, this.native = a, this.zone = u, this.walletManager = i, this.items = [], this.masterWalletId = "1", this.init()
        }
        return l.prototype.ionViewDidLoad = function() {}, l.prototype.init = function() {
          var l = this;
          this.masterWalletId = $t.a.getCurMasterWalletId();
          var n = $t.a.getMappingList();
          this.native.info(n), this.zone.run(function() {
            l.items = $t.a.objtoarr(n)
          }), this.native.info(this.items)
        }, l.prototype.itemSelected = function(l) {
          this.native.info(l);
          var n = l.id;
          $t.a.setCurMasterWalletId(n), this.getAllsubWallet(n)
        }, l.prototype.saveId = function(l) {
          var n = this;
          this.localStorage.saveCurMasterId({
            masterId: l
          }).then(function(t) {
            n.native.info(l), $t.a.setCurMasterWalletId(l), n.masterWalletId = $t.a.getCurMasterWalletId(), n.navCtrl.pop()
          })
        }, l.prototype.nextPage = function() {
          this.native.Go(this.navCtrl, va)
        }, l.prototype.registerWalletListener = function(l, n) {
          var t = this;
          this.walletManager.registerWalletListener(l, n, function(e) {
            $t.a.setResregister(l, n, !0), t.events.publish("register:update", l, n, e)
          })
        }, l.prototype.getAllsubWallet = function(l) {
          this.registerWalletListener(l, "ELA");
          var n = $t.a.getSubWallet(l);
          console.log("==========" + JSON.stringify(n));
          for (var t in n) this.registerWalletListener(l, t);
          this.saveId(l)
        }, l
      }(),
      Ue = function() {
        function l(l, n, t, e, a, u, i, s) {
          this.navCtrl = l, this.navParams = n, this.walletManager = t, this.native = e, this.localStorage = a, this.zone = u, this.events = i, this.popupProvider = s, this.masterWalletId = "1", this.wallet = {
            name: "myWallet",
            showBalance: !0
          }, this.ElaObj = {
            name: "ELA",
            balance: 0
          }, this.coinList = [], this.account = {}
        }
        return l.prototype.ionViewWillEnter = function() {
          this.init()
        }, l.prototype.ionViewDidLeave = function() {
          this.events.unsubscribe("register:update")
        }, l.prototype.init = function() {
          var l = this;
          this.masterWalletId = $t.a.getCurMasterWalletId(), this.account = $t.a.getAccountType(this.masterWalletId), this.wallet.name = $t.a.getWalletName(this.masterWalletId), this.events.subscribe("register:update", function(n, t, e) {
            e.MasterWalletID === l.masterWalletId && "ELA" === e.ChaiID && l.handleEla(e), e.MasterWalletID === l.masterWalletId && "IdChain" === e.ChaiID && l.handleIdchain(t, e)
          }), this.goPayment(), this.zone.run(function() {
            l.elaPer = $t.a.getMasterPer(l.masterWalletId, "ELA"), l.idChainPer = $t.a.getMasterPer(l.masterWalletId, "IdChain")
          }), this.getAllSubWallets()
        }, l.prototype.onOpen = function() {
          this.wallet.showBalance = !this.wallet.showBalance
        }, l.prototype.goPayment = function() {
          var l = this;
          this.localStorage.get("payment").then(function(n) {
            n && (l.localStorage.remove("payment"), l.native.Go(l.navCtrl, Ge, JSON.parse(n)))
          })
        }, l.prototype.onClick = function(l) {
          switch (l) {
            case 0:
              this.native.Go(this.navCtrl, He);
              break;
            case 1:
              this.native.Go(this.navCtrl, Ye)
          }
        }, l.prototype.onItem = function(l) {
          this.native.Go(this.navCtrl, Be, {
            name: l.name,
            elaPer: this.elaPer,
            idChainPer: this.idChainPer
          })
        }, l.prototype.getElaBalance = function(l) {
          var n = this;
          this.walletManager.getBalance(this.masterWalletId, l.name, function(l) {
            ie.a.isNull(l.success) ? alert("getElaBalance=error:" + JSON.stringify(l)) : n.zone.run(function() {
              n.ElaObj.balance = ie.a.scientificToNumber(l.success / $t.a.SELA)
            })
          })
        }, l.prototype.getAllSubWallets = function() {
          this.getElaBalance(this.ElaObj), this.handleSubwallet()
        }, l.prototype.getSubBalance = function(l) {
          var n = this;
          this.walletManager.getBalance(this.masterWalletId, l, function(t) {
            if (n.native.info(t), ie.a.isNull(t.success)) alert("getSubBalance=error" + JSON.stringify(t));
            else if (0 === n.coinList.length) n.coinList.push({
              name: l,
              balance: t.success / $t.a.SELA
            });
            else {
              var e = n.getCoinIndex(l);
              if (-1 != e) {
                var a = n.coinList[e];
                a.balance = t.success / $t.a.SELA, n.coinList.splice(e, 1, a)
              } else n.coinList.push({
                name: l,
                balance: t.success / $t.a.SELA
              })
            }
          })
        }, l.prototype.getCoinIndex = function(l) {
          for (var n = 0; n < this.coinList.length; n++) {
            if (l === this.coinList[n].name) return n
          }
          return -1
        }, l.prototype.handleSubwallet = function() {
          var l = $t.a.getSubWallet(this.masterWalletId);
          if (l) {
            if (ie.a.isEmptyObject(l)) return void(this.coinList = []);
            for (var n in l) this.getSubBalance(n)
          } else this.coinList = []
        }, l.prototype.handleEla = function(l) {
          var n = this;
          "OnTransactionStatusChanged" === l.Action && (this.native.info(l.confirms), 1 == l.confirms && (this.getElaBalance(this.ElaObj), this.popupProvider.ionicAlert("confirmTitle", "confirmTransaction").then(function(l) {}))), "OnBalanceChanged" === l.Action && (ie.a.isNull(l.Balance) || this.zone.run(function() {
            n.ElaObj.balance = ie.a.scientificToNumber(l.Balance / $t.a.SELA)
          })), "OnBlockSyncStopped" === l.Action ? this.zone.run(function() {
            alert('JSON.stringify(l)');
            n.elaPer = $t.a.getMasterPer(n.masterWalletId, "ELA")
          }) : "OnBlockSyncStarted" === l.Action ? this.zone.run(function() {
            n.elaPer = $t.a.getMasterPer(n.masterWalletId, "ELA")
          }) : "OnBlockHeightIncreased" === l.Action && l.progress && this.zone.run(function() {
            n.elaPer = l.progress, $t.a.setMasterPer(n.masterWalletId, "ELA", n.elaPer)
          }), 1 === this.elaPer && this.zone.run(function() {
            n.elaPer = $t.a.getMasterPer(n.masterWalletId, "ELA")
          })
        }, l.prototype.handleIdchain = function(l, n) {
          var t = this;
          if ("OnBalanceChanged" === n.Action && !ie.a.isNull(n.Balance))
            if (0 === this.coinList.length) this.coinList.push({
              name: l,
              balance: ie.a.scientificToNumber(n.Balance / $t.a.SELA)
            });
            else {
              var e = this.getCoinIndex(l);
              if (-1 != e) {
                var a = this.coinList[e];
                a.balance = ie.a.scientificToNumber(n.Balance / $t.a.SELA), this.coinList.splice(e, 1, a)
              } else this.coinList.push({
                name: l,
                balance: ie.a.scientificToNumber(n.Balance / $t.a.SELA)
              })
            }
          "OnTransactionStatusChanged" === n.Action && 1 == n.confirms && (this.handleSubwallet(), this.popupProvider.ionicAlert("confirmTitle", "confirmTransaction").then(function(l) {})), "OnBlockSyncStopped" === n.Action ? this.zone.run(function() {
            t.idChainPer = $t.a.getMasterPer(t.masterWalletId, l)
          }) : "OnBlockSyncStarted" === n.Action ? this.zone.run(function() {
            t.idChainPer = $t.a.getMasterPer(t.masterWalletId, l)
          }) : "OnBlockHeightIncreased" === n.Action && this.zone.run(function() {
            t.idChainPer = n.progress, $t.a.setMasterPer(t.masterWalletId, l, t.idChainPer)
          }), 1 === this.idChainPer && this.zone.run(function() {
            t.idChainPer = $t.a.getMasterPer(t.masterWalletId, l)
          })
        }, l.prototype.doRefresh = function(l) {
          this.getElaBalance(this.ElaObj), this.handleSubwallet(), setTimeout(function() {
            l.complete()
          }, 1e3)
        }, l
      }(),
      qe = function() {
        function l(l, n, t, e, a) {
          this.navCtrl = l, this.navParams = n, this.walletManager = t, this.native = e, this.localStorage = a, this.masterWalletId = "1", this.readonly = "", this.masterWalletType = "", this.singleAddress = !1, this.exprotObj = {
            name: "",
            backupPassWord: "",
            reBackupPassWord: "",
            payPassword: ""
          }, this.account = {}, this.onWalletDatainit()
        }
        return l.prototype.onWalletDatainit = function() {
          this.masterWalletId = $t.a.getCurMasterWalletId(), this.exprotObj.name = $t.a.getWalletName(this.masterWalletId), this.account = $t.a.getAccountType(this.masterWalletId), this.getMasterWalletBasicInfo()
        }, l.prototype.checkparms = function() {
          return ie.a.isNull(this.exprotObj.backupPassWord) ? (this.native.toast_trans("text-wallet-pwd"), !1) : this.exprotObj.backupPassWord != this.exprotObj.reBackupPassWord ? (this.native.toast_trans("text-passworld-compare"), !1) : ie.a.isNull(this.exprotObj.payPassword) && "Readonly" != this.readonly ? (this.native.toast_trans("text-pay-passworld-input"), !1) : ("Readonly" === this.readonly && (this.exprotObj.payPassword = "s12345678"), !0)
        }, l.prototype.onDown = function() {
          this.checkparms() && this.onExport()
        }, l.prototype.onExport = function() {
          var l = this;
          this.walletManager.exportWalletWithKeystore(this.masterWalletId, this.exprotObj.backupPassWord, this.exprotObj.payPassword, function(n) {
            n.success && (l.backupWalletPlainText = n.success)
          })
        }, l.prototype.onCopay = function() {
          var l = this;
          this.native.copyClipboard(this.backupWalletPlainText).then(function() {
            l.native.toast_trans("text-copied-to-clipboard")
          }).catch(function() {})
        }, l.prototype.getMasterWalletBasicInfo = function() {
          var l = this;
          this.walletManager.getMasterWalletBasicInfo(this.masterWalletId, function(n) {
            if (n.success) {
              l.native.info(n);
              var t = JSON.parse(n.success).Account;
              l.masterWalletType = t.Type, l.singleAddress = t.SingleAddress, l.readonly = t.InnerType || ""
            }
          })
        }, l
      }(),
      $e = function() {
        function l(l, n, t, e) {
          this.navCtrl = l, this.navParams = n, this.walletManager = t, this.native = e, this.masterWalletId = "1", this.masterWalletId = $t.a.getCurMasterWalletId()
        }
        return l.prototype.onSubmit = function() {
          var l = this;
          ie.a.password(this.payPassword) ? this.payPassword == this.rePayPassword ? this.walletManager.changePassword(this.masterWalletId, this.oldPayPassword, this.payPassword, function(n) {
            n.success ? (l.native.info(n), l.native.toast_trans("reset-pwd-success"), l.navCtrl.pop()) : l.native.info(n)
          }) : this.native.toast_trans("text-repwd-validator") : this.native.toast_trans("text-pwd-validator")
        }, l
      }(),
      Ze = function() {
        function l(l, n, t, e, a) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.localStorage = e, this.events = a, this.walletname = "", this.masterWalletId = "1", this.masterWalletId = $t.a.getCurMasterWalletId(), this.walletname = $t.a.getWalletName(this.masterWalletId)
        }
        return l.prototype.ionViewDidLoad = function() {
          console.log("ionViewDidLoad ModifywalletnamePage")
        }, l.prototype.modify = function() {
          var l = this;
          ie.a.isNull(this.walletname) ? this.native.toast_trans("text-wallet-name-validator") : ie.a.isWalletName(this.walletname) ? this.native.toast_trans("text-wallet-name-validator1") : ie.a.isWallNameExit(this.walletname) ? this.native.toast_trans("text-wallet-name-validator2") : this.native.showLoading().then(function() {
            l.modifyName()
          })
        }, l.prototype.modifyName = function() {
          var l = this,
            n = this.native.clone($t.a.masterWallObj);
          n.id = this.masterWalletId, n.Account = $t.a.getAccountType(this.masterWalletId), n.wallname = this.walletname;
          var t = $t.a.getSubWallet(this.masterWalletId);
          t && (n.coinListCache = t), this.localStorage.saveMappingTable(n).then(function(t) {
            var e = l.native.clone($t.a.getMappingList());
            e[l.masterWalletId] = n, $t.a.setWalletName(l.masterWalletId, l.walletname), $t.a.setMappingList(e), l.native.hideLoading(), l.navCtrl.pop()
          })
        }, l
      }(),
      Qe = function() {
        function l(l, n, t, e) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.walletManager = e, this.masterWalletId = "1", this.qrcode = null, this.getPublicKey()
        }
        return l.prototype.ionViewDidLoad = function() {}, l.prototype.copy = function() {
          this.native.copyClipboard(this.qrcode), this.native.toast_trans("copy-ok")
        }, l.prototype.getPublicKey = function() {
          var l = this;
          this.masterWalletId = $t.a.getCurMasterWalletId(), this.walletManager.getMasterWalletPublicKey(this.masterWalletId, function(n) {
            n.success ? (l.qrcode = n.success, l.native.info(n)) : l.native.info(n)
          })
        }, l
      }(),
      Xe = function() {
        function l(l, n, t) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.mnemonicList = [], this.selectList = [], this.selectComplete = !1, this.init()
        }
        return l.prototype.ionViewDidLoad = function() {
          console.log("ionViewDidLoad CheckmnemomicPage")
        }, l.prototype.init = function() {
          this.mnemonicStr = this.native.clone(this.navParams.get("mnemonicStr")), this.mnemonicList = this.native.clone(this.navParams.get("mnemonicList")).sort(function() {
            return .5 - Math.random()
          })
        }, l.prototype.addButton = function(l, n) {
          this.selectList.push({
            text: n.text,
            prevIndex: l
          }), this.mnemonicList[l].selected = !0, this.shouldContinue()
        }, l.prototype.removeButton = function(l, n) {
          this.selectList.splice(l, 1), this.mnemonicList[n.prevIndex].selected = !1, this.shouldContinue()
        }, l.prototype.shouldContinue = function() {
          if (this.selectComplete = this.selectList.length === this.mnemonicList.length, this.selectComplete) {
            for (var l = "", n = 0; n < this.selectList.length; n++) l += this.selectList[n].text;
            ie.a.isNull(l) || l != this.mnemonicStr.replace(/\s+/g, "") ? this.native.toast_trans("text-mnemonic-prompt3") : (this.native.toast_trans("text-export-menmonic-sucess"), this.navCtrl.popTo(this.navCtrl.getByIndex(this.navCtrl.length() - 3)))
          }
        }, l
      }(),
      la = function() {
        function l(l, n, t, e, a) {
          this.navCtrl = l, this.navParams = n, this.walletManager = t, this.native = e, this.events = a, this.payPassword = "", this.masterWalletId = "1", this.mnemonicList = [], this.isShow = !0, this.mnemonicStr = "", this.walltename = "", this.account = {}, this.init()
        }
        return l.prototype.ionViewDidLoad = function() {
          console.log("ionViewDidLoad ExportmnemomicPage")
        }, l.prototype.ionViewWillEnter = function() {
          var l = this;
          this.masterWalletId = $t.a.getCurMasterWalletId(), this.walltename = $t.a.getWalletName(this.masterWalletId), this.account = $t.a.getAccountType(this.masterWalletId), this.events.subscribe("error:update", function() {
            l.isShow = !0
          })
        }, l.prototype.init = function() {
          this.masterWalletId = $t.a.getCurMasterWalletId(), this.walltename = $t.a.getWalletName(this.masterWalletId)
        }, l.prototype.checkparms = function() {
          if (ie.a.password(this.payPassword)) return !0;
          this.native.toast_trans("text-pwd-validator")
        }, l.prototype.onNext = function() {
          this.native.Go(this.navCtrl, Xe, {
            mnemonicStr: this.mnemonicStr,
            mnemonicList: this.mnemonicList
          })
        }, l.prototype.onExport = function() {
          var l = this;
          this.checkparms() && this.walletManager.exportWalletWithMnemonic(this.masterWalletId, this.payPassword, function(n) {
            if (l.native.info(n), n.success) {
              l.mnemonicStr = n.success.toString();
              for (var t = l.mnemonicStr.split(/[\u3000\s]+/), e = 0; e < t.length; e++) l.mnemonicList.push({
                text: t[e],
                selected: !1
              });
              l.isShow = !1
            }
          })
        }, l.prototype.ionViewDidLeave = function() {
          this.events.unsubscribe("error:update")
        }, l
      }(),
      na = function() {
        function l(l, n, t, e, a, u, i, s) {
          this.navCtrl = l, this.navParams = n, this.events = t, this.localStorage = e, this.popupProvider = a, this.walletManager = u, this.app = i, this.native = s, this.walletName = "", this.masterWalletId = "1", this.currentLanguageName = "", this.readonly = "", this.masterWalletType = "", this.singleAddress = !1, this.masterWalletId = $t.a.getCurMasterWalletId(), this.walletName = $t.a.getWalletName(this.masterWalletId), this.getMasterWalletBasicInfo()
        }
        return l.prototype.ionViewWillEnter = function() {
          this.walletName = $t.a.getWalletName(this.masterWalletId)
        }, l.prototype.ionViewDidLeave = function() {}, l.prototype.onItem = function(l) {
          var n = this;
          switch (l) {
            case 0:
              this.native.Go(this.navCtrl, qe);
              break;
            case 1:
              this.native.Go(this.navCtrl, $e);
              break;
            case 2:
              this.popupProvider.ionicConfirm("confirmTitle", "confirmSubTitle").then(function(l) {
                l && n.native.showLoading().then(function() {
                  n.destroyWallet(n.masterWalletId)
                })
              });
              break;
            case 3:
              this.native.Go(this.navCtrl, Qe);
              break;
            case 4:
              this.native.Go(this.navCtrl, Ze);
              break;
            case 5:
              this.native.Go(this.navCtrl, la)
          }
        }, l.prototype.getAllCreatedSubWallets = function() {
          var l = this;
          this.walletManager.getAllSubWallets(this.masterWalletId, function(n) {
            if (n.success) {
              var t = JSON.parse(n.success),
                e = t.length;
              for (var a in t) {
                l.destroyWalletListener(a, e, l.masterWalletId, t[a])
              }
            } else l.native.hideLoading(), alert("==getAllSubWallets==error" + JSON.stringify(n))
          })
        }, l.prototype.destroyWalletListener = function(l, n, t, e) {
          var a = this;
          this.walletManager.removeWalletListener(t, e, function(e) {
            e.success ? parseInt(l) === n - 1 && a.destroyWallet(t) : alert("==getAllSubWallets==error" + JSON.stringify(e))
          })
        }, l.prototype.destroyWallet = function(l) {
          var n = this;
          this.walletManager.destroyWallet(l, function(t) {
            t.success ? (n.native.info(t), n.delWalletListOne(l)) : n.native.info(t)
          })
        }, l.prototype.delWalletListOne = function(l) {
          this.native.info(l);
          var n = $t.a.getMasterWalletIdList(),
            t = n.indexOf(l);
          if (this.native.info(t), t > -1 && n.splice(t, 1), 0 !== n.length) {
            this.native.info(n), $t.a.setCurMasterWalletId(n[0]);
            var e = this.native.clone($t.a.getMappingList());
            delete e[this.masterWalletId], this.native.info(e), $t.a.setMappingList(e), this.saveWalletList(n[0])
          } else this.saveWalletList1()
        }, l.prototype.saveWalletList = function(l) {
          var n = this;
          this.localStorage.saveCurMasterId({
            masterId: l
          }).then(function(t) {
            n.native.hideLoading(), $t.a.setCurMasterWalletId(l), n.native.setRootRouter(ua)
          })
        }, l.prototype.saveWalletList1 = function() {
          this.native.hideLoading(), $t.a.setMappingList({}), this.native.setRootRouter(va)
        }, l.prototype.getMasterWalletBasicInfo = function() {
          var l = this;
          this.walletManager.getMasterWalletBasicInfo(this.masterWalletId, function(n) {
            if (n.success) {
              l.native.info(n);
              var t = JSON.parse(n.success).Account;
              l.masterWalletType = t.Type, l.singleAddress = t.SingleAddress, l.readonly = t.InnerType || ""
            } else l.native.info(n)
          })
        }, l
      }(),
      ta = function() {
        function l(l, n, t, e, a, u, i) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.walletManager = e, this.localStorage = a, this.events = u, this.dataManager = i
        }
        return l.prototype.onNext = function(l) {
          switch (l) {
            case 0:
              this.createId();
              break;
            case 1:
              this.native.Go(this.navCtrl, this, ve)
          }
        }, l.prototype.createId = function() {
          var l = this,
            n = this;
          this.walletManager.createDID("s12345678", function(t) {
            var e = {
              id: t.didname
            };
            console.info("ElastosJs luncher.ts createDID result add registerIdListener" + JSON.stringify(t)), n.walletManager.registerIdListener(t.didname, function(l) {
              if (console.info("lacucher.ts ElastosJs createDID registerIdListener " + JSON.stringify(l)), "Added" == l.path) {
                var t = JSON.parse(l.value);
                if (t.Contents.length > 0 && t.Contents[0].Values.length > 0 && t.Contents[0].Values[0].Proof) {
                  var e = JSON.parse(t.Contents[0].Values[0].Proof);
                  console.info('lacucher.ts ElastosJs createDID proofObj["signature"]  ' + e.signature);
                  var a = n.dataManager.getSeqNumObj(e.signature).serialNum;
                  console.info("lacucher.ts ElastosJs createDID serialNum " + a), n.setOrderStatus(5, a), n.dataManager.OutPutIDJson(l.id, t.Contents[0].Path, e.signature)
                }
              }
              console.info("lacucher.ts ElastosJs createDID registerIdListener  data  callback !!!!!" + JSON.stringify(l))
            }), l.localStorage.add("kycId", e).then(function() {
              l.native.Go(l.navCtrl, We)
            })
          })
        }, l.prototype.setOrderStatus = function(l, n) {
          var t = this;
          console.info("setOrderStatus begin status " + l + " serialNum " + n);
          var e = $t.a.getSerIds(),
            a = e[n];
          console.info("setOrderStatus serid" + JSON.stringify(a)), console.info("setOrderStatus serids" + JSON.stringify(e));
          var u = a.id,
            i = a.path;
          console.info("setOrderStatus appr" + i);
          var s = {};
          this.localStorage.getKycList("kycId").then(function(e) {
            null != e && void 0 !== e && e !== {} && "" !== e && ((s = JSON.parse(e))[u][i][n].pathStatus = l, t.localStorage.set("kycId", s).then(function() {
              t.events.publish("order:update", l, i)
            }))
          })
        }, l
      }(),
      ea = function() {
        function l(l, n, t, e, a) {
          this.navCtrl = l, this.translate = n, this.navParams = t, this.localStorage = e, this.events = a, this.languages = [{
            name: "English",
            isoCode: "en"
          }, {
            name: "中文（简体）",
            isoCode: "zh",
            useIdeograms: !0
          }], this.currentLanguage = this.navParams.data.isoCode || "en", this.translate.use(this.currentLanguage)
        }
        return l.prototype.save = function(l) {
          var n = this,
            t = {};
          this.localStorage.set("wallte-language", t = "zh" === l ? {
            name: "中文（简体）",
            isoCode: "zh"
          } : {
            name: "English",
            isoCode: "en"
          }).then(function() {
            n.translate.use(l), n.events.publish("language:update", t), n.navCtrl.pop()
          })
        }, l
      }(),
      aa = function() {
        function l(l, n, t, e, a, u) {
          this.navCtrl = l, this.navParams = n, this.walletManager = t, this.events = e, this.native = a, this.localStorage = u, this.masterWalletId = "1", this.masterWalletType = "", this.readonly = "", this.currentLanguageName = ""
        }
        return l.prototype.ionViewWillEnter = function() {
          this.init()
        }, l.prototype.init = function() {
          var l = this;
          this.localStorage.getLanguage("wallte-language").then(function(n) {
            l.currentLanguageName = JSON.parse(n).name || "";
            var t = JSON.parse(n).isoCode || "";
            l.native.setMnemonicLang("en" == t ? "english" : "zh" == t ? "chinese" : "english")
          }), this.events.subscribe("language:update", function(n) {
            l.currentLanguageName = n.name || "";
            var t = n.isoCode || "";
            l.native.setMnemonicLang("en" == t ? "english" : "zh" == t ? "chinese" : "english")
          }), this.events.subscribe("wallte:update", function(n) {
            l.masterWalletId = n, l.getMasterWalletBasicInfo()
          }), this.masterWalletId = $t.a.getCurMasterWalletId(), this.getMasterWalletBasicInfo()
        }, l.prototype.getMasterWalletBasicInfo = function() {
          var l = this;
          this.walletManager.getMasterWalletBasicInfo(this.masterWalletId, function(n) {
            if (n.success) {
              l.native.info(n);
              var t = JSON.parse(n.success).Account;
              l.masterWalletType = t.Type, l.readonly = t.InnerType || ""
            } else l.native.info(n)
          })
        }, l.prototype.onNext = function(l) {
          switch (l) {
            case 0:
              this.native.Go(this.navCtrl, na);
              break;
            case 1:
              this.native.Go(this.navCtrl, Qe);
              break;
            case 2:
              this.native.Go(this.navCtrl, ce);
              break;
            case 3:
              this.sendTX();
              break;
            case 4:
              this.singTx();
              break;
            case 6:
              this.getDIDList();
              break;
            case 5:
              this.setLanguage();
              break;
            case 7:
              this.getVoteNode();
              break;
            case 8:
              this.native.Go(this.navCtrl, "AboutPage")
          }
        }, l.prototype.getDIDList = function() {
          var l = this;
          this.localStorage.get("kycId").then(function(n) {
            ie.a.isNull(n) ? l.native.Go(l.navCtrl, ta) : l.native.Go(l.navCtrl, We)
          })
        }, l.prototype.singTx = function() {
          this.native.Go(this.navCtrl, Ae, {
            pageType: "3"
          })
        }, l.prototype.sendTX = function() {
          this.native.Go(this.navCtrl, Ae, {
            pageType: "4"
          })
        }, l.prototype.ionViewDidLeave = function() {
          this.events.unsubscribe("wallte:update")
        }, l.prototype.setLanguage = function() {
          var l = this;
          this.localStorage.getLanguage("wallte-language").then(function(n) {
            var t = JSON.parse(n);
            l.native.Go(l.navCtrl, ea, t)
          })
        }, l.prototype.getVoteNode = function() {
          this.native.Go(this.navCtrl, "SuperpointPage")
        }, l
      }(),
      ua = function() {
        return function() {
          this.homeRoot = Ue, this.settingsRoot = aa
        }
      }(),
      ia = function() {
        function l(l, n, t, e, a, u) {
          var i = this;
          this.navCtrl = l, this.navParams = n, this.walletManager = t, this.native = e, this.localStorage = a, this.events = u, this.masterWalletId = "1", this.publicKeyArr = [], this.name = "", this.curIndex = 0, this.qrcode = null, this.native.info(this.navParams.data), this.msobj = this.navParams.data, this.name = this.msobj.name;
          var s = 0;
          this.msobj.payPassword ? (this.isOnly = !1, this.innerType = "Standard", s = this.msobj.totalCopayers - 1, this.getPublicKey()) : (this.isOnly = !0, this.innerType = "Readonly", s = this.msobj.totalCopayers);
          for (var o = 0; o < s; o++) {
            this.publicKeyArr.push({
              index: o,
              publicKey: ""
            })
          }
          this.masterWalletId = $t.a.uuid(6, 16), this.events.subscribe("publickey:update", function(l) {
            i.publicKeyArr[i.curIndex].publicKey = l
          })
        }
        return l.prototype.ionViewDidLoad = function() {
          console.log("ionViewDidLoad AddpublickeyPage")
        }, l.prototype.copy = function() {
          this.native.copyClipboard(this.qrcode), this.native.toast_trans("copy-ok")
        }, l.prototype.saomiao = function(l) {
          this.curIndex = l, console.log("saomiao=" + l), this.native.Go(this.navCtrl, Ae, {
            pageType: "5"
          })
        }, l.prototype.nextPage = function() {
          var l = this;
          this.native.showLoading().then(function() {
            l.msobj.payPassword ? l.createWalletWithMnemonic() : l.createWallet()
          })
        }, l.prototype.createWallet = function() {
          var l = this,
            n = this.getTotalCopayers();
          this.walletManager.createMultiSignMasterWallet(this.masterWalletId, n, this.msobj.requiredCopayers, function(n) {
            n.success ? l.createSubWallet("ELA") : (l.native.hideLoading(), alert("=====createMultiSignMasterWallet===error==" + JSON.stringify(n)))
          })
        }, l.prototype.getTotalCopayers = function() {
          for (var l = [], n = 0; n < this.publicKeyArr.length; n++) {
            var t = this.publicKeyArr[n].publicKey.replace(/^\s+|\s+$/g, "");
            l.push(t)
          }
          return JSON.stringify(l)
        }, l.prototype.createSubWallet = function(l) {
          var n = this;
          this.walletManager.createSubWallet(this.masterWalletId, l, 0, function(t) {
            t.success ? (n.native.info(t), n.registerWalletListener(n.masterWalletId, l), n.saveWalletList()) : n.native.hideLoading()
          })
        }, l.prototype.saveWalletList = function() {
          var l = this;
          $t.a.getMasterWalletIdList().push(this.masterWalletId), this.localStorage.saveCurMasterId({
            masterId: this.masterWalletId
          }).then(function(n) {
            var t = l.native.clone($t.a.masterWallObj);
            t.id = l.masterWalletId, t.wallname = l.name, t.Account = {
              SingleAddress: !0,
              Type: "Multi-Sign",
              InnerType: l.innerType
            }, l.localStorage.saveMappingTable(t).then(function(n) {
              var e = l.native.clone($t.a.getMappingList());
              e[l.masterWalletId] = t, l.native.info(e), $t.a.setMappingList(e), l.native.hideLoading(), $t.a.setCurMasterWalletId(l.masterWalletId), l.native.setRootRouter(ua)
            })
          })
        }, l.prototype.createWalletWithMnemonic = function() {
          var l = this,
            n = this.getTotalCopayers();
          this.walletManager.createMultiSignMasterWalletWithMnemonic(this.masterWalletId, this.msobj.mnemonicStr, this.msobj.mnemonicPassword, this.msobj.payPassword, n, this.msobj.requiredCopayers, function(n) {
            n.success ? (l.native.info(n), l.createMnemonicSubWallet("ELA", l.msobj.payPassword)) : l.native.hideLoading()
          })
        }, l.prototype.createMnemonicSubWallet = function(l, n) {
          var t = this;
          this.walletManager.createSubWallet(this.masterWalletId, l, 0, function(n) {
            n.success ? (t.native.hideLoading(), t.native.info(n), t.registerWalletListener(t.masterWalletId, l), t.saveWalletList()) : (t.native.hideLoading(), alert("createSubWallet=error:" + JSON.stringify(n)))
          })
        }, l.prototype.registerWalletListener = function(l, n) {
          var t = this;
          this.walletManager.registerWalletListener(l, n, function(e) {
            $t.a.isResregister(l, n) || $t.a.setResregister(l, n, !0), t.events.publish("register:update", l, n, e)
          })
        }, l.prototype.getPublicKey = function() {
          var l = this;
          this.walletManager.getMultiSignPubKeyWithMnemonic(this.msobj.mnemonicStr, this.msobj.mnemonicPassword, function(n) {
            n.success && (l.qrcode = n.success)
          })
        }, l
      }(),
      sa = function() {
        function l(l, n, t, e, a, u) {
          var i = this;
          this.navCtrl = l, this.navParams = n, this.walletManager = t, this.native = e, this.localStorage = a, this.events = u, this.masterWalletId = "1", this.publicKey = "", this.publicKeyArr = [], this.name = "", this.curIndex = 0, this.qrcode = null, this.native.info(this.navParams.data), this.msobj = this.navParams.data, this.name = this.msobj.name;
          for (var s = this.msobj.totalCopayers, o = 0; o < s - 1; o++) {
            this.publicKeyArr.push({
              index: o,
              publicKey: this.publicKey
            })
          }
          this.masterWalletId = $t.a.uuid(6, 16), this.getMultiSignPubKeyWithPrivKey(), this.events.subscribe("privatekey:update", function(l) {
            i.publicKeyArr[i.curIndex].publicKey = l
          })
        }
        return l.prototype.ionViewDidLoad = function() {
          console.log("ionViewDidLoad AddprivatekeyPage")
        }, l.prototype.copy = function() {
          this.native.copyClipboard(this.qrcode), this.native.toast_trans("copy-ok")
        }, l.prototype.saomiao = function(l) {
          this.curIndex = l, console.log("saomiao=" + l), this.native.Go(this.navCtrl, Ae, {
            pageType: "6"
          })
        }, l.prototype.nextPage = function() {
          var l = this;
          this.native.showLoading().then(function() {
            l.createWallet()
          })
        }, l.prototype.createWallet = function() {
          var l = this,
            n = this.getTotalCopayers();
          this.walletManager.createMultiSignMasterWalletWithPrivKey(this.masterWalletId, this.msobj.importText, this.msobj.passWord, n, this.msobj.requiredCopayers, function(n) {
            n.success ? l.createSubWallet("ELA") : (l.native.hideLoading(), alert("=====createMultiSignMasterWalletWithPrivKey===error===" + JSON.stringify(n)))
          })
        }, l.prototype.getTotalCopayers = function() {
          for (var l = [], n = 0; n < this.publicKeyArr.length; n++) {
            var t = this.publicKeyArr[n].publicKey.replace(/^\s+|\s+$/g, "");
            l.push(t)
          }
          return JSON.stringify(l)
        }, l.prototype.createSubWallet = function(l) {
          var n = this;
          this.walletManager.createSubWallet(this.masterWalletId, l, 0, function(t) {
            t.success ? (n.native.info(t), n.registerWalletListener(n.masterWalletId, l), n.saveWalletList()) : n.native.hideLoading()
          })
        }, l.prototype.saveWalletList = function() {
          var l = this;
          $t.a.getMasterWalletIdList().push(this.masterWalletId), this.localStorage.saveCurMasterId({
            masterId: this.masterWalletId
          }).then(function(n) {
            var t = l.native.clone($t.a.masterWallObj);
            t.id = l.masterWalletId, t.wallname = l.name, t.Account = {
              SingleAddress: !0,
              Type: "Multi-Sign",
              InnerType: "Simple"
            }, l.localStorage.saveMappingTable(t).then(function(n) {
              var e = l.native.clone($t.a.getMappingList());
              e[l.masterWalletId] = t, l.native.info(e), $t.a.setMappingList(e), l.native.hideLoading(), $t.a.setCurMasterWalletId(l.masterWalletId), l.native.setRootRouter(ua)
            })
          })
        }, l.prototype.registerWalletListener = function(l, n) {
          var t = this;
          this.walletManager.registerWalletListener(l, n, function(e) {
            $t.a.isResregister(l, n) || $t.a.setResregister(l, n, !0), t.events.publish("register:update", l, n, e)
          })
        }, l.prototype.getMultiSignPubKeyWithPrivKey = function() {
          var l = this;
          this.walletManager.getMultiSignPubKeyWithPrivKey(this.msobj.importText, function(n) {
            n.success && (l.qrcode = n.success)
          })
        }, l
      }(),
      oa = function() {
        function l(l, n, t, e) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.walletManager = e, this.masterWalletId = "1", this.qrcode = null, this.exatParm = this.navParams.data, this.native.info(this.exatParm), this.exatParm.mnemonicStr ? this.getPublicKey() : this.exatParm.importText && this.getMultiSignPubKeyWithPrivKey()
        }
        return l.prototype.ionViewDidLoad = function() {
          console.log("ionViewDidLoad MpublickeyPage")
        }, l.prototype.copy = function() {
          this.native.copyClipboard(this.qrcode), this.native.toast_trans("copy-ok")
        }, l.prototype.getPublicKey = function() {
          var l = this;
          this.walletManager.getMultiSignPubKeyWithMnemonic(this.exatParm.mnemonicStr, this.exatParm.mnemonicPassword, function(n) {
            n.success && (l.qrcode = n.success)
          })
        }, l.prototype.getMultiSignPubKeyWithPrivKey = function() {
          var l = this;
          this.walletManager.getMultiSignPubKeyWithPrivKey(this.exatParm.importText, function(n) {
            n.success && (l.qrcode = n.success)
          })
        }, l.prototype.nextPage = function() {
          this.exatParm.mnemonicStr ? this.native.Go(this.navCtrl, ia, this.exatParm) : this.exatParm.importText && this.native.Go(this.navCtrl, sa, this.exatParm)
        }, l
      }(),
      ra = function() {
        function l(l, n, t) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.mnemonicList = [], this.selectList = [], this.selectComplete = !1, this.init()
        }
        return l.prototype.init = function() {
          this.exatParm = this.native.clone(this.navParams.data), this.multType = this.navParams.get("mult"), this.mnemonicStr = this.native.clone(this.navParams.get("mnemonicStr")), this.mnemonicList = this.native.clone(this.navParams.get("mnemonicList")).sort(function() {
            return .5 - Math.random()
          })
        }, l.prototype.onNext = function() {
          for (var l = "", n = 0; n < this.selectList.length; n++) l += this.selectList[n].text;
          ie.a.isNull(l) || l != this.mnemonicStr.replace(/\s+/g, "") ? this.native.toast_trans("text-mnemonic-prompt3") : this.multType ? this.native.Go(this.navCtrl, oa, this.exatParm) : (this.native.toast_trans("text-mnemonic-ok"), this.native.setRootRouter(ua))
        }, l.prototype.addButton = function(l, n) {
          this.selectList.push({
            text: n.text,
            prevIndex: l
          }), this.mnemonicList[l].selected = !0, this.shouldContinue()
        }, l.prototype.removeButton = function(l, n) {
          this.selectList.splice(l, 1), this.mnemonicList[n.prevIndex].selected = !1, this.shouldContinue()
        }, l.prototype.shouldContinue = function() {
          this.selectComplete = this.selectList.length === this.mnemonicList.length
        }, l
      }(),
      ca = function() {
        function l(l, n, t, e, a, u) {
          var i = this;
          this.navCtrl = l, this.navParams = n, this.walletManager = t, this.native = e, this.localStorage = a, this.events = u, this.masterWalletId = "1", this.mnemonicList = [], this.mnemonicPassword = "", this.singleAddress = !1, this.defaultCointype = "Ela", this.isSelect = !1, e.showLoading().then(function() {
            i.init()
          })
        }
        return l.prototype.init = function() {
          var l = this;
          this.masterWalletId = $t.a.uuid(6, 16), this.walletManager.generateMnemonic(this.native.getMnemonicLang(), function(n) {
            if (n.success) {
              l.native.hideLoading(), l.native.info(n), l.mnemonicStr = n.success.toString();
              for (var t = l.mnemonicStr.split(/[\u3000\s]+/), e = 0; e < t.length; e++) l.mnemonicList.push({
                text: t[e],
                selected: !1
              })
            } else l.native.info(n)
          }), this.payPassword = this.navParams.get("payPassword"), this.name = this.navParams.get("name"), this.singleAddress = this.navParams.get("singleAddress"), this.multType = this.navParams.get("mult")
        }, l.prototype.onNext = function() {
          var l = this;
          ie.a.password(this.mnemonicPassword) || !this.isSelect ? this.mnemonicPassword != this.mnemonicRepassword && this.isSelect ? this.native.toast_trans("text-repwd-validator") : (this.isSelect || (this.mnemonicPassword = "", this.mnemonicRepassword = ""), ie.a.isEmptyObject(this.multType) ? this.native.showLoading().then(function() {
            l.walletManager.createMasterWallet(l.masterWalletId, l.mnemonicStr, l.mnemonicPassword, l.payPassword, l.singleAddress, function(n) {
              n.success ? (l.native.info(n), l.createSubWallet("ELA")) : l.native.info(n)
            })
          }) : this.native.Go(this.navCtrl, ra, {
            mult: this.multType,
            mnemonicStr: this.mnemonicStr,
            mnemonicList: this.mnemonicList,
            totalCopayers: this.multType.totalCopayers,
            requiredCopayers: this.multType.requiredCopayers,
            mnemonicPassword: this.mnemonicPassword,
            payPassword: this.payPassword,
            name: this.name
          })) : this.native.toast_trans("text-pwd-validator")
        }, l.prototype.createSubWallet = function(l) {
          var n = this;
          this.walletManager.createSubWallet(this.masterWalletId, l, 0, function(t) {
            if (t.success) {
              var e = n.native.clone($t.a.masterWallObj);
              e.id = n.masterWalletId, e.wallname = n.name, e.Account = {
                SingleAddress: n.singleAddress,
                Type: "Standard"
              }, n.localStorage.saveMappingTable(e).then(function(t) {
                var a = n.native.clone($t.a.getMappingList());
                a[n.masterWalletId] = e, n.native.info(a), $t.a.setMappingList(a), n.saveWalletList(), n.registerWalletListener(n.masterWalletId, l)
              })
            } else alert("createSubWallet=error:" + JSON.stringify(t))
          })
        }, l.prototype.saveWalletList = function() {
          var l = this;
          $t.a.getMasterWalletIdList().push(this.masterWalletId), this.localStorage.saveCurMasterId({
            masterId: this.masterWalletId
          }).then(function(n) {
            l.native.hideLoading(), $t.a.setCurMasterWalletId(l.masterWalletId), l.native.Go(l.navCtrl, ra, {
              mnemonicStr: l.mnemonicStr,
              mnemonicList: l.mnemonicList
            })
          })
        }, l.prototype.registerWalletListener = function(l, n) {
          var t = this;
          this.walletManager.registerWalletListener(l, n, function(e) {
            $t.a.isResregister(l, n) || $t.a.setResregister(l, n, !0), t.events.publish("register:update", l, n, e)
          })
        }, l
      }(),
      _a = function() {
        function l(l, n, t) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.isShow = !1, this.wallet = {
            name: "",
            singleAddress: !1,
            payPassword: "",
            rePayPassword: ""
          }, this.MultObj = this.navParams.data, this.native.info(this.MultObj), ie.a.isEmptyObject(this.MultObj) || (this.wallet.singleAddress = !0, this.isShow = !0)
        }
        return l.prototype.onCreate = function() {
          ie.a.isNull(this.wallet.name) ? this.native.toast_trans("text-wallet-name-validator") : ie.a.isWalletName(this.wallet.name) ? this.native.toast_trans("text-wallet-name-validator1") : ie.a.isWallNameExit(this.wallet.name) ? this.native.toast_trans("text-wallet-name-validator2") : ie.a.password(this.wallet.payPassword) ? this.wallet.payPassword == this.wallet.rePayPassword ? this.createWallet() : this.native.toast_trans("text-repwd-validator") : this.native.toast_trans("text-pwd-validator")
        }, l.prototype.createWallet = function() {
          this.native.Go(this.navCtrl, ca, {
            payPassword: this.wallet.payPassword,
            name: this.wallet.name,
            singleAddress: this.wallet.singleAddress,
            mult: this.MultObj
          })
        }, l
      }(),
      da = function() {
        function l(l, n, t, e, a, u, i) {
          var s = this;
          this.navCtrl = l, this.navParams = n, this.walletManager = t, this.native = e, this.localStorage = a, this.events = u, this.popupProvider = i, this.masterWalletId = "1", this.selectedTab = "words", this.importFileObj = {
            payPassword: "",
            rePayPassword: "",
            backupPassWord: "",
            name: ""
          }, this.mnemonicObj = {
            mnemonic: "",
            payPassword: "",
            rePayPassword: "",
            phrasePassword: "",
            name: "",
            singleAddress: !1
          }, this.accontObj = {}, this.masterWalletId = $t.a.uuid(6, 16), this.events.subscribe("error:update", function(l) {
            l.error && 20036 === l.error.code && s.popupProvider.webKeyPrompt().then(function(l) {
              console.log("========webKeyStore" + l), null !== l && s.webKeyStore(l.toString())
            })
          })
        }
        return l.prototype.toggleShowAdvOpts = function() {
          this.showAdvOpts = !this.showAdvOpts
        }, l.prototype.selectTab = function(l) {
          this.selectedTab = l
        }, l.prototype.onImport = function() {
          var l = this;
          switch (this.selectedTab) {
            case "words":
              this.checkWorld() && this.native.showLoading().then(function() {
                l.importWalletWithMnemonic()
              });
              break;
            case "file":
              this.checkImportFile() && this.native.showLoading().then(function() {
                l.importWalletWithKeystore()
              })
          }
        }, l.prototype.checkImportFile = function() {
          if (ie.a.isNull(this.keyStoreContent)) return this.native.toast_trans("import-text-keystroe-message"), !1;
          if (ie.a.isNull(this.importFileObj.name)) return this.native.toast_trans("text-wallet-name-validator"), !1;
          if (ie.a.isWalletName(this.importFileObj.name)) this.native.toast_trans("text-wallet-name-validator1");
          else {
            if (!ie.a.isWallNameExit(this.importFileObj.name)) return ie.a.isNull(this.importFileObj.backupPassWord) ? (this.native.toast_trans("text-backup-passworld-input"), !1) : ie.a.isNull(this.importFileObj.payPassword) ? (this.native.toast_trans("text-pay-passworld-input"), !1) : this.importFileObj.payPassword == this.importFileObj.rePayPassword || (this.native.toast_trans("text-passworld-compare"), !1);
            this.native.toast_trans("text-wallet-name-validator2")
          }
        }, l.prototype.importWalletWithKeystore = function() {
          var l = this;
          this.walletManager.importWalletWithKeystore(this.masterWalletId, this.keyStoreContent, this.importFileObj.backupPassWord, this.importFileObj.payPassword, function(n) {
            n.success ? (l.accontObj = JSON.parse(n.success).Account, l.walletManager.createSubWallet(l.masterWalletId, "ELA", 0, function(n) {
              n.success ? (l.registerWalletListener(l.masterWalletId, "ELA"), l.getAllCreatedSubWallets()) : (l.native.hideLoading(), alert("=====createSubWallet=error" + JSON.stringify(n)))
            })) : (l.native.hideLoading(), alert("=====importWalletWithKeystore=error" + JSON.stringify(n)))
          })
        }, l.prototype.checkWorld = function() {
          if (ie.a.isNull(this.mnemonicObj.name)) return this.native.toast_trans("text-wallet-name-validator"), !1;
          if (ie.a.isWalletName(this.mnemonicObj.name)) this.native.toast_trans("text-wallet-name-validator1");
          else {
            if (!ie.a.isWallNameExit(this.mnemonicObj.name)) {
              if (ie.a.isNull(this.mnemonicObj.mnemonic)) return this.native.toast_trans("text-input-mnemonic"), !1;
              return 12 != this.normalizeMnemonic(this.mnemonicObj.mnemonic).replace(/^\s+|\s+$/g, "").split(/[\u3000\s]+/).length ? (this.native.toast_trans("text-mnemonic-validator"), !1) : ie.a.isNull(this.mnemonicObj.payPassword) ? (this.native.toast_trans("text-pay-password"), !1) : ie.a.password(this.mnemonicObj.payPassword) ? this.mnemonicObj.payPassword == this.mnemonicObj.rePayPassword || (this.native.toast_trans("text-passworld-compare"), !1) : (this.native.toast_trans("text-pwd-validator"), !1)
            }
            this.native.toast_trans("text-wallet-name-validator2")
          }
        }, l.prototype.normalizeMnemonic = function(l) {
          if (!l || !l.indexOf) return l;
          var n = l.indexOf("　") > -1;
          return l.split(/[\u3000\s]+/).join(n ? "　" : " ")
        }, l.prototype.importWalletWithMnemonic = function() {
          var l = this,
            n = this.normalizeMnemonic(this.mnemonicObj.mnemonic);
          this.walletManager.importWalletWithMnemonic(this.masterWalletId, n, this.mnemonicObj.phrasePassword, this.mnemonicObj.payPassword, this.mnemonicObj.singleAddress, function(n) {
            n.success ? (l.accontObj = JSON.parse(n.success).Account, l.walletManager.createSubWallet(l.masterWalletId, "ELA", 0, function(n) {
              n.success ? (l.native.toast_trans("import-text-world-sucess"), l.registerWalletListener(l.masterWalletId, "ELA"), l.saveWalletList(null)) : (l.native.hideLoading(), alert("createSubWallet==error" + JSON.stringify(n)))
            })) : (l.native.hideLoading(), alert("importWalletWithMnemonic==error" + JSON.stringify(n)))
          })
        }, l.prototype.getAllCreatedSubWallets = function() {
          var l = this;
          this.walletManager.getAllSubWallets(this.masterWalletId, function(n) {
            if (n.success) {
              var t = l.getCoinListCache(JSON.parse(n.success));
              l.native.toast_trans("import-text-keystroe-sucess"), l.saveWalletList(t)
            } else l.native.hideLoading(), alert("==getAllSubWallets==error" + JSON.stringify(n))
          })
        }, l.prototype.getCoinListCache = function(l) {
          var n = {};
          for (var t in l) {
            var e = l[t];
            "ELA" != e && (n[e] = e)
          }
          return n
        }, l.prototype.saveWalletList = function(l) {
          var n = this;
          $t.a.getMasterWalletIdList().push(this.masterWalletId), this.localStorage.saveCurMasterId({
            masterId: this.masterWalletId
          }).then(function(t) {
            var e = "";
            "words" === n.selectedTab ? (e = n.mnemonicObj.name, n.accontObj.SingleAddress = n.mnemonicObj.SingleAddress) : "file" === n.selectedTab && (e = n.importFileObj.name);
            var a = n.native.clone($t.a.masterWallObj);
            a.id = n.masterWalletId, a.wallname = e, a.Account = n.accontObj, l && (a.coinListCache = l, n.registersubWallet(n.masterWalletId, l)), n.localStorage.saveMappingTable(a).then(function(l) {
              var t = n.native.clone($t.a.getMappingList());
              t[n.masterWalletId] = a, n.native.info(t), $t.a.setMappingList(t), n.native.hideLoading(), $t.a.setCurMasterWalletId(n.masterWalletId), n.native.setRootRouter(ua)
            })
          })
        }, l.prototype.registerWalletListener = function(l, n) {
          var t = this;
          this.walletManager.registerWalletListener(l, n, function(e) {
            $t.a.isResregister(l, n) || $t.a.setResregister(l, n, !0), t.events.publish("register:update", l, n, e)
          })
        }, l.prototype.registersubWallet = function(l, n) {
          for (var t in n) {
            this.registerWalletListener(l, n[t])
          }
        }, l.prototype.ionViewDidLeave = function() {
          this.events.unsubscribe("error:update")
        }, l.prototype.webKeyStore = function(l) {
          var n = this;
          console.log("========webKeyStore" + l), this.native.showLoading().then(function() {
            n.walletManager.importWalletWithOldKeystore(n.masterWalletId, n.keyStoreContent, n.importFileObj.backupPassWord, n.importFileObj.payPassword, l, function(l) {
              l.success ? (n.accontObj = JSON.parse(l.success).Account, n.walletManager.createSubWallet(n.masterWalletId, "ELA", 0, function(l) {
                l.success ? (n.native.toast_trans("import-text-world-sucess"), n.registerWalletListener(n.masterWalletId, "ELA"), n.saveWalletList(null)) : (n.native.hideLoading(), alert("createSubWallet==error" + JSON.stringify(l)))
              })) : (n.native.hideLoading(), alert("importWalletWithOldKeystore==error" + JSON.stringify(l)))
            })
          })
        }, l
      }(),
      ha = function() {
        function l(l, n, t) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.importText = "", this.passWord = "", this.rePassWorld = "", this.name = "", this.msobj = this.navParams.data
        }
        return l.prototype.ionViewDidLoad = function() {
          console.log("ionViewDidLoad ImportprivatekeyPage")
        }, l.prototype.import = function() {
          this.checkParms() && (this.msobj.importText = this.importText.replace(/^\s+|\s+$/g, ""), this.msobj.passWord = this.passWord, this.msobj.name = this.name, this.navCtrl.push(oa, this.msobj))
        }, l.prototype.checkParms = function() {
          if (ie.a.isNull(this.name)) this.native.toast_trans("text-wallet-name-validator");
          else if (ie.a.isWalletName(this.name)) this.native.toast_trans("text-wallet-name-validator1");
          else {
            if (!ie.a.isWallNameExit(this.name)) return ie.a.isNull(this.importText) ? (this.native.toast_trans("text-import-privatekey-placeholder"), !1) : ie.a.isNull(this.passWord) ? (this.native.toast_trans("text-pay-password"), !1) : this.passWord == this.rePassWorld || (this.native.toast_trans("text-passworld-compare"), !1);
            this.native.toast_trans("text-wallet-name-validator2")
          }
        }, l
      }(),
      pa = function() {
        function l(l, n, t) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.name = "", this.navObj = this.navParams.data
        }
        return l.prototype.ionViewDidLoad = function() {
          console.log("ionViewDidLoad CreatewalletnamePage")
        }, l.prototype.import = function() {
          this.checkParms() && (this.navObj.name = this.name, this.native.Go(this.navCtrl, ia, this.navObj))
        }, l.prototype.checkParms = function() {
          if (ie.a.isNull(this.name)) return this.native.toast_trans("text-wallet-name-validator"), !1;
          if (ie.a.isWalletName(this.name)) this.native.toast_trans("text-wallet-name-validator1");
          else {
            if (!ie.a.isWallNameExit(this.name)) return !0;
            this.native.toast_trans("text-wallet-name-validator2")
          }
        }, l
      }(),
      ga = function() {
        function l(l, n, t) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.mnemonicObj = {
            mnemonic: "",
            payPassword: "",
            rePayPassword: "",
            phrasePassword: "",
            name: "",
            singleAddress: !0
          }, this.exatParm = this.navParams.data
        }
        return l.prototype.ionViewDidLoad = function() {
          console.log("ionViewDidLoad ImportmnemonicPage")
        }, l.prototype.checkWorld = function() {
          if (ie.a.isNull(this.mnemonicObj.name)) return this.native.toast_trans("text-wallet-name-validator"), !1;
          if (ie.a.isWalletName(this.mnemonicObj.name)) this.native.toast_trans("text-wallet-name-validator1");
          else {
            if (!ie.a.isWallNameExit(this.mnemonicObj.name)) {
              if (ie.a.isNull(this.mnemonicObj.mnemonic)) return this.native.toast_trans("text-input-mnemonic"), !1;
              return 12 != this.normalizeMnemonic(this.mnemonicObj.mnemonic).replace(/^\s+|\s+$/g, "").split(/[\u3000\s]+/).length ? (this.native.toast_trans("text-mnemonic-validator"), !1) : ie.a.isNull(this.mnemonicObj.payPassword) ? (this.native.toast_trans("text-pay-password"), !1) : ie.a.password(this.mnemonicObj.payPassword) ? this.mnemonicObj.payPassword == this.mnemonicObj.rePayPassword || (this.native.toast_trans("text-passworld-compare"), !1) : (this.native.toast_trans("text-pwd-validator"), !1)
            }
            this.native.toast_trans("text-wallet-name-validator2")
          }
        }, l.prototype.normalizeMnemonic = function(l) {
          if (!l || !l.indexOf) return l;
          var n = l.indexOf("　") > -1;
          return l.split(/[\u3000\s]+/).join(n ? "　" : " ")
        }, l.prototype.nextPage = function() {
          this.checkWorld() && (this.exatParm.mnemonicStr = this.normalizeMnemonic(this.mnemonicObj.mnemonic), this.exatParm.mnemonicPassword = this.mnemonicObj.phrasePassword, this.exatParm.payPassword = this.mnemonicObj.payPassword, this.exatParm.name = this.mnemonicObj.name, this.native.Go(this.navCtrl, oa, this.exatParm))
        }, l.prototype.toggleShowAdvOpts = function() {
          this.showAdvOpts = !this.showAdvOpts
        }, l
      }(),
      fa = function() {
        function l(l, n, t) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.native.info(this.navParams.data), this.navObj = this.navParams.data, this.totalCopayers = this.navParams.data.totalCopayers
        }
        return l.prototype.ionViewDidLoad = function() {}, l.prototype.wayOne = function() {
          this.native.Go(this.navCtrl, _a, this.navObj)
        }, l.prototype.wayTwo = function() {
          this.native.Go(this.navCtrl, ha, this.navObj)
        }, l.prototype.wayThree = function() {
          this.native.Go(this.navCtrl, pa, this.navObj)
        }, l.prototype.wayFour = function() {
          this.native.Go(this.navCtrl, ga, this.navObj)
        }, l
      }(),
      ma = function() {
        function l(l, n, t) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.copayers = [1, 2, 3, 4, 5, 6], this.signatures = [1, 2, 3, 4, 5, 6], this.totalCopayers = 2, this.requiredCopayers = 2
        }
        return l.prototype.ionViewDidLoad = function() {}, l.prototype.setTotalCopayers = function() {}, l.prototype.nextPage = function() {
          this.totalCopayers < this.requiredCopayers ? this.native.toast_trans("text-multi-error") : this.native.Go(this.navCtrl, fa, {
            totalCopayers: this.totalCopayers,
            requiredCopayers: this.requiredCopayers
          })
        }, l
      }(),
      va = function() {
        function l(l, n) {
          this.navCtrl = l, this.navParams = n
        }
        return l.prototype.ionViewDidLoad = function() {


          cordova.plugins.Wallet.print(['aa'], null, function(error) {
            alert("错误信息：" + JSON.stringify(error));
            //this.native.toast(error);
          });
          console.log("ionViewDidLoad WalltelistPag");







        }, l.prototype.onNext = function(l) {
          switch (l) {
            case 1:
              this.navCtrl.push(_a);
              break;
            case 2:
              this.navCtrl.push(da);
              break;
            case 3:
              this.navCtrl.push(ma)
          }
        }, l
      }(),
      ya = function() {
        function l(l, n, t, e, a, u, i) {
          this.navCtrl = l, this.navParams = n, this.native = t, this.localStorage = e, this.walletManager = a, this.popupProvider = u, this.platform = i, this.kycIdArr = [], this.init()
        }
        return l.prototype.init = function() {
          var l = this;
          this.message = ie.a.GetQueryString("message"), this.localStorage.get("kycId").then(function(n) {
            null === n ? (l.kycIdArr = [], l.native.Go(l.navCtrl, ta)) : l.kycIdArr = $t.a.objtoarr(JSON.parse(n))
          })
        }, l.prototype.onItem = function(l) {
          var n = this;
          this.popupProvider.presentPrompt().then(function(t) {
            if (ie.a.isNull(t)) n.native.toast_trans("text-id-kyc-prompt-password");
            else {
              n.didNum = l, n.walletManager.didSign(l, n.message, t.toString(), function(l) {
                n.sign = l.value
              }), n.walletManager.didGetPublicKey(l, function(l) {
                n.didPubkey = l.value
              });
              n.platform.exitApp()
            }
          })
        }, l
      }(),
      ba = function() {
        function l(l, n, t, e, a, u, i, s, o) {
          this.appCtrl = l, this.platform = n, this.navCtrl = t, this.navParams = e, this.walletManager = a, this.native = u, this.localStorage = i, this.events = s, this.translate = o, this.backButtonPressed = !1
        }
        return l.prototype.ionViewDidLoad = function() {
          var l = this;
          this.registerBackButtonAction(this.tabs), this.native.showLoading().then(function() {
            l.initializeApp()
          })
        }, l.prototype.registerBackButtonAction = function(l) {
          var n = this;
          this.platform.registerBackButtonAction(function() {
            var t = n.appCtrl.getActiveNav();
            t.canGoBack() ? t.pop() : null == l || l._selectHistory[l._selectHistory.length - 1] === l.getByIndex(0).id ? n.showExit() : l.select(0)
          }, 1)
        }, l.prototype.showExit = function() {
          var l = this;
          if (this.backButtonPressed) this.platform.exitApp();
          else {
            var n = this.translate.instant("text-exit-message");
            this.native.toast(n), this.backButtonPressed = !0, setTimeout(function() {
              return l.backButtonPressed = !1
            }, 2e3)
          }
        }, l.prototype.initializeApp = function() {
          var l = this;
          this.load().then(function(n) {
            l.successHandle(n.success)
          }).catch(function(n) {
            l.errorHandle(n)
          })
        }, l.prototype.load = function() {
          var l = this;
          return new Promise(function(n, t) {
            l.walletManager.getAllMasterWallets(function(l) {
              l.success ? n(l) : t(l)
            })
          })
        }, l.prototype.successHandle = function(l) {
          var n = this,
            t = JSON.parse(l),
            e = ie.a.GetQueryString("type");
          0 === t.length ? ($t.a.setMappingList({}), this.handleNull(e)) : (this.native.info(t), this.localStorage.getCurMasterId().then(function(l) {
            var a = JSON.parse(l);
            if (n.native.info(a.masterId), n.isInArray(t, a.masterId)) $t.a.setCurMasterWalletId(a.masterId), $t.a.setMasterWalletIdList(t), n.handleMappingdata(t), n.getAllsubWallet(a.masterId, e);
            else {
              var u = t[0];
              $t.a.setCurMasterWalletId(u), $t.a.setMasterWalletIdList(t), n.handleMappingdata(t), n.getAllsubWallet(u, e)
            }
          }))
        }, l.prototype.errorHandle = function(l) {
          var n = l.error;
          if (this.native.info(n.code), 10002 === n.code) {
            this.native.info(n.code);
            var t = ie.a.GetQueryString("type");
            this.handleNull(t)
          } else this.native.hideLoading()
        }, l.prototype.handleNull = function(l) {
          var n = this;
          if ("payment" == l) {
            var t = ie.a.GetQueryString("account"),
              e = ie.a.GetQueryString("address"),
              a = ie.a.GetQueryString("memo");
            this.localStorage.set("payment", {
              account: t,
              toAddress: e,
              memo: a
            }).then(function() {
              n.native.hideLoading(), $t.a.setMasterWalletIdList([]), n.native.setRootRouter(va)
            })
          } else this.native.hideLoading(), $t.a.setMasterWalletIdList([]), this.native.setRootRouter(va)
        }, l.prototype.handleMappingdata = function(l) {
          var n = $t.a.getMappingList(),
            t = {};
          for (var e in l) {
            var a = l[e];
            t[a] = n[a]
          }
          $t.a.setMappingList(t), this.native.info($t.a.getMappingList())
        }, l.prototype.getAllsubWallet = function(l, n) {
          var t = this;
          this.walletManager.getAllSubWallets(l, function(e) {
            if (e.success) {
              var a = JSON.parse(e.success);
              for (var u in a) {
                t.registerWalletListener(l, a[u])
              }
              switch (t.native.hideLoading(), n) {
                case "payment":
                  t.native.setRootRouter(Ge);
                  break;
                case "did_login":
                  t.native.setRootRouter(ya);
                  break;
                default:
                  t.native.setRootRouter(ua)
              }
            }
          })
        }, l.prototype.registerWalletListener = function(l, n) {
          var t = this;
          this.walletManager.registerWalletListener(l, n, function(e) {
            $t.a.isResregister(l, n) || $t.a.setResregister(l, n, !0), t.events.publish("register:update", l, n, e)
          })
        }, l.prototype.isInArray = function(l, n) {
          for (var t = 0; t < l.length; t++)
            if (n === l[t]) return !0;
          return !1
        }, l
      }(),
      ka = function() {
        function l(l, n, t, e, a, u, i, s) {
          var o = this;
          this.onicApp = l, this.appCtrl = n, this.platform = t, this.localStorage = u, this.translate = i, this.native = s, this.backButtonPressed = !1, t.ready().then(function() {
            e.styleDefault(), a.hide(), o.initTranslateConfig(), o.init()
          })
        }
        return l.prototype.init = function() {
          var l = this;
          this.getKycIdList(), this.localStorage.getMappingTable().then(function(n) {
            l.native.info(n), n && $t.a.setMappingList(JSON.parse(n)), l.rootPage = ba
          })
        }, l.prototype.onReceiveJG = function(l) {
          var n = JSON.parse(l).serialNum,
            t = this.translate.instant("text-Jpush-kyc-message-1"),
            e = this.translate.instant("text-Jpush-kyc-message-2");
          alert(t + n + e)
        }, l.prototype.initTranslateConfig = function() {
          var l = this;
          this.translate.addLangs(["zh", "en"]), this.localStorage.getLanguage("wallte-language").then(function(n) {
            if (null == n) {
              var t = navigator.language.substr(0, 2),
                e = {
                  name: "English",
                  isoCode: "en"
                };
              "en" == t ? e = {
                name: "English",
                isoCode: "en"
              } : "zh" == t && (e = {
                name: "中文（简体）",
                isoCode: "zh"
              }), l.localStorage.set("wallte-language", e).then(function() {
                l.translate.setDefaultLang(t), l.translate.use(t), l.native.setMnemonicLang("en" == t ? "english" : "zh" == t ? "chinese" : "english")
              })
            } else {
              var a = JSON.parse(n).isoCode;
              l.translate.use(a), l.native.setMnemonicLang("en" == a ? "english" : "zh" == a ? "chinese" : "english")
            }
          })
        }, l.prototype.initJsPush = function() {
          cordova.plugins.Java2JSBridge.init(this), cordova.plugins.Java2JSBridge.getRegistrationID(function(l) {
            $t.a.setDeviceID(l)
          })
        }, l.prototype.getKycIdList = function() {
          this.localStorage.getKycList("kycId").then(function(l) {
            if (null != l && void 0 !== l && l !== {} && "" !== l) {
              var n = $t.a.getSertoId(JSON.parse(l));
              $t.a.setSerIds(n)
            }
          })
        }, l
      }(),
      xa = function() {
        function l(l, n) {
          this.viewCtrl = l, this.native = n, this.singleAddress = !1
        }
        return l.prototype.click_close = function() {
          this.viewCtrl.dismiss({})
        }, l.prototype.click_button = function() {
          this.payPassword ? this.viewCtrl.dismiss({
            password: this.payPassword,
            singleAddress: this.singleAddress
          }) : this.native.toast_trans("text-pwd-validator")
        }, l.prototype.click_vcode = function() {}, l
      }(),
      wa = t(228),
      Ca = t(434),
      Ia = function() {
        function l(l) {
          this.walletManager = l, this.masterWalletId = "1", this.phrasePassword = "66666666", this.newPassword = "66666666", this.payPassword = "66666666", this.backupPassword = "66666666", this.keystoreContent = "ssssss", this.mnemonic = "sssssss", this.language = "english", this.fromAddress = "sssss", this.toAddress = "EWs2TgP4Ds3qZcTzWmBZ5hNsx2PaEyxbui", this.chinaId = "ELA", this.toadress = "EWs2TgP4Ds3qZcTzWmBZ5hNsx2PaEyxbui", this.unit = 1e8, this.rawTransaction = "sss", this.interfaces = [{
            id: 24,
            name: "generateMnemonic"
          }, {
            id: 3,
            name: "createMasterWallet"
          }, {
            id: 0,
            name: "createSubWallet"
          }, {
            id: 9,
            name: "createAddress"
          }, {
            id: 41,
            name: "createTransaction"
          }, {
            id: 42,
            name: "calculateTransactionFee"
          }, {
            id: 43,
            name: "sendRawTransaction"
          }, {
            id: 30,
            name: "createDID"
          }, {
            id: 31,
            name: "getDIDList"
          }, {
            id: 32,
            name: "destoryDID"
          }, {
            id: 33,
            name: "didSetValue"
          }, {
            id: 34,
            name: "didGetValue"
          }, {
            id: 35,
            name: "didGetHistoryValue"
          }, {
            id: 37,
            name: "didGetAllKeys"
          }, {
            id: 38,
            name: "didSign"
          }, {
            id: 39,
            name: "didCheckSign"
          }, {
            id: 40,
            name: "didGetPublicKey"
          }, {
            id: 28,
            name: "getSupportedChains"
          }, {
            id: 8,
            name: "getBalance"
          }, {
            id: 29,
            name: "changePassword"
          }, {
            id: 19,
            name: "getAllMasterWallets"
          }, {
            id: 1,
            name: "recoverSubWallet"
          }, {
            id: 4,
            name: "importWalletWithKeystore"
          }, {
            id: 5,
            name: "importWalletWithMnemonic"
          }, {
            id: 6,
            name: "exportWalletWithKeystore"
          }, {
            id: 10,
            name: "getAllAddress"
          }, {
            id: 11,
            name: "getBalanceWithAddress"
          }, {
            id: 13,
            name: "generateMultiSignTransaction"
          }, {
            id: 14,
            name: "getAllTransaction"
          }, {
            id: 15,
            name: "registerWalletListener"
          }, {
            id: 16,
            name: "checkSign"
          }, {
            id: 17,
            name: "sing"
          }, {
            id: 18,
            name: "deriveIdAndKeyForPurpose"
          }, {
            id: 20,
            name: "destroyWallet"
          }, {
            id: 21,
            name: "isAddressValid"
          }, {
            id: 22,
            name: "getBalanceInfo"
          }, {
            id: 25,
            name: "saveConfigs"
          }, {
            id: 26,
            name: "getWalletId"
          }, {
            id: 27,
            name: "getAllChainIds"
          }, {
            id: 7,
            name: "exportWalletWithMnemonic"
          }]
        }
        return l.prototype.onNext = function(l) {
          switch (l) {
            case 41:
              this.createTransaction();
              break;
            case 42:
              this.calculateTransactionFee();
              break;
            case 43:
              this.sendRawTransaction();
              break;
            case 40:
              this.didGetPublicKey();
              break;
            case 39:
              this.didCheckSign();
              break;
            case 38:
              this.didSign();
              break;
            case 37:
              this.didGetAllKeys();
              break;
            case 35:
              this.didGetHistoryValue();
              break;
            case 34:
              this.didGetValue();
            case 33:
              this.didSetValue();
              break;
            case 30:
              this.createDID();
              break;
            case 31:
              this.getDIDList();
              break;
            case 32:
              this.destoryDID(this.did);
              break;
            case 0:
              this.createSubWallet(this.chinaId);
              break;
            case 1:
              this.recoverSubWallet();


            case 3:
              this.createMasterWallet(this.masterWalletId, this.mnemonic, this.phrasePassword, this.payPassword);



              break;



            case 4:
              this.importWalletWithKeystore(this.masterWalletId, "sssss", this.backupPassword, this.payPassword, this.phrasePassword);
              break;
            case 5:
              this.importWalletWithMnemonic(this.masterWalletId, this.mnemonic, this.phrasePassword, this.payPassword);
              break;
            case 6:
              this.exportWalletWithKeystore(this.backupPassword, this.payPassword);
              break;
            case 7:
              this.exportWalletWithMnemonic(this.backupPassword);
              break;
            case 8:
              this.getBalance();
              break;
            case 9:
              this.createAddress(this.chinaId);
              break;
            case 10:
              this.getAllAddress(this.chinaId);
              break;
            case 11:
              this.getBalanceWithAddress(this.chinaId);
              break;
            case 13:
              this.generateMultiSignTransaction();
              break;
            case 14:
              this.getAllTransaction();
              break;
            case 15:
              this.registerWalletListener(this.chinaId);
              break;
            case 16:
              this.checkSign("ssssss", this.singMessage, "sssss", this.payPassword);
              break;
            case 17:
              this.sign("1111111111111", this.payPassword);
              break;
            case 18:
              this.deriveIdAndKeyForPurpose(1, 1, this.payPassword);
              break;
            case 19:
              this.getAllMasterWallets();
              break;
            case 20:
              this.destroyWallet(this.masterWalletId);
              break;
            case 21:
              this.isAddressValid(this.adress);
              break;
            case 22:
              this.getBalanceInfo(this.chinaId);
              break;
            case 24:
              this.generateMnemonic();
              break;
            case 25:
              this.saveConfigs();
              break;
            case 26:
              this.getWalletId();
              break;
            case 27:
              this.getAllChainIds();
              break;
            case 28:
              this.getSupportedChains();
              break;
            case 29:
              this.changePassword()
          }
        }, l.prototype.changePassword = function() {
          this.walletManager.changePassword(this.masterWalletId, this.payPassword, this.newPassword, function() {
            alert("修改成功")
          })
        }, l.prototype.generateMnemonic = function() {
          this.walletManager.generateMnemonic(this.language, function(l) {
            alert("=====generateMnemonic=====" + JSON.stringify(l))
          })
        }, l.prototype.destroyWallet = function(l) {
          this.walletManager.destroyWallet(l, function(l) {
            alert("删除主钱包成功")
          })
        }, l.prototype.createSubWallet = function(l) {
          this.walletManager.createSubWallet(this.masterWalletId, l, 0, function(l) {
            alert("子钱包"), alert(JSON.stringify(l))
          })
        }, l.prototype.recoverSubWallet = function() {
          this.walletManager.recoverSubWallet(this.masterWalletId, this.chinaId, 0, 0, function() {
            alert("恢复子钱包")
          })
        }, l.prototype.createMasterWallet = function(l, n, t, e) {
          this.walletManager.createMasterWallet(l, n, t, e, !1, function(l) {
            alert("创建主钱包成功")
          })
        }, l.prototype.importWalletWithKeystore = function(l, n, t, e, a) {
          this.walletManager.importWalletWithKeystore(l, n, t, e, function() {
            alert("导入keystore成功")
          })
        }, l.prototype.importWalletWithMnemonic = function(l, n, t, e) {
          this.walletManager.importWalletWithMnemonic(l, n, t, e, !1, function() {
            alert("导入住记词成功")
          })
        }, l.prototype.exportWalletWithKeystore = function(l, n) {
          this.walletManager.exportWalletWithKeystore(this.masterWalletId, l, n, function(l) {
            alert("导出keystore成功" + JSON.stringify(l))
          })
        }, l.prototype.exportWalletWithMnemonic = function(l) {
          this.walletManager.exportWalletWithMnemonic(this.masterWalletId, l, function(l) {
            alert(JSON.stringify(l))
          })
        }, l.prototype.createAddress = function(l) {
          var n = this;
          this.walletManager.createAddress(this.masterWalletId, l, function(l) {
            n.adress = l.address, alert(n.adress)
          })
        }, l.prototype.getAllAddress = function(l) {
          alert("===chinaId====" + l), this.walletManager.getAllAddress(this.masterWalletId, l, 0, function(l) {
            alert(JSON.stringify(l))
          })
        }, l.prototype.getBalanceWithAddress = function(l) {
          this.walletManager.getBalanceWithAddress(this.masterWalletId, l, "eeeeeeee", function(l) {
            alert(JSON.stringify(l))
          })
        }, l.prototype.generateMultiSignTransaction = function() {}, l.prototype.getAllTransaction = function() {
          this.walletManager.getAllTransaction(this.masterWalletId, this.chinaId, 0, "123455", function(l) {
            alert(JSON.stringify(l))
          })
        }, l.prototype.registerWalletListener = function(l) {
          this.walletManager.registerWalletListener(this.masterWalletId, l, function(l) {
            alert("监听注册成功")
          })
        }, l.prototype.checkSign = function(l, n, t, e) {
          this.walletManager.checkSign(this.masterWalletId, this.chinaId, l, n, t, function(l) {
            alert(JSON.stringify(l))
          })
        }, l.prototype.sign = function(l, n) {
          var t = this;
          this.walletManager.sign(this.masterWalletId, this.chinaId, l, n, function(l) {
            alert(JSON.stringify(l)), t.singMessage = l
          })
        }, l.prototype.getBalance = function() {
          this.walletManager.getBalance(this.masterWalletId, this.chinaId, function(l) {
            alert("获取余额" + JSON.stringify(l))
          })
        }, l.prototype.deriveIdAndKeyForPurpose = function(l, n, t) {
          this.walletManager.deriveIdAndKeyForPurpose(l, n, t, function(l) {
            alert(JSON.stringify(l))
          })
        }, l.prototype.getAllMasterWallets = function() {
          this.walletManager.getAllMasterWallets(function(l) {
            alert("allAllMasterWallets" + JSON.stringify(l))
          })
        }, l.prototype.isAddressValid = function(l) {
          this.walletManager.isAddressValid(this.masterWalletId, l, function(l) {
            alert("isAddressValid====" + JSON.stringify(l))
          })
        }, l.prototype.getBalanceInfo = function(l) {
          this.walletManager.getBalanceInfo(this.masterWalletId, l, function(l) {
            alert("余额信息：" + JSON.stringify(l))
          })
        }, l.prototype.saveConfigs = function() {
          this.walletManager.saveConfigs(function(l) {
            alert("保存配置成功")
          })
        }, l.prototype.getWalletId = function() {}, l.prototype.getAllChainIds = function() {
          this.walletManager.getAllChainIds(function(l) {
            alert("所有子钱包==" + JSON.stringify(l))
          })
        }, l.prototype.getSupportedChains = function() {
          var l = this;
          this.walletManager.getSupportedChains(this.masterWalletId, function(n) {
            alert("已经支持的所有子钱包==" + JSON.stringify(n));
            for (var t in n) l.createSubWallet(t)
          })
        }, l.prototype.createDID = function() {
          var l = this;
          this.walletManager.createDID(this.payPassword, function(n) {
            alert("==did==" + JSON.stringify(n)), l.did = n.didname
          })
        }, l.prototype.getDIDList = function() {
          this.walletManager.getDIDList(function(l) {
            alert("==DIDList==" + JSON.stringify(l))
          })
        }, l.prototype.destoryDID = function(l) {
          this.walletManager.destoryDID(l, function(n) {
            alert("删除成功：" + l)
          })
        }, l.prototype.didSetValue = function() {
          alert("===didSetValue===" + this.did);
          this.walletManager.didSetValue(this.did, "1", JSON.stringify({
            101: {
              datahash: "datahash1",
              proof: "hello proof1",
              sign: "hello sign1"
            },
            102: {
              datahash: "datahash2",
              proof: "hello proof2",
              sign: "hello sign2"
            },
            103: {
              datahash: "datahash3",
              proof: "hello proof3",
              sign: "hello sign3"
            }
          }), function(l) {
            alert("=====" + JSON.stringify(l))
          })
        }, l.prototype.didGetValue = function() {
          this.walletManager.didGetValue(this.did, "1", function(l) {
            alert("===didGetValue====" + JSON.stringify(l))
          })
        }, l.prototype.didGetHistoryValue = function() {
          this.walletManager.didGetHistoryValue(this.did, "1", function(l) {
            alert("===didGetHistoryValue====" + JSON.stringify(l))
          })
        }, l.prototype.didGetAllKeys = function() {
          this.walletManager.didGetAllKeys(this.did, 0, 2, function(l) {
            alert("===didGetAllKeys====" + JSON.stringify(l))
          })
        }, l.prototype.didSign = function() {
          var l = this;
          this.walletManager.didSign(this.did, "ssssss", this.payPassword, function(n) {
            alert("===didSign===" + JSON.stringify(n)), l.signature = "sssss"
          })
        }, l.prototype.didCheckSign = function() {
          this.walletManager.didCheckSign(this.did, "ssssss", this.signature, function(l) {
            alert("===didCheckSign===" + JSON.stringify(l))
          })
        }, l.prototype.didGetPublicKey = function() {
          this.walletManager.didGetPublicKey(this.did, function(l) {
            alert("===didGetPublicKey===" + JSON.stringify(l))
          })
        }, l.prototype.createTransaction = function() {
          this.walletManager.createTransaction(this.masterWalletId, this.chinaId, "", this.toAddress, 1 * this.unit, "sssssss", "ssss", function(l) {
            alert("=====createTransaction======" + JSON.stringify(l))
          })
        }, l.prototype.calculateTransactionFee = function() {
          this.walletManager.calculateTransactionFee(this.masterWalletId, this.chinaId, this.rawTransaction, 0, function(l) {
            alert("===== calculateTransactionFee =====" + JSON.stringify(l))
          })
        }, l.prototype.sendRawTransaction = function() {}, l
      }(),
      Pa = t(246),
      Sa = function() {
        function l() {}
        return l.prototype.getTranslation = function(l) {
          return Yt.Observable.create(function(n) {
            switch (l) {
              case "zh":
              default:
                n.next(Gt);
                break;
              case "en":
                n.next(Ht)
            }
            n.complete()
          })
        }, l
      }(),
      Da = function() {
        return new Sa
      },
      Ma = function() {
        return function() {}
      }(),
      ja = t(95),
      Wa = t(436),
      Oa = t(437),
      Na = t(438),
      Ta = t(439),
      La = t(440),
      Aa = t(441),
      Ra = t(442),
      Ja = t(443),
      Ea = t(444),
      Va = t(829),
      Fa = t(74),
      za = t(113),
      Ka = t(6),
      Ba = t(10),
      Ya = t(7),
      Ga = t(3),
      Ha = t(5),
      Ua = t(19),
      qa = t(69),
      $a = t(53),
      Za = t(8),
      Qa = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Xa = Vt.Z("app", ka, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app", [], null, null, null, e, Qa)), Vt._2(1, 49152, null, 0, ka, [ja.b, Ya.a, Ha.a, zt.a, Ft.a, Zt, Bt.k, ue.a], null, null)], null, null)
      }, {}, {}, []),
      lu = t(830),
      nu = t(102),
      tu = t(13),
      eu = t(831),
      au = t(152),
      uu = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      iu = Vt.Z("ng-component", ua, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "ng-component", [], null, null, null, a, uu)), Vt._2(1, 49152, null, 0, ua, [], null, null)], null, null)
      }, {}, {}, []),
      su = t(51),
      ou = t(49),
      ru = t(445),
      cu = t(171),
      _u = t(20),
      du = t(12),
      hu = t(90),
      pu = t(244),
      gu = t(101),
      fu = t(17),
      mu = t(56),
      vu = t(9),
      yu = t(33),
      bu = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      ku = Vt.Z("app-home", Ue, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-home", [], null, null, null, o, bu)), Vt._2(1, 49152, null, 0, Ue, [Ba.a, vu.a, se, ue.a, Zt, Vt.x, yu.a, te.a], null, null)], null, null)
      }, {}, {}, []),
      xu = t(89),
      wu = t(37),
      Cu = t(27),
      Iu = t(26),
      Pu = t(32),
      Su = t(35),
      Du = t(47),
      Mu = t(43),
      ju = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Wu = Vt.Z("app-my", aa, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-my", [], null, null, null, d, ju)), Vt._2(1, 49152, null, 0, aa, [Ba.a, vu.a, se, yu.a, ue.a, Zt], null, null)], null, null)
      }, {}, {}, []),
      Ou = t(22),
      Nu = t(24),
      Tu = t(16),
      Lu = t(25),
      Au = t(21),
      Ru = t(18),
      Ju = t(29),
      Eu = t(23),
      Vu = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Fu = Vt.Z("app-launcher", va, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-launcher", [], null, null, null, h, Vu)), Vt._2(1, 49152, null, 0, va, [Ba.a, vu.a], null, null)], null, null)
      }, {}, {}, []),
      zu = t(64),
      Ku = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Bu = Vt.Z("app-manager", na, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-manager", [], null, null, null, v, Ku)), Vt._2(1, 49152, null, 0, na, [Ba.a, vu.a, yu.a, Zt, te.a, se, Ya.a, ue.a], null, null)], null, null)
      }, {}, {}, []),
      Yu = t(48),
      Gu = t(44),
      Hu = t(38),
      Uu = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      qu = Vt.Z("app-paypassword-reset", $e, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-paypassword-reset", [], null, null, null, y, Uu)), Vt._2(1, 49152, null, 0, $e, [Ba.a, vu.a, se, ue.a], null, null)], null, null)
      }, {}, {}, []),
      $u = t(130),
      Zu = t(85),
      Qu = t(207),
      Xu = t(832),
      li = t(116),
      ni = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      ti = Vt.Z("app-import", da, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-import", [], null, null, null, I, ni)), Vt._2(1, 49152, null, 0, da, [Ba.a, vu.a, se, ue.a, Zt, yu.a, te.a], null, null)], null, null)
      }, {}, {}, []),
      ei = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      ai = Vt.Z("app-exprot-prikey", qe, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-exprot-prikey", [], null, null, null, N, ei)), Vt._2(1, 49152, null, 0, qe, [Ba.a, vu.a, se, ue.a, Zt], null, null)], null, null)
      }, {}, {}, []),
      ui = t(435),
      ii = t(117),
      si = t(67),
      oi = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      ri = Vt.Z("app-mnemonic", ca, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-mnemonic", [], null, null, null, R, oi)), Vt._2(1, 49152, null, 0, ca, [Ba.a, vu.a, se, ue.a, Zt, yu.a], null, null)], null, null)
      }, {}, {}, []),
      ci = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      _i = Vt.Z("app-write", ra, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-write", [], null, null, null, z, ci)), Vt._2(1, 49152, null, 0, ra, [Ba.a, vu.a, ue.a], null, null)], null, null)
      }, {}, {}, []),
      di = t(112),
      hi = t(833),
      pi = t(142),
      gi = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      fi = Vt.Z("app-address", Fe, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-address", [], null, null, null, B, gi)), Vt._2(1, 49152, null, 0, Fe, [Ba.a, vu.a, se, yu.a, ue.a], null, null)], null, null)
      }, {}, {}, []),
      mi = t(91),
      vi = t(93),
      yi = t(75),
      bi = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      ki = Vt.Z("app-contacts", re, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-contacts", [], null, null, null, Z, bi)), Vt._2(1, 49152, null, 0, re, [Ba.a, vu.a, ue.a, Zt, yu.a, te.a], null, null)], null, null)
      }, {}, {}, []),
      xi = t(124),
      wi = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Ci = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Ii = Vt.Z("coin", Be, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "coin", [], null, null, null, ul, Ci)), Vt._2(1, 49152, null, 0, Be, [Ba.a, vu.a, se, ue.a, yu.a], null, null)], null, null)
      }, {}, {}, []),
      Pi = t(76),
      Si = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Di = Vt.Z("app-transfer", Re, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-transfer", [], null, null, null, il, Si)), Vt._2(1, 49152, null, 0, Re, [Ba.a, vu.a, se, ue.a, Zt, Pi.a, yu.a], null, null)], null, null)
      }, {}, {}, []),
      Mi = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      ji = Vt.Z("app-payment-confirm", Ge, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-payment-confirm", [], null, null, null, sl, Mi)), Vt._2(1, 49152, null, 0, Ge, [Ba.a, vu.a, se, ue.a, Zt, Pi.a, yu.a], null, null)], null, null)
      }, {}, {}, []),
      Wi = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Oi = Vt.Z("app-did-login", ya, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-did-login", [], null, null, null, rl, Wi)), Vt._2(1, 49152, null, 0, ya, [Ba.a, vu.a, ue.a, Zt, se, te.a, Ha.a], null, null)], null, null)
      }, {}, {}, []),
      Ni = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Ti = Vt.Z("app-receive", ze, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-receive", [], null, null, null, cl, Ni)), Vt._2(1, 49152, null, 0, ze, [Ba.a, vu.a, se, ue.a], null, null)], null, null)
      }, {}, {}, []),
      Li = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Ai = Vt.Z("app-recharge", Je, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-recharge", [], null, null, null, _l, Li)), Vt._2(1, 49152, null, 0, Je, [Ba.a, vu.a, se, ue.a, Zt, Pi.a, yu.a], null, null)], null, null)
      }, {}, {}, []),
      Ri = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Ji = Vt.Z("app-coin-slect", Ee, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-coin-slect", [], null, null, null, gl, Ri)), Vt._2(1, 49152, null, 0, Ee, [Ba.a, vu.a, ue.a], null, null)], null, null)
      }, {}, {}, []),
      Ei = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Vi = Vt.Z("app-withdraw", Ve, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-withdraw", [], null, null, null, fl, Ei)), Vt._2(1, 49152, null, 0, Ve, [Ba.a, vu.a, se, ue.a, Zt, Pi.a, yu.a], null, null)], null, null)
      }, {}, {}, []),
      Fi = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      zi = Vt.Z("app-contact-list", ce, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-contact-list", [], null, null, null, bl, Fi)), Vt._2(1, 49152, null, 0, ce, [Ba.a, vu.a, se, ue.a, Zt, yu.a], null, null)], null, null)
      }, {}, {}, []),
      Ki = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Bi = Vt.Z("page-publickey", Qe, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-publickey", [], null, null, null, kl, Ki)), Vt._2(1, 49152, null, 0, Qe, [Ba.a, vu.a, ue.a, se], null, null)], null, null)
      }, {}, {}, []),
      Yi = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Gi = Vt.Z("app-contact-create", oe, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-contact-create", [], null, null, null, xl, Yi)), Vt._2(1, 49152, null, 0, oe, [Ba.a, vu.a, se, ue.a, Zt, yu.a], null, null)], null, null)
      }, {}, {}, []),
      Hi = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Ui = Vt.Z("app-coin-list", Ye, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-coin-list", [], null, null, null, Il, Hi)), Vt._2(1, 49152, null, 0, Ye, [Ba.a, vu.a, se, ue.a, Zt, Pi.a, yu.a], null, null)], null, null)
      }, {}, {}, []),
      qi = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      $i = Vt.Z("app-wallet-create", _a, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-wallet-create", [], null, null, null, Pl, qi)), Vt._2(1, 49152, null, 0, _a, [Ba.a, vu.a, ue.a], null, null)], null, null)
      }, {}, {}, []),
      Zi = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Qi = Vt.Z("app-recordinfo", Ke, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-recordinfo", [], null, null, null, Nl, Zi)), Vt._2(1, 49152, null, 0, Ke, [Ba.a, vu.a, se, ue.a], null, null)], null, null)
      }, {}, {}, []),
      Xi = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      ls = Vt.Z("app-testjni", Ia, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-testjni", [], null, null, null, Ll, Xi)), Vt._2(1, 49152, null, 0, Ia, [se], null, null)], null, null)
      }, {}, {}, []),
      ns = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      ts = Vt.Z("id-launcher", ta, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "id-launcher", [], null, null, null, Al, ns)), Vt._2(1, 49152, null, 0, ta, [Ba.a, vu.a, ue.a, se, Zt, yu.a, ee], null, null)], null, null)
      }, {}, {}, []),
      es = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      as = Vt.Z("id-home", We, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "id-home", [], null, null, null, Vl, es)), Vt._2(1, 49152, null, 0, We, [Ba.a, vu.a, ue.a, se, Zt, yu.a, ee], null, null)], null, null)
      }, {}, {}, []),
      us = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      is = Vt.Z("id-import", ve, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "id-import", [], null, null, null, Fl, us)), Vt._2(1, 49152, null, 0, ve, [Ba.a, vu.a, ue.a, Zt, ee], null, null)], null, null)
      }, {}, {}, []),
      ss = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      os = Vt.Z("app-manager", ye, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "app-manager", [], null, null, null, Hl, ss)), Vt._2(1, 49152, null, 0, ye, [Ba.a, vu.a, ue.a, se, Zt, yu.a, ee], null, null)], null, null)
      }, {}, {}, []),
      rs = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      cs = Vt.Z("id-company", be, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "id-company", [], null, null, null, Ul, rs)), Vt._2(1, 49152, null, 0, be, [Ba.a, vu.a, ue.a, se, Zt, yu.a, ee], null, null)], null, null)
      }, {}, {}, []),
      _s = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      ds = Vt.Z("id-kyc-result", Oe, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "id-kyc-result", [], null, null, null, Zl, _s)), Vt._2(1, 49152, null, 0, Oe, [Ba.a, vu.a, ue.a, se, Zt, yu.a, ee], null, null)], null, null)
      }, {}, {}, []),
      hs = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      ps = Vt.Z("page-company-write-chain", ke, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-company-write-chain", [], null, null, null, en, hs)), Vt._2(1, 49152, null, 0, ke, [Ba.a, vu.a, ue.a, se, Zt, yu.a, ee, te.a, Vt.x], null, null)], null, null)
      }, {}, {}, []),
      gs = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      fs = Vt.Z("page-person-write-chain", Ce, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-person-write-chain", [], null, null, null, pn, gs)), Vt._2(1, 49152, null, 0, Ce, [Ba.a, vu.a, ue.a, se, Zt, yu.a, ee, te.a, Vt.x], null, null)], null, null)
      }, {}, {}, []),
      ms = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      vs = Vt.Z("page-pathlist", je, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-pathlist", [], null, null, null, fn, ms)), Vt._2(1, 49152, null, 0, je, [Ba.a, vu.a, ue.a, se, Zt, yu.a, ee], null, null)], null, null)
      }, {}, {}, []),
      ys = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      bs = Vt.Z("page-companypathinfo", xe, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-companypathinfo", [], null, null, null, wn, ys)), Vt._2(1, 49152, null, 0, xe, [Ba.a, vu.a, ue.a, se, Zt, yu.a, ee], null, null)], null, null)
      }, {}, {}, []),
      ks = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      xs = Vt.Z("page-bankcardpathinfo", Ie, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-bankcardpathinfo", [], null, null, null, jn, ks)), Vt._2(1, 49152, null, 0, Ie, [Ba.a, vu.a, ue.a, se, Zt, yu.a, ee], null, null)], null, null)
      }, {}, {}, []),
      ws = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Cs = Vt.Z("page-phonepathinfo", Se, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-phonepathinfo", [], null, null, null, Rn, ws)), Vt._2(1, 49152, null, 0, Se, [Ba.a, vu.a, ue.a, Zt, ee], null, null)], null, null)
      }, {}, {}, []),
      Is = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Ps = Vt.Z("page-identitypathinfo", Me, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-identitypathinfo", [], null, null, null, Bn, Is)), Vt._2(1, 49152, null, 0, Me, [Ba.a, vu.a, ue.a, Zt, ee], null, null)], null, null)
      }, {}, {}, []),
      Ss = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Ds = Vt.Z("page-identityauth", De, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-identityauth", [], null, null, null, Yn, Ss)), Vt._2(1, 49152, null, 0, De, [Ba.a, vu.a, ue.a, se, Zt, yu.a, ee], null, null)], null, null)
      }, {}, {}, []),
      Ms = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      js = Vt.Z("page-phoneauth", Pe, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-phoneauth", [], null, null, null, Gn, Ms)), Vt._2(1, 49152, null, 0, Pe, [Ba.a, vu.a, ue.a, se, Zt, yu.a, ee], null, null)], null, null)
      }, {}, {}, []),
      Ws = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Os = Vt.Z("page-bankcardauth", we, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-bankcardauth", [], null, null, null, Hn, Ws)), Vt._2(1, 49152, null, 0, we, [Ba.a, vu.a, ue.a, se, Zt, yu.a, ee], null, null)], null, null)
      }, {}, {}, []),
      Ns = t(198),
      Ts = t(100),
      Ls = t(88),
      As = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Rs = Vt.Z("page-language", ea, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-language", [], null, null, null, qn, As)), Vt._2(1, 49152, null, 0, ea, [Ba.a, Bt.k, vu.a, Zt, yu.a], null, null)], null, null)
      }, {}, {}, []),
      Js = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Es = Vt.Z("page-walltelist", He, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-walltelist", [], null, null, null, Xn, Js)), Vt._2(1, 49152, null, 0, He, [Ba.a, vu.a, yu.a, Zt, ue.a, Vt.x, se], null, null)], null, null)
      }, {}, {}, []),
      Vs = t(150),
      Fs = t(834),
      zs = t(151),
      Ks = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Bs = Vt.Z("page-createmultiwallte", ma, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-createmultiwallte", [], null, null, null, tt, Ks)), Vt._2(1, 49152, null, 0, ma, [Ba.a, vu.a, ue.a], null, null)], null, null)
      }, {}, {}, []),
      Ys = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Gs = Vt.Z("page-walltemode", fa, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-walltemode", [], null, null, null, et, Ys)), Vt._2(1, 49152, null, 0, fa, [Ba.a, vu.a, ue.a], null, null)], null, null)
      }, {}, {}, []),
      Hs = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Us = Vt.Z("page-addpublickey", ia, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-addpublickey", [], null, null, null, it, Hs)), Vt._2(1, 49152, null, 0, ia, [Ba.a, vu.a, se, ue.a, Zt, yu.a], null, null)], null, null)
      }, {}, {}, []),
      qs = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      $s = Vt.Z("page-addprivatekey", sa, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-addprivatekey", [], null, null, null, ot, qs)), Vt._2(1, 49152, null, 0, sa, [Ba.a, vu.a, se, ue.a, Zt, yu.a], null, null)], null, null)
      }, {}, {}, []),
      Zs = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Qs = Vt.Z("page-importprivatekey", ha, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-importprivatekey", [], null, null, null, rt, Zs)), Vt._2(1, 49152, null, 0, ha, [Ba.a, vu.a, ue.a], null, null)], null, null)
      }, {}, {}, []),
      Xs = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      lo = Vt.Z("page-coinlistpassword", xa, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-coinlistpassword", [], null, null, null, ct, Xs)), Vt._2(1, 49152, null, 0, xa, [Ka.a, ue.a], null, null)], null, null)
      }, {}, {}, []),
      no = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      to = Vt.Z("page-scancode", Ne, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-scancode", [], null, null, null, _t, no)), Vt._2(1, 49152, null, 0, Ne, [Ba.a, vu.a, ue.a, se], null, null)], null, null)
      }, {}, {}, []),
      eo = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      ao = Vt.Z("page-txdetails", Le, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-txdetails", [], null, null, null, pt, eo)), Vt._2(1, 49152, null, 0, Le, [Ba.a, vu.a, te.a, ue.a, se], null, null)], null, null)
      }, {}, {}, []),
      uo = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      io = Vt.Z("page-initializepage", ba, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-initializepage", [], null, null, null, gt, uo)), Vt._2(1, 49152, null, 0, ba, [Ya.a, Ha.a, Ba.a, vu.a, se, ue.a, Zt, yu.a, Bt.k], null, null)], null, null)
      }, {}, {}, []),
      so = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      oo = Vt.Z("page-paymentbox", Te, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-paymentbox", [], null, null, null, vt, so)), Vt._2(1, 49152, null, 0, Te, [Ba.a, vu.a, Ka.a, ue.a], null, null)], null, null)
      }, {}, {}, []),
      ro = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      co = Vt.Z("page-createwalletname", pa, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-createwalletname", [], null, null, null, yt, ro)), Vt._2(1, 49152, null, 0, pa, [Ba.a, vu.a, ue.a], null, null)], null, null)
      }, {}, {}, []),
      _o = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      ho = Vt.Z("page-modifywalletname", Ze, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-modifywalletname", [], null, null, null, bt, _o)), Vt._2(1, 49152, null, 0, Ze, [Ba.a, vu.a, ue.a, Zt, yu.a], null, null)], null, null)
      }, {}, {}, []),
      po = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      go = Vt.Z("page-mpublickey", oa, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-mpublickey", [], null, null, null, kt, po)), Vt._2(1, 49152, null, 0, oa, [Ba.a, vu.a, ue.a, se], null, null)], null, null)
      }, {}, {}, []),
      fo = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      mo = Vt.Z("page-importmnemonic", ga, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-importmnemonic", [], null, null, null, It, fo)), Vt._2(1, 49152, null, 0, ga, [Ba.a, vu.a, ue.a], null, null)], null, null)
      }, {}, {}, []),
      vo = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      yo = Vt.Z("page-exportmnemomic", la, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-exportmnemomic", [], null, null, null, Nt, vo)), Vt._2(1, 49152, null, 0, la, [Ba.a, vu.a, se, ue.a, yu.a], null, null)], null, null)
      }, {}, {}, []),
      bo = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      ko = Vt.Z("page-checkmnemomic", Xe, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-checkmnemomic", [], null, null, null, Rt, bo)), Vt._2(1, 49152, null, 0, Xe, [Ba.a, vu.a, ue.a], null, null)], null, null)
      }, {}, {}, []),
      xo = t(835),
      wo = t(98),
      Co = Vt._1({
        encapsulation: 2,
        styles: [],
        data: {}
      }),
      Io = Vt.Z("page-scan", Ae, function(l) {
        return Vt._25(0, [(l()(), Vt._3(0, 0, null, null, 1, "page-scan", [], null, null, null, Jt, Co)), Vt._2(1, 49152, null, 0, Ae, [Ba.a, vu.a, ae.a, Ka.a, yu.a, ue.a], null, null)], null, null)
      }, {}, {}, []),
      Po = t(199),
      So = t(397),
      Do = t(230),
      Mo = t(180),
      jo = t(182),
      Wo = t(188),
      Oo = t(245),
      No = t(110),
      To = t(94),
      Lo = t(140),
      Ao = t(205),
      Ro = t(201),
      Jo = t(210),
      Eo = t(395),
      Vo = t(392),
      Fo = t(200),
      zo = t(80),
      Ko = t(189),
      Bo = t(202),
      Yo = t(394),
      Go = Vt._0(Ma, [ja.b], function(l) {
        return Vt._11([Vt._12(512, Vt.i, Vt.W, [
          [8, [Wa.a, Oa.a, Na.a, Ta.a, La.a, Aa.a, Ra.a, Ja.a, Ea.a, Xa, iu, ku, Wu, Fu, Bu, qu, ti, ai, ri, _i, fi, ki, Ii, Di, ji, Oi, Ti, Ai, Ji, Vi, zi, Bi, Gi, Ui, $i, Qi, ls, ts, as, is, os, cs, ds, ps, fs, vs, bs, xs, Cs, Ps, Ds, js, Os, Rs, Es, Bs, Gs, Us, $s, Qs, lo, to, ao, io, oo, co, ho, go, mo, yo, ko, Io]],
          [3, Vt.i], Vt.v
        ]), Vt._12(5120, Vt.u, Vt._20, [
          [3, Vt.u]
        ]), Vt._12(4608, fu.k, fu.j, [Vt.u, [2, fu.s]]), Vt._12(5120, Vt.b, Vt._5, []), Vt._12(5120, Vt.s, Vt._13, []), Vt._12(5120, Vt.t, Vt._16, []), Vt._12(4608, Et.c, Et.q, [fu.c]), Vt._12(6144, Vt.H, null, [Et.c]), Vt._12(4608, Et.f, Po.a, []), Vt._12(5120, Et.d, function(l, n, t, e, a) {
          return [new Et.k(l, n), new Et.o(t), new Et.n(e, a)]
        }, [fu.c, Vt.x, fu.c, fu.c, Et.f]), Vt._12(4608, Et.e, Et.e, [Et.d, Vt.x]), Vt._12(135680, Et.m, Et.m, [fu.c]), Vt._12(4608, Et.l, Et.l, [Et.e, Et.m]), Vt._12(5120, So.a, Xt.d, []), Vt._12(5120, So.c, Xt.e, []), Vt._12(4608, So.b, Xt.c, [So.a, So.c]), Vt._12(5120, Vt.F, Xt.f, [Et.l, So.b, Vt.x]), Vt._12(6144, Et.p, null, [Et.m]), Vt._12(4608, Vt.K, Vt.K, [Vt.x]), Vt._12(4608, Et.h, Et.h, [fu.c]), Vt._12(4608, Et.i, Et.i, [fu.c]), Vt._12(4608, Kt.c, Kt.c, []), Vt._12(4608, Kt.h, Kt.b, []), Vt._12(5120, Kt.k, Kt.l, []), Vt._12(4608, Kt.j, Kt.j, [Kt.c, Kt.h, Kt.k]), Vt._12(4608, Kt.g, Kt.a, []), Vt._12(5120, Kt.e, Kt.m, [Kt.j, Kt.g]), Vt._12(4608, Ut.n, Ut.n, []), Vt._12(4608, Do.b, Xt.b, [Vt.F, Et.b]), Vt._12(4608, Ut.c, Ut.c, []), Vt._12(5120, Bt.g, Da, []), Vt._12(4608, Bt.c, Bt.e, []), Vt._12(4608, Bt.i, Bt.d, []), Vt._12(4608, Bt.b, Bt.a, []), Vt._12(4608, Bt.n, Bt.n, []), Vt._12(4608, Bt.k, Bt.k, [Bt.n, Bt.g, Bt.c, Bt.i, Bt.b, Bt.l, Bt.m]), Vt._12(4608, Mo.a, Mo.a, [Ya.a, Ga.a]), Vt._12(4608, jo.a, jo.a, [Ya.a, Ga.a]), Vt._12(4608, yu.a, yu.a, []), Vt._12(4608, Iu.a, Iu.a, []), Vt._12(4608, si.a, si.a, [Ha.a]), Vt._12(4608, tu.a, tu.a, [Ga.a, Ha.a, Vt.x, Za.a]), Vt._12(4608, Wo.a, Wo.a, [Ya.a, Ga.a]), Vt._12(5120, fu.f, Oo.c, [fu.q, [2, fu.a], Ga.a]), Vt._12(4608, fu.e, fu.e, [fu.f]), Vt._12(5120, No.b, No.d, [Ya.a, No.a]), Vt._12(5120, $a.a, $a.b, [Ya.a, No.b, fu.e, To.b, Vt.i]), Vt._12(4608, Pi.a, Pi.a, [Ya.a, Ga.a, $a.a]), Vt._12(4608, Lo.a, Lo.a, [Ya.a, Ga.a]), Vt._12(4608, Ao.a, Ao.a, [Ya.a, Ga.a, $a.a]), Vt._12(4608, Ro.a, Ro.a, [Ga.a, Ha.a, Za.a, Ya.a, Ua.l]), Vt._12(4608, Jo.a, Jo.a, [Ya.a, Ga.a]), Vt._12(4608, qa.a, qa.a, [Ha.a, Ga.a]), Vt._12(5120, Eo.a, Eo.c, [Eo.b]), Vt._12(4608, zt.a, zt.a, []), Vt._12(4608, Ft.a, Ft.a, []), Vt._12(4608, Ca.a, Ca.a, []), Vt._12(4608, Qt.a, Qt.a, []), Vt._12(4608, $t.a, $t.a, []), Vt._12(4608, Zt, Zt, [Eo.a]), Vt._12(4608, ne.a, ne.a, [Kt.e]), Vt._12(4608, ue.a, ue.a, [Jo.a, Qt.a, Bt.k, Ya.a, Wo.a, ne.a]), Vt._12(4608, wa.a, wa.a, []), Vt._12(4608, te.a, te.a, [jo.a, Bt.k]), Vt._12(4608, se, se, [ue.a, yu.a, te.a]), Vt._12(4608, le, le, []), Vt._12(4608, ee, ee, []), Vt._12(4608, ae.a, ae.a, []), Vt._12(512, fu.b, fu.b, []), Vt._12(512, Vt.l, Vo.a, []), Vt._12(256, Ga.b, {
          backButtonText: "",
          backButtonIcon: "arrow-dropleft-circle",
          iconMode: "ios",
          mode: "ios",
          tabsHideOnSubPages: "true"
        }, []), Vt._12(1024, Fo.a, Fo.b, []), Vt._12(1024, Ha.a, Ha.b, [Et.b, Fo.a, Vt.x]), Vt._12(1024, Ga.a, Ga.c, [Ga.b, Ha.a]), Vt._12(512, Za.a, Za.a, [Ha.a]), Vt._12(512, zo.a, zo.a, []), Vt._12(512, Ya.a, Ya.a, [Ga.a, Ha.a, [2, zo.a]]), Vt._12(512, Ua.l, Ua.l, [Ya.a]), Vt._12(256, No.a, {
          links: [{
            loadChildren: "../pages/about/about.module.ngfactory#AboutPageModuleNgFactory",
            name: "AboutPage",
            segment: "about",
            priority: "low",
            defaultHistory: []
          }, {
            loadChildren: "../pages/supernodeelection/superpoint/iconpromptbox/iconpromptbox.module.ngfactory#IconpromptboxPageModuleNgFactory",
            name: "IconpromptboxPage",
            segment: "iconpromptbox",
            priority: "low",
            defaultHistory: []
          }, {
            loadChildren: "../pages/supernodeelection/superpoint/inputpassword/inputpassword.module.ngfactory#InputpasswordPageModuleNgFactory",
            name: "InputpasswordPage",
            segment: "inputpassword",
            priority: "low",
            defaultHistory: []
          }, {
            loadChildren: "../pages/supernodeelection/superpoint/inputtickets/inputtickets.module.ngfactory#InputticketsPageModuleNgFactory",
            name: "InputticketsPage",
            segment: "inputtickets",
            priority: "low",
            defaultHistory: []
          }, {
            loadChildren: "../pages/supernodeelection/superpoint/joinvotelist/joinvotelist.module.ngfactory#JoinvotelistPageModuleNgFactory",
            name: "JoinvotelistPage",
            segment: "joinvotelist",
            priority: "low",
            defaultHistory: []
          }, {
            loadChildren: "../pages/supernodeelection/superpoint/lockdetails/lockdetails.module.ngfactory#LockdetailsPageModuleNgFactory",
            name: "LockdetailsPage",
            segment: "lockdetails",
            priority: "low",
            defaultHistory: []
          }, {
            loadChildren: "../pages/supernodeelection/superpoint/myvote/myvote.module.ngfactory#MyvotePageModuleNgFactory",
            name: "MyvotePage",
            segment: "myvote",
            priority: "low",
            defaultHistory: []
          }, {
            loadChildren: "../pages/supernodeelection/superpoint/nodeinformation/nodeinformation.module.ngfactory#NodeinformationPageModuleNgFactory",
            name: "NodeinformationPage",
            segment: "nodeinformation",
            priority: "low",
            defaultHistory: []
          }, {
            loadChildren: "../pages/supernodeelection/superpoint/pointvote/pointvote.module.ngfactory#PointvotePageModuleNgFactory",
            name: "PointvotePage",
            segment: "pointvote",
            priority: "low",
            defaultHistory: []
          }, {
            loadChildren: "../pages/supernodeelection/superpoint/signup/signup.module.ngfactory#SignupPageModuleNgFactory",
            name: "SignupPage",
            segment: "signup",
            priority: "low",
            defaultHistory: []
          }, {
            loadChildren: "../pages/supernodeelection/superpoint/superpoint.module.ngfactory#SuperpointPageModuleNgFactory",
            name: "SuperpointPage",
            segment: "superpoint",
            priority: "low",
            defaultHistory: []
          }, {
            loadChildren: "../pages/supernodeelection/superpoint/votemanage/votemanage.module.ngfactory#VotemanagePageModuleNgFactory",
            name: "VotemanagePage",
            segment: "votemanage",
            priority: "low",
            defaultHistory: []
          }, {
            loadChildren: "../pages/supernodeelection/superpoint/votingrules/votingrules.module.ngfactory#VotingrulesPageModuleNgFactory",
            name: "VotingrulesPage",
            segment: "votingrules",
            priority: "low",
            defaultHistory: []
          }]
        }, []), Vt._12(512, Vt.h, Vt.h, []), Vt._12(512, Ko.a, Ko.a, [Vt.h]), Vt._12(1024, To.b, To.c, [Ko.a, Vt.q]), Vt._12(1024, Vt.c, function(l, n, t, e, a, u, i, s, o, r, c, _, d) {
          return [Et.s(l), Bo.a(n), yu.b(t, e), Ro.b(a, u, i, s, o), To.d(r, c, _, d)]
        }, [
          [2, Vt.w], Ga.a, Ha.a, Za.a, Ga.a, Ha.a, Za.a, Ya.a, Ua.l, Ga.a, No.a, To.b, Vt.x
        ]), Vt._12(512, Vt.d, Vt.d, [
          [2, Vt.c]
        ]), Vt._12(131584, Vt.f, Vt.f, [Vt.x, Vt.X, Vt.q, Vt.l, Vt.i, Vt.d]), Vt._12(512, Vt.e, Vt.e, [Vt.f]), Vt._12(512, Et.a, Et.a, [
          [3, Et.a]
        ]), Vt._12(512, Kt.f, Kt.f, []), Vt._12(512, Ut.m, Ut.m, []), Vt._12(512, Ut.d, Ut.d, []), Vt._12(512, Bt.h, Bt.h, []), Vt._12(512, Yo.a, Yo.a, []), Vt._12(512, Xt.a, Xt.a, []), Vt._12(512, Ut.l, Ut.l, []), Vt._12(512, Oo.a, Oo.a, []), Vt._12(512, qt.a, qt.a, []), Vt._12(512, Pa.a, Pa.a, []), Vt._12(512, Ma, Ma, []), Vt._12(256, Bt.m, void 0, []), Vt._12(256, Bt.l, void 0, []), Vt._12(256, ja.a, ka, []), Vt._12(256, fu.a, "/", []), Vt._12(256, Eo.b, {
          name: "__walletdb",
          driverOrder: ["localstorage", "indexeddb", "sqlite", "websql"]
        }, [])])
      });
    Object(Vt.Q)(), Object(Et.j)().bootstrapModuleFactory(Go)
  },
  54: function(l, n, t) {
    "use strict";
    t.d(n, "a", function() {
      return e
    });
    t(1), t(14);
    var e = function() {
      function l(l, n) {
        this.alertCtrl = l, this.translate = n
      }
      return l.prototype.ionicAlert = function(l, n, t) {
        var e = this;
        return new Promise(function(a, u) {
          e.alertCtrl.create({
            title: e.translate.instant(l),
            subTitle: e.translate.instant(n),
            enableBackdropDismiss: !1,
            buttons: [{
              text: t || e.translate.instant("confirm"),
              handler: function() {
                console.log("Ok clicked"), a()
              }
            }]
          }).present()
        })
      }, l.prototype.ionicAlert_data = function(l, n, t, e) {
        var a = this,
          u = this.translate.instant("suggest-amount");
        return new Promise(function(i, s) {
          a.alertCtrl.create({
            title: a.translate.instant(l),
            subTitle: a.translate.instant(n) + "(" + u + t + ")",
            enableBackdropDismiss: !1,
            buttons: [{
              text: e || a.translate.instant("confirm"),
              handler: function() {
                console.log("Ok clicked"), i()
              }
            }]
          }).present()
        })
      }, l.prototype.ionicConfirm = function(l, n, t, e) {
        var a = this;
        return new Promise(function(u, i) {
          a.alertCtrl.create({
            title: a.translate.instant(l),
            message: a.translate.instant(n),
            buttons: [{
              text: e || a.translate.instant("cancel"),
              handler: function() {
                console.log("Disagree clicked"), u(!1)
              }
            }, {
              text: t || a.translate.instant("confirm"),
              handler: function() {
                console.log("Agree clicked"), u(!0)
              }
            }]
          }).present()
        })
      }, l.prototype.ionicPrompt = function(l, n, t, e, a) {
        var u = this;
        return new Promise(function(i, s) {
          u.alertCtrl.create({
            title: l,
            message: n,
            cssClass: t.useDanger ? "alertDanger" : null,
            enableBackdropDismiss: !!t.enableBackdropDismiss,
            inputs: [{
              value: t && t.defaultText ? t.defaultText : null,
              placeholder: t && t.placeholder ? t.placeholder : null,
              type: t && t.type ? t.type : "text"
            }],
            buttons: [{
              text: a || u.translate.instant("Cancel"),
              handler: function(l) {
                console.log("Cancel clicked"), i(null)
              }
            }, {
              text: e || u.translate.instant("Ok"),
              handler: function(l) {
                console.log("Saved clicked"), i(l[0])
              }
            }]
          }).present()
        })
      }, l.prototype.presentPrompt = function() {
        var l = this;
        return new Promise(function(n, t) {
          l.alertCtrl.create({
            title: l.translate.instant("text-id-kyc-prompt-title"),
            inputs: [{
              name: "password",
              placeholder: l.translate.instant("text-id-kyc-prompt-password"),
              type: "password"
            }],
            buttons: [{
              text: l.translate.instant("cancel"),
              role: "cancel",
              handler: function(l) {
                console.log("Cancel clicked"), t(null)
              }
            }, {
              text: l.translate.instant("Ok"),
              handler: function(l) {
                n(l.password)
              }
            }]
          }).present()
        })
      }, l.prototype.presentConfirm = function(l) {
        var n = this;
        return new Promise(function(t, e) {
          n.alertCtrl.create({
            title: n.translate.instant("text-id-kyc-prompt-title"),
            message: n.translate.instant("text-id-kyc-cochain") + l + "ELA",
            buttons: [{
              text: n.translate.instant("cancel"),
              role: "cancel",
              handler: function() {
                e()
              }
            }, {
              text: n.translate.instant("Ok"),
              handler: function() {
                t()
              }
            }]
          }).present()
        })
      }, l.prototype.webKeyPrompt = function() {
        var l = this;
        return new Promise(function(n, t) {
          l.alertCtrl.create({
            title: l.translate.instant("text-id-kyc-prompt-title"),
            inputs: [{
              name: "password",
              placeholder: l.translate.instant("importmnes-optionalpassword-placeholder"),
              type: "password"
            }],
            buttons: [{
              text: l.translate.instant("cancel"),
              role: "cancel",
              handler: function(l) {
                console.log("Cancel clicked"), t(null)
              }
            }, {
              text: l.translate.instant("Ok"),
              handler: function(l) {
                n(l.password)
              }
            }]
          }).present()
        })
      }, l
    }()
  },
  742: function(l, n) {},
  744: function(l, n) {},
  776: function(l, n) {},
  777: function(l, n) {}
}, [446]);
