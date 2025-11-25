Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010033.outbound.protection.outlook.com [52.103.10.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF5C2741AC;
	Tue, 25 Nov 2025 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764063417; cv=fail; b=DQiB0Hfq7zExVZuN+OXGbnrCfpVHk/zsm/Bz7nA2VWLYaT4OlNjcka3nijnMCdnuofvI2Th+f6SprfRmr2yskjm5vBPV3o0Krvl06ASHTUR2csST2Su+/95Sxzo9L7apL07yxakGl+Qx5zabI/VB/ZyTM2jGlfwQe8qck4L4o5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764063417; c=relaxed/simple;
	bh=vXgOGhqmJTGS6SQ6epWbJMYTueRlSsSqn67FIyGiO+M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=onJK0GKu8aIDiAgKEsGbrEumhm9wqRe5rlaM/O0XB2ba8YqE9BqLlYhg4JeZtLcip/RBJcgFwoSqcGIvkYNfdcFCRfEF1/M9o19TlKHXI51eq18F7BaiRkmx0l9vgsAlkFrtU4ry2lt7kS4LQOpeLXn0lZY/Q5ex0WvOTk6Zfzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Rggvpnrr; arc=fail smtp.client-ip=52.103.10.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Rggvpnrr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJmKbdyUDa6VLPMxThyZg8l4TKTWtlUrcGLqPZE4SXCGDqI5hQgStTflmDKYfvgcqTW3youZBsWvzgq08nZmUbWc92wZuY8JxXdBxi2ZG6KeHT0ySWvplYTaeVwa8j9/d0Prr5MwFuIdmOBkxNC1hbAUVNmzm1vHA9eff3U+5brArYQDLzVRAcepYwnBgmAii/nxo0zGTDNqdJX/B2afeJxsPlF8+xg5AAPO/1kmqHAcsFPvtRzXK1RGA/+X4yemI6JA1AQQQy26ue+GWFMun3deWo97YZcZ4OJsSqasKlO4iXEQN0tc3xFJ/Y6wNd0Oo8PGMD6P5HTyeIJ/RF71Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXgOGhqmJTGS6SQ6epWbJMYTueRlSsSqn67FIyGiO+M=;
 b=b6RjcpP01hlKOYTK94jBNjCbg6OLAxz+pl7AlgwGgHbZmFRsa1voGyZD41HSG4yAVKEQ+PdLF6xxhe7HzzlV/kKZ0OCAbDbm2vmSW8DI6dYjRIia6pQA0wxSXr5aPQc6ZUpibm1o5UoZ/v6Q9gKzpp4czPpiJL9Wixig8bT94277MHYDCVntb4n6kDsvaSb8+M7WGpd/6Caf7x9R9+9kZMWz3SCd5lAHhzDs1K0Jor/qT+7rS1ElEZ6pBxZCXWtvI2KzUCMeLx4cd6bc8zmifIUgtrfM5bOtdKMxsN11hzgLi5pq4F5KHpCV8+MXLwRLGX0TNw3hygg65/YASYduuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXgOGhqmJTGS6SQ6epWbJMYTueRlSsSqn67FIyGiO+M=;
 b=RggvpnrrG5aUEaaWOyFsfdPTezPOAnQLaBazTaECNmx9XcTXhKy8wheVMPzQ3vZYf/vk462CUVEeDwodbc4If5tMEq1uvKpBG9PRhk8Jzs2ILfr+8NQ5YZOsHVjHH0TIjU0oE82dnB0k/7DoHQOdyifiVVBDPTnn8T5ytYVpUds0+JqV3WiotLHGIeWl/r3y1jUb5xXMg6qjQ5bC8qPxd1MKdP+ZT/gqMhsP8w4krC1tR8+edj+losbkm0SCceeEzV82ML7cd2lTdF5pPTp+ZPcD3xBiL0td4uPHmbZePg9oQZAcdVM0OJreHCNlky89IVjFo1ZuskJJfsp/6VkIIA==
Received: from SA2PR10MB4460.namprd10.prod.outlook.com (2603:10b6:806:118::23)
 by CY8PR10MB6588.namprd10.prod.outlook.com (2603:10b6:930:57::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 09:36:54 +0000
Received: from SA2PR10MB4460.namprd10.prod.outlook.com
 ([fe80::59c5:5e37:ba2b:6bd4]) by SA2PR10MB4460.namprd10.prod.outlook.com
 ([fe80::59c5:5e37:ba2b:6bd4%3]) with mapi id 15.20.9343.011; Tue, 25 Nov 2025
 09:36:54 +0000
From: Les Boys <lesboyspp43@outlook.com>
To: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alex.aring@gmail.com" <alex.aring@gmail.com>, "stefan@datenfreihafen.org"
	<stefan@datenfreihafen.org>, "miquel.raynal@bootlin.com"
	<miquel.raynal@bootlin.com>
Subject: [PATCH v1 1/2] include: add macros for ieee 802.15.4 channel masks
Thread-Topic: [PATCH v1 1/2] include: add macros for ieee 802.15.4 channel
 masks
Thread-Index: AQHcXe8Iu0yz+NjonUuSbN35y5Y9Qw==
Date: Tue, 25 Nov 2025 09:36:54 +0000
Message-ID:
 <SA2PR10MB4460A0469EEA025738C416D1A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
References:
 <SA2PR10MB446095FC84B7983FEB79DC40A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
In-Reply-To:
 <SA2PR10MB446095FC84B7983FEB79DC40A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR10MB4460:EE_|CY8PR10MB6588:EE_
x-ms-office365-filtering-correlation-id: 088e0902-fc42-4c5e-f5fc-08de2c062b69
x-ms-exchange-slblob-mailprops:
 30ekHghIwFq9KAoT6rfaOY2rsHHmJAOmTAW/KDwI12lqjGty+e1O1aiQ+KDvJNSX0w/x6MEnVNnLkiM1BWUePYR1+eRkZkM9GksFzJjQVBbdXjZyvaSAsY0K3WUM6nqDOc2ADy2ippHgJdfKyaTx1Ye/cf+J+oSozl8pfxZBGFpM66mdbtUmV3pfdcUCTTvq8qMzMpSz6XEnd9eiunVebAghFpNU1M+SzZr9b6fiC2BI14My16523UJjO0IbTSxmdIZJvSi1o48cjRPfDiIbkYuP+X3tIiJ0K47q1tVMxeJAGMGZ/AhlQRTIsya1tNYlofEvTUCaEWRoARJ2ZseJ/v0k+x3veYqGmcUZM/ZEdNq9wISC8USFfpyh0r2/utKqtcfKRWNZ8NDy2huHwgzb0JzmU64E/LA7Ndlb8rAoeo4t/LpbEH20g76N6hK2BXOV5nR11QjNQewrMSOmAKzZ3nOaeOmFp/CwlmDU+nyOc05wAwQngXHDUZdRfwRLDmWH2fAUcAc9zRjY01dgE5/wi89Vo2H94m0m+sOHlc+fvKQcYBSEfnXF9GAHnheugKQakjFa7uNksa8rffaUBWQrZ2sv4b52KiMyrjJCYEoVVvAsF229aDd03pMD0Bkpv7fOJZlv4MlkCErt4J5SSIh+hvcCsH+JhTX6T9Oe/6cuqjwIMMt40NhWezT3kzDXZogW0DzyZ6HXjN2HlBaimCcSU0VWbFx92FsqDtOFY01g2YRgaV5/KWFk2/yJu661G8oM
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|8060799015|15080799012|19110799012|15030799006|51005399006|31061999003|7042599007|461199028|40105399003|440099028|3412199025|102099032|26104999006;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?1uNsvW3XufNAwE/rSBM9L3K1rDbin4JrRZZzgtQUOrcy2D3Cnt9SigBXuE?=
 =?iso-8859-1?Q?chXWH0HPDY3utWf4OeLXLSXbEAEqitwW7jEyYyKonL4xuN/pWvfDIlD1Rt?=
 =?iso-8859-1?Q?FLomxvYdWisWFc1Itik2FT8jxTqXxvfE46aMywk04FnAVBYxYovHkgFHCm?=
 =?iso-8859-1?Q?Xxb0zNtdaC9RScqjyUH2UfwRy3/K2F07d5CfQJ0ki9I0wWmroeN/c3216e?=
 =?iso-8859-1?Q?zt/YKaCSxL+bwATBqRD4Z4PWLAr6QRh0TmIkQLLsSdu+G9NRuzTO49l1Lr?=
 =?iso-8859-1?Q?JamiMaaAJWfNkEgYtKtvnD1gbQZiieLn8rJ5jE9CKkIdPjajzoUhvlRT4Y?=
 =?iso-8859-1?Q?0FztgvnD5gikxuf/6s7J1IsmUL+TXHloz76y3tGU4aM5+WW4MaCut4fljJ?=
 =?iso-8859-1?Q?Qjt64MJepq8mG3IxqV/07/AsN8EtEhTjhsLUV/BWZJlFuZwlaOczK+KXG/?=
 =?iso-8859-1?Q?kQeg8S31KGIDINZvQhQKCRfmVlxBVg3IpovcxX86+fejnTG2UPVydRPrvL?=
 =?iso-8859-1?Q?mhq7NF8nB8CtCMFX6dQtaU+pbqsrp4hS1p4D2GhdmqlEY3jTR/TuGp8Jir?=
 =?iso-8859-1?Q?1xkXxblZRY6oQuw/45I67PW2GeZMWoq8nTDharXcm03edaZ+SAkKVtUuSN?=
 =?iso-8859-1?Q?SnpqmFJESg/RgdPsU1sJ9vcX7EsqBuMsUyp14QUPN3Or95DFUWhc7y9tAp?=
 =?iso-8859-1?Q?SaO7Y68s+cS4tyic39DT20IynVmqTNBmicWfH2n5SZRejbN/O4N1aytCx9?=
 =?iso-8859-1?Q?zF+LlP9hbMysZqIs4WuHOAUNzcgmpD+gimkZI5I5uOWIJZX7EkeHSh8sYU?=
 =?iso-8859-1?Q?MFsw+u0Tjy55B5yqjQ5qnzOTP0O/OQq37b1cBWPjUy58ToucuJ6aov1oMP?=
 =?iso-8859-1?Q?uQaebxXWUKcp/ecQsAcg5u7rW00e5UBkB8RgtZwgrKA29LjWCF0VOdJQg1?=
 =?iso-8859-1?Q?vXQq7RDt+y2IGwm7cDVPsUxmuHCajR1vbv9C0mYn6P97/xeIV4Qv5v80cW?=
 =?iso-8859-1?Q?hH1s7uqLroG7B5e+hQH25/p6VtxEyLFoo0kEeSccxEienQSBcMhvEiZ1te?=
 =?iso-8859-1?Q?BcKX6QxrDDSsLgCCARnxpzTKv6Md4u42KQAPAChWlphfp+npQm1faTMWe0?=
 =?iso-8859-1?Q?ZcoPzDZopi0uotcTlPKHs22Ix1jdrp4gg9XAgro4bNCI+eSi+rpQgQvQ4r?=
 =?iso-8859-1?Q?vLF3t7XzFnp2a7yIfDw7K836wXYuEfJPX3zbkyrfaMEct2HrmjBKAHBx92?=
 =?iso-8859-1?Q?sovYkU86gPJMbsDUXYvHFTJYURh6yotxw1y7v/6qJUhJL8gZRhRz0vt9nu?=
 =?iso-8859-1?Q?DQ+fAVeoGdKidRnEb0epDLDd6g=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CCZBagFa4EeUToD/VYoldQQVcpMQwww5fu+142y01l246QnberN/6iALWv?=
 =?iso-8859-1?Q?waSv2mqQJPdjZ9cL8vSkwe0VhOyK93UOXRJzQ92Z/sMCbMh97z/pm6csHE?=
 =?iso-8859-1?Q?9QZ2EJPNSrjymzZx/9NWlOxGpsLau5pLuboXUeZ5L4ZRlb0kiZ+EBwDUJO?=
 =?iso-8859-1?Q?1bpUA5wnrRVEO0NNQSMXILCOIWz+otj/QQ4U4phLL38GrmVq4DlqwMVpbT?=
 =?iso-8859-1?Q?6ZnsFjdK8mX1Q7CasKQA9S4rxuMN/OPudEgmNkKzjNVCd+2SEZy2Qm7dIS?=
 =?iso-8859-1?Q?QJOzi/pj6gJjQW1wR1jXhLCjBpwImvenCGLrGyMQhfVXGfPtSvCGVvXDhx?=
 =?iso-8859-1?Q?tMpQPHHWR1y8HzOKg+an6hrz2qe2m0q71ErebRHSzeBKlorTNNuN09Mm1u?=
 =?iso-8859-1?Q?pGj4UalNUC74KQONHq8b4J6PIKcCtvoaJkihAwjhiFlQeqXEr3F9sFOstZ?=
 =?iso-8859-1?Q?P9SR+wnKWrJgfxcGGF7fTJH3ENaJhqMQEE/otI0xw/hx6QfdNTfREtXB2t?=
 =?iso-8859-1?Q?XbeR8JzpSQ0gvqutfOBWWIMzuhHDlOwaLu7T49jkEizrPjAtPQQiP9EPiu?=
 =?iso-8859-1?Q?Zae8tSjOUTbZZmJSiCbyxJ61teYzMpRLtCyvgouinKb/DovrOkcxvb3qYE?=
 =?iso-8859-1?Q?GZlA5dY4if/vSpgMIgi9cHLjTH7PrTLBIiGD58Ix3wc9/gleXYqjD08Fs3?=
 =?iso-8859-1?Q?CG6TIDn03xWK6315xX3eK3/h9wSvQKlYjcH3mVCeNtU56BfLpJqBlkN6+V?=
 =?iso-8859-1?Q?oja6qHhbwTnhwV2OD/MH/qqwkAd/9fHUa/CAePWl8hy5jPOxij0JBYav18?=
 =?iso-8859-1?Q?3Lu6rDhQKeTves4CGuLKrAc5VbiJ9NAR4ujioF0OiBGLxbn1wr2wlJcTgG?=
 =?iso-8859-1?Q?cz6h5VqjpiJVxcYsA799XY2go64K9tZA99gUcwOB02+znt4HSoR6AnMpiq?=
 =?iso-8859-1?Q?yBbyR9hJZSf3Mketb7ydo/0ZWJiVtdfFGXKL9K1/UMsjX4rFYTyZ1LMYbA?=
 =?iso-8859-1?Q?r2FkLlLjCkFV6zpwdpKFuzJ+gykm0mekpQikDxaeU3SFd10vsJluaxPLgv?=
 =?iso-8859-1?Q?GLpC+G+JKqdFirtJUdCy2D/ekXZp59GW31mc0gwcisMxkGtBv/7K1HEBnE?=
 =?iso-8859-1?Q?usiEQAWd92O0UZtejZwLDvXXeNH26n7ercaTFiy/bQVomOiC9MBkbLyV+B?=
 =?iso-8859-1?Q?rXtHe2L1MSXLY1NoGG/BlqDghTTOz2LaH7RcYlyMpkmzQH7xWCe08mcM/y?=
 =?iso-8859-1?Q?3ckKWPSkur/MWhGY+6BC5QBnPSvV/Xk8kOsHs8hAc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4460.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 088e0902-fc42-4c5e-f5fc-08de2c062b69
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 09:36:54.2808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6588

This commit defined all the 15 possible channel masks in=0A=
<linux/ieee802154.h>.=0A=
=0A=
---=0A=
=A0include/linux/ieee802154.h | 16 ++++++++++++++++=0A=
=A01 file changed, 16 insertions(+)=0A=
=0A=
diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h=0A=
index 140f61ec0..cd42f28a9 100644=0A=
--- a/include/linux/ieee802154.h=0A=
+++ b/include/linux/ieee802154.h=0A=
@@ -58,6 +58,22 @@=0A=
=A0#define IEEE802154_MAX_CHANNEL =A0 =A0 =A0 =A0 26=0A=
=A0#define IEEE802154_MAX_PAGE =A0 =A0 =A0 =A0 =A0 =A031=0A=
=0A=
+#define IEEE802154_CHAN_750M_O_QPSK =A0 =A0 =A0 =A00xf =A0 =A0 =A0 =A0 =A0=
/* 750 MHz O-QPSK 802.15.4c-2009 */=0A=
+#define IEEE802154_CHAN_750M_MPSK =A0 =A0 =A0 =A0 =A00xf0 =A0 =A0 =A0 =A0 =
/* 750 MHz MPSK 802.15.4c-2009 */=0A=
+#define IEEE802154_CHAN_868M_ASK =A0 =A0 =A0 =A0 =A0 0x1 =A0 =A0 =A0 =A0 =
=A0/* 868 MHz ASK 802.15.4-2006 */=0A=
+#define IEEE802154_CHAN_868M_BPSK =A0 =A0 =A0 =A0 =A00x1 =A0 =A0 =A0 =A0 =
=A0/* 868 MHz BPSK 802.15.4-2003 */=0A=
+#define IEEE802154_CHAN_868M_O_QPSK =A0 =A0 =A0 =A00x1 =A0 =A0 =A0 =A0 =A0=
/* 868 MHz O-QPSK 802.15.4-2006 */=0A=
+#define IEEE802154_CHAN_915M_ASK =A0 =A0 =A0 =A0 =A0 0x7FE =A0 =A0 =A0 =A0=
/* 915 MHz ASK 802.15.4-2006 */=0A=
+#define IEEE802154_CHAN_915M_BPSK =A0 =A0 =A0 =A0 =A00x7FE =A0 =A0 =A0 =A0=
/* 915 MHz BPSK 802.15.4-2003 */=0A=
+#define IEEE802154_CHAN_915M_O_QPSK =A0 =A0 =A0 =A00x7FE =A0 =A0 =A0 =A0/*=
 915 MHz O-QPSK 802.15.4-2006 */=0A=
+#define IEEE802154_CHAN_950M_BPSK =A0 =A0 =A0 =A0 =A00x3FF =A0 =A0 =A0 =A0=
/* 950 MHz BPSK 802.15.4d-2009 */=0A=
+#define IEEE802154_CHAN_950M_GFSK =A0 =A0 =A0 =A0 =A00x3FFC00 =A0 =A0 /* 9=
50 MHz GFSK 802.15.4d-2009 */=0A=
+#define IEEE802154_CHAN_2D4G_O_QPSK =A0 =A0 =A0 =A00x7FFF800 =A0 =A0/* 2.4=
 GHz O-QPSK 802.15.4-2003 */=0A=
+#define IEEE802154_CHAN_2D4G_CSS =A0 =A0 =A0 =A0 =A0 0x3FFF =A0 =A0 =A0 /*=
 2.4 GHz CSS 802.15.4a-2007 */=0A=
+#define IEEE802154_CHAN_UWB_SUBGIGA =A0 =A0 =A0 =A00x1 =A0 =A0 =A0 =A0 =A0=
/* UWB Sub-gigahertz 802.15.4a-2007 */=0A=
+#define IEEE802154_CHAN_UWB_LOWBAND =A0 =A0 =A0 =A00x1E =A0 =A0 =A0 =A0 /*=
 UWB Low Band 802.15.4a-2007 */=0A=
+#define IEEE802154_CHAN_UWB_HIGHBAND =A0 =A0 =A0 0xFFE0 =A0 =A0 =A0 /* UWB=
 High Band 802.15.4a-2007 */=0A=
+=0A=
=A0#define IEEE802154_FC_TYPE_BEACON =A0 =A0 =A00x0 =A0 =A0 /* Frame is bea=
con */=0A=
=A0#define =A0 =A0 =A0 =A0IEEE802154_FC_TYPE_DATA =A0 =A0 =A0 =A0 0x1 =A0 =
=A0 /* Frame is data */=0A=
=A0#define IEEE802154_FC_TYPE_ACK =A0 =A0 =A0 =A0 0x2 =A0 =A0 /* Frame is a=
cknowledgment */=0A=
--=0A=
2.44.0=
