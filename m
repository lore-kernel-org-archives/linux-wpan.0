Return-Path: <SRS0=TmWs=D2=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9141DC433E7
	for <linux-wpan@archiver.kernel.org>; Mon, 19 Oct 2020 06:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0915222257
	for <linux-wpan@archiver.kernel.org>; Mon, 19 Oct 2020 06:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MLPAConsultingGmbH.onmicrosoft.com header.i=@MLPAConsultingGmbH.onmicrosoft.com header.b="i1aXNHXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgJSGHR (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 19 Oct 2020 02:07:17 -0400
Received: from mail-vi1eur05on2100.outbound.protection.outlook.com ([40.107.21.100]:41505
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726553AbgJSGHR (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 19 Oct 2020 02:07:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRuzsKXBitAAIFxbkSUHmZvNF05yXNG/ANJeeh3jOgKETEEFOwljDJykgVA7JDnxtZyVedjQNUUC6p+TSDs9gmxVKFJW1K+UWCEEFalNgeRKpYhVXeUO6nPuPpqkNIgeqYJJg1BmAetUEG9F3yaBdLLBRBqhUul+b5MfvdJLHeaK7IWsK00qs3rKp4xwzRSaVcFJ/n6Rg1itSN/oLhWsuSOs4xax82QSI7YzDOwV5Ph9Qwc9+s6iuhxzwgRD4PuftNb75aZYD1sQdrR4XNBf/6abYJQwLSUenHYmhrZ80c+uStUiVyp9KNCgqp9wR1FBz4fwxzCaQnqKdmTes9GxBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHHYuqQBla84KiZVScOSRaZxpUhjui3BAtOtED0DV3o=;
 b=geFwQ32Rlh2tU9gdj2ZoC1ywQ6adoDveeqfCkFzSZuCaqCXI33/JjphdMATENXXXjTtPXiyIXDBi09YYhFLNi589mRlV33TbUFtqNtc85sBPgZpnSZQLTy8XBWeF3lH6jxKGMcDYHUf1PqYAOOtf+p0+s1OK8bZirvSfFtyBitymz6oItVvnArcfwZYxio2k9DgJEX0RyiH04nJh5VE/c5aJGVAz6P2N+C5yyUeakqqBF7JqqLXNkxAOZmuH/IHiUNDiHYjXCuJ3/suiAALk7xGZPyyn17vLY8yAd1ZdR9kZzu0hCXo538VncBvRM9C7vVzzSetrDgxvh+89JP0lRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ml-pa.com; dmarc=pass action=none header.from=ml-pa.com;
 dkim=pass header.d=ml-pa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MLPAConsultingGmbH.onmicrosoft.com;
 s=selector2-MLPAConsultingGmbH-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHHYuqQBla84KiZVScOSRaZxpUhjui3BAtOtED0DV3o=;
 b=i1aXNHXRqcWc4sodRmWT55fKr3jowrP60QW8aHW4Vq0FPDxcbg+BUhGFIfCcvCTLZ63DzQLuKNWB1vKoS92R7onMqjkG5X/sE7oOoo1zJmmc1IvYX+sxPyliGEYvnAbi/SCAhPiZ7C0WC7dDsAwrUS/oDDxkKIkOK+NL+16SbzA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=ml-pa.com;
Received: from AM0PR01MB5475.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:17a::28) by AM0PR01MB4627.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:ed::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Mon, 19 Oct
 2020 06:07:13 +0000
Received: from AM0PR01MB5475.eurprd01.prod.exchangelabs.com
 ([fe80::c1ef:81:1816:4528]) by AM0PR01MB5475.eurprd01.prod.exchangelabs.com
 ([fe80::c1ef:81:1816:4528%3]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 06:07:12 +0000
Date:   Mon, 19 Oct 2020 08:07:11 +0200
From:   Benjamin Valentin <benjamin.valentin@ml-pa.com>
To:     Alexander Aring <alex.aring@gmail.com>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>, koen@bergzand.net
Subject: Re: iwpan with LLSEC - attribute type 1 has an invalid length
Message-ID: <20201019080711.3f070beb@rechenknecht2k11>
In-Reply-To: <CAB_54W5VgY+DeqdjiQ7BJsmXw-G=POwGE7tzYuwAwYixe6y9XQ@mail.gmail.com>
References: <20201018170934.2c03c9e3@rechenknecht2k11>
        <CAB_54W5VgY+DeqdjiQ7BJsmXw-G=POwGE7tzYuwAwYixe6y9XQ@mail.gmail.com>
Organization: ML!PA Consulting GmbH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2001:16b8:454e:e600:dd8e:1227:593f:d7c2]
X-ClientProxiedBy: AM6P195CA0034.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::47) To AM0PR01MB5475.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:17a::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rechenknecht2k11 (2001:16b8:454e:e600:dd8e:1227:593f:d7c2) by AM6P195CA0034.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend Transport; Mon, 19 Oct 2020 06:07:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e065558b-7e77-403f-4b56-08d873f53892
X-MS-TrafficTypeDiagnostic: AM0PR01MB4627:
X-Microsoft-Antispam-PRVS: <AM0PR01MB4627C950F3CCDA8679107C10AD1E0@AM0PR01MB4627.eurprd01.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ApvAEkcuj1e9+uU19jsjBbZLLYZOc0/U1pECudgx5hNtE0JPK2LmdD34giH9S5sxxJIcj6Dv99245MhvS97SfYNQFUQldj+t66ESljPkqHARJuzlSlsFaa8yl62lBdnhSKu8sozpgA12oUyRAAwZd8cik/n1Ty3331SgoSSuUv8mp8Stw+my57dfZYctZVjiMtmpWdj4wxoSQBQygaFwB6ISeAnbQkvpDrzhxWzyEsegvdw4a5w85zBlDRr8tbebHvgxBsqsutdDGHUjNIqTjTrPfTeGqSCulU2Mgpxtsv7EL5f1fIBZiAA838Z80pVHiyG7mhKcNHHJ7kQXkvz03UIl0e8S89JPRYUl03fts6O3hxO3Ld5vfYZm0baK6RbkWHYP6/y57o/R3iLm6u455w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR01MB5475.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(39830400003)(396003)(136003)(83380400001)(86362001)(16526019)(52116002)(6916009)(186003)(36916002)(6496006)(9686003)(316002)(2906002)(8676002)(33716001)(478600001)(8936002)(4326008)(55016002)(44832011)(5660300002)(66476007)(66946007)(66556008)(9576002)(966005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: JhIT6knGSqW3BjWiaAg7DVAalXUFkrIAOOH8XehClWhNXPqP+pckhFDVvbxBO3wiS6RK1z1TLcUNghB/zcUhFCAtl20nnqF07HB0zdlyxQf/z+NO0tubaf+UHMt++p96pq7V2b32S4wwkr4/Qy14F8RE8ppZDTwe1llUR87qMnIyajximtxq6c+opHQeX0D+tAc8Lh4TaZ9aan/zlN/4dkhaOkgRX09uae68te3GkYCWIo1TTjYvqtzXdiMSbr4tNOLW9AoccCe5S38yXMayNO1+ZF8Bu2GI96tnKnEu0wzaendI0OW9WjJjfZyP86cFROkfMmvX0CDMfsC7ITNe1ScfYDq5OOLaKpaIg358n2U0h16KiOUA0pQNLHNXO9TrIKnGzmt2tdZhXWAtQ67Q25WaabrURwmCZYb2ec3ifDhjlkM027efQQWrhHyBK+y8nMTOls4BEZdmr1XftrbgOOMicogZx03FW/8YivtQzzCc3SIJphNK0Xjx60VfZxn9ZgSsfCC5yppmRzSG02cun+UVmqmieBlvpzXpXisEcWUhEmIbNco+bdRcpfvxQi9lGSvxXB+I9sKg7zexWBjXdzIDSbG4gxDNrQ1J77hNF9uAD/vfVh+Pe+gJChjmC5/ceVzvkGolAzbABBFBN4xQe7JzcdKnh0H9W0KzSefK4m7Gb+W9pt4YZk4oksQOVeRjELsrRVdqmkvmGnBSHIMgfQ==
X-OriginatorOrg: ml-pa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e065558b-7e77-403f-4b56-08d873f53892
X-MS-Exchange-CrossTenant-AuthSource: AM0PR01MB5475.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 06:07:12.8717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23090d33-f0df-44f5-9356-137a7bdfe69c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wjQc07nhQJwjt9QJg/qfITI7veIea6ZTOiVs+HJDFpO94IF9+jK+CZxT226+zflHccR9sQhGBZj/8889rvqWkLvGgkxshxRpeAivFFvk18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR01MB4627
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Sun, 18 Oct 2020 19:20:53 -0400
Alexander Aring <alex.aring@gmail.com> wrote:

> 2 is ack frame, I think you mean 1.

Same error with 1
 
> Success? Like above? Can you tell me the command line error message
> please? What does tell you "type 1 has an invalid length"

dmesg tells me that when I enter that command:

[  156.899429] netlink: 'iwpan': attribute type 1 has an invalid length.

So I assume that's why encryption fails.

>  - Don't trust wireshark, you will not see exactly what's sending out
> on the wire. We just do the encryption on the wrong layer, but moving
> it was causing other problems. I recently stumbled over something
> which maybe can help us there, but didn't look closely at that, some
> subsystems have special handling for tcpdump/wireshark things.

Would that cause interoperability issues with other implementations? 

>  - The frame_counter thing that you see above needs to be synchronized
> on all nodes, if nodes join with a zero value you can do replay
> attacks. 802.15.4 doesn't solve that on the link layer for peer to
> peer, MLE can do that in a way to just make the attack window smaller.
>  - When the fame_counter overflows you need a new key, means key
> management and key exchange. Biggest problem :-) I was talking with
> Koen about that once... he showed me some interesting stuff, forgot
> the name..

Urgh this just came up again in https://github.com/RIOT-OS/RIOT/pull/15150
Does the standard suggest anything here?
How does Thread solve this?

> Please dump more:
> 
> iwpan dev $WPAN_DEV seclevel dump

iwpan dev $WPAN_DEV seclevel add 0xff 1 0 

> iwpan dev $WPAN_DEV device dump

iwpan dev $WPAN_DEV device add 0x00000000 0x0023 0xffff 0x82b989a7f0d5decb 0 0 

> iwpan dev $WPAN_DEV devkey dump

[nothing]

> iwpan dev $WPAN_DEV key dump

iwpan dev $WPAN_DEV key add 0x02 c0:c1:c2:c3:c4:c5:c6:c7:c8:c9:ca:cb:cc:cd:ce:cf 0 0x0023 3 0x82b989a7f0d5decb 
 
> - Alex

Thank you for your help,
Benjamin
