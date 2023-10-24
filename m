Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C463C00A8F
	for <linux-wpan@archiver.kernel.org>; Tue, 24 Oct 2023 18:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjJXSfR (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 24 Oct 2023 14:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjJXSfQ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 24 Oct 2023 14:35:16 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF379F
        for <linux-wpan@vger.kernel.org>; Tue, 24 Oct 2023 11:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkLbuq/pft4sh1bEsYEbq071yCxqOtE47vQzoPOs/Njg/GlOFCs2O/p29eco5E/E8L+2ORtGLCROJUQvu8FB1z92Km10U4kLzEXXy4qf0xV90fL4/N41C72TgHY7APFcUwBUg/7bAgVvJcN36ZEuUY8av1FZPHEz0eyHz9TBArmB7b3vyPeTVkvfZUIIGQiqKESZEQyTTLyr4e/6vFjuLgIUKyimVmyNkRH0SH/CF7S5WCsvvB0l846HqK+y7t9ycep2w/6RGxBVevNky8jjyy4VUcXI+tOncF+KR8zHmIC4g9lP8SN4fj3TyaC7j/JBOq6XtGyDW+U3GRZldBQBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hujVzPj/gGIk4lxC5MEAdckS5uG6yCjI2fMoW7xea28=;
 b=cNMuUbL5EHMMOf34GHP3WeUk++3DYHcyypnBKollmRCXfSUVYlaAXY97Pp6GGICwMQNxOozp+Xf3ANda5MJGKNaU9YukWPP3Mia7QjDR0XStQ9Bja8hc6HVWDwwxG7EB/jbtyVMFKICGG5q45t1ZjiGTv3v/PRXokSPnd52GDueXhv7DYIRXg4AHDXx3/JSzQrTSlCYS1d9Yd5thqHZNh+F5JWTsvfcX3vBoX3Fucf9ge2vZUNS9f5Ojkhy8H+6gBbuex2RvOVBUsv63eP5aqxQzEmhdvaCxssKZV0mzyQfhz+7wmrDnAIxO0a9eginf3WljehlR0+7lhzFhjlONRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hujVzPj/gGIk4lxC5MEAdckS5uG6yCjI2fMoW7xea28=;
 b=B6Px0GY/pn4+U7UYRmFU+wqGbU8w8BkdL7Hqd4EpIMuEPN2fUbbFSf3wMZ+npr2s7MZoqSPgPUA1wQDh9nRq5eLkM9B/lbAF9pBvmmv0P8lUUTFtRkfOZOqpL55trOlfoOUAhiRI/NgXm5TYsAH9WdwkAO3NExqYZ/FVrVOWqoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from MN2PR11MB4711.namprd11.prod.outlook.com (2603:10b6:208:24e::13)
 by DM4PR11MB5517.namprd11.prod.outlook.com (2603:10b6:5:388::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 18:35:11 +0000
Received: from MN2PR11MB4711.namprd11.prod.outlook.com
 ([fe80::99a6:2fd5:468d:5dae]) by MN2PR11MB4711.namprd11.prod.outlook.com
 ([fe80::99a6:2fd5:468d:5dae%6]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 18:35:11 +0000
Message-ID: <d25926f8-84bd-4eef-9e44-86fb1e3e5932@silabs.com>
Date:   Tue, 24 Oct 2023 20:35:07 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Cc:     =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
From:   Mathis Marion <mathis.marion@silabs.com>
Subject: RPL lwtunnel encapsulation
To:     linux-wpan@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:122::12) To MN2PR11MB4711.namprd11.prod.outlook.com
 (2603:10b6:208:24e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB4711:EE_|DM4PR11MB5517:EE_
X-MS-Office365-Filtering-Correlation-Id: 8288669b-d725-4ed6-2bb8-08dbd4bff4b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjnqTBJ22H6E00tI+N8M1anPbqmUg4e5zHjkwIfzd3CbyfDOU9i0qJnFjRTx69sHTDuaG9o7k6YjZHAoWmZ1P4rB1tOmqjwreDKFrQkah3VrLobXbcoho6GEsILo13Axmv10jSJKBpym+54Xv4ukytRqbH4wVVcwqCygrpJSvX5KZzlnrdL3uLx9XC8NfUO5HytFFFh9DvnUxvtg7CBs35IvUg2FpVZ97O3M5NZJlzUHG9I8V/3rlcMcxHl9kvfJTmjVQ3eajFN7oQfhvKRji7dqQRz56C0o1xRTNSG1wztjwnF9oXD8Apm3dyQYxp4Sf0EIY0/j3H44ifFvL0QmhxCUY9mGc6QMXQx/l5Pd5dNqlOBgnXY9YZJFVHVyFy2yb0aCDuqBioxUfsWrVlkhJnm5L/w+lHHqEvEMXjTDdOcg/lig5nTUmcEugjvBwnhw6Ek7QE/MB2+38YXRIw+VXgLbhP50VwCLbQqtTFdFN8A020Zo6YP4ApSfRA38jm2HCi2Q2AE4eBfVcfMC5kr7NLiAf5PDCfdOVZpXLI3UDyI09XCAIzR5Aw6zfZECNcO6lCGj6aIyPJMhhknd1+vG8wTMb6kdX23zFHErvIkrcMDRuS3yHlxV9TJyN1P44VMHTiHS1dI5ay0+wwt3f11LGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4711.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39850400004)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(36756003)(86362001)(44832011)(107886003)(31686004)(41300700001)(66476007)(66556008)(66946007)(5660300002)(6916009)(2906002)(316002)(8676002)(8936002)(7116003)(4326008)(31696002)(3480700007)(6486002)(478600001)(6666004)(38100700002)(6506007)(6512007)(2616005)(66574015)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmZ3K3FpMmtCUlg1cy9ENkdCU1JnTEI5eDd6eFdjL1FsYmthbUdNNnFZZW1T?=
 =?utf-8?B?cmo5QVIwYnUzeXArY3ZpalFKYk5TVHB1eVBsZThXREY4VHljcjFsNVd1Zllz?=
 =?utf-8?B?dGxscHdjVnJSeFZRYjdSMWJNcUhqWE9URkZDQUpQL01PblBSZmtWTVZ4SXFP?=
 =?utf-8?B?SE9qY0laWGowVCtlOFR4enIzNVFSNzlFbkpMY3hDMXZVMTN5MjR6QnlYNEhO?=
 =?utf-8?B?OXNEbDgzNjlYZnJ5bGtFQkZlZWRISkpScCtqS3lLZXZBbGdBaVBlZXZ0ZWE0?=
 =?utf-8?B?T1ppSzU1bktlbkNHYXJDZ1JucTMveG0yM1NBdmMzYWRnUUZHcEQvcnZVTGlE?=
 =?utf-8?B?SEhRWEZZOCtvVUNJMUtFRG9JdWRKVEJOU3dsSjRwYnZ0OG1TSzVGSmJUb3Zt?=
 =?utf-8?B?ZWpnM20rcEl4TThlRlVhOFE4WituZU14NDZOc09iY3ZNckcwdlpyTmVOQ0VR?=
 =?utf-8?B?YVFYdks2dW9PaG9ia0pxVUtUOHM2dG1BbDExSXFkVURtR2t3VkpDbEQ2LzZY?=
 =?utf-8?B?aStZdzFHaFVDcTY2dGhxSlpYcVdabUcycWF5dEplVUhzUmVVeHpDbTRMNy93?=
 =?utf-8?B?eWEvRFpUdWVHeS9rYXkrN0lnNHQ4SmlYdHB2QVZnbWcwZy8zMFk2NEhYSFFm?=
 =?utf-8?B?R1l6eENHUzdwRzRUYmRIU0s0NFhTcmNKVWJob3JlZ0h0Vm9TejVIRnFIVVhQ?=
 =?utf-8?B?cWtvN2U1dkhmL1dOeXBCbHYvU01XQVhnUDRrL0U4TjFxWFdTZDVveFBQTEFD?=
 =?utf-8?B?eFRFeGoxVGU3OGRWYWVzMEw0cWNlWG91ZkdlMXN2SUdBVW82eW50N0RmeTJP?=
 =?utf-8?B?YXFGdU1CampZUjMrZVBmME5YaGdYNGMxelVtVkh6R1o3cHFEYm4rN0VqZ2N1?=
 =?utf-8?B?Y2kxWDZFRndUcDE1L21WK1d2M1NIaDk4MFNTNEpOcXg5STA4VVNoNUJQNGdu?=
 =?utf-8?B?Q1NYL2JjVVI3NzZqalRWbUlRbUZMalhtM3FEQWVMbGFCcE5qZkFpOXFDUEJJ?=
 =?utf-8?B?cWd5d3YrbVMyenE1elhraTZqbTBHY2tsMVhpM2hpT1FtWEFFS2tUT0FCNUpi?=
 =?utf-8?B?L2tNV3RBTHVHS1VpQUZiSVZKSXJZOTJDQlBTeWtVNUtJeW5DY0praFllZ2tC?=
 =?utf-8?B?RnZLZVpUVnRqOHM3NmowRW9WcDJpTmRTUHZmV21vOWZJN1JKWnBRNFowT2ps?=
 =?utf-8?B?dG9MOFRMK3pRT09FT2thUk9kNmhaWEYrT0lBa2g2R0VWSlgvZExiNXpNdWhQ?=
 =?utf-8?B?dnpERWdXQkExUzRlTFZ6RVpIWUR3Y0FqeDdxb3FUZExYalc5ZU5ncWlQZnVS?=
 =?utf-8?B?RGhJa25IRGJFc1NTSFFtYVRXdWFPcnkyaXhYczdKZ3d0NnRtcjc2R09NMURD?=
 =?utf-8?B?TWpOSjNPb0c5dXdFWVZGTUltcEJmYjA4UUw1eVZZeGtpbXRzQkRTbU5SL1Fj?=
 =?utf-8?B?RjRzYVZMZkxQWENRUWI0a3FaZHRITVlKV3hPN25UZTk3UUltaVZiZkY0bkV5?=
 =?utf-8?B?c2ZJL2lJWXhOeWc1SE51M09yNlE4ZFdLajlBYVZ5SnNqTXJzQmxKQzdtV2Zw?=
 =?utf-8?B?WUdRVGhWbURnSi9LRkN5c3dyZWpRWEZyNzFKL2k2aFc3UTZ5RG41cFVmMWh3?=
 =?utf-8?B?Tkc1b0Nod2pxWlBJYUgzcUpsYzAxVGl6UnFtMEZhZDQ3bXVJUm1Vb0w5OURq?=
 =?utf-8?B?d2xvLzRUbU1hNG1zS0ZSdUkrQ2RaMmhMdHVDMmxyL1puUnhDWHJaWG92Uk85?=
 =?utf-8?B?TUJwM0x2YnlQck5rMFJ3N3lKb2tjRHY4MWtiUDUwN0VWWDIrQzNzaWZBUnBX?=
 =?utf-8?B?Q3pkUUV3ZkZqVG1DVXVFVi81M3AxekJHOUxZcVNXSkNKNzMwMUFIVHllbjdV?=
 =?utf-8?B?Q09qdFk5cFN6NmdLQStFQ2M3bVBVNDROc3RvRStWbnFUSFhVU2paVk9SUmZx?=
 =?utf-8?B?QVBpQ0VDdFVTMFdBMHZFczdjUmoxeW5LdzhoMHFYbEN3NVlYRWVoVU5wUG83?=
 =?utf-8?B?VkZPMW1raXM4bDZTOGcvcHA4QXZXRmRqaVBSRFI4ZWptUTd2Q0lXVGNFMS9J?=
 =?utf-8?B?KzZMMW1NUFZNajF4N1NBRjdSbjV3K3QvNEdaUmFIU2dwU2hMUUVvMFRvOGp1?=
 =?utf-8?B?UVhKbTZSejFrTEZtOFZiL0p1bXFOdzdmeG5sRit5dEhQcjhlcGRuSk56Z0FO?=
 =?utf-8?Q?wW2MMPwth2QPy3SOzlEueeES5Bph4/rVUtvx77wJoWXh?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8288669b-d725-4ed6-2bb8-08dbd4bff4b0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4711.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 18:35:11.4085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvY4jI8R76bcnRe1sR07boTENR7Jn7Ud2DJXFfC4irrwULkYmIYujCJO6ZolOG9C4Azii9qRaeJ9pJHZkKP5cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5517
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello linux-wpan devs,

I have been experimenting with the RPL SRH support implemented by
Alexander Aring. I hope related questions fit into this mailing list,
otherwise feel free to redirect me elsewhere.

In the original merge commit (96376cad3508) for this feature, the log
indicates that IPv6-in-IPv6 encapsulation is implemented:

     In receive handling I add handling for IPIP encapsulation as RFC6554
     describes it as possible.

However, my observations suggest that it is actually not the case when
forwarding packets. Instead, the IPv6 header of the packet is modified
in a way which violates the IPv6 specification (RFC 8200 section 4):

    Extension headers (except for the Hop-by-Hop Options header) are not
    processed, inserted, or deleted by any node along a packet's delivery
    path, until the packet reaches the node (or each of the set of nodes,
    in the case of multicast) identified in the Destination Address field
    of the IPv6 header.

In the appendix I describe more precisely the steps I took to come to
this conclusion. A couple questions follow from my observations:
- First of all, is my analysis flawed?
- Then, was this behavior implemented knowingly?
- Finally, should it be changed?

########################################################################

Appendix: my experiment

I have 2 TUN devices setup and a couple simple routes to do testing.

     $ ip -6 route
     [...]
     2001:db8::1 dev tun1 proto kernel metric 256 pref medium
     2001:db8::2 dev tun2 proto kernel metric 256 pref medium
     2001:db8::3 dev tun2 metric 1024 pref medium
     2001:db8::4  encap rpl segs 1 [ 2001:db8::3 ] dev tun2 metric 1024 
pref medium
     [...]

I am then generating a packet at tun1, destined to 2001:db8::4, and
observing what goes through both interfaces using tshark.

     $ tshark -i tun1 -i tun2 -V
     Capturing on 'tun1' and 'tun2'
     Frame 1: 48 bytes on wire (384 bits), 48 bytes captured (384 bits) 
on interface tun1, id 0
     [...]
     Internet Protocol Version 6, Src: 2001:db8::1, Dst: 2001:db8::4
         0110 .... = Version: 6
         .... 0000 0000 .... .... .... .... .... = Traffic Class: 0x00 
(DSCP: CS0, ECN: Not-ECT)
             .... 0000 00.. .... .... .... .... .... = Differentiated 
Services Codepoint: Default (0)
             .... .... ..00 .... .... .... .... .... = Explicit 
Congestion Notification: Not ECN-Capable Transport (0)
         .... .... .... 0000 0000 0000 0000 0000 = Flow Label: 0x00000
         Payload Length: 8
         Next Header: UDP (17)
         Hop Limit: 255
         Source Address: 2001:db8::1
         Destination Address: 2001:db8::4
     User Datagram Protocol, Src Port: 5000, Dst Port: 5000
         Source Port: 5000
         Destination Port: 5000
         Length: 8
         Checksum: 0x7d57 [unverified]
         [Checksum Status: Unverified]
         [Stream index: 0]

     Frame 2: 64 bytes on wire (512 bits), 64 bytes captured (512 bits) 
on interface tun2, id 1
     [...]
     Internet Protocol Version 6, Src: 2001:db8::1, Dst: 2001:db8::3
         0110 .... = Version: 6
         .... 0000 0000 .... .... .... .... .... = Traffic Class: 0x00 
(DSCP: CS0, ECN: Not-ECT)
             .... 0000 00.. .... .... .... .... .... = Differentiated 
Services Codepoint: Default (0)
             .... .... ..00 .... .... .... .... .... = Explicit 
Congestion Notification: Not ECN-Capable Transport (0)
         .... .... .... 0000 0000 0000 0000 0000 = Flow Label: 0x00000
         Payload Length: 24
         Next Header: Routing Header for IPv6 (43)
         Hop Limit: 254
         Source Address: 2001:db8::1
         Destination Address: 2001:db8::3
         Routing Header for IPv6 (RPL Source Route)
             Next Header: UDP (17)
             Length: 1
             [Length: 16 bytes]
             Type: RPL Source Route (3)
             Segments Left: 1
             1111 .... .... .... .... .... .... .... = Compressed 
Internal Octets (CmprI): 15
             .... 1111 .... .... .... .... .... .... = Compressed Final 
Octets (CmprE): 15
             .... .... 0111 .... .... .... .... .... = Padding Bytes: 7
             .... .... .... 0000 0000 0000 0000 0000 = Reserved: 0
             [Total Address Count: 1]
             Address: 04
             [Address[1]: 2001:db8::4]
     User Datagram Protocol, Src Port: 5000, Dst Port: 5000
         Source Port: 5000
         Destination Port: 5000
         Length: 8
         Checksum: 0x7d57 [unverified]
         [Checksum Status: Unverified]
         [Stream index: 0]

We can then see that the original packet header was modified, with
destination address changed, and a routing extension header added. If
IPv6-in-IPv6 encapsulation was at play, the original header would have
been copied unchanged (except the hop limit I suppose), and an
additional IPv6 header accompanied with the SRH would have been added as
an outer header.
