Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA48C433DB
	for <linux-wpan@archiver.kernel.org>; Tue, 23 Mar 2021 21:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD9FA619A5
	for <linux-wpan@archiver.kernel.org>; Tue, 23 Mar 2021 21:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbhCWVPC (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 23 Mar 2021 17:15:02 -0400
Received: from mail-eopbgr680063.outbound.protection.outlook.com ([40.107.68.63]:49732
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233424AbhCWVOs (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 23 Mar 2021 17:14:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PT3j8thJEwsZvHrMccBPBem77XznM3GKbsEyRfUh5yM9pn6++QwVXeY9AXN3KOXUhY8ORmoM7MtmbQUlxfr9801Yi1vKS+k5hEFTdsnRDLn2yR1OnVeDUEgi1raFtU9q2OBnzvQDl1CQmHGRGiCqbOWCGZpXq/MYzvxxjUah7MKA4A3Tw7dXU52T6RRZJx2m2vWL446EX0yLisetFID1yzrZGz8mEhrr6pyi+nEIlMJrNHsTGlI/mPA+nJCVp4EpGpHaMRs3ifr2Z2GYTD1x/vX7yHZBJkaHfn3HdnWS6aNMCJn/4CnSnfAT+3ltJCKUeXBNcrq9ruI9YnscIjZjRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcJhTIUYTHp7fxzZcKhoAPr7F/kibZWiPsE0HstoABQ=;
 b=F5eOw/Wrd64QM8VwKG2sJMoMRqfQZUcT+SCZtjGmGN0IUAheOGrBuaXXgj8s4qmTWI+7lezHjrduHqxDE695ZwnmgHR3mXkVLB+nInEPhI1YyO/JX+E4KcvVFs3w+tu2ojbt+Jb6/wnMW3xVro8YQMb1KYzr3hVCobt8gKCBtic0v6MuHN0ywF6lNEj4O65pm7e2Ne4MbMI9ulID4LEMd7QRAh/4sUtS+9msvm7Fx69DmpcoulS3rGHFGSSuuaejEx7+B1ONKeLEFGk+ilrF3KS8bndEAeaBDhN/FBJ13o09RnE0qgd2zVZq+atKh+vjpacQRR5dIX8CVEEgfOIS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=myfuelmaster.com; dmarc=pass action=none
 header.from=myfuelmaster.com; dkim=pass header.d=myfuelmaster.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SynTechSystemsInc.onmicrosoft.com;
 s=selector2-SynTechSystemsInc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcJhTIUYTHp7fxzZcKhoAPr7F/kibZWiPsE0HstoABQ=;
 b=dUeOtOE2rN9h6SX3Dbs/DiWx2OIDuGMfNj8ZEzJuw/Eo8wcMSxDxOk1x4Q2JHcJwZC0DGQ+7IUyHnn0GY7F+9UgNC3eRLk+aJ7qCh/OcP/u0+b6LeyYagjMQoyyEI8necsR/boGbndNHjRCR6dRbt50l+pr/uGbYIn9cT/eloYc=
Received: from SN6PR01MB3648.prod.exchangelabs.com (2603:10b6:805:17::29) by
 SN6PR01MB4847.prod.exchangelabs.com (2603:10b6:805:ce::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Tue, 23 Mar 2021 21:14:47 +0000
Received: from SN6PR01MB3648.prod.exchangelabs.com
 ([fe80::5850:8c87:f08c:61f4]) by SN6PR01MB3648.prod.exchangelabs.com
 ([fe80::5850:8c87:f08c:61f4%4]) with mapi id 15.20.3890.042; Tue, 23 Mar 2021
 21:14:47 +0000
From:   Mark Butsch <Mark.Butsch@myfuelmaster.com>
To:     "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
Subject: things not working - newbie questions
Thread-Topic: things not working - newbie questions
Thread-Index: AdcgJAbuYgnnKPB3Q3a4VxkAkd4UWw==
Date:   Tue, 23 Mar 2021 21:14:47 +0000
Message-ID: <SN6PR01MB364865A6E7BF0E559808BD9587649@SN6PR01MB3648.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=myfuelmaster.com;
x-originating-ip: [63.148.217.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d05bb0b-b80e-4b4a-8a35-08d8ee40b027
x-ms-traffictypediagnostic: SN6PR01MB4847:
x-microsoft-antispam-prvs: <SN6PR01MB484782D6FB78F525E2A712F587649@SN6PR01MB4847.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zU81GOnI0+FCMK3ocavTAqF7sV+F2fW7gJpdPucWRh0dgwpfdtl1LtxH/kjpLKrZHRtgGk58H7gLcBBLiWoRaxfyiaGufRtEvTlk9xn6sozQC/n+7vsYivNfrGeltt2+iC7vBGHn9yA5OSFctYT6+yzoYdN9wZjAQ7eVJEH4QboubomtAzT60N4Isub/tYv0auaGKTY6DiG++/iPom6hDa425dTboNS0lwffkDjn9CkFvZXZIhJN25j6XMSJ+PfjA3UYhXkwMlmTY/l34KFwcONiEK3F6NB0Ww9yrn994GUpi/8+9Vm4HsrZ87KOpkdR6fGxufpZV3tSd0gmrZDWshlL5hCUYP7kMcGHozXSyj+6+bn7iGj4e5BqVZZji8IBlGWbYE/DPaDTpKkE/my/OIoH1PIp/ZcEOzpNGc6Ceb9LmLnNcaxm9BkJ4dW/2wkllklwBrMzDRY41ksEV785f4JOliby0xWOUk7qSNc/WnvjTf4bEBMag1ASB/lTplKWf2IwokZsOXzsVxo7jYFqDNxHbcYgePOFscuJjrPaWnUNPpNeFNivYYUYxyScx5zdJCoH876fV/rtWx0fycQz3mRxJdeyYmYjcxJ83jOSw6O9BN/Bjt0Yzg5i23s6qD5Uxr+fcViU6sborURHYRaCROLmoXhgE2Cw7ofwvuGsa5k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB3648.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(396003)(376002)(366004)(346002)(136003)(8676002)(5660300002)(316002)(66946007)(6916009)(33656002)(55016002)(52536014)(71200400001)(9686003)(83380400001)(186003)(2906002)(76116006)(66446008)(38100700001)(26005)(7696005)(478600001)(66476007)(6506007)(86362001)(8936002)(66556008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?aRDol2FGsc720xhVQHIJfbOoIKgKtKdrqpKul5/AF44DvsCN6p4O/LY00h?=
 =?iso-8859-1?Q?SXhPtPCc+gaLwERw7tEH/gSTnx5clIoBj7YeRLBDyN1BbJZkblBRbYRzeg?=
 =?iso-8859-1?Q?ve54whKPLt26sjrlRnP2mtX26GOwVanerTSbZi7HISFP6WHroS9py+jcVW?=
 =?iso-8859-1?Q?mYuDyFT4rJ1kWpRP0OrlUwvGBl97cUWds+9W6sRw8kWzyv1Zkl9wFUKZt9?=
 =?iso-8859-1?Q?Evj+JQjtfnNRlvVXqk7NbH8R6zP3LAl0ZcidUCKTwlbjZySZdPMHKM8ogA?=
 =?iso-8859-1?Q?nZ9yn7ROCydp523y0PiKLu50EOlYoIWd4/nJRmDfDQMGcTFVgw5c/Fw3c6?=
 =?iso-8859-1?Q?xjuFpuV/wL2NJ/lbj/o0bz/AlixIUMTR+HiVv3NtljN1UP/GNWuPc1fa7p?=
 =?iso-8859-1?Q?wd6lM/RXw4Kb2t9XRn6Z0k4KSWg+2eNiOcM0+WedKxTPYxdKq6otHLtvsY?=
 =?iso-8859-1?Q?HUlYkbc/wZmQYQhddtTkrDGIzi/+PPB/Uf0mSEotqG7cBW0P90lSu+evG2?=
 =?iso-8859-1?Q?9V/xB3hnB8EXuHCwC5Dl4ac217scfl0mjR0brOsLJ1rSBp+tX4uR1gU30a?=
 =?iso-8859-1?Q?k5C+ZpI9LmiDkkofsrWxv1qQigNCc8Jwi6mvajcUkLsmk6k3JHPCVxBEPK?=
 =?iso-8859-1?Q?NpigjUZJQI6ODr/dqsyd0CLzHaiqwgLZ+1WZnFmXWUuc7ag4ROcqcCfqal?=
 =?iso-8859-1?Q?ui6LBeFN0UjXBr7ey4IoP+abmj2A2gx3f2zkrv8X0lldTz3Vp+hZGe+e6t?=
 =?iso-8859-1?Q?OWLO6rdLEDW68pytFD2sYekZS2g6VsNFGN+indy5JMTKY+TZfBvGSqSwEB?=
 =?iso-8859-1?Q?DHt6/I8mlUs8Yv+lfOghFp6/2NT47LeeCtLk0VNBC2UhXwBb8lw4vM9rNE?=
 =?iso-8859-1?Q?udeB2WT6cRDEnakHq7aFZZCwLxu1ON1qhxJlcfQicdvpfJ32ZMHSvtyElu?=
 =?iso-8859-1?Q?HzgyU7DR3a1sYfbw39E3KKFlJx57lSAs9mvJhsCJ9QP5aXRKfQi52rB0o3?=
 =?iso-8859-1?Q?59i+iVWHp9DuBVrXkR3oTjzLUnonZRRUMdWDNNxzaeRZAFOWIMnfK0F6Sx?=
 =?iso-8859-1?Q?G7/SUA+vfACee4LPR2JT7tADMMwfk1ViyPAHBTsz8baD7bHaioP1pe3/1V?=
 =?iso-8859-1?Q?Pjg4detBQ09WLj3Ai4X0fWkFhXXrUwt2pQ7+oAlTCcN7TZ+QA+tsnGJ1Ye?=
 =?iso-8859-1?Q?9HUEd/WCzF1usGFweEzQUdq2SKaOtsSCqk5lGV9+/fC4cOGa1/2xGJWoJ3?=
 =?iso-8859-1?Q?AsScDC2Cgt2tOGqzT8cmgczm1fNn0NmcnYr3JitwY6TvQlF1sJMWi/PAuY?=
 =?iso-8859-1?Q?a38dK9F/cCJqq+gEAJFYMygbmFqttHQpGFV2jjLoxMHwz8pQraXIqmDc/W?=
 =?iso-8859-1?Q?762RA2b1Yr?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: myfuelmaster.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB3648.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d05bb0b-b80e-4b4a-8a35-08d8ee40b027
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 21:14:47.3054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dd4cdb5b-3a50-4947-bce6-dd41ce3544d6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36iWDdkJ3m1gcrQSXdBalBX5E0zzxdZDO1GtUZoUP5lMZDEhGQJ8HgjnIaohsUTcmkmgUNAEotY4r0kjQ/N1+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4847
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello,

Sorry if this has all been asked before.

I am trying to setup a 6lowpan network using a Raspberry Pi 400 and Atmel R=
EB233-XPRO modules (AT86RF233). I have 2 of each.

I have wired the radio modules to the Raspberry Pi GPIO connector.

If have created a device tree overlay that I think works when applied becau=
se I see this in the dmesg output:

[=A0=A0 36.388574] at86rf230 spi0.0: Detected at86rf233 chip version 2

I have installed 'wpan-tools' and 'lowpan-tools'

I get what looks like good output when I run:

$ iwpan dev wpan0 info
Interface wpan0
=A0=A0=A0=A0=A0=A0=A0 ifindex 4
=A0=A0=A0=A0=A0=A0=A0 wpan_dev 0x1
=A0=A0=A0=A0=A0=A0=A0 extended_addr 0xc62e26eced5de562
=A0=A0=A0=A0=A0=A0=A0 short_addr 0xffff
=A0=A0=A0=A0=A0=A0=A0 pan_id 0xffff
=A0=A0=A0=A0=A0=A0=A0 type node
=A0=A0=A0=A0=A0=A0=A0 max_frame_retries 3
=A0=A0=A0=A0=A0=A0=A0 min_be 3
=A0=A0=A0=A0=A0=A0=A0 max_be 5
=A0=A0=A0=A0=A0=A0=A0 max_csma_backoffs 4
=A0=A0=A0=A0=A0=A0=A0 lbt 0
=A0=A0=A0=A0=A0 =A0=A0ackreq_default 0

I tried to setup a 6lowpan network (based on things I googled) but pings di=
dn't work, so I am starting over trying to confirm the lower level parts ar=
e working first.

I set the pan_id to 0xabba on both systems.

I set the short_addr to 0x0001 on one and 0x0002 on the other.

When I try using wpan-ping (from 0x0001), I get:

$ wpan-ping -a 0x0002 -c 5
PING 0x0002 (PAN ID 0xabba) 5 data bytes
Hit 500 ms packet timeout
Hit 500 ms packet timeout
Hit 500 ms packet timeout
Hit 500 ms packet timeout
Hit 500 ms packet timeout

I used "ip link set wpan0 up" (on both systems) and the result is the same,=
 but I can see packets in wireshark on wpan0.

A hardware person here suggested using a near field probe to see if we coul=
d detect any transmission. We didn't. So I don't know if the radios are act=
ually transmitting.

Any suggestions on where to go next?


Thanks,
Mark

