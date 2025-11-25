Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012073.outbound.protection.outlook.com [52.103.11.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D942E1EEE;
	Tue, 25 Nov 2025 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061011; cv=fail; b=VXIKDF7YrIz3Rtu6yw230qCI+vK+ZmB+HhX+sOZrrweH7xd1oQTtnTwMk8guhm9Em8d1TdlRwzs7m47azS8cOQYsNEt1h66lQY43BIaCdfYGY8VDG+xmZOeqlXjuIJu29vnrao5ETpWjC7ArTPj5wKJThUv1h2CuUbvoS+T2Q6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061011; c=relaxed/simple;
	bh=mO/ttUlxE8xrTAft1bH+Vu+uTI+/c3gyJhkhLpRTc8c=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iUpDkrrrkjhaYITdNi9UrJvqRCFBnc1pkOfKIEtBZ/aOFuWyJnJU5hOPn1gfpSUzWKEIFc9FH4S6evwWoX3wpYwH4BKTj+tra7TPm100r8EeaWTFtEBw8OMRlXA+xuSkRRMqvhZEUD6YOOOrPzSk4Foznar6ZjfXaLrE2FiwFAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ArvwwcX2; arc=fail smtp.client-ip=52.103.11.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ArvwwcX2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bo8sZGFcQEY6+kNB0fIvPLIbZ+XpLfYgD2dinROAfNOJskold/q0yM1ZgQRTbjMcAhohXorOb+Gz9QORkK3DRHDcIwXBDyD4UaNRrYSYQ8buVomplrYHjbdE+SQWjflIWIG4KwOh3uZkuSfwpN4HXQKgQFPbTQftPaATTg9nz4Fhv2g8iHIvWy5JiqgRu1Wo/m7yn0nZ7RYaRbbswEf4RAfdtw8IvsauyEzg3qy4Uzjb00fMrVWl0Pvh1XBZsi2TOoAO3u1fL2bNcIjlSnmeFIUsyD23ZOkhrPe2Ov3pwRCf7ur0GBz5ycH/m1pxWskSG2x+/0aQ/HXC2zuLMSeHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mO/ttUlxE8xrTAft1bH+Vu+uTI+/c3gyJhkhLpRTc8c=;
 b=ixX3iKVYGmGhnDdMn5fHj2LhfUYxNts/yUV1CCe/60zzS4Z2jrxYirK4KhS4ug4utw7UrsxFmAvd9c6SVjBJCdiw9TDXSdndINzdMrs9YhNRdVjNn0CucZJFI03PSE/yI28cQWRYsjMagT50td3bw7BRgDuCIPMAt8ZOLrXbIYPuyGWdkWWkoAwQ5uix/QCWTpBYAObeeSeqgu/V9304+m59RmRc37kp3O+uLv4W74vG+/gsv/Vu/+0+xepY5gVp9Hygq5OieWkL1p0lI33peE0bikcXvzrr7D04T9Ini3FW4al2f0PK26Aa71uSXfKmGxpjY/8p2FsXYdoJ/cZObw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mO/ttUlxE8xrTAft1bH+Vu+uTI+/c3gyJhkhLpRTc8c=;
 b=ArvwwcX2bov7qElBB0R7L6LoqafB2Dl6NL1lXG/sDYWu6DCuQkCICCIMANxS+1Ps8p0bIRajSGSL+92KyZbimUU8T/bCZs1w9ArjzuCjXcwP6c2ujmPwg9LhBkuD4rdOaWPAdHa6YJ1ybpBaVj0XdyEimt3IIVaZYEzbYXIgVVvQcRHUJ0S4/QSwBV3tSJu9IptqVjE1FV+YDlK2/N3A3iChrLYCLwXrl+fqDy55vtHtXvAhDu2IWBYV3QmBvm+C2HrggPShGMzdQBc8mJY88yzExSMLkfy+hqEPSqpcsdC7Fx1ccnuSmQfIDVhS0nAkeJYkHl6OA+mJ23Ar21Dcyw==
Received: from SA2PR10MB4460.namprd10.prod.outlook.com (2603:10b6:806:118::23)
 by IA0PR10MB6889.namprd10.prod.outlook.com (2603:10b6:208:433::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 08:56:47 +0000
Received: from SA2PR10MB4460.namprd10.prod.outlook.com
 ([fe80::59c5:5e37:ba2b:6bd4]) by SA2PR10MB4460.namprd10.prod.outlook.com
 ([fe80::59c5:5e37:ba2b:6bd4%3]) with mapi id 15.20.9343.011; Tue, 25 Nov 2025
 08:56:46 +0000
From: Les Boys <lesboyspp43@outlook.com>
To: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alex.aring@gmail.com" <alex.aring@gmail.com>, "stefan@datenfreihafen.org"
	<stefan@datenfreihafen.org>, "miquel.raynal@bootlin.com"
	<miquel.raynal@bootlin.com>
Subject: [PATCH v1 0/2] ieee802154: use macros to replace hard-coded channel
 masks
Thread-Topic: [PATCH v1 0/2] ieee802154: use macros to replace hard-coded
 channel masks
Thread-Index: AQHcXejpXfzujdBSCEub0aiIvXcctQ==
Date: Tue, 25 Nov 2025 08:56:46 +0000
Message-ID:
 <SA2PR10MB446095FC84B7983FEB79DC40A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR10MB4460:EE_|IA0PR10MB6889:EE_
x-ms-office365-filtering-correlation-id: 8eaeac8f-47a1-46e3-97f1-08de2c009053
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|7042599007|461199028|8062599012|8060799015|19110799012|39105399006|15080799012|15030799006|3412199025|440099028|40105399003|26104999006|102099032;
x-microsoft-antispam-message-info:
 =?gb2312?B?K1BLTE1Ha3FjbW5Pc0dKYytRUzZnTXFLdnc4SmZFZG1JRDFHQVU3eU02S2pN?=
 =?gb2312?B?cXQ3Um0yVkpsY1pZeEFHS1BVM0dEUFlVRXBxKzE2V0NtUEZtMFRDN1pzWXpS?=
 =?gb2312?B?aGdKQzM1eFNGcFN0LzIyZ2o1bXBJUGJrQkZ5Si9Ob0w2K3RpQk9mWUVyeUN3?=
 =?gb2312?B?UVhGSkhXM3NPbjM0KzBuODd4eTZ5em40OUtJaGFqc3grelJ1Y2RLMUVVVXQr?=
 =?gb2312?B?ZG0zb2dzbGVkZHpKQVRNd1hnejRHTDZxTkxCTUNrcUZNTmRJOUxsMjhndzFh?=
 =?gb2312?B?TVRMQW9nclduMlNnejdtdi9PcEpjbzE2dDh5allhbEdzYUpRODEya0t2cDNu?=
 =?gb2312?B?NGJneWgwaVBzTEQvbHFLVlV2TGsvcU1zY0FucFUxWEtRSWJkdlFTNUFLQzY0?=
 =?gb2312?B?ekhBL2YzYUpUOXFybmozMXhrQzl2MGs5djhHZHY2MWcyYnU4bDArdkZvWXNQ?=
 =?gb2312?B?WTJDWHlTQVl6SlBwNEUrSG05bkZYeDVjc2Uvcy96NGRRQ2ZsTmVIbHFna0kx?=
 =?gb2312?B?bHU3L1h0VDVvVmRGQ0FKdjQvNnBZdGtZa0gxaEw3WEZWU3BTN2R5NUFWNTFp?=
 =?gb2312?B?REw0aXVObWZleStkTVVybFlWYUQxenluS2pQelF0YThwQUdVRkJEcDdRWUpM?=
 =?gb2312?B?NUVjNjhremk1Wll5aUp2UXFOQ3NRSS8vV2xLanFHMDVvaGlUWFhkK2pmVXkz?=
 =?gb2312?B?eHdMdm1nMzR0dStXM2s3N09FNnM2NjE2ODRjalhDQW5kcFF6di9wYjBoMVNq?=
 =?gb2312?B?UHN3azBUMjR2TUlJa0ZJdDVwQ0hvUmRFWVQ2L1p3Nm9KektnUUJuNnBpUVYw?=
 =?gb2312?B?M3Z3dUJpTE9qa0FoSmZNTHBSbUkxVEMwMUZSdTFFSEllU09UaWRNMmxpQ2t5?=
 =?gb2312?B?YUJoWFlIcHl0aW1lNGlZS0VxbEFSYlVrRm5aY1BoTHNwYXQxWnZGSGxvd0ZV?=
 =?gb2312?B?b21xV3J5SmxkYTR2dnp1RDR6THlJZUtTOUUvR1ozT0ZzR0orVXpFU3B1S1Ex?=
 =?gb2312?B?dzdwd3d3S1BhREZBTDdQdlBMVUMxTzVtcjNwZWZCT0JCU3I2NXRrSDRlOURE?=
 =?gb2312?B?cVltbVFMSysvQURQeCtvd0FyUkg0ZFFRRmJrenYrYWhlOHZrcWl2TkpiWGFk?=
 =?gb2312?B?NGRhUHlQWVhjeUJwZVp2cnVnYUErRktqckZuK0daTzVIN0tpbW5TMWlVUk13?=
 =?gb2312?B?blJHeG9BNTVpRjRTYVUxK2RDdHNDbkxiZUJ0THk5bHk0dDE5ZUNnVUFYSzd6?=
 =?gb2312?B?bXorak90SEE2ZG9HdjI2Q2NWOVV2TWlzbitBSkowQkVZaE5iK2ljZ2U3NXk0?=
 =?gb2312?B?WTdkdE5rSWdEbDRPdVN6NFRpSTlheUpYUWgrcEdRQUVIMzFLcnRrMlkrZVBP?=
 =?gb2312?B?WEtmUUpHdUhxUnJLbFhhZmJGK2xXeXFYdnJPcG93L1dOQ0U0RUJqWGJjdXV1?=
 =?gb2312?B?ZXRFQ2VYNUE5c29aaXN0bWsvTEN3MHhiWE5oOXc3OUtONUV6SnZpWlZwVDE2?=
 =?gb2312?B?QWozKzVLZGxMNzQ5Z0RjdGNIcG82YzRJYll3SmgvZ2R3V3M2Z1ZoS0xPN1hG?=
 =?gb2312?B?TVpxZytCZlRRWVFLVUNPR2NpaGw0MUU0YTdEbi9Fa1lUKzljZDVzOXVnMklR?=
 =?gb2312?B?bkhFYlRNTDc5Um5lUWgxbWEwUkJlQ1dnbDhnNTNVekJBQTh1WWRCZ05QOU1s?=
 =?gb2312?B?VzhWbnllZTByL3lTOG9Rd1RpQjZwYlhQYWF6RklhVjd6K0VOUmZMakd3PT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bGlScDgvRndwODljeDUzOTE2YnFFSWgxVGhHUnd2cStVK0s1d1BUNC96ckNl?=
 =?gb2312?B?b3ExUlQxMzRwcm9Pb09rMEdZcjlidkRYOHpWZFdzUURDNGZGTTdXR0kwOVF4?=
 =?gb2312?B?WjNqTmo1bEwxY21pQ3FMSkF0SHBoMDU5Ym4xbmxwdXZMMG9DZUpXNk1aUVdv?=
 =?gb2312?B?bit6S1FvT1FGZmxpc1RXdHg3Y1V2Z2dmVmNJbDR1dEs3N2xrTnhBNCtxeFpS?=
 =?gb2312?B?UWV3WW02L1o1R3pLd0VGZThSdGo0cWZCUTc1ZU1zdjBzUDlMbE1kRWNNR2Za?=
 =?gb2312?B?c001SEp6ZUFZZkw1dVFKckRXa1BmTXhzUmt2Nkt6QVVKazdwbktvOU4zNHRt?=
 =?gb2312?B?MVFmaXhMS0dqS2VsTjJ5T3R4VzV4eVdFbW5yZlduS3JxTGI2MmhLQlJMR0Ja?=
 =?gb2312?B?a2hTR2V3aG84bGhROUZTOGh3b0crT2pWNnJGUTFnVmFPdjk1Qy9YUGlockJ0?=
 =?gb2312?B?TVcrdTdKTVcrbnVTY0NXWjkrdlBrTGNtQ1hBT0V4WnY5bmpPTUFqbmF5RjZM?=
 =?gb2312?B?Z0xIUGN6Zm1BeHEvMUg2cHdGdUUxNWNyaUJnZ3VLbmczZ0JtSHp3TURGaUNZ?=
 =?gb2312?B?c080NnZrT01VOVdId0Juc21zUmhLbUhNQ2hMV0xqZWpsc2x4T3c0VHVXeDZU?=
 =?gb2312?B?eFZlOEtJUXpFMWdoNmlLeUJIeVppVk1ieVE1eDVNNEhLNEZnNGRoYURiK0pn?=
 =?gb2312?B?VUw5OU1xZnQrcFhCaVpnM1lua3FpL01vQ1N6OGtDNUxKczk0VFIvUGJXVmtj?=
 =?gb2312?B?MFl4MzQ1V2l3K01rZTBxRkRRa05iSEt0RHYydkVkNnRaM1ZjdDJOTGFLZG8z?=
 =?gb2312?B?UHVncHJycDVlNnJYUC9LS3YraENBaEhXejcydXRsbjFrNmhVZTF2L3R5bHlo?=
 =?gb2312?B?WGkwV3BUVFo4OFpCNjNmY0thbXVaVXdMVURxVVZyd1pjSXptNlZCWEV6Lzgv?=
 =?gb2312?B?SFd4aThDd2xBM1VVUDZ4MHZQamU4M3hDb2VrSVRCZ2JtRytxbTNxcEw3bklh?=
 =?gb2312?B?eGw2dzlrSmJjRVRZV2FzR2pzUnZvenZ1MFhpbU4vV0hUNlpDL1NoL2NWQWUr?=
 =?gb2312?B?Qjd0dVRvUlMxSEhPUEx4YzNud3hwbGZjRkhqaWtIUHIrSTQwbzFlc1drbWds?=
 =?gb2312?B?TFNMMy9FUVA4UHZ1TkRRbk03djhpUGlGOWxodGp4SmxTSWFpR0V4YTJjaHVt?=
 =?gb2312?B?a3N1OU5Jdk1SUWQ0SEU0bXgxZ3ZsRURXTW82bjUvUHZaRWs3L2JKZEdyUi9M?=
 =?gb2312?B?WmZJbXgwbVFSbUFqZDlWb2RQM3BHazZMelBVT1l5b0pGZWpZMWRqZGZCUVR0?=
 =?gb2312?B?U0U3eG1sL3dKU1VpckgrZHZra1czK3QzdWdNdlNqRUpQL0huanNpNFRFWmFx?=
 =?gb2312?B?K0ZmYkFaZHdKek1sMURNZzVOMmtQa3NyemxyYlBRZWR6SE11S01sVTRTUE5l?=
 =?gb2312?B?cHFVUnV1b1hvbkcvanlOT3NyK2R3ZGorS3lqVytoN0VpaDlxbnZoTGtNY0JQ?=
 =?gb2312?B?eW4yNmRhSGFqY2RBeWpoRC9MZVZuN3g1VmtWL3ZOMHI2U1NnY3pwOEkxMXcx?=
 =?gb2312?B?NXFEcVVnVFg1WXlVMnVyS21pb2FsMnB6Mkh0Ritmc0hxbVNWRDRzcmFlNDls?=
 =?gb2312?Q?xT5TTSEkapPYe4n+1TA1tZNWeRUmHVX0QYAQAYJ86fUw=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eaeac8f-47a1-46e3-97f1-08de2c009053
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 08:56:46.6017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6889

KENsZWFudXApIEl0IHdhcyBub3RpY2VkIHRoYXQgaW4gdGhlIHByZXZpb3VzIGltcGxlbWVudGF0
aW9uLCB0aGUgY2hhbm5lbAptYXNrcyB3ZXJlIGhhcmQtY29kZWQgaW4gdGhlIHNvdXJjZSBjb2Rl
LiBUaGlzIHBhdGNoIGV4dHJhY3RzIGFsbCBjaGFubmVsCm1hc2tzIGludG8gYSBoZWFkZXIgZmls
ZS4KCkNvbW1pdHM6CiAxLiBpbmNsdWRlOiBhZGQgbWFjcm9zIGZvciBpZWVlIDgwMi4xNS40IGNo
YW5uZWwgbWFza3MKIDIuIG5ldC9pZWVlODAyMTU0OiB1c2UgY2hhbm5lbCBtYXNrIG1hY3JvcyBy
ZXBsYWNlIHRoZSBoYXJkLWNvZGVkIG1hZ2ljIG51bWJlcg==
