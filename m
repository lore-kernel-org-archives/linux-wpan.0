Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3996AC433ED
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 13:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ACE26128C
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 13:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240892AbhDLNUw (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:20:52 -0400
Received: from mail-bn8nam08on2067.outbound.protection.outlook.com ([40.107.100.67]:17280
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239617AbhDLNUw (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 12 Apr 2021 09:20:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwjrQWrwMkNLExr119gYaaKNyXJZkb+2gw7y2gHfwN4YseRjNk3WBfF423eockETcnMUtDoY/6dZt4MSfSNgFgipWILwxIjpViO8JMtabAf1c43yxi9n30k0g78tMCyL35d2Mj/zgBszmUoWlp5N01uI0B8mvHXs8EHiGW027vi0k1Fc5i9GoJU2XZSvXs1vDG1bmHHQsA3URhJRht8PdHceC+3IfFdLA3nrkJ6AD29vEnWXucSb+DGF8d9E9qhLhKCInfcp38KUn97FDxbXqBdfFHcqzY5VAY+AHJzJFJloBEi/LnibkgE4yPJnx/ahKrW8KV/MR8uVq4S8VNiivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ec6StZ2fNkilFZlrH9ehfZbSzgccbYwiRIN2Mrv2a2w=;
 b=OtBVAooPClZQ6SqNxWcXHUfpioDdGqu+E8Wg9rMBYemdde6ulQ/g8O1nN5YwA4i7h3wSR3cH2SPjiAGZnhdXA3P0i/gkQFWs4rtDcpPsoqD9RxeNvaOzNZtLO7lf9oHQ11aT5pipGKlxNtxbL2sahJOzn5QqMUZWtCcs86NcGVpkNqaXnhyrdQplErKkfuFC5VerVMyWLMyo50qbRQIEaIPiyvr2SHaQrHmUecG2u54yfy5MhBz3KyPZrhdingKRounTl72eKlg0P5rw/MjwkI48ZZjgqrzHL+W8DQKhUCHtLyE/Fsh0C/CYW65nS2mnI0XRjsW+9DFse65ZoZ9AVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=myfuelmaster.com; dmarc=pass action=none
 header.from=myfuelmaster.com; dkim=pass header.d=myfuelmaster.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SynTechSystemsInc.onmicrosoft.com;
 s=selector2-SynTechSystemsInc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ec6StZ2fNkilFZlrH9ehfZbSzgccbYwiRIN2Mrv2a2w=;
 b=hzkml/oMXG6fTJcSuNypFSJm8fO/OKQ4quuYUdH/RnId7MAGTJsO/aZGcjHEFrPJPxFSy6wSCPcO0+5eIwHqHRMuauKOjtbcyrQqV3aj5WNdCrO/25UjHTaIrsuClvS7JBbB61x6sJ7suWCQIfNau1FDl5vmDAfWQNKPvmMyvno=
Received: from SN6PR01MB3648.prod.exchangelabs.com (2603:10b6:805:17::29) by
 SN6PR01MB5262.prod.exchangelabs.com (2603:10b6:805:da::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.22; Mon, 12 Apr 2021 13:20:30 +0000
Received: from SN6PR01MB3648.prod.exchangelabs.com
 ([fe80::35c4:628c:3aa6:356b]) by SN6PR01MB3648.prod.exchangelabs.com
 ([fe80::35c4:628c:3aa6:356b%4]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 13:20:30 +0000
From:   Mark Butsch <Mark.Butsch@myfuelmaster.com>
To:     Alexander Aring <alex.aring@gmail.com>
CC:     "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
Subject: RE: things not working - newbie questions
Thread-Topic: things not working - newbie questions
Thread-Index: AQHXLJbSrwMevhaahUSOzvbwPssI7KqsLYNQgAASYACAACU4kIAEcIWAgAAN22A=
Date:   Mon, 12 Apr 2021 13:20:30 +0000
Message-ID: <SN6PR01MB3648B9E70DF2898FD3BC83F587709@SN6PR01MB3648.prod.exchangelabs.com>
References: <SN6PR01MB3648B4FC16E10CA1B04F756587749@SN6PR01MB3648.prod.exchangelabs.com>
 <CAB_54W7K7ir+CLxMkXGMYbxuvDEEJD5vNW2arbLLiaSKrGtbLg@mail.gmail.com>
 <SN6PR01MB3648AD0120B58D72E5B0C00F87739@SN6PR01MB3648.prod.exchangelabs.com>
 <CAB_54W4j7G53YT8G32GdM4pNET8i0v9_zkNMe=0dwdfbHvEXFg@mail.gmail.com>
 <SN6PR01MB3648864C8E0A272EAC656AEA87739@SN6PR01MB3648.prod.exchangelabs.com>
 <CAB_54W4P4Y8q-A4x9H+zA7bf8KR=Qb7CFoxn24JuasiGSnHzTQ@mail.gmail.com>
In-Reply-To: <CAB_54W4P4Y8q-A4x9H+zA7bf8KR=Qb7CFoxn24JuasiGSnHzTQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=myfuelmaster.com;
x-originating-ip: [63.148.217.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 088dd02f-f80b-4bc4-689f-08d8fdb5bf00
x-ms-traffictypediagnostic: SN6PR01MB5262:
x-microsoft-antispam-prvs: <SN6PR01MB5262ADA785E984CD59E79E7C87709@SN6PR01MB5262.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X9UvkxB9Zqy6Ei6TnL3gJnL3bn1nrHU7KEU1FAxxQjRmnpN7QCGj2u76n5evS654psEEsAYOkxKI2Kx8F9/gO7qq0HaeSSZc8suHW4TZ2F9AXQd+KMZn3LmXKoRXKeIa8QuQiH2rvmm9HX0DjR5YsEHN2K8FMltw89fLyM2x6Y1UHbBHAcUspTuDKhGG3nVzGqfrFVP8wKM4CZsiqRMgzFxNv6fghsfi93YUJUZlteV4wHvcmuipR02sqHFyiyXXGFpg4ptpulQNj4gpSITRnlsYdDrcpJNaxA52OG75OGKH2FcN66aTkvZn8wlOGuwWnXHU/X8jl2+OSj6Y8wG9RHa0REvuWU0sojqa7O5rFYnmsn1uPhmhH/d3Auqy6e8A5y8/dTe6+x1oQSbcjJb49qEL6nGdSNaKhWW/n5U5OBo/LrdOT0l7pbj/DgewhlalYU/FF0Yy5qNnDTCOOJmulf1mSOwL5dKDkX3nF0qPiMKGBtGVAT/gskiDTo/bbtDkbK3J5z1YvGJKQNS7vI+Sp+QjYxqqBIihhgdjDJJA9hLI7FPGccMVPn9sJUtRXlBKWzZzQA1JnBf2P8Iz2aKHCOSbbCob3N0CHkd5G3ijfPk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB3648.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(396003)(136003)(346002)(366004)(376002)(52536014)(4744005)(66446008)(5660300002)(4326008)(8936002)(55016002)(9686003)(316002)(6506007)(38100700002)(6916009)(66946007)(66476007)(76116006)(7696005)(186003)(26005)(64756008)(71200400001)(86362001)(83380400001)(2906002)(33656002)(66556008)(8676002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VExRZzlTemZOaWNCdHFhQ1ovdlcwUEVhd2FvWE5yaGZOQUxLcEdheGxvMFEx?=
 =?utf-8?B?anlKWXFCT1MrTkY2UzlVdWwwbTJ2cEdidDZBTWtsTTBYcnJYZ2plN29BVGZM?=
 =?utf-8?B?d1hKbTIzcjBHTmFkNjVkM3BqRlJEb3ozeVZWYWV0cEgzVUVGZmNLbHJOVkdw?=
 =?utf-8?B?c2NMd0RldWhFSVZ4SGF2TTcxNFd5aytyR1k5K2xaYm5UbjlRUHpwZENMR1E4?=
 =?utf-8?B?dTdBTDB2YXM4VTBYVG5laVFNNE5hYysvWTZWQ3hLMWJmWnJlWjNxWkVhNzRl?=
 =?utf-8?B?VjNtTi9XUXFyKzJrSFA4dHhWL2RtS0I0R284dUpZVWEyMU9RKzJzblRmWm8x?=
 =?utf-8?B?V3BUWDNTbUR0UVVKdG9PTDVza1FBblpwclFPUGZCaVc1NVBsT01hSXlGQW9j?=
 =?utf-8?B?YU5heEZ0V2twZDlLZ3hpTXRKVjJlazBrQ2pjYW1HY09RZVJZZXpyTDBVUlAy?=
 =?utf-8?B?RWRrZXp6KzlsTVNVMC80UUtOaEd3Q2RhdkZ2Q29abWN4MXE5R3BTQnVqdTNK?=
 =?utf-8?B?SmVBVUJEcXdhTFYrSUh4bGJWZlBzNDQ3ZmMzYzcxdmNwSTNhN1FUTjY0SldG?=
 =?utf-8?B?emlKL0dhNjdaNG5qWlBXVjJxV1o4Z2FPUDUxZHlsS3NZUzNta3lBaTk2b3li?=
 =?utf-8?B?NExFZTQ0YmlXT05QSVVLbVVuMmxERHdMemVuV3RWb09sTHE0TXF4K2Y3a1Bu?=
 =?utf-8?B?NTQ1SHFqU2F4VkplN0tWenM1Ly9PWSs1KzU0ZHJwNE5vK25remhtdWlmWWhU?=
 =?utf-8?B?cjFpUnE5Z281Uyt6N1Z6SDFVTjNyVkJZLzJOL1M4bG80dzZjWk9XbHlXNUM5?=
 =?utf-8?B?VVlpL2lOQzVpeG53bldGU25TYkdaZ2JOMTlQa0VUYUJLalRYRFRUOWVJMEpy?=
 =?utf-8?B?aldicVkyaGVpQzk0UkpVekw4UkRsK1RwSFB5WnlzMjZiZGpEVkd4dDJtVFFR?=
 =?utf-8?B?cm51ZWd3WDZoeTNoL1FOZlZ5UTZMa2xPdzFaaW5KbWM5SUNQMm1oUXFmcjE1?=
 =?utf-8?B?ek40ckZkd2NKRTlyOEFwcXpmVGlEcWg4U21ESVJzTEVtMmk0Sm9sNWxXL0VL?=
 =?utf-8?B?NTluK1ZJazFBbGhZdm1GUE05SU1yRjdkcDlYUkI4ektWaUJWY1FIU3JFTlJV?=
 =?utf-8?B?U1pLREI0UUdiUDJNZVJCYVNkNEJDeVRuTGc0bksvUFY2R0NEOTVNemlhRGtZ?=
 =?utf-8?B?VitZcVhSYjVGaUpuT2FvQ0hXWnFoa1BYNlJaWnRQa3paTlM3S2pmNmhWNGxz?=
 =?utf-8?B?L0RKcVFGSHJKVStkYitTRzl4R3RkVStRUWp0TExaSWxCYy9mdDJlb2pZWXNG?=
 =?utf-8?B?eXVpbS9qRm1MU09BZVpueDRZV3ZqUFU1a093OGE2NzVtajh4QVpSd0RlaFNO?=
 =?utf-8?B?UWd3ZnVRUENCT1ZrU1ZyK2FFRUFXWENsQjNtTXl5UlF3K29tdmY0VktiZzVK?=
 =?utf-8?B?d1hGaXhHNFFpQjRFWDVHUCtXZDZwdDdoQ1JDd1hrTDZLMWVDSFFCeFJTZmNI?=
 =?utf-8?B?MTM2aGMrc3F3aWNIdTl0Nllocjg3U1lTWDNueE5IWEVZYmVSVUVNbkJ6azlO?=
 =?utf-8?B?dCtmME5BMDdvcTdQcUNpbEttOUIvbDNEd1h6SjI5TW8xU3k5RGNCYjJEZlZN?=
 =?utf-8?B?azMrYXhPeXVRTzRuWFhrYXdpOERldzIxWXV1dEl5WTR0Qm5aNy85eXFpMlNu?=
 =?utf-8?B?c0ZYVGdSNjFmc3F5UG5GOGJkbEYyd2VLa1hOSTRwNXhJM1Z6eWd6aDZoYUc4?=
 =?utf-8?Q?5ZCkgM6jHNUAJOmOe66t0dFm/6eEOgPpAVzwHHw?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: myfuelmaster.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB3648.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088dd02f-f80b-4bc4-689f-08d8fdb5bf00
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 13:20:30.7208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dd4cdb5b-3a50-4947-bce6-dd41ce3544d6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r2/amwAdLM7oRZyG9Npf31UAREoZYTg/Ui00tYWcxw1f8jZJAM+l0SzoeSNz70KKCHxpySWNHJsH41lVqyOgXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB5262
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

SGVsbG8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZGVy
IEFyaW5nIDxhbGV4LmFyaW5nQGdtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBBcHJpbCAxMiwg
MjAyMSA4OjI5IEFNDQoNCg0KPiBJIHRyaWVkIHRvIHJlcHJvZHVjZSBpdCwgSSBkb24ndCBzZWUg
YW55IG1pc3Rha2UgYW5kIGl0IGRvZXMgbm90IHdvcmsgZm9yIG1lIGFzDQo+IHdlbGwuIEhvd2V2
ZXIgSSBhbSBub3QgYW4gZXhwZXJ0IGluIGFmODAyMTU0IHNvY2tldCAoSSBuZXZlciB0b3VjaGVk
IGl0IHNvDQo+IGZhcikgaXQncyBhIHZlcnkgaGlzdG9yaWNhbCBncm93aW5nIHRoaW5nLiBNYXli
ZSBTdGVmYW4gY2FuIGhlbHAgaGVyZS4NCj4gSG93ZXZlciwgSSB0ZXN0ZWQgYW4gSVB2NiBwaW5n
IG9uIG15IHNpZGUgYW5kIGl0IHdvcmtlZC4gSnVzdCBkbyBwaW5nNg0KPiAiZmU4MC4uLi4lbG93
cGFuMCIsIHdoZXJlYXMgdGhlIGFkZHJlc3MgaXMgbG93cGFuMSBvZiBjb3Vyc2UuIE1heSBJIGhh
dmUgYXQNCj4gdGhlIHdlZWtlbmQgdGltZSB0byBsb29rIGF0IGl0IGFuZCBtYXliZSB3ZSBjYW4g
ZmluYWxseSBzdGFydCBzb21lIG5leHQNCj4gZ2VuZXJhdGlvbiBzb2NrZXQgaW50ZXJmYWNlIG9y
IGJldHRlciBtYWtlIHRoaXMgb25lIGxlc3MgY29tcGxpY2F0ZWQvZml4aW5nDQo+IGJ1Z3MgKGFs
c28gc29tZSBuZXRucyBhd2FyZW5lc3Mgc2VlbXMgdG8gYmUgbWlzc2luZywgYXMgSSBmaWd1cmVk
IG91dD8pLg0KPiANCj4gSSBhbHNvIHdhcyBsb29raW5nIGF0IHdpcmVzaGFyaywgaXQgd2FzIHNo
b3dpbmcgc29tZSBkYXRhIGFycml2aW5nLg0KDQpJIHdpbGwgdHJ5IHRoZSBJUHY2IHBpbmcgYXMg
d2VsbC4NCg0KQW55IGFzc2lzdGFuY2UgaXMgZ3JlYXRseSBhcHByZWNpYXRlZC4gVGhpcyBpcyBh
IHByb29mIG9mIGNvbmNlcHQgZXhlcmNpc2UgYXQgdGhpcyBwb2ludCB3aXRoIG5vIGhhcmQgZGVh
ZGxpbmUuDQoNCk1hcmsNCg==
