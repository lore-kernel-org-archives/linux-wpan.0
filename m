Return-Path: <SRS0=TmWs=D2=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E89C433E7
	for <linux-wpan@archiver.kernel.org>; Mon, 19 Oct 2020 20:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E822223BE
	for <linux-wpan@archiver.kernel.org>; Mon, 19 Oct 2020 20:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MLPAConsultingGmbH.onmicrosoft.com header.i=@MLPAConsultingGmbH.onmicrosoft.com header.b="fJslZWEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgJSUNF (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 19 Oct 2020 16:13:05 -0400
Received: from mail-vi1eur05on2125.outbound.protection.outlook.com ([40.107.21.125]:41697
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726478AbgJSUNE (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 19 Oct 2020 16:13:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4ytOPs3xh3KJLKMhppxmWIQv+fqKyZt6xTUEcwmU75sw3OfmX7fa3ZtR+X8v9Q7ay27j2A4FWpKjc/lDJ+Z1IjgNFDwwYghNx7W/AK013XAqOK+Ovx0E0wtvwZqg5mA1UqMO6pEyngji127ExZ2ov6oagliChJUSEIHmNirmJyGXkoU5zWzdIpL0CQV9VJgvCHsIuqfKYk47/HcZ/biwDpQbUHPxyK7tZMUC3OG/j/MPEv4ccjwM/3QfIU2VPiEfsWTjhpYKcaLDtstEEVIsK1jKVgXpnmCviZ9neZhupJAiqX9XQTFaP6W7STFzj8ESo9qE4P3K62/O4EnTo1EmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkTz9fDxPW4W3Tka5JXqYhUvGHJnW3fFRVHozeOBz3o=;
 b=c9SI5x6kejyiHsyqcvtwGEVfgn9ffmug+syTn1BL77UPSXdJ2SypKsrdAREPzuFDDAlIgTQAcdN3aKjabROYmvjbdtcq/2ZE0wO3ZR7yU3h9MlbiC53RT6jCXgjz7OT4G02tE+arid7eATQ6Lo12Muix0vitAFaDMGWY1tPd+AgiMeCCArIaM6PkniRUwo1LEHQiJ54A/bkNcxo9QEGlWw/9aBDTDxL+LOO8VNb/8UPSPw9s6X+9qand2i4tnjlV3QCnQJbIEpKiUZ7Zj41h4edKr++V6WdVGwZIyV4SXeDHuEuMA1/4Z7TBCjjqgqqAlNBX5gwYg1y3u/I9iNEGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ml-pa.com; dmarc=pass action=none header.from=ml-pa.com;
 dkim=pass header.d=ml-pa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MLPAConsultingGmbH.onmicrosoft.com;
 s=selector2-MLPAConsultingGmbH-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkTz9fDxPW4W3Tka5JXqYhUvGHJnW3fFRVHozeOBz3o=;
 b=fJslZWEt/sgrP8d2V3QoPdrnuKUuuFBprZGL5xVMWifQybG0K60jAycj0aJuALFqus09cjUii8AgKs1ifRri95gwbjRDHztKeg2HA2AMXjo8J99u+9+JAsO2EtTFwNxFcde/c49z1W20H6k92x0yFtB5OicW/4YiiRF+TBgb/Og=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=ml-pa.com;
Received: from AM0PR01MB5475.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:17a::28) by AM4PR0101MB2259.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:48::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Mon, 19 Oct
 2020 20:13:02 +0000
Received: from AM0PR01MB5475.eurprd01.prod.exchangelabs.com
 ([fe80::c1ef:81:1816:4528]) by AM0PR01MB5475.eurprd01.prod.exchangelabs.com
 ([fe80::c1ef:81:1816:4528%3]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 20:13:02 +0000
Date:   Mon, 19 Oct 2020 22:13:00 +0200
From:   Benjamin Valentin <benjamin.valentin@ml-pa.com>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>, koen@bergzand.net
Subject: Re: iwpan with LLSEC - attribute type 1 has an invalid length
Message-ID: <20201019221300.2552a33c@rechenknecht2k11>
In-Reply-To: <CAB_54W5neFEzFGV=1v_AD4OSYs1qw=YjkoM-FeUkSyHjJ3owtA@mail.gmail.com>
References: <20201018170934.2c03c9e3@rechenknecht2k11>
        <CAB_54W5VgY+DeqdjiQ7BJsmXw-G=POwGE7tzYuwAwYixe6y9XQ@mail.gmail.com>
        <20201019080711.3f070beb@rechenknecht2k11>
        <CAB_54W5neFEzFGV=1v_AD4OSYs1qw=YjkoM-FeUkSyHjJ3owtA@mail.gmail.com>
Organization: ML!PA Consulting GmbH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2001:16b8:454e:e600:dd8e:1227:593f:d7c2]
X-ClientProxiedBy: AM6P195CA0099.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:86::40) To AM0PR01MB5475.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:17a::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rechenknecht2k11 (2001:16b8:454e:e600:dd8e:1227:593f:d7c2) by AM6P195CA0099.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:86::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Mon, 19 Oct 2020 20:13:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75780dbf-327e-4330-0729-08d8746b6183
X-MS-TrafficTypeDiagnostic: AM4PR0101MB2259:
X-Microsoft-Antispam-PRVS: <AM4PR0101MB225963CE9B1A83CC5A635001AD1E0@AM4PR0101MB2259.eurprd01.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1cLcTSdfxm/Sal2XJ4fe3fxEdV/zhl99ztblhdSZ0wIvcLqW1Os+IWkTj0RSNLMJye7Dig1H/qeXqrj+DD+3yRvYgd00hFWvzVQ+huGjmFAxOAp5J8Mph3dA/CQ//XMOGB3u/bYiCzO2KcVJ+iA5trJ9ALURcXHMhfLPV5kQxJKo7oqFL8PDbjdVKMQjwjpVYKGQMpqei3BcJc0waEdTtnPkSOSfRh+ZGU91LLxgAM4MB6eSrKR+TYANICinURp+Ganv7pLRzEQaCCV3xdNnNM1RZ+Cpc5Rmq90OdPGTiwqg+Ed6O5EW++A25QoUX9f3vAsVbsRM91RI1y1024zHvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR01MB5475.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39830400003)(366004)(396003)(136003)(44832011)(109986005)(16526019)(2906002)(186003)(9686003)(86362001)(9576002)(4326008)(478600001)(55016002)(1076003)(83380400001)(6496006)(66476007)(36916002)(33716001)(316002)(66556008)(8936002)(8676002)(52116002)(5660300002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: tXSvHGFwgdGOh5MGtPyMfUHB6iRSB0DpPTzzNLS7HSOd4+iq8uNa98UROftv8tMcCKehWiSlS2h8zexVZtujkMp7xoxoh/qdL//ih/6NAvEyKKcqa21EwmhWcHMmTKyb5ffcV1MJg9sz2cD7bTGUKJ2JmBRF3OEVppAuo87GZxEdm8sicOPxywn7qMJP4Ouc8qQuuzKpFcUjtJ6VS4Y+e5F2FJkoV/L2hC27B6xrorCcFfTZHaUqkE/HSGkGfSq4EnuMROofJwbwH27/XbKuT4/6FLXaVI/yJA1zFW6jXFIBXg1hj4HImQMa/pRUglxvooUCCPQLBdNMlf3u0XJTTkRy55bdC2okqNRF370LT+dPr6EbQP4xlhIONZrXTEAVe0rXFd+w1gAasPomzfiJJaB+SkYD6Ci6eypK3OgF8D32QmFG4+JxCxAgFgNwapcXRwExO7pf9Jwxu7w9unGJmzdaGfZHX67XkDLY7wGJeaZCTs5Y+28dSM6DgmEpRJuNqeLbrASHeBNh2fH8zxIdGPUKfHuFJFADmlTG3Dd8bC8zGLYjfVUAiG2CYrqg57dzDOIflahWv7nZGka40lAD+p6UCunCJM0uURXpV5HNbqdnLKXP/ePKDJayVM9Gt8O9xIr7ETfvvrOm/5ns8dP9Vpb7kkPMslfvcbhWPtREuvkjrkAqxhqR+y0UhDc0xX1RCUQPQ9c7X6YedQCdk0mFlw==
X-OriginatorOrg: ml-pa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75780dbf-327e-4330-0729-08d8746b6183
X-MS-Exchange-CrossTenant-AuthSource: AM0PR01MB5475.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 20:13:02.0404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23090d33-f0df-44f5-9356-137a7bdfe69c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8hKwsv0KeF8uP16NQaSYGIPJleQdjgnkqd615vP1qJjNIbM17bl/rpZ0T0QDUNosuj0+CyaiOrEUoUtTzaMu5Hbqdcfv6mLPQ91p5y73LV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0101MB2259
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Mon, 19 Oct 2020 15:54:30 -0400
Alexander Aring <alex.aring@gmail.com> wrote:

> That should fix it.

Thank you, that fixed it indeed!

Well, insofar that I don't get any netlink errors anymore during setup.
I still get

[  331.928242] ieee802154 phy0 wpan0: encryption failed: -126
[  332.971098] ieee802154 phy0 wpan0: encryption failed: -126

when trying to send packets. No plaintext traffic is sent either, the
radio just remains silent.
Receiving encrypted frames (from RIOT) also doesn't work (I assumed that mrf24j40
bug was fixed by now)

My complete setup script is

KEY="c0:c1:c2:c3:c4:c5:c6:c7:c8:c9:ca:cb:cc:cd:ce:cf"
WPAN=wpan0

PANID=$(iwpan     dev $WPAN info | grep pan_id        | head -1 | awk '{print $2}')
SHORTADDR=$(iwpan dev $WPAN info | grep short_addr    | head -1 | awk '{print $2}')
EXTADDR=$(iwpan   dev $WPAN info | grep extended_addr | head -1 | awk '{print $2}')

iwpan dev $WPAN set security 1
iwpan dev $WPAN key add 2 $KEY 0 $PANID 3 $EXTADDR
iwpan dev $WPAN seclevel add 0xff 1 0
iwpan dev $WPAN device add 0 $PANID $SHORTADDR $EXTADDR 0 0
iwpan dev $WPAN set out_level 0x05
iwpan dev $WPAN set out_key_id 0 $PANID 2 $SHORTADDR 3 $EXTADDR

> > >  - Don't trust wireshark, you will not see exactly what's sending
> > > out on the wire. We just do the encryption on the wrong layer,
> > > but moving it was causing other problems. I recently stumbled
> > > over something which maybe can help us there, but didn't look
> > > closely at that, some subsystems have special handling for
> > > tcpdump/wireshark things.  
> >
> > Would that cause interoperability issues with other implementations?
> >  
> 
> No, just use a monitor interface to see what the on air traffic is.
> Don't trust local captures.

Don't worry, I'm using a CC2531 dongle with whsniff, only looking at
traffic that's actually on the air.

Best,
Benjamin
