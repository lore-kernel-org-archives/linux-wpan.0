Return-Path: <SRS0=f8AC=DZ=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67985C433DF
	for <linux-wpan@archiver.kernel.org>; Sun, 18 Oct 2020 15:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0326A21D7F
	for <linux-wpan@archiver.kernel.org>; Sun, 18 Oct 2020 15:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MLPAConsultingGmbH.onmicrosoft.com header.i=@MLPAConsultingGmbH.onmicrosoft.com header.b="bO7rhaWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgJRPJm (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 18 Oct 2020 11:09:42 -0400
Received: from mail-eopbgr10112.outbound.protection.outlook.com ([40.107.1.112]:57230
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbgJRPJl (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Sun, 18 Oct 2020 11:09:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdHQzjfvkJLyt+yyddt4YkHHLMOhWXfJfLmTEnaFDUU7MPbrB2mxLIrA8MJjnfcqSfBAwIO1YnXCGveBSPkKKEiRH5Ex5NuuPwl1a1BJtv1Cd7IMKvErPXEc7SaFN4KthW5UxQVcid/3iOlskPMB0X9CQfyg+EkosS0QJ9+61Rax8pMMGkovCuasIVyXMSmwEdDP3z5NLJhxETF/zt33GJRbPssnnla2xsIBrQmvM0Ufl3XNIy+3cwcSWewBrgf5mFhN1REOAqaqEoj3dGfksMQG0geYfZ7gedPgRTgStyauXyz6RVfsU2RJY2RvmN/aGjAwPHlCk6OiQMFUb7luiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8xeOa5XpGdJTukV2GcP+s30znnswDP66zraxVesQn8=;
 b=V0QZMwxeLK4Aw4/2NlEAv2dLpqdFRX/0VozUJaptSTI1w+pcES4gZeQvMHl2+c0Cq8KkWhtH4GneLvR2MvuG+B9YoHqJynk3z+dQGFzhs6XJ3mUDvRV9rGJfsvBAMaVTqC6zplKDUfdcCQJ5/ja3p/WEFcI2iq5YWAxDlxGHbGQkjls4X5cGHW8SvX4yZX22Px/AzZR/zLSTAIAdB4RCk4PqthtMHVo6sS7YNkfQpdomzbConSsF6gs4+SUSQ6VPdWBoAN6zo0C6lFZEHw1nlWeL7jJYYZrl5cxruUMsa5SIBthCyCnziq8vep74r76ZE56evrCYyiaFJ9EyKqfbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ml-pa.com; dmarc=pass action=none header.from=ml-pa.com;
 dkim=pass header.d=ml-pa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MLPAConsultingGmbH.onmicrosoft.com;
 s=selector2-MLPAConsultingGmbH-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8xeOa5XpGdJTukV2GcP+s30znnswDP66zraxVesQn8=;
 b=bO7rhaWLoWwwlwA2Y8vC/eS3VbId6SZtLAr6nNRefEgOJQqNRwZAvG847vyh/sy18SHd4wIo/0F9dWWWDSrsFdCl4NUWmwdptsAhUrRqwNt9PmozPXdD7vqoJCykqSrwf3X0UHM42OAFleuPhuX8iKYw0d/j4/pTWJWNSSwrbxQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=ml-pa.com;
Received: from AM0PR01MB5475.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:17a::28) by AM0PR01MB5313.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:11f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Sun, 18 Oct
 2020 15:09:36 +0000
Received: from AM0PR01MB5475.eurprd01.prod.exchangelabs.com
 ([fe80::c1ef:81:1816:4528]) by AM0PR01MB5475.eurprd01.prod.exchangelabs.com
 ([fe80::c1ef:81:1816:4528%3]) with mapi id 15.20.3477.028; Sun, 18 Oct 2020
 15:09:36 +0000
Date:   Sun, 18 Oct 2020 17:09:34 +0200
From:   Benjamin Valentin <benjamin.valentin@ml-pa.com>
To:     linux-wpan@vger.kernel.org
Cc:     Alexander Aring <aring@mojatatu.com>
Subject: iwpan with LLSEC - attribute type 1 has an invalid length
Message-ID: <20201018170934.2c03c9e3@rechenknecht2k11>
Organization: ML!PA Consulting GmbH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2001:16b8:458d:900:665f:6e86:ead4:af62]
X-ClientProxiedBy: AM6P191CA0082.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::23) To AM0PR01MB5475.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:17a::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rechenknecht2k11 (2001:16b8:458d:900:665f:6e86:ead4:af62) by AM6P191CA0082.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8a::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Sun, 18 Oct 2020 15:09:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e28100c5-580a-4b98-adf9-08d87377d38c
X-MS-TrafficTypeDiagnostic: AM0PR01MB5313:
X-Microsoft-Antispam-PRVS: <AM0PR01MB5313F06BDF77B5093263F96BAD010@AM0PR01MB5313.eurprd01.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BE6Iweay7KT8itaRqe2vYWK0E0C/5E5VK9GUgMn9tcabYOMwY6wRC1gXsZ4yXbjgGhIt2Slom3ljETRNHZ+pYaF0glnEWaBKtTCw0KKDDEilx9fHeVtLavhsRrYLdSYP65uPeLj3IghyiQSM1eKDlJOePP7nW6CpTWoJQoJY5rWDo5YIo+teQSGeJwk628FIUZKq+41hSiCBpUgOPPxAvkKgeYDvBxCTAfeok04AbGaDUYcfwGrFC7akR7kpktd66rGaCjj8u8nWajwafzYTUamcs4sXMkYphKckV0jjWXfCBF16XcWtY/hsiFqzZTXZQbrOJFUJt977S7Zv9a0UuREjSgVGr0XQAEyoRUWcjtYqSDPymPQUTQxLnvByOome+jJ673dX37N1Gan/3IU3iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR01MB5475.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(136003)(39830400003)(376002)(346002)(396003)(366004)(186003)(16526019)(55016002)(52116002)(5660300002)(36916002)(6496006)(9576002)(33716001)(966005)(316002)(8676002)(9686003)(8936002)(83380400001)(1076003)(2906002)(4326008)(83730400002)(478600001)(66556008)(66946007)(66476007)(86362001)(6916009)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 4YocbdKfJVfVmwnm1F0cU1yGRyUS5ZG6DAK2I7SEUJnVJeTVQGa4xe/F+xkmB03c9pVsrB0fjum0V4qDUkTGGtBLx2gwZ0RxDcMbDlbiwvHieWU6b6TIFAx2XsMyzhixaEhHdbmKsfzyNpQ+LS61XMrAU02enRAhMyFd8B5ezMmC9jyJ9ytVyF4xHCFKVud6vXlaIclpkL3Oi8rmagWcXz+1c/VludtjqEieXj/EHpU9L09ZMAyuNEgRXzfEiIXpJxEieEsGH6wrbkIwn8mnBe9t1wYCY8r83JnTioSvIYyt9iWb5A1KbQl4rNybpcw+X1HXgYUYKAVi7ma1bLa+hY7+H4N/Ginx2lzbCCv+4Cb0D+yElJVJVajj/o4C3MXN6i9tEZlTZvTXDVUX4S9DmBiul20lCLe2are320UAtfxSlW/hn4lQHue3bqsyhLnkOHV1eWgv42HfefNHb8ihoulHAVXKycikl+W4EVMxPPqBCFXwZc2QwFOoUixKgIFAa88CSwUHjLilGMA5Ahl6FXqjBb5CsJ2qQ1gkuOD5fCl0a/MGyEpYTXpASdcdbXY0S5Oa8FqFF3tz8KofnVyM9d7PqIrHeQr7F65kNkLakoC7bZEP7m2/XxYorIBIZV3diegPmFcIyAuyMt+kmDCOcB5DyDg15waZgMqHGi6Fvx66rJu4hZH3BeDIbZKuBDap0XrgT/cvPnowad8xS4QutA==
X-OriginatorOrg: ml-pa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28100c5-580a-4b98-adf9-08d87377d38c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR01MB5475.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2020 15:09:36.2108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23090d33-f0df-44f5-9356-137a7bdfe69c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dwqZVuXzDICfCmHP/pLN7vQEtkfcb50Y97Y2IX+Ff2GocJnfENll/QNyIeXmSI/55qqFGdwB73ITD396kizUSMBKMDvPQDR8tMyC5PEQvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR01MB5313
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

I'm trying to use the Linux WPAN stack with link-layer security.
I checked out the nl802154_llsec branch of wpan-tools and enabled the
IEEE802154_NL802154_EXPERIMENTAL config option.

I followed the steps outlined in [0], but configuring the seclevel
would always fail with

> netlink: 'iwpan': attribute type 1 has an invalid length.

in dmesg.
I followed the commands from the GitHub wiki:

KEY="c0:c1:c2:c3:c4:c5:c6:c7:c8:c9:ca:cb:cc:cd:ce:cf"
WPAN=wpan0

PANID=$(iwpan     dev $WPAN info | grep pan_id        | head -1 | awk '{print $2}')
SHORTADDR=$(iwpan dev $WPAN info | grep short_addr    | head -1 | awk '{print $2}')
EXTADDR=$(iwpan   dev $WPAN info | grep extended_addr | head -1 | awk '{print $2}')

iwpan dev $WPAN set security 1 # works fine
iwpan dev --debug $WPAN key add 2 $KEY 0 $PANID 3 $EXTADDR # works fine

-- Debug: Sent Message:
--------------------------   BEGIN NETLINK MESSAGE ---------------------------
  [NETLINK HEADER] 16 octets
    .nlmsg_len = 112
    .type = 24 <0x18>
    .flags = 5 <REQUEST,ACK>
    .seq = 1603033315
    .port = 1971323733
  [GENERIC NETLINK HEADER] 4 octets
    .cmd = 23
    .version = 0
    .unused = 0
  [PAYLOAD] 92 octets
    08 00 03 00 03 00 00 00 54 00 25 00 05 00 02 00 ........T.%.....
    02 00 00 00 14 00 04 00 c0 c1 c2 c3 c4 c5 c6 c7 ................
    c8 c9 ca cb cc cd ce cf 34 00 01 00 28 00 03 00 ........4...(...
    06 00 01 00 23 00 00 00 08 00 02 00 03 00 00 00 ....#...........
    06 00 03 00 00 ab 00 00 0c 00 04 00 8f d7 0c a1 ................
    9c 41 04 92 08 00 01 00 00 00 00 00             .A..........
---------------------------  END NETLINK MESSAGE   ---------------------------
-- Debug: Received Message:
--------------------------   BEGIN NETLINK MESSAGE ---------------------------
  [NETLINK HEADER] 16 octets
    .nlmsg_len = 36
    .type = 2 <ERROR>
    .flags = 256 <ROOT>
    .seq = 1603033315
    .port = 1971323733
  [ERRORMSG] 20 octets
    .error = 0 "Success"
  [ORIGINAL MESSAGE] 16 octets
    .nlmsg_len = 16
    .type = 24 <0x18>
    .flags = 5 <REQUEST,ACK>
    .seq = 1603033315
    .port = 1971323733
---------------------------  END NETLINK MESSAGE   ---------------------------

iwpan --debug dev $WPAN seclevel add 0xff 2 0 # dmesg says attribute type 1 has an invalid length.

-- Debug: Sent Message:
--------------------------   BEGIN NETLINK MESSAGE ---------------------------
  [NETLINK HEADER] 16 octets
    .nlmsg_len = 56
    .type = 24 <0x18>
    .flags = 5 <REQUEST,ACK>
    .seq = 1603033355
    .port = 1535116138
  [GENERIC NETLINK HEADER] 4 octets
    .cmd = 32
    .version = 0
    .unused = 0
  [PAYLOAD] 36 octets
    08 00 03 00 03 00 00 00 1c 00 22 00 08 00 01 00 ..........".....
    ff 00 00 00 08 00 02 00 02 00 00 00 05 00 04 00 ................
    00 00 00 00                                     ....
---------------------------  END NETLINK MESSAGE   ---------------------------
-- Debug: Received Message:
--------------------------   BEGIN NETLINK MESSAGE ---------------------------
  [NETLINK HEADER] 16 octets
    .nlmsg_len = 36
    .type = 2 <ERROR>
    .flags = 256 <ROOT>
    .seq = 1603033355
    .port = 1535116138
  [ERRORMSG] 20 octets
    .error = 0 "Success"
  [ORIGINAL MESSAGE] 16 octets
    .nlmsg_len = 16
    .type = 24 <0x18>
    .flags = 5 <REQUEST,ACK>
    .seq = 1603033355
    .port = 1535116138
---------------------------  END NETLINK MESSAGE ---------------------------

I then continue with

iwpan dev $WPAN device add 0 $PANID $SHORTADDR $EXTADDR 0 0
iwpan dev $WPAN set out_level 0x05
iwpan dev $WPAN set out_key_id 0 $PANID 2 $SHORTADDR 3 $EXTADDR

But I can not receive encrypted frames nor can I send any - instead I get

[  502.970528] ieee802154 phy0 wpan0: encryption failed: -126
[  503.972415] ieee802154 phy0 wpan0: encryption failed: -126

in dmesg.

iwpan dev wpan0 info gives:

Interface wpan0
	ifindex 3
	wpan_dev 0x1
	extended_addr 0x9204419ca10cd78f
	short_addr 0xffff
	pan_id 0x0023
	type node
	max_frame_retries 3
	min_be 3
	max_be 5
	max_csma_backoffs 4
	lbt 0
	ackreq_default 0
	security 1
	out_level 5
	out_key_id
		mode implicit
		pan_id 0x0023
		addr_mode 2
		short_addr 0xffff
	frame_counter 0x00000000

Is LLSEC broken or am I configuring it wrong?

Best,
Benjamin

[0]
https://github.com/linux-wpan/wpan-tools/wiki/Guide:-Contiki-%E2%86%94-Linux,-with-llsec#linuxiwpan-configuration
