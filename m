Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBAD3B7B7D;
	Sun, 20 Sep 2026 02:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871454; cv=fail; b=qH8RDixXSDhgUrBDxtOq6zG/vsc1RjvBsqoC+4FcHNGHP8HYL7fh4mI8ob8Gy/k/6gPdanwurqgr0kB9WANTDMr8f1xZjXLFzBNt2YFXv7UPt9iI6IEx5+TV5WIi44j5RZVcgY/tDyx1Yu2ciOcTsv3kpA8rKmUtIuzUZy1vc10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871454; c=relaxed/simple;
	bh=SP3w/7Vp3NhbCGDo5ucP79H2mzyycyNuotOUw2gZQCw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DtIOdYwAW+gTCgQE8LXuAeCVRfk1UESQ0/kxRF4LHDRg+Vn1AAMcWObAUeE5M9iOlnOLpHSQedAr1e5FkJ/D+EWG8hRNnWO9whSNOrJBzfNSdMckh/rPM9GZVFcfKyear6EMPK3X7hNGhh1/0toDjbJps5SPp13uyno0ZU6W7r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xUqoahPh; arc=fail smtp.client-ip=52.101.72.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xUqoahPh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxcA9nrwVTGt6Qik5JNT3xkPAA4sKEevzFDUtfXh7HuovmGMHvjh8BFx2WwcAUEyFfVcNy5+T1+wJIqF83OawbyA0QC7YvTGsrXyuOoUPa738irso21v0LSfnfvkkMJ6cxQRfxxYb0L7FKbj+YB3oNoLQb11k2De4EQwGvF11OpfumDMvAaYklxIKOkDxje0AJul7muc/md6ZerId8DO2Sz82kcAlPnTBP5iVI8j7zR7CRDzudCJyxp6YdC5SNg3mSe0HUG6OajbAwVWdufKNizbEf2/1f1bSt29Ys47xU5G/IxDXOn9uBt82t7A/OpUauLZgIZa2ZbcVOy34s9K8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFskB9uxYH0/IoqRfn5UwlZlU/SB+jcOdlfemlMQzgU=;
 b=FGgL48ExWwroQe0dRX1TT/y18F3JTuxVGBrwd+eC8eulm9tgmFnc/VBJ6/Gg6q5wz+811ZNX6QhKWTdjdaZDHlQvbCyIo01fEQEKBRJNHeJd9lAYB8mtXWrmCj/p50wC8e59M1JxchLgvB5JfYJLvxxwwV92h463zb4YSJEqaPgzXWaXXAFz0OraqikxangDByvQDTpFJXS5wnoWPtgGUmDYdJLQXO5l1jTNXJmblmcCVlaedO8WbdAkTXLhYGzEClH5hT/Zix0BXfkb6sOYoPLyGmZ0yX2vLp1gvvcEhnmhFCmlxhOB5VJJv1q2OcG6AWQxzdR0gNqyhyOogjypXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFskB9uxYH0/IoqRfn5UwlZlU/SB+jcOdlfemlMQzgU=;
 b=xUqoahPhPlMSJ0LFR3wpZ2ub3hLwJb323M2I2Rbt3Mvm0IYE5n/gPBWxWvDErzsnYOTUc/RevnZR6KqTrx/ZhpU7kII9l5YS+NKH50JSDBWNrvCJFHnRaa2mD0wg+7YWrZNnhOF9RTD6RPCBkxcOQ2635wLQ3jC4Xsf2wkj4mSWnK/2hjdHQ9W9bzDPpkqEmN3tg1xVd/La4wkuS6INiCtmd7ho43RX3rRpRZOHMZe70eeyOHJ9dfah8EwUq+4wfYYWms+5lvaBkeqdGZN8A1oj7VsbPMCRvxSkwLzq0u0VrD6P6x86cnXLC7KFS6WLVyXopn7EGzVGYSBRpdMhOnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB9596.eurprd04.prod.outlook.com (2603:10a6:102:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sun, 20 Sep
 2026 02:30:16 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.014; Sun, 20 Sep 2026
 02:30:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Alexander Aring <alex.aring@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	Martin Schiller <ms@dev.tdt.de>
Cc: linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	linux-bluetooth@vger.kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-x25@vger.kernel.org
Subject: [PATCH] net: protocol: use assign_bit() where applicable
Date: Sun, 20 Sep 2026 10:27:44 +0800
Message-ID: <20260920022745.3145847-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB9596:EE_
X-MS-Office365-Filtering-Correlation-Id: df50fb30-989a-4314-a81e-08df16bf1b20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|19092799006|366016|921020|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	7eTIxiONogXszFKJL3vRfDAJD9RWOfaDSuf/DxGYl0U+J1gqe2QPxYz/Qd6eRymP9ZJtUHCVhf/0A3fLublO9qVsf0BDgopAu8D69a5tNzl/g5CQLj7GiL1uFdrxsErFx63iF1FQmxHrp4lo+Y8Ypo6bMHYVbf5NL0rMBqjUPD/wziKsI/zyc4DYSVfUOBcttbJf5QggCTafCtESTE9KQ27Gt7imEO8LefeQ1Jh++d9elTJssPsjnfWZntZJ5HuA33VW+Ueyx4N5aij7TuPcQADYqUSWUOkgFHmVvZ/juQGmi0C6lhAy3xH666HVYwZlOPd1752UV1gWlDHM7QgGq6IYvvUr/rQ3hnuQDN35wl5QfWjCkD9t310r5fnk/62ZGx0ha1Fon/LClrO5mpWCknuCdQHsQtxZVnL0o6aCru8PnJLDuy9a6fWLryw5MbzPh9ToWWyAQL1Mn1/uzwvv3AQc/5eQ5+yPaCPrimRWzgCA2HUiZOSPJj8tNtGCuNxrIzlkwWJeLB8bqQgGOk37sYbzD+UA76SyhgI6WeVAYmI1/l+qyD91VqOIxIPLImwMI8avYKCp4i7JHqGs96IAOsqOtP6V0ICcQizsQyviNth4xH+57xpyAYt1wZ8ly01BhaIEYrPFCIjDLBT32nVNsIZTkteBU9nLQpRkcOkle66QQ6Gz3x6YakTW+Rhl6xfcf7T/m9A/uDrXY/6cG4Upbw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(19092799006)(366016)(921020)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jhh37yoe4+/0KE6q99/8/umLlttSIjhLCJMtE5iTsOhTxh/k3HZjvqrB+Vqz?=
 =?us-ascii?Q?ZXkcSYE26Cs5xNwCKIuttZvYmylMVENwVirrWiB8AeZ+NhjEVEEfKutCdJ24?=
 =?us-ascii?Q?5FE8fxkj4mkaRoEyjLx+BVnPogCeQvZinnSsk2DB+3AJYOtpa+yVXVFLHteX?=
 =?us-ascii?Q?Hx9/JAZbY4b87ED0Z8W3DJlY72h2d8PFniYykRncG6kX6VI3DIm8jlggZ8eA?=
 =?us-ascii?Q?5yj6+Vh9aepSmaoU3HolQ/Qdp6kagS2OtfUr9Eu7ylDJS0TU6v6OHNGomOiO?=
 =?us-ascii?Q?7oi6ncUjznmtWKcL3LDdhIgJUfR5FUtkP6vlNxnCPQqJo9G9Mbeo01I+ieoQ?=
 =?us-ascii?Q?gHTrVmAH9oOgaeGMlvMrLMHc+yg01dlTw7qT1cz0uicrQ592bmL9VqgsggOf?=
 =?us-ascii?Q?NCe2mZRbey3DFeLZVDlc6BJT4D6frp3Nzv8LVF4oP45dCq0D7ZsYLriXbBva?=
 =?us-ascii?Q?Tttb6dvjhReebyk/hIvgxxnI9QaI3xv+jc/dTrtk27sL0uRCg8AvYkb8hRod?=
 =?us-ascii?Q?WvKbxczoic7Klq8h73QmeB1gYUZvIEyxqQvvYb+XejZKzMqZHe8NS2IXp/WL?=
 =?us-ascii?Q?Th8Add5aqD4r1T7t6dKDHKk5tDaOqpzwps6xGVJe7RViZZ49yaylZlyUbeWa?=
 =?us-ascii?Q?Ina+psdQE4QVziIbNkgsbQBRwoAlN/5HJ+7tDLxGRPBv2gqKG9wmR+CU0ySo?=
 =?us-ascii?Q?Rwj5lM75vfctiBRCzXXTrb7tmgVXz/LzaXrLEKbuiPtLaSUJU5OtFiVpnbWe?=
 =?us-ascii?Q?EKN5RjOGQZw15h8j5OMgVcvF7AnwE7KEl2c2anLjix/krYv3tHkZ86M/lCFD?=
 =?us-ascii?Q?t//a68QgpkXWl7SQyTf68xD0n+/gq/7PQiyL51uC5aIp2RJciergC9bQhhG0?=
 =?us-ascii?Q?iRkP7jlHPtXG5TJuWvXE75+RSNsfMZ5w6e3UlbssEK25JSWuizQuXWKlXjhk?=
 =?us-ascii?Q?88dCWR+deAnpHwJHp5X6FHnbcHBaz2X+2bx4nwa564MLXk1HNTJyM1eVlhB4?=
 =?us-ascii?Q?AIEOl1aFqk+AESRhtHgDYEYPdi0KND5MxXBgUIa13p593rcAqZ5vdYCr4DvP?=
 =?us-ascii?Q?UQrwl2XenJwBsyTowVld0cfTFPcH6czsWjsH8Sx2D9ksQWu7F5SZaaNw3o+4?=
 =?us-ascii?Q?f2yHSjIthfZs8HcejXpxPty+JQEq24/3qvcpxZzHqy2v98j+D51MGMykiyyv?=
 =?us-ascii?Q?tlwUROv+ciXz9eEIpordgb416zcMRrhH8QbD80nvetwcIPKUS1dOVQr+YwPT?=
 =?us-ascii?Q?Tx5uER34eTXNvRt68dbx54LUB5ORINdQYKQcI1psBB0UEqlCR7nDc87oSF36?=
 =?us-ascii?Q?OCd8DUygay7zYv+ZuJtoevVPIvMt7M4JMOUXves4qcdkLM+b4VK8QuX9tLdF?=
 =?us-ascii?Q?UdXM/taXzKkPBYRLOYTwaswKTwImxk8z1PR6vGdH4vg3q2yyifn7fgGbSmo/?=
 =?us-ascii?Q?wB+PEeMLBlFxAd9Mr86WVQnYIlJvupHa6JSkX2JgG4QTh1o2T3WFomIWPDNk?=
 =?us-ascii?Q?OhYBKAYSYMeFMblmNBSN72+4QBrvJDExf+bT1k2Ya2EPgwnCTWiUBFTPMLqa?=
 =?us-ascii?Q?sppGSSxLUY7PHdGDceQUUfxBhvGj9s5naLwHbqj7z8zXwN/jpTw8onFteqbc?=
 =?us-ascii?Q?lqLBpwoWooRaoIY2n/IM9XQV8Kg8KFmf3ODEPgIhZLLZo83NkG3/XuvX6OGL?=
 =?us-ascii?Q?bBPT5+k4h5aO6ZCuG2UVgmkHc5sZD5sqjZtKJJ+aaVSdBGF8QFg8cxI7j4m+?=
 =?us-ascii?Q?lCy3ZkRlBz852EpT/wDvPPcIHoFfW0MomA4ttODKMvFY+tnQPrlc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df50fb30-989a-4314-a81e-08df16bf1b20
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 02:30:16.2081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbt60i/Wizpjd2WpIhump/HqgasGAdVQxxVkAPJsuQd5adkKRU5BNpbgmkFwdzadmoODZ/gvTmTsXyo5muW3VZAKOA6uWFRYhtKVF6MNt0IlgJisXdM3UT3uaExX7hEv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9596

From: Peng Fan <peng.fan@nxp.com>

Convert open-coded if/else with set_bit/clear_bit and their
non-atomic __set_bit/__clear_bit variants to the assign_bit/__assign_bit
API. Where a bit is toggled based on its own value, use change_bit()
instead.

Done with Coccinelle semantic patch:
    // set_bit -> clear_bit => assign_bit

    @@
    expression cond, bit, addr;
    @@

    -if (cond)
    -        set_bit(bit, addr);
    -else
    -        clear_bit(bit, addr);
    +assign_bit(bit, addr, cond);

    // clear_bit -> set_bit => assign_bit

    @@
    expression cond, bit, addr;
    @@

    -if (cond)
    -        clear_bit(bit, addr);
    -else
    -        set_bit(bit, addr);
    +assign_bit(bit, addr, !cond);

    // __set_bit -> __clear_bit => __assign_bit

    @@
    expression cond, bit, addr;
    @@

    -if (cond)
    -        __set_bit(bit, addr);
    -else
    -        __clear_bit(bit, addr);
    +__assign_bit(bit, addr, cond);

    // __clear_bit -> __set_bit => __assign_bit

    @@
    expression cond, bit, addr;
    @@

    -if (cond)
    -        __clear_bit(bit, addr);
    -else
    -        __set_bit(bit, addr);
    +__assign_bit(bit, addr, !cond);

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 net/6lowpan/debugfs.c    | 10 ++--------
 net/bridge/br.c          |  5 +----
 net/bridge/br_sysfs_if.c | 10 ++--------
 net/dsa/tag_ksz.c        |  5 +----
 net/ncsi/ncsi-rsp.c      | 10 ++--------
 net/x25/af_x25.c         |  5 +----
 6 files changed, 9 insertions(+), 36 deletions(-)

diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
index 600b9563bfc5..d959b132c067 100644
--- a/net/6lowpan/debugfs.c
+++ b/net/6lowpan/debugfs.c
@@ -21,10 +21,7 @@ static int lowpan_ctx_flag_active_set(void *data, u64 val)
 	if (val != 0 && val != 1)
 		return -EINVAL;
 
-	if (val)
-		set_bit(LOWPAN_IPHC_CTX_FLAG_ACTIVE, &ctx->flags);
-	else
-		clear_bit(LOWPAN_IPHC_CTX_FLAG_ACTIVE, &ctx->flags);
+	assign_bit(LOWPAN_IPHC_CTX_FLAG_ACTIVE, &ctx->flags, val);
 
 	return 0;
 }
@@ -46,10 +43,7 @@ static int lowpan_ctx_flag_c_set(void *data, u64 val)
 	if (val != 0 && val != 1)
 		return -EINVAL;
 
-	if (val)
-		set_bit(LOWPAN_IPHC_CTX_FLAG_COMPRESSION, &ctx->flags);
-	else
-		clear_bit(LOWPAN_IPHC_CTX_FLAG_COMPRESSION, &ctx->flags);
+	assign_bit(LOWPAN_IPHC_CTX_FLAG_COMPRESSION, &ctx->flags, val);
 
 	return 0;
 }
diff --git a/net/bridge/br.c b/net/bridge/br.c
index a5e5b2db110e..09a120b3b76c 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -396,10 +396,7 @@ void br_opt_toggle(struct net_bridge *br, enum net_bridge_opts opt, bool on)
 	if (cur == on)
 		return;
 
-	if (on)
-		set_bit(opt, &br->options);
-	else
-		clear_bit(opt, &br->options);
+	assign_bit(opt, &br->options, on);
 }
 
 static void __net_exit br_net_exit_rtnl(struct net *net,
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index bde731c01e10..b9bcafa7f034 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -64,10 +64,7 @@ static int store_flag(struct net_bridge_port *p, unsigned long v,
 	int err;
 
 	oflags = flags;
-	if (v)
-		__set_bit(bitnr, &flags);
-	else
-		__clear_bit(bitnr, &flags);
+	__assign_bit(bitnr, &flags, v);
 
 	if (flags == oflags)
 		return 0;
@@ -77,10 +74,7 @@ static int store_flag(struct net_bridge_port *p, unsigned long v,
 		netdev_err(p->dev, "%s\n", extack._msg);
 		return err;
 	}
-	if (v)
-		set_bit(bitnr, &p->flags);
-	else
-		clear_bit(bitnr, &p->flags);
+	assign_bit(bitnr, &p->flags, v);
 	br_port_flags_change(p, BIT(bitnr));
 	return 0;
 }
diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index b4d70ba930dc..b0340a7be8c9 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -41,10 +41,7 @@ static void ksz_hwtstamp_set_state(struct dsa_switch *ds, bool on)
 {
 	struct ksz_tagger_private *priv = ksz_tagger_private(ds);
 
-	if (on)
-		set_bit(KSZ_HWTS_EN, &priv->state);
-	else
-		clear_bit(KSZ_HWTS_EN, &priv->state);
+	assign_bit(KSZ_HWTS_EN, &priv->state, on);
 }
 
 static void ksz_disconnect(struct dsa_switch *ds)
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index fbd84bc8026a..9c91872a2921 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -884,10 +884,7 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
 	spin_lock_irqsave(&nc->lock, flags);
 	bitmap = &ncmf->bitmap;
 	for (i = 0; i < rsp->mac_cnt; i++, pdata += 6) {
-		if (!(enable & (0x1 << i)))
-			clear_bit(i, bitmap);
-		else
-			set_bit(i, bitmap);
+		assign_bit(i, bitmap, enable & (0x1 << i));
 
 		memcpy(&ncmf->addrs[i * ETH_ALEN], pdata, ETH_ALEN);
 	}
@@ -899,10 +896,7 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
 	bitmap = &ncvf->bitmap;
 	spin_lock_irqsave(&nc->lock, flags);
 	for (i = 0; i < rsp->vlan_cnt; i++, pdata += 2) {
-		if (!(enable & (0x1 << i)))
-			clear_bit(i, bitmap);
-		else
-			set_bit(i, bitmap);
+		assign_bit(i, bitmap, enable & (0x1 << i));
 
 		ncvf->vids[i] = ntohs(*(__be16 *)pdata);
 	}
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 033e7d059f58..f45c9ec7d2c6 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -439,10 +439,7 @@ static int x25_setsockopt(struct socket *sock, int level, int optname,
 	if (copy_from_sockptr(&opt, optval, sizeof(int)))
 		goto out;
 
-	if (opt)
-		set_bit(X25_Q_BIT_FLAG, &x25_sk(sk)->flags);
-	else
-		clear_bit(X25_Q_BIT_FLAG, &x25_sk(sk)->flags);
+	assign_bit(X25_Q_BIT_FLAG, &x25_sk(sk)->flags, opt);
 	rc = 0;
 out:
 	return rc;
-- 
2.51.0

