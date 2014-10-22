Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17923 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754677AbaJVJnt (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 22 Oct 2014 05:43:49 -0400
From: "Zhang, Baoli" <baoli.zhang@intel.com>
Subject: RE: [Linux-zigbee-devel] Questions about the Zigbee in Linux
Date: Wed, 22 Oct 2014 09:42:14 +0000
Message-ID: <EBA0C22CC7D5724C87D7C17A60FEE9EE46E6AA@SHSMSX101.ccr.corp.intel.com>
References: <EBA0C22CC7D5724C87D7C17A60FEE9EE46D85E@SHSMSX101.ccr.corp.intel.com>
 <20141022082919.GA1603@x61s.guest.pengutronix.de>
 <EBA0C22CC7D5724C87D7C17A60FEE9EE46E22D@SHSMSX101.ccr.corp.intel.com>
 <20141022090135.GA2721@x61s.guest.pengutronix.de>
 <54476EAF.7090208@xsilon.com>
 <20141022092905.GC2721@x61s.guest.pengutronix.de>
 <EBA0C22CC7D5724C87D7C17A60FEE9EE46E5BC@SHSMSX101.ccr.corp.intel.com>
 <20141022095316.GD2721@x61s.guest.pengutronix.de>
 <EBA0C22CC7D5724C87D7C17A60FEE9EE46E654@SHSMSX101.ccr.corp.intel.com>
 <20141022100308.GE2721@x61s.guest.pengutronix.de>
In-Reply-To: <20141022100308.GE2721@x61s.guest.pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, "linux-zigbee-devel@lists.sourceforge.net" <linux-zigbee-devel@lists.sourceforge.net>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

TG9uZyB3YXkgdG8gZ28uLi4uDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBs
aW51eC13cGFuLW93bmVyQHZnZXIua2VybmVsLm9yZyBbbWFpbHRvOmxpbnV4LXdwYW4tb3duZXJA
dmdlci5rZXJuZWwub3JnXSBPbiBCZWhhbGYgT2YgQWxleGFuZGVyIEFyaW5nDQpTZW50OiBXZWRu
ZXNkYXksIE9jdG9iZXIgMjIsIDIwMTQgNjowMyBQTQ0KVG86IFpoYW5nLCBCYW9saQ0KQ2M6IFNp
bW9uIFZpbmNlbnQ7IGxpbnV4LXppZ2JlZS1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQ7IGxp
bnV4LXdwYW5Admdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW0xpbnV4LXppZ2JlZS1kZXZl
bF0gUXVlc3Rpb25zIGFib3V0IHRoZSBaaWdiZWUgaW4gTGludXgNCg0KT24gV2VkLCBPY3QgMjIs
IDIwMTQgYXQgMDk6MzI6MzlBTSArMDAwMCwgWmhhbmcsIEJhb2xpIHdyb3RlOg0KPiBSUEwgaW4g
dXNlcnNwYWNlLCB0aGF0IG1heWJlIGxlYWQgdG8gcGVyZm9ybWFuY2UgaXNzdWUuICBJIGFtIHRo
aW5raW5nIHdoeSB0aGV5IGRvbid0IGltcGxlbWVudCBpdCBpbiB0aGUga2VybmVsIHNwYWNlLg0K
PiANCg0KVGhleSBoYXZlIGFsc28gYSBtYWlsaW5nbGlzdCwgbWF5YmUgYXNrIHRoZXJlLiBUbyBt
YWtlIGEgaGFuZGxpbmcgb2YgdGhpcyBpbnNpZGUga2VybmVsc3BhY2Ugc2VlbXMgbm90IHNvIGVh
c3kgdGhhbiB0byBoYW5kbGUgdGhpcyBpbnNpZGUgdXNlcnNwYWNlLg0KDQpJIGNhbiBvbmx5IGlt
YWdpbmUgdGhhdCBhbiB1c2Vyc3BhY2UgaW1wbGVtZW50YXRpb24gYXQgZmlyc3Qgd291bGQgYmUg
bXVjaCBlYXNpZXIgdGhhbiB0byB0cnkgdG8gY29ubmVjdCBldmVyeXRoaW5nIHdoYXQgeW91IG5l
ZWQgaW4ga2VybmVsc3BhY2UuDQoNCjgwMi4xNS40IDZMb1dQQU4gbmVlZHMgYWxzbyBzb21lIGdy
ZWF0IGlkZWEncyBob3cgd2UgY2FuIGRlYWwgYXMgYWRhcHRpb24gbGF5ZXIgZm9yIElQdjYuDQoN
Ci0gQWxleA0KLS0NClRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBsaXN0OiBzZW5kIHRoZSBsaW5l
ICJ1bnN1YnNjcmliZSBsaW51eC13cGFuIiBpbiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFq
b3Jkb21vQHZnZXIua2VybmVsLm9yZyBNb3JlIG1ham9yZG9tbyBpbmZvIGF0ICBodHRwOi8vdmdl
ci5rZXJuZWwub3JnL21ham9yZG9tby1pbmZvLmh0bWwNCg==
