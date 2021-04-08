Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E21CC433ED
	for <linux-wpan@archiver.kernel.org>; Thu,  8 Apr 2021 13:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E47D96102A
	for <linux-wpan@archiver.kernel.org>; Thu,  8 Apr 2021 13:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhDHN75 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:59:57 -0400
Received: from mail-bn8nam12on2053.outbound.protection.outlook.com ([40.107.237.53]:57633
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229964AbhDHN75 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 8 Apr 2021 09:59:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oR8H/SSFn6+5tHXAbWOmGuX5NYPtX7qFBqOu7imoEimWrb13TeLHTeHfC5kCY8j6Q/eF40P6nlyiXL1y7OLVmL0T1jcvj9yOTHVJPnTUBkwIbkYStz4hXdzANjixFSWc2tOu4ci0FEs7iE18T5d1pH07ojM6UvUBry19wLNsS+rMkd2P6fzb/NVfRiX5k/BLoxfYeM7tNTqCVQOPOEy5TmLE4cVPYaJV54f8rPfjioDp9GekBORTkh4/fau365rHNREQd8uLmfvvVYheTO3NmDvcqjT+pclg8eYWu1a8n+eNXrXBW3sxWTPPGku5L19SP8OTcqR2Y12CG/XkNOBhqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1Tn7DMlJuN+LbLjqNUY7PM9tFsZpwGxjtYnmUCigC0=;
 b=GcyJYrZXnfksurWSy5fILxd0EBD0eFkCJ7CgHOPoGSow80lDjWr72MpFMtz2PGnWS0V9ZAEhLzkiKsy67JXLHG/YYKEywPcEo/zoqXPRG+W+/XDnExzDX/i4X5IHH9Jwqd+CTJ4Q1pFPIY/oTub8dwWGNTozI0295pE/xO7SprZhk9WrYs0WVIjrQZUPOn4bteV//C82Rdk4KtLNtEdIoWV7Dwcn/cPrTb/2eZtMoxHCyyvniojcgAwWPwjfg7rduIpg4kP95XKTRSvqQ6cxcG2H5Ql+dYFlST3Obi6NL9G2OT1ffgciV3xMxCMtK/i/TXcZZgRHw1wWCpOMlD4q8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=myfuelmaster.com; dmarc=pass action=none
 header.from=myfuelmaster.com; dkim=pass header.d=myfuelmaster.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SynTechSystemsInc.onmicrosoft.com;
 s=selector2-SynTechSystemsInc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1Tn7DMlJuN+LbLjqNUY7PM9tFsZpwGxjtYnmUCigC0=;
 b=stPO/A8zsjfJIlXN+9WYwPh1W4nMESWfMxinw4dqR4SK4ndA838CH28LsPPlHCCWlf0eJjRW2K2MWAHvC0onxvqBQ5FIC8FTxX+YsesvBVtlxMDcnnj2s2jLSeWhJCmYFZhrM3ZgSV2EW5dc2XII/oxVfOuUG7HJSkpEeWS9z4U=
Received: from SN6PR01MB3648.prod.exchangelabs.com (2603:10b6:805:17::29) by
 SN6PR0102MB3328.prod.exchangelabs.com (2603:10b6:805:f::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17; Thu, 8 Apr 2021 13:59:44 +0000
Received: from SN6PR01MB3648.prod.exchangelabs.com
 ([fe80::35c4:628c:3aa6:356b]) by SN6PR01MB3648.prod.exchangelabs.com
 ([fe80::35c4:628c:3aa6:356b%4]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 13:59:44 +0000
From:   Mark Butsch <Mark.Butsch@myfuelmaster.com>
To:     "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
Subject: Re: things not working - newbie questions
Thread-Topic: Re: things not working - newbie questions
Thread-Index: Adcse/2H4DRWt01aRyOTDLkybUgyOQ==
Date:   Thu, 8 Apr 2021 13:59:44 +0000
Message-ID: <SN6PR01MB3648B4FC16E10CA1B04F756587749@SN6PR01MB3648.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=myfuelmaster.com;
x-originating-ip: [63.148.217.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 796b2e13-1b5e-463f-5649-08d8fa96904b
x-ms-traffictypediagnostic: SN6PR0102MB3328:
x-microsoft-antispam-prvs: <SN6PR0102MB3328BE421EFD72E34A1A041387749@SN6PR0102MB3328.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/q+J7mhCx/7/2rAWzzWHZX8OpJvpfX1Sxv8Ompb4CwJPw1XvugYmzuSzKugnP/2jwk97Os36Uf3YLMmKPc4teNSaKKVl8u8yHlM7WmtpoQrq4UCYG7DZPykiKnMdEY0jKb89xfoi8iiXyD78tGnLwfJ2D3tLm1oVBvXqHv5ht74fQI5eG4ZjQ6rsp3eQqzBzkdSaFt9bg6ScIkQfwxilE06ShttptqRXYZk4LoXFhIKuZQzGYgLukhtOHNe4FIY1y71YrVcmyr9EstlYU4LqHpl8x/jkXOVLJ50bpvEa+R9hbGhXw0Om6UpbI4oCmXtR9cAfzqB0hyHoXzY4AL5v1GHh/OG+N3hhJ8rDNrA7/DRwrdTCZ6hGev5DziiUdfgj/TxXagMhetk+ofg1QpZDnNez6L+dsl0ggN4LI+4fonn2D1ZNM7jOmpPQxmRfAlf4cg0bWTb4xfe4RSbvc4WIEcYVTKJQ1ff6/Z2l9GF/kQH6AmGJ3/DqiKjYYEPOS7abp8M4TOGMgzJfFLQTGUoI4jmyQs6elttge5oE+iw8YCtjyVIvTGRIMqVrFj3TuY/7FH+dkW9k8wgEQ+BjC3Gal4W/mfiVcWw1m75L4O3GawzzNkfmMyJFColxHewpUO5Vhs5i6zdnjtEVNrJ4c/G0O6JhiP86q0s5LRgG5a2VeU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB3648.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39840400004)(376002)(346002)(136003)(396003)(83380400001)(66476007)(66446008)(66946007)(64756008)(66556008)(55016002)(5660300002)(26005)(86362001)(2906002)(76116006)(7696005)(33656002)(9686003)(52536014)(53546011)(8936002)(478600001)(6506007)(8676002)(71200400001)(6916009)(186003)(316002)(38100700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WblChS0O17EYK2+ra2MVrhm7tzIeUdABThXR95td+tRLi+aOYRH64421pQ/0?=
 =?us-ascii?Q?xLImNeb/E4tF4ZexVwwtUIO9fa9Vz1Yth141quqhvoM74+0Dqir6wKSLXpTk?=
 =?us-ascii?Q?lalBQvTyBX8+MA1quxbPrvzw77YJvS4uo4bbOHzAwDp40nDMuztsZcynelGV?=
 =?us-ascii?Q?c2A+V5lnWwc4Ek2dB9TgZE4U3Spgf96r1mwWy6e+ldx0RNfTU+NcmCZVkrYY?=
 =?us-ascii?Q?NqUOWxxyKXlF0U2fp3e4LjdUJukq/kaSreCaiNC50WHjWFUowV/UUvuEmboj?=
 =?us-ascii?Q?Q16FWNrrmRHdBdQPjMX57ByN8ED1dW2aZ1v4O/tEwC7EGPw0SOYaukjGfvXa?=
 =?us-ascii?Q?PVLJ0mTbgz/dIDp9EKlH4NwjHDp6nvgnWW1H7u9ohDhNTzL1fK1hQRQApvwO?=
 =?us-ascii?Q?IFEqZDxNekhXKO61Mdsynb8Tepfi2xvDyU63ZXYmK1hlY1uKD73S4h3uKSZJ?=
 =?us-ascii?Q?wvZHytnrcgPqHZQ1nZ4m/gyeL3jkBgbiSgyhtvizdTjBG6BesDWT3w6ovrfw?=
 =?us-ascii?Q?2iUOXKN+2JxuZKX1MbPH1jJ+P5uEu4ITWZEv5Ek00h22sXCyBYAnWsRPvYhj?=
 =?us-ascii?Q?Ygi4YtEDWshB1qxvmJJtl+wLcOg8WTC9+PSnneSqavwRpO6hOMeNYa+LjbBE?=
 =?us-ascii?Q?FcVFWhU30kU1l7jaCD013CFcyRJyAlXMbflk55tTKe+oj+k/kXBI1hrSy5CR?=
 =?us-ascii?Q?nio0vhOhXmFBIT1FRBaKQpHBxPoFCf9zyCCE4QIfeu5tOUM+RIfmhj8xh6LS?=
 =?us-ascii?Q?LK9ZLwYZ/7K4RO3IpbV9s3pseBrmFsJ9dAGly7/5IEvtmXLnWW4MTaMR5lrG?=
 =?us-ascii?Q?AKEAbbQo5+gBS2dK215kNDjSidBekNzwWEwnRa7thzCERKD4RvucJvcQT/2i?=
 =?us-ascii?Q?EVRzeGWYAcPWQSvISYBY5URphV7gOkwbDqSe5bPxflOwzD4jGWoYgyaepzoc?=
 =?us-ascii?Q?PXRAMSfrR+0Z3rCxRLRJyJbEf5GGrhu618EzoqhdqmU2ccQPWzC/n4h9R/br?=
 =?us-ascii?Q?2Y8pCmNhkdUbCa4YdCOo5Q+3ydyB9XY8FPRGghO23q405LlF7HHfmTo2CV3v?=
 =?us-ascii?Q?QbxtJsoYZF5F9YE9EDP/hHO2RVf98vZbqJUqDJbqmfOAM2KYBuKuncxE1sIt?=
 =?us-ascii?Q?roC8qntBa+PNlT+9nubkaLzvBS4ORS9w2dIzlExGHIHHvj1QY/0Yia2f5cDT?=
 =?us-ascii?Q?1YAlJlv9s110h2bStHLy5FcQ1mklHAIKZHatYMbbDoNgyi1nKS1+YJ43vBzC?=
 =?us-ascii?Q?SibYPHnezStVhusSRvkRd97c9Onv1og1aC7Dw5vsLhaIvAMEgwsF3Oz3zIeF?=
 =?us-ascii?Q?mohkbXE2lJvtyv01HI0KYS4g?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: myfuelmaster.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB3648.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796b2e13-1b5e-463f-5649-08d8fa96904b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 13:59:44.4200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dd4cdb5b-3a50-4947-bce6-dd41ce3544d6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xuu3/Jir9tierp9NxpK/qwcxOfntbW4S5XVzd6X69XjH7FLdNNXe8ZFongNmPmefSKzSGYLqSFCU9YyyPBwNrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR0102MB3328
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Stefan, somehow I did not directly receive your reply, but spotted it in th=
e archives. The formatting of this reply may be a little strange as a resul=
t.

On 2021-03-30  7:30 UTC Stefan wrote:

> From: Stefan Schmidt @ 2021-03-30  7:30 UTC (permalink / raw)
>   To: Mark Butsch, linux-wpan
>
> Hello.
>
> On 23.03.21 22:14, Mark Butsch wrote:
> > Hello,
> >=20
> > Sorry if this has all been asked before.
> >=20
> > I am trying to setup a 6lowpan network using a Raspberry Pi 400 and Atm=
el REB233-XPRO modules (AT86RF233). I have 2 of each.
> >=20
> > I have wired the radio modules to the Raspberry Pi GPIO connector.
> >=20
> > If have created a device tree overlay that I think works when applied b=
ecause I see this in the dmesg output:
> >=20
> > [   36.388574] at86rf230 spi0.0: Detected at86rf233 chip version 2
> >=20
> > I have installed 'wpan-tools' and 'lowpan-tools'
>
> You will need wpan-tools only. lowpan tools is deprecated for a long=20
> time now.
>

Thank you, I will note that

> >=20
> > I get what looks like good output when I run:
> >=20
> > $ iwpan dev wpan0 info
> > Interface wpan0
> >          ifindex 4
> >          wpan_dev 0x1
> >          extended_addr 0xc62e26eced5de562
> >          short_addr 0xffff
> >          pan_id 0xffff
> >          type node
> >          max_frame_retries 3
> >          min_be 3
> >          max_be 5
> >          max_csma_backoffs 4
> >          lbt 0
> >          ackreq_default 0
> >=20
> > I tried to setup a 6lowpan network (based on things I googled) but ping=
s didn't work, so I am starting over trying to confirm the lower level part=
s are working first.
> >=20
> > I set the pan_id to 0xabba on both systems.
> >=20
> > I set the short_addr to 0x0001 on one and 0x0002 on the other.
> >=20
> > When I try using wpan-ping (from 0x0001), I get:
> >=20
> > $ wpan-ping -a 0x0002 -c 5
> > PING 0x0002 (PAN ID 0xabba) 5 data bytes
> > Hit 500 ms packet timeout
> > Hit 500 ms packet timeout
> > Hit 500 ms packet timeout
> > Hit 500 ms packet timeout
> > Hit 500 ms packet timeout
>
> Do you actually run wpan-ping in server mode on the other node? Without=20
> it there would be no reply. Its different from the normal ping utility.

Yes, I did run it in server mode using:
$ wpan-ping -d

I have seen examples where an address was specified for the server mode (is=
 that required?). I tried it as well with no success.

I did notice that on the server side that the 'ifconfig' output shows packe=
ts being received. The packet count increments correctly by the number of p=
ings sent from the client

wpan0: flags=3D195<UP,BROADCAST,RUNNING,NOARP>  mtu 123
        unspec 86-53-D3-E1-44-D4-0C-6F-00-00-00-00-00-00-00-00  txqueuelen =
300  (UNSPEC)
        RX packets 15  bytes 1215 (1.1 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

I also monitored wpan0 with wireshark and it captured no packets.

I wonder where they go after being received (according to ifconfig).

>
> > I used "ip link set wpan0 up" (on both systems) and the result is the s=
ame, but I can see packets in wireshark on wpan0.
> >=20
> > A hardware person here suggested using a near field probe to see if we =
could detect any transmission. We didn't. So I don't know if the radios are=
 actually transmitting.
> >=20
> > Any suggestions on where to go next?
>
> For wpan-ping you need to ahve the server on the other node as stated abo=
ve.
>
> For your 6lowpan ping6 problem I have not enough description of the=20
> actual problem to help you.
>

Understood. Probably best to focus on resolving the wpan level first

> regards
> Stefan Schmidt

Thanks,
Mark
