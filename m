Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F296C433B4
	for <linux-wpan@archiver.kernel.org>; Fri,  9 Apr 2021 13:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D7B61105
	for <linux-wpan@archiver.kernel.org>; Fri,  9 Apr 2021 13:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhDIN3a (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 9 Apr 2021 09:29:30 -0400
Received: from mail-bn8nam11on2069.outbound.protection.outlook.com ([40.107.236.69]:32609
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231599AbhDIN3a (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Fri, 9 Apr 2021 09:29:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Et6wIX6v4XEyOtK3X5xQg5fkbbKWstcLgv8eI6FGV3ekj5q7gAEoweXSiRexnkS2HmJ+a1Tr1h3qGeHgtLukkeShWoNbHPJKy+PV8HI2VctScg4S9kV6pJrK9Cn/ixN40jzB1uyQMv9Mxp0+Mhue2fu7KWhyTCbV6CAcjM1RTuaPUMivObhfevIcm5e5niywnYeXYn6Sm4FGIP4PlhwVhZdileSOJ6du/2VRWqXo6uTPFYTh0SFNhAaynMeqofeCtxCi7pLLZfJQzbeW/xUV/0higxmmVU8n/CMYoGtGuX1Ipp3cNFXnRNiAN0mVXfHIXWVLMv6iKaNRIDCBvIRU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtYRpX0EDr7EUjo1efsUOZuVtRpVlJkTeHOXimclHZ8=;
 b=cSwxR7ji12VmH3BKsfL9Dkia8tC0dQZcC75a96FCxV7IDoMrCyMNHczzlAY3YXho3w1WZY0Cv5OmjJiagUqMvpvTSQpQO8OhTyydw4dyB4lTf2svNYBy0qio3Kx1y9B1UNneEmXkZfypDO+32D7lG1nh73tVD+R3pgHo6vu87ZLfONd/m7TdG3PejJ3bkf3VlPU+F5A/yAD689OEZNOz5LdiXCSlQc0XD3qgiA4gEBWWkAE9tb/o5jnn/K0Y4h6ufljSkmTc5RRsK/rqFzWuv1oAhnVlXTDxqxl2czEl5+hxZjs+1KQ2IiLcEEFV/cITf+7hFFJVLsMP41jZGLUVzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=myfuelmaster.com; dmarc=pass action=none
 header.from=myfuelmaster.com; dkim=pass header.d=myfuelmaster.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SynTechSystemsInc.onmicrosoft.com;
 s=selector2-SynTechSystemsInc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtYRpX0EDr7EUjo1efsUOZuVtRpVlJkTeHOXimclHZ8=;
 b=yMqTklnc3Ehj29FaEU9x4H0xzoEyxaBh8O6RCgnZNzaf59BXBcQV8dlZfRProPwAexOMAWDI1DOf2ZHN1dYMTh2cp+O+PhsayXj754VaQqlAk3bLmFA6mjRiJp34obbPZvpwnbKNVfMAzquXQdZavq5zj52P9QZsXRGRdqf6eHw=
Received: from SN6PR01MB3648.prod.exchangelabs.com (2603:10b6:805:17::29) by
 SN6PR01MB4269.prod.exchangelabs.com (2603:10b6:805:ad::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21; Fri, 9 Apr 2021 13:29:15 +0000
Received: from SN6PR01MB3648.prod.exchangelabs.com
 ([fe80::35c4:628c:3aa6:356b]) by SN6PR01MB3648.prod.exchangelabs.com
 ([fe80::35c4:628c:3aa6:356b%4]) with mapi id 15.20.3999.032; Fri, 9 Apr 2021
 13:29:15 +0000
From:   Mark Butsch <Mark.Butsch@myfuelmaster.com>
To:     Alexander Aring <alex.aring@gmail.com>
CC:     "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
Subject: RE: things not working - newbie questions
Thread-Topic: things not working - newbie questions
Thread-Index: AQHXLJbSrwMevhaahUSOzvbwPssI7KqsLYNQ
Date:   Fri, 9 Apr 2021 13:29:15 +0000
Message-ID: <SN6PR01MB3648AD0120B58D72E5B0C00F87739@SN6PR01MB3648.prod.exchangelabs.com>
References: <SN6PR01MB3648B4FC16E10CA1B04F756587749@SN6PR01MB3648.prod.exchangelabs.com>
 <CAB_54W7K7ir+CLxMkXGMYbxuvDEEJD5vNW2arbLLiaSKrGtbLg@mail.gmail.com>
In-Reply-To: <CAB_54W7K7ir+CLxMkXGMYbxuvDEEJD5vNW2arbLLiaSKrGtbLg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=myfuelmaster.com;
x-originating-ip: [63.148.217.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d24860e-44c7-4289-558f-08d8fb5b7870
x-ms-traffictypediagnostic: SN6PR01MB4269:
x-microsoft-antispam-prvs: <SN6PR01MB42693C6E2CC7BE4EB51632CA87739@SN6PR01MB4269.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Tk1HabKasbtbLw50n76lTuHek0cMr6+MGNmcMp0tDxgLdBRi3N2/RxBkj5v5X70CWsBTr8NwYBbCBrfhoDUazAL6AeCveOj9jPdi1aXs70gt4WbTy45Nu7uSBBhPTaZxfesvdUdngqFXT3bwHtp9+dogqpadH2Qz8PMSRuU31ZSC3lCcQPdZpGBJkhBv9PD84DBLLvOy/dDrI8GfWLanCY5IGEzp9Yq9pWD/Z+Ki6g6+/vb1T38ZjGqg9At6VunlbjZ0/jU9/o4IxQVB/OnC5NrE76qcP/HUE7jyb3G3a6Ca2U6PLb3hfn2x0JTvWRHUG86TwvCMX2Nyhb1TO7vFSCy21jb/69S9o8l3PYtKMz7BjwhWK0tVolSfGIqhtG5dlu8H/tROAE7/YSQMcLwpb2gUQtOycbS2qQK7ChFxIJuZN47e0X4TkKnhgR4jfYKnf6+TrwCBXWaAAxPWSaMLGPv4ZiIwRz+GDCmS9GhgVtZOFJE5GRgyuEG3JeH/i4gkKOdsgKKeTZlXWkvpMwfFOwVCI6b+inLgkcHENErtmdL2uFN6dHccAp7dWdbgPqPQn2t98lNQA2ViQW2YsY/wDC4iV2+FVodXYx1ZbHGw33Oybstv3FypMZmWjTle+pK0aRD1MshHDIN79nk/D+V/breC5Nb8X5BbCpst3gBNkKy4j3nFUufwhn28iagEKhN2co4T21qVOIeC6QCBTFs6aUaT9CRdz4W8XwvYOq/TG1TUy7eBKpthMlxoK+MqfUg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB3648.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39840400004)(366004)(396003)(136003)(55016002)(33656002)(26005)(9686003)(6916009)(4326008)(5660300002)(316002)(7696005)(38100700001)(2906002)(64756008)(66446008)(83380400001)(478600001)(52536014)(53546011)(76116006)(86362001)(8936002)(8676002)(66946007)(71200400001)(66476007)(186003)(6506007)(45080400002)(66556008)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2rRKeqMecuAL0mHxMSYsai/nqXxe/dg6Lkhka2sr09KOXMVJXMoHmJJJ3IOW?=
 =?us-ascii?Q?3zaUXFU4Q+whW/epUCOWNDkgcQxV4A9hmAW2+elsKzWGGy3Y0vwjR4cdltJ+?=
 =?us-ascii?Q?gyMJmexRCJFWWDqvPfdBulkfx5RHN14ySAKoWEBkWXe4JstzEq/8vSZTo97Z?=
 =?us-ascii?Q?2o/NS6585QFNqsLJz5nwlBMJkaMJ32fG9qZwX5dl7dXdGLVoSiobQReeik4b?=
 =?us-ascii?Q?61xxzkoD80DxUCgTN3C4ENQslvXZ5j+smUM0/t/uFv83bkS5bpULX7d4Kgrc?=
 =?us-ascii?Q?T9LJhUqWGiUAuEImyIadJtPscfAqJ3Y/iJX8o6+7wEbe4e3lvDUfkNZ3vE14?=
 =?us-ascii?Q?lUwqE8ZFy9QQRIZsIFJAhy+Sjwk9BGSq84FoOrPC4k+wr0w3uhb4BgWeirxD?=
 =?us-ascii?Q?BV8AdwhOQLdMBs5C0lVOIPseGEw+GI56gp53Eyhz5OPvDiEOAfj2y/hRRNoc?=
 =?us-ascii?Q?0+VcA3DOfAthLnbea7XzklGmpiZblfTHgW/3z/ziVdzM3oDVmZdWTJIFAuf8?=
 =?us-ascii?Q?nGn/HbuYkL7f3r3M+u89mRuMe3NdImlxXyjofnFglWTRQnKXnq0asOEhs+gN?=
 =?us-ascii?Q?PS0KxgyEVt/vzQS1O1VlE6xo9cQ1Mu+Kb5O2JRksRJwAzDli/LPamcsVlGXn?=
 =?us-ascii?Q?WNaQ29KWMCOlbAqaP6lJK/rBDlTbqmfZznrKZuB10AsQgJnCNdwn9Z5wtRUD?=
 =?us-ascii?Q?XY1AyCMKI/7qYRAgwr92tZGQsSRPngm8J/XZ00XAmxbmuWgdJg9EKbCLzird?=
 =?us-ascii?Q?V82jW71BvufXTnaabguOlJZ2EQablWfc4m1w/ERzvkeqRzYqQnaIqXPRVEHf?=
 =?us-ascii?Q?gPQa693zMHAxGPlf5B5gfrgAgttoQLcacs55XftvgqRw438OwnY17SLeB38P?=
 =?us-ascii?Q?prKQEBMxQxM2HQrKzPEWoIlW53e0AtFwoJ5R1GCqfOXvaDAm0Csk7jtBuO2+?=
 =?us-ascii?Q?OuE5UDJNXiR0Qr2WPrZqOD6bkKbZ3oBpk/A7deBnpNmXKEk03FQKchvJUqnm?=
 =?us-ascii?Q?wI7DSaeoKpSwq5Hjrxgup7ejd58RJaTeYkiKlywx6mqT0avddVgICGwRRi7w?=
 =?us-ascii?Q?39N/8VRE9Bt+yh8A1ElRCaQcXMJ6U6ZcFxbHSkQI9ISToDcYAm03CzbGyTVp?=
 =?us-ascii?Q?jL+IIioW6VLXUzxCoSYWKd2EnPshSukjR1rOl0UPY7X7Udy86lnpCyxX5CZ3?=
 =?us-ascii?Q?d6ynNo0mpCwW2+Xx0vv6lkdgwVAEhwzkdPsKsYDL8qVEk0GHZSYfE7nJ0X7n?=
 =?us-ascii?Q?qkSu81R6Ts2IwDDD3g7LovyB5G5nFyYz2zM1HfUsjvZan0jokO4P3sUgB9s3?=
 =?us-ascii?Q?MsSaOuVkHnZjgFlOC48hLYTg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: myfuelmaster.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB3648.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d24860e-44c7-4289-558f-08d8fb5b7870
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 13:29:15.3079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dd4cdb5b-3a50-4947-bce6-dd41ce3544d6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dEJF3q6qC1mlkpOE7FizWsTc/veQ0QSgJJCb5340OnJuSfAA+0BxuUqOymOSZof+vZPRyhy+OdZHxG32Gk7/Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4269
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello,

I ran the bash script you referenced, but was unsure of how to test.

I also tried using the mac802154_hwsim driver without the separate namespac=
es.

I took it as far as creating and bringing up the wpan's and they show up in=
 ifconfig.

Then I tried using wpan-ping, but got time outs like I was seeing with the =
real hardware.

Ifconfig shows one phy with the TX packet count increasing and the other wi=
th the RX packet count increasing like I saw with the real hardware as well=
.

Thanks,
Mark

> -----Original Message-----
> From: Alexander Aring <alex.aring@gmail.com>
> Sent: Thursday, April 8, 2021 12:47 PM
> To: Mark Butsch <Mark.Butsch@myfuelmaster.com>
> Cc: linux-wpan@vger.kernel.org
> Subject: Re: things not working - newbie questions
>=20
> CAUTION: This email originated from outside of the organization. Do not c=
lick
> links or open attachments unless you recognize the sender and know the
> content is safe.
>=20
>=20
> Hi,
>=20
> On Thu, 8 Apr 2021 at 09:59, Mark Butsch
> <Mark.Butsch@myfuelmaster.com> wrote:
> ...
> >
> > Understood. Probably best to focus on resolving the wpan level first
> >
>=20
> You can try to use some virtual hardware driver to check if there are no
> setting failures whatever you are doing.
>=20
> Load mac802154_hwsim. _Maybe_ it's required to move it into another
> namespace (for ip sometimes yes).
> It will register two phys (by default) who should be able to receive to e=
ach
> other, see [0] for an example.
>=20
> - Alex
>=20
> [0]
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith
> ub.com%2Flinux-
> wpan%2Frpld%2Fblob%2Fnonstoring_mode%2Ftest%2Fns_setup_simple&a
> mp;data=3D04%7C01%7CMark.Butsch%40myfuelmaster.com%7C855fe6084169
> 4ab3ebcf08d8faadf3f9%7Cdd4cdb5b3a504947bce6dd41ce3544d6%7C1%7C0
> %7C637534972318591913%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s
> data=3D5MCmuyVwxZn7lC019oJ3689u6%2BzKt4Lods%2BEa9q3BAQ%3D&amp;r
> eserved=3D0
