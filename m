Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010023.outbound.protection.outlook.com [52.101.128.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D64B16F0CB;
	Fri, 30 Aug 2024 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005662; cv=fail; b=mRmEd0FBnDH2ccylaAZxyj6iMs3nOSfNfuYrm8dkdk1ERP+IsaC8QbOoR7f6vtWLmAc6pvTXooRhSNGbhrSpVXdSNUyjlgBfzPyYAs6LznAuqYNxKTUvM+ImNON3UUNn96CY7nSW41NofcGQzQAbKDQC2EUhYc0Q6h9jj/IW08E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005662; c=relaxed/simple;
	bh=rO7yoG7Gu2ulLfmZWZlzKGZPpzIYKu7WPdA/YTwk684=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MOUG0/XTOXrP8XShG+63zq5xN1ajCxPF0EzX+ckIUvXoCeDaqebqDFS5H+ewccvB9MxfgCPpe/dryi9AgMF6E0bDkJwdDcwhLtDMAt2jvnjhV8ucxmZ1indPAlj7/kURQ7PWcTg+vgtEgcd/R9lzr1JwvE+mYzNgimTnKcvXZjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KfmXG3MY; arc=fail smtp.client-ip=52.101.128.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KfmXG3MY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZC/OwINud7hovWj7beL1f6vU0l5D1X+oVBstj2NknyhlaSRZxM1ASfJ+ax8NrDpz+Rh3t7F2NF5Twhuo2sJEzErSHn3OENt6oH4CaAyjgsnFArZ6XcMaQDsyjVqE9bSxLj54GbTD/5KnhV+TFrUm8aHwYtgte2banbWovl/dO9ALkMGogf7OdX04kMBaB4BO/fAMCc+MRxvieOI28OscHQrOfTv7w6+G/vJXo/zJCd1KoTXTxkHdqcK4xKh3KjvbYEgK4NpYKGJ/DarkDNqI+UOR8PYByHxfgHskfs49ULOQR4Q9gAXr+UcoKnqnFJDeeg4kPypo1uk5TGmmQDT+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5p7r5OZlit5ZYM5I0QlsM9r6LgDxjGt8cS/wBn3pUg=;
 b=e9CSPZdRjBpr7jJ6FymGj+Ce41aw16nkWpIq7CJNb+kafowT2ey2tPtjpn2uCcP+sFddx8SJ0WgiKcJgYLO7qjRGaEzg5pehnqhPT3rk++RpcpRqJrN5qhvaYhTS1epZezryp5Xh2I5sVFNNfbWKxe5WZq0XQCqyDuXon9phyaD8dA4F6w9mtv6vHNRseXh28ArzWrJ8/I5mNaGZYgA0RZ/VWN0cjwaHbVeDypwMic/96rpQNO7uK6kh/qeKXTdL0NbysgU3wAKDkU8hdEETzOkIdTrW1zhR7I5xJ9CgoDbNPcQDkB8CzwjqLmbf4jKPxBYGxRY8Fy1VHS9B6frK4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5p7r5OZlit5ZYM5I0QlsM9r6LgDxjGt8cS/wBn3pUg=;
 b=KfmXG3MYMvhNbmvzTou2HdFoYMOzhFeBzvVz9pZtxgY0cyXaGZyNDJQB234bJl4eiS7T6YjIphGI45qzRD+ok/s9TjxAHtcGakQzao39hn0MeKZwMnFbKFzwTqfZkeggLg5nMH0qLzJFCZAN3A3Zw0D89TGGnu2RuPfJTXWv+40r7jrOP34FSrZVoJR9PZHAU2+prgda4oUX2DdO44p9TXclDqF5mkki60qGVVMnuB89ceL54pC/S7pWX8KjaaIV34lk77qYJNtbgi70V9PDYt5L+4Mdse29ggZQHzg4VfrtsCF3lGkiyeSRcjQZFbmuZlSERIkdzYS4HmnKeLP6Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by SEYPR06MB5037.apcprd06.prod.outlook.com (2603:1096:101:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 08:14:14 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 08:14:14 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] ieee802154: at86rf230: Simplify with dev_err_probe()
Date: Fri, 30 Aug 2024 16:14:02 +0800
Message-Id: <20240830081402.21716-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|SEYPR06MB5037:EE_
X-MS-Office365-Filtering-Correlation-Id: 25448646-e3dd-4b0d-8f68-08dcc8cbbc17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dbXk0laLkAozCPqd1mE2gyfEitznc22uWEUZ6us+7mz/NnSWhdMGSVNHa0f6?=
 =?us-ascii?Q?gnX3jBxifSdploG/R5CJC5YjnqAqqOJ1PPh3abX9FZ60+E5MCvK9iex7Ft0K?=
 =?us-ascii?Q?+9Vr/I/W9vDPU3mh+s4iFVsFEyj6tnxfpUC0bTQwhfTWnfw6Y956Jq+rq/4Q?=
 =?us-ascii?Q?nx/b+WP01x3w/KK11V5soaQCtEkZ23mMmK2MypsE3iCQArskGEne+6+fEjyW?=
 =?us-ascii?Q?arYEq6t/TtvP8Vf7f3mAGG7ffxIag1f7zE+caBc3zXnStSdoBabSNgnmhBF8?=
 =?us-ascii?Q?v3AFZfrzXCCDqkPwCJ1devmjpIg4I8t+coZkPSMbQTihQeTUzkg/sL7nbFPS?=
 =?us-ascii?Q?1dldAKVOEnlP9cpi/BkBcF5QHNQ7lpzSKXa2jQGj0dOVhcJgpNjmNPrVlIuB?=
 =?us-ascii?Q?1XN410VGFoSTzX+idSOtavhX8oSfClzr4ef8hUlhoM4ZM7taXok7QMFSdayV?=
 =?us-ascii?Q?9x6xpveC502/SFZYbPs0ttqsAgintwl0RH6+WYzLFoSlH0ccSDWadIP7RJAU?=
 =?us-ascii?Q?fj9VNpitss7gaFvYWIeGI8U/YmiHI7/9JjPd/ZKraQdTkk2mkmWqtJDerP1y?=
 =?us-ascii?Q?uce+lxrHXYCHhQ/fk5KMut9qBhtqS65B1q5xZ+D+Jq92GFDbNwuEcyHsqGlB?=
 =?us-ascii?Q?uzLMtCxEOVP0U7YbV8+he0897Up7ewIxbNcCgr59vIWBlPke8Y0PR9W8CnqY?=
 =?us-ascii?Q?ss6jh46Di7vLDZ2Df0HOAT8jei8O5vaP6NGjOiTzMUIaRHQbmycCP/9qqpyp?=
 =?us-ascii?Q?8w50jn/T+dIyDqAdaaZqfflmxg0vFy5caWrswF1TKq/a39RTAJgz0lSsenM2?=
 =?us-ascii?Q?oFsVl1y1Ka8IAiiiGvfpltinu+BHyCH/BhA+VA2fIEryg5ybNPTA2XSdRBMX?=
 =?us-ascii?Q?i6yY6Rbl1isXOYDOTt0Sw8B5IoUdLILYqisKZ5758PCJ0nkeq5emgv4jkBhO?=
 =?us-ascii?Q?9K4OPsHczlVpHobKjMYpwo48i/Lp/el0MhrbWPJjVFg/IC1ehYHtKZY0ShxE?=
 =?us-ascii?Q?H2V5EjpR1KPhLa6sCpMQC4bKV0FlTQWGQe15PQgOXEXwygMnXaSScIpj9/um?=
 =?us-ascii?Q?GufTO/nL/GDPkAx9gk83ledYRNEJfJoIEjZuJtYOu5irgTdhNxkk/q2rYgw+?=
 =?us-ascii?Q?zlXlLX4FgbTGhKLSlyvjb8uaz3i2AYHKbeU3KgSD6EAilBCWHWRi3ILLtWF9?=
 =?us-ascii?Q?8rjFkB90+TZ9gS7lZp9cMPOl558Kd0OgJpXPEBBaSdoj5ynrtiy96Ai3+Fi9?=
 =?us-ascii?Q?TZho7/lE3rUSXKBK1U27Oh4qWp1LLXhux2oUumFlIqMIaS3oDqu7n6Fot5id?=
 =?us-ascii?Q?v1XF3we1E8IJ6LWbgyOEX/KvAOlUU3Ic0Uji6Lfx+6BiFc6SsrcJQtYIiIjL?=
 =?us-ascii?Q?HfuI8SLEK9iA7fkc9e0LalXWrJX2UNmz/0C/k3Z21DI9goIemQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wrax/UEk/TEwnyj/3buXl1dU3X4YU6Do5pOMW2bkhba7JWR1Rb2CPFkHUXxp?=
 =?us-ascii?Q?60e32NlSKyNmQ/qDBUKlxFaL30R3wOzGHTEp4g1J/A0JXBnYAUkqf5dLXMrD?=
 =?us-ascii?Q?mQ0wYXqv85VLNPYG+IfzwrEV1jL29fIHBKB+N+Oc3gRh+JsGUK/bVA+4H6ln?=
 =?us-ascii?Q?fBfAjwXAym4EjFZOt2ftE7ixcSwlnu4PHKwvtJCufWL0QUA5tRJncxcUUTo8?=
 =?us-ascii?Q?AUfYf2Yai7Uy6dSRFQHij0UZuCEejb4xC5HKFVdMxs6lbena8AVuux82/AXq?=
 =?us-ascii?Q?vFwFIhdk9fB1KPClld5L1YkzZDNY+CGcHDJV1gDpJXExTZz/OQa7RjmFyyxm?=
 =?us-ascii?Q?vcG+GZiyr6tjfJDd9FmgiWb6r1yXSzLN37uX+UBx81cnspiPNUocXe36c89/?=
 =?us-ascii?Q?pKa/UOYe9MJLg2C2p8cTSRkHY5xUND8LPXgZeYPWxo6YHrZ3KDuA2k803kVN?=
 =?us-ascii?Q?uUW8rsOEGSwh8TbNlpMquA9I76Pmi/F8JmjRRidmZlo7xPQwXcwDHie36JqN?=
 =?us-ascii?Q?hpEjStBr3w+R4jvteel7PkKddWxLUAUgE72L8fRqo/fPCBztuWLvcFxEbyxg?=
 =?us-ascii?Q?hL4xBgQkOMI+FUGHWRNMSqGmo2c9CqwawOC7zHwzLOZ57ZEWfRO/PFpVe+q1?=
 =?us-ascii?Q?V40Q1VwP5Y1aGJIvQoAaPmSUrdXmn6sCZxh0E//Q9knxUcKEtqmQYjQPSXDF?=
 =?us-ascii?Q?ORoOTtUMVKAx57D+OPdmofDbR/wkP5eB1vjfMjm1qWtkuaZx93Hj+4SDEAWz?=
 =?us-ascii?Q?e1FhInHbOQtKlx51X8kbjjW5c4x3rTzgZnW7KGG7je7C1hkEMw5SwjCfNEJr?=
 =?us-ascii?Q?DdVb8xK0xP+80bVyFNIpCqjZMduQyoR2AQloOjn4yuvj2mEZcre4e1vtmRFs?=
 =?us-ascii?Q?dEajt4uhr4ilU0AAHOEq5PAAW34EkP8kd1PwGFWiTbmJRIQ2YIJOG+2R3b8c?=
 =?us-ascii?Q?1j/+3IuHQfcrqTtd95YSlmpIDc2QF9B9tpmeFXSU8E+XtA0RwYsF+aVQbZ7+?=
 =?us-ascii?Q?9lWmhzthfyvpH7b3gofBjlzM/9nJ6OpSQW4jNZfh6lBqMC8uYHcGZ6nUk6Tn?=
 =?us-ascii?Q?Q/9eYfUbaIY2XUUUDC7P78nJ9Hi4Y9Ay5OadHgwGiyOBkWqjjKLzjFdrFInr?=
 =?us-ascii?Q?+dKhupRx5oaN86biFHrNGw21hRFpRg9xthh9MOIgduJYJrlCt82JpKMDkUmY?=
 =?us-ascii?Q?bCPEukAr4ULfJ0Y4xeA6iTzXgIa2z3LyR1B/74yP18QGYvgp+RhX9rYG0TsS?=
 =?us-ascii?Q?mK9BR5JXBZ25gUH3ub5SZpwdzH9fBKsGkhX9skX6zjTwXf7HVfqv9mvmVzoJ?=
 =?us-ascii?Q?HYiC/fj8QrOZf+bmv09MndquMTT6xINHQB4YUzMfwTXpvDubnud47SF/QTJh?=
 =?us-ascii?Q?zBDKjbNjyp5/H6P/Dlwc0FYxUi4Twf+A3Z2orbj8NHwu8KWbufL+n0F+tlKB?=
 =?us-ascii?Q?+LkAQu/EWoZk3Zi/DjTjwIG2xon9k4ai4SecSjMh9ryvS74TmFxIU35lIAyD?=
 =?us-ascii?Q?FWMbzPCi3mzmTRE9/65Asuy3fArUsJI2DhVOnrCJr4kcDAlvYF8xn1KVei1V?=
 =?us-ascii?Q?yQwImLOMJknLwVWudU8IVt5n6fD3Gtw/kcqJ4Ie3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25448646-e3dd-4b0d-8f68-08dcc8cbbc17
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 08:14:14.1091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYx5nX1gzRguF2p4DHiMSSpSs0emfgf67QR2MmCE1afxd30jJz6vUjG4utvSEJT/BofNs/LHgU9Vgpv79gDgpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5037

Use dev_err_probe() to simplify the error path and unify a message
template.

Using this helper is totally fine even if err is known to never
be -EPROBE_DEFER.

The benefit compared to a normal dev_err() is the standardized format
of the error code, it being emitted symbolically and the fact that
the error code is returned which allows more compact error paths.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/net/ieee802154/at86rf230.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index f632b0cfd5ae..3fb536734034 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1532,11 +1532,9 @@ static int at86rf230_probe(struct spi_device *spi)
 
 	rc = device_property_read_u8(&spi->dev, "xtal-trim", &xtal_trim);
 	if (rc < 0) {
-		if (rc != -EINVAL) {
-			dev_err(&spi->dev,
-				"failed to parse xtal-trim: %d\n", rc);
-			return rc;
-		}
+		if (rc != -EINVAL)
+			return dev_err_probe(&spi->dev, rc,
+					     "failed to parse xtal-trim\n");
 		xtal_trim = 0;
 	}
 
@@ -1576,9 +1574,8 @@ static int at86rf230_probe(struct spi_device *spi)
 
 	lp->regmap = devm_regmap_init_spi(spi, &at86rf230_regmap_spi_config);
 	if (IS_ERR(lp->regmap)) {
-		rc = PTR_ERR(lp->regmap);
-		dev_err(&spi->dev, "Failed to allocate register map: %d\n",
-			rc);
+		dev_err_probe(&spi->dev, PTR_ERR(lp->regmap),
+			      "Failed to allocate register map\n");
 		goto free_dev;
 	}
 
-- 
2.17.1

