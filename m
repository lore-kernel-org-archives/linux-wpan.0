Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-co1nam03on0079.outbound.protection.outlook.com ([104.47.40.79]:23391
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750913AbeGJG5r (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 10 Jul 2018 02:57:47 -0400
From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: Re: [PATCH] net: ieee802154: adf7242: Fix erroneous RX enable
Date: Tue, 10 Jul 2018 06:57:43 +0000
Message-ID: <2a984eac96b8a4b203d92ea0f7fe6bcbd8b0ddd1.camel@analog.com>
References: <20180625134951.14227-1-alexandru.ardelean@analog.com>
         <3028fa25-12c2-2182-b98e-22e165f2ec22@datenfreihafen.org>
In-Reply-To: <3028fa25-12c2-2182-b98e-22e165f2ec22@datenfreihafen.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <297A1001A5506347B6BEA9B22F72A5CF@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "stefan@datenfreihafen.org" <stefan@datenfreihafen.org>, "stefan@osg.samsung.com" <stefan@osg.samsung.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "Hennerich, Michael" <Michael.Hennerich@analog.com>

T24gTW9uLCAyMDE4LTA3LTA5IGF0IDExOjAxICswMjAwLCBTdGVmYW4gU2NobWlkdCB3cm90ZToN
Cj4gSGVsbG8gQWxleGFuZHJ1Lg0KPiANCj4gT24gMjUuMDYuMjAxOCAxNTo0OSwgQWxleGFuZHJ1
IEFyZGVsZWFuIHdyb3RlOg0KPiA+IEZyb206IE1pY2hhZWwgSGVubmVyaWNoIDxtaWNoYWVsLmhl
bm5lcmljaEBhbmFsb2cuY29tPg0KPiA+IA0KPiA+IE9ubHkgZW5hYmxlIFJYIG1vZGUgaWYgdGhl
IG5ldGRldiBpcyBvcGVuZWQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBIZW5u
ZXJpY2ggPG1pY2hhZWwuaGVubmVyaWNoQGFuYWxvZy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
QWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9uZXQvaWVlZTgwMjE1NC9hZGY3MjQyLmMgfCA1ICsrKystDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvaWVlZTgwMjE1NC9hZGY3MjQyLmMNCj4gPiBiL2Ry
aXZlcnMvbmV0L2llZWU4MDIxNTQvYWRmNzI0Mi5jDQo+ID4gaW5kZXggM2U4NWU5NTAwMjMzLi4w
YTI0MGEzZjc4MTcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvaWVlZTgwMjE1NC9hZGY3
MjQyLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9pZWVlODAyMTU0L2FkZjcyNDIuYw0KPiA+IEBA
IC03MzksNyArNzM5LDEwIEBAIHN0YXRpYyBpbnQgYWRmNzI0Ml9jaGFubmVsKHN0cnVjdCBpZWVl
ODAyMTU0X2h3DQo+ID4gKmh3LCB1OCBwYWdlLCB1OCBjaGFubmVsKQ0KPiA+ICAJYWRmNzI0Ml93
cml0ZV9yZWcobHAsIFJFR19DSF9GUkVRMSwgZnJlcSA+PiA4KTsNCj4gPiAgCWFkZjcyNDJfd3Jp
dGVfcmVnKGxwLCBSRUdfQ0hfRlJFUTIsIGZyZXEgPj4gMTYpOw0KPiA+ICANCj4gPiAtCXJldHVy
biBhZGY3MjQyX2NtZChscCwgQ01EX1JDX1JYKTsNCj4gPiArCWlmICh0ZXN0X2JpdChGTEFHX1NU
QVJULCAmbHAtPmZsYWdzKSkNCj4gPiArCQlyZXR1cm4gYWRmNzI0Ml9jbWRfcngobHApOw0KPiA+
ICsJZWxzZQ0KPiA+ICsJCXJldHVybiBhZGY3MjQyX2NtZChscCwgQ01EX1JDX1BIWV9SRFkpOw0K
PiA+ICB9DQo+ID4gIA0KPiA+ICBzdGF0aWMgaW50IGFkZjcyNDJfc2V0X2h3X2FkZHJfZmlsdChz
dHJ1Y3QgaWVlZTgwMjE1NF9odyAqaHcsDQo+ID4gDQo+IA0KPiBUaGlzIHBhdGNoIGhhcyBiZWVu
IGFwcGxpZWQgdG8gdGhlIHdwYW4gdHJlZSBhbmQgd2lsbCBiZQ0KPiBwYXJ0IG9mIHRoZSBuZXh0
IHB1bGwgcmVxdWVzdCB0byBuZXQuIFRoYW5rcyENCg0KVGhhbmtzDQoNClNvcnJ5IGZvciB0aGUg
c2xvd25lc3MgaW4gcmVwbHlpbmcuDQpJIG1lYW50IHRvIHJlcGx5IHNvb25lciB0byB5b3VyIHF1
ZXN0aW9uLCBidXQgSSBuZWVkZWQgdG8gdGFrZSBhIGxvb2sNCmZpcnN0Lg0KDQpUaGFua3MgYWdh
aW4NCkFsZXgNCg0KPiANCj4gcmVnYXJkcw0KPiBTdGVmYW4gU2NobWlkdA0KPiA=
