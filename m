Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2D21547ED;
	Tue, 24 Sep 2024 09:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169147; cv=fail; b=rwlP6tebvwDGUKqqBa7SYkdNCjsD0vuLgs/FGaefJh0zbkrkUrZuzec9mjsnRt8X83nM95OPR2mVKcN9wPClV7WxHZZ8aWCPhBhElylkCvwfyJGuI+chw4S9tUX7XKu9vXxcu+/xGeUEK17a9QLfBsiw34YbCnJI0P5bNGqpRR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169147; c=relaxed/simple;
	bh=HuvTVTAQ9B3s/xoKeO+1AUuDlIHtDv0g0kZujEA7860=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DrZydNL5zqzRXYGqjCrVorSAqZSS7uwqVPowxp4I7JdjQ45A/iFMzsaOjQi4ljaM7zuynnDoBMlMZcz1KczxpxdHphOF6b4tusF/veSPpcqjQGds2bT7zoa2SPWxI9ycBooj0WF9l/od9twGcWzbY9+ilmn+YSowQVF6t0CCisc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AEvBV6nL; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AEvBV6nL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727169145; x=1758705145;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HuvTVTAQ9B3s/xoKeO+1AUuDlIHtDv0g0kZujEA7860=;
  b=AEvBV6nL72JW/sxwca8cXMKBSltirBC/35iPBSzVBcVlmRJ71daAaZTZ
   mLQiurjJDmXEL75OEJUO8506po+ghjtUSvycO/sZdJez1ypNXX1u2dnsS
   6oNOvtvWW3camHw+k3vPAYi34WEceB60JsU+30tbUdEPcPq46cqc2koUf
   vFciazH2BbM9Ft4qCvVD6VLzBAbxEOnF/CCSY5GrR7S2vcBY+e3J6m0FH
   0NAbSWaHC2ynvfYdU77tqW+DY8K4812nw3pDBDEpGxkZOglap+gO6VLhp
   LxpdmmknWjITNEiEJZ19oC6nnR7fwYVz7vJ1DvjbY/4INL897ULSFwSyv
   w==;
X-CSE-ConnectionGUID: gZVmlxKSTomNp/hfWRJrSw==
X-CSE-MsgGUID: fotxUbjNR9+IuG9Qg6vM/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="25972194"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="25972194"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 02:12:22 -0700
X-CSE-ConnectionGUID: nzViB0/YT/qkK3kpNoL5hw==
X-CSE-MsgGUID: y5Xg+RRWQuGXu2sR9sTQdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="71797208"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 02:12:22 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 02:12:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 02:12:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 02:12:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIkoBhANhoqEZS0+f7q0GkrVl/+JbxGsrLws0FMWAPUSrp1AttywEoek9Z9yc65TbCyGjk5rMsSxg+3e7gH5encihlMm10Gi2OWrpoPdo65W7haqFvz/QC+IaZyx7Os1jkprb5lIHZiOGSNGHj1t5McpIBujOTXdiLhBEbErqq0sBn7filFoV4NWfYP4bas3ozTNrkBehkSaQpcrG35NKyKKAj2C+LoaXozqiO5QcLvBM5A14+ND2ATOHEhrJzdz9/vxpSDb9fhGCRafHyqRfcqxX4EapSzNnS/hFSUN2BkWb3FnXWOiKHIsqk884IDic1Yiv58nUn8RAoM14aOQag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIr6HKaLQn9WJcqzbgRs5Re/Xohn1jYPwzrihbdPv0w=;
 b=fR17wXG2IdA/jd5uV/TW/Hw//8sJttj/yIdMB2UgqkLOLcBrssO3otQvDbj64Km5A/EWbqBJJE69qgKZ0jrIaLozB/k7vlajpIi1GgtJMclbQqEWkmG5SLiLJJn6wrjBNmiQYog1kf60XMeJWHCEGuE/WWD4z6ItLyQJK/ENzqiqI4aQE6Lybse8y7qZ7nr3JnUpV7tyT29+xz7POUJ3FLsdkSKTga9+u06gISfnVXzIWxrsI45nBxIyU2fTDyG9guEjrTA/KOwg8WLoW2V3V92AaScqyikdf2w38IGEnBMg6X//LsqcAraN2TmdJ4r3D0FBNLT0sbLzoFill7tWfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CO1PR11MB5107.namprd11.prod.outlook.com (2603:10b6:303:97::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Tue, 24 Sep
 2024 09:12:18 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 09:12:18 +0000
Message-ID: <cf07ed35-836b-4d1b-a934-8af2b4cc3bfe@intel.com>
Date: Tue, 24 Sep 2024 11:12:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mac802154: Fix potential RCU dereference issue in
 mac802154_scan_worker
To: Jiawei Ye <jiawei.ye@foxmail.com>
CC: <alex.aring@gmail.com>, <davem@davemloft.net>,
	<stefan@datenfreihafen.org>, <david.girault@qorvo.com>,
	<edumazet@google.com>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-wpan@vger.kernel.org>, <miquel.raynal@bootlin.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <stable@vger.kernel.org>
References: <tencent_3B2F4F2B4DA30FAE2F51A9634A16B3AD4908@qq.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <tencent_3B2F4F2B4DA30FAE2F51A9634A16B3AD4908@qq.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CO1PR11MB5107:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b4ba42-bdb3-4904-e1ee-08dcdc78fd62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUhGV3BSRHBqTGVVMlZmaG5VY2JRMVpMRUJxV2k0c2h2WGhsMnAyVHF0c0gv?=
 =?utf-8?B?V1lmZGd0aWREenBqaHlBMlNyQmtHL0t2VThmVWpVa3hkcUxDN2VNZTdWQWVZ?=
 =?utf-8?B?V0h3NGFUSkEreGR2M1JJemQzSE95NC9UYUppdkdxUGFyNjhkUGFhQUpPV2ZS?=
 =?utf-8?B?Z3NXYnZIUlpMZXVCc3p0S1EyRmloTnRwS1lnQVp0aFU5Z0picndHazN1a2h5?=
 =?utf-8?B?SkE1RUJDYTJkRUhCZDI3cjlTTVEwKy94QnNqdUhwQ2dEZTZGTkRSYzl2NHIz?=
 =?utf-8?B?SXNFSXJ2d0dmT2J0YkpzeUYzTFRGbk9aT1UrWVJvSDVqeGgwRE9NUThRcGFo?=
 =?utf-8?B?R2ZmTlJCWStsdnlZS1B1NzByUjhRM2tKZHpkS2VUdmhHWWVOMkovQXUzZlV6?=
 =?utf-8?B?anhmVks3cjR5VDJaU0RJVjJHVjY2c1Rlb2cwQU13WDhDRHJDbVFjb3R4eEFI?=
 =?utf-8?B?cUlBNyt3V0tzMkJmNTEwNjE0NlRwbDY2cVNXbEtST1VIVlZJK0tSczNPaWxF?=
 =?utf-8?B?NWNsSUk5a1lkUVFMMTRIL056Lzk2ak40TGtrdXpIUFUzWjN1bXdXdVAyZ1RF?=
 =?utf-8?B?QUx1QTlHZGQydFJxV0k3aE5uWjlMRGU5Z0FqUW5KbWZZSzR2dW9lMXUyS3k2?=
 =?utf-8?B?eVNscW5iWGlrSGc4S2JXZEZoNGRmcXJFaHRHMlYvNllQTGpEU1NDQzUranpu?=
 =?utf-8?B?c2p2RDB2TC9EYUdEOWtvL2g1N3hrK1haSWpydUJnd2RWT1hadk9EYVFmTTRV?=
 =?utf-8?B?QUNxWXlDRmY0cGh4YzA5NnpKWUVGNmxTckxrcDVSMnU5WHc2Q25nSkNPeG1X?=
 =?utf-8?B?UzhyV3hTN1VjN00xdzVQeDd4WHJRbFRwUk1pUjE3dVBoY0lQREVkcTB5VzZ0?=
 =?utf-8?B?WEppT1FXSUdXTGFBN2VnQ0QzekJBR2FlVCtHYWVzZFV0a216L00wZnkxYzZl?=
 =?utf-8?B?WjFNdGRBeUtYUWVYMDhmZzAzajNpNTN5cDNxWEgzOUZiMXc5K0IzZmhMdUJ5?=
 =?utf-8?B?OXdJMTBsNDNvbklVcTBCSE9YaVY2dHBhdUtwUDZOd0N4eFlPUFVPZi9MQ1hW?=
 =?utf-8?B?RU44Q3N0TnNRREE0TGdDbHlna3EwS0RzbEFhQW13RW1lM3VHZWNGQ0U5aURI?=
 =?utf-8?B?Nmd5WURtTU8rZmppN0xML2JOUlQ2NExTQ1RIUnh0b3IzOXdMWnh2bUhYMjZL?=
 =?utf-8?B?SElmYjBUZ09DMUp5UTl3bFhEb0phTFNaQXVrWGRUZytTT0RaWnpUdWJnSXNP?=
 =?utf-8?B?OTFpVFI0OGkvd1h1RnVuRmlzalZNcnhUU2hyTlkwT2NFYytUc3dtM3huOFFv?=
 =?utf-8?B?RkkzTVNmVHVVMUlReE5aK0xCSVV1dWh1UVh3SG1EVFlvblYxdmU3MzcrdUpz?=
 =?utf-8?B?WEUvMDBXbzdmeDdVd2VESWRXSDVuUWdwYjk2MzhXRFZpWnpJaU5KbEJ3VDN0?=
 =?utf-8?B?RjhFYVJmZ3FZNThsYXdUZlJxc3l4THA4b0ozeUlFcEZ6Rmx0S1VscUErTlFH?=
 =?utf-8?B?akJ2clRGMjB3UUZRUDRibWxLL1ZmdWJGazBGUVU1SVpvREdZbU5vemlld3FD?=
 =?utf-8?B?TjNsenJlTkw1eTNpQXNrOWN0aE9KSWdraHBlT2R1ZzJOeUtuV2tRSElIL1Vs?=
 =?utf-8?B?MHpIZ211d2g2aUw2cjFyRUNFdFhrUFV0Q1lsaHFMTE4vZlBZK1RBbStDamo1?=
 =?utf-8?B?eGlRUXBUSmxyMmtFVFBIb3BWQU4wbDNCa2d1amZPQ1Mwdzd0aHhLNTV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkNmSk1EaE9LNVhIU2N6SDdPdTRDQ0lKaFdhRExWQWljb2l4MUVTMnZXWjdh?=
 =?utf-8?B?OG5XZS94dDZYRFkrdThVVzQwZ1VQZlRyWksweEE0TnVMd3hlaFpoTHFHbFVB?=
 =?utf-8?B?NGVjZGVUWExrVnBLTTB5M3hMUkxiaFArT2lPY3dUY2U0Y0xiVHRaZS9YN1NI?=
 =?utf-8?B?UUxQTFBKSmM0eDhtT05hUUJOOFpqNVROQ3lreTNFUm5mbXMvNzV5RmhDQTE2?=
 =?utf-8?B?cGdDemJzZ3MrNlUvVHJFdGVIWmpEWUptUDBaUGxxQzNuUVhJMUxIVnU3TllQ?=
 =?utf-8?B?UVlkSTF5Tm93OGtDZVFQY2M4cy9YeEF4eGpXYVF1TEZ5bFMxVUFoWC9tMWJT?=
 =?utf-8?B?NG12WlNNdWllWWxrT0V0ZlV5YzdSWWxDN0lHSkROM2IvNG1uUHhSeXRUcVlv?=
 =?utf-8?B?YWlhTFRSWTd1aXdvL3hmbXFBWmhzekJ4YzNoT1lqQ3lObjVLMGNxT25HcWlS?=
 =?utf-8?B?emNGbWV1U2lMeGFoci9JS2kweG5ZVmdzY1VvTDFVODY2ZFhGZHJSS09Ja3py?=
 =?utf-8?B?L2tqeW1RaTZXL0o4VlpUUzZaYkFkYWREQ3RMVFFCUGhrblNhNHNJaUEzYTEw?=
 =?utf-8?B?aGhpS0wybkYxZ3EwTkpDcTlYVmJIQUJJWFd1ZzhndFJydWlQeDNRdmI4RHI4?=
 =?utf-8?B?Y0hrTTJaZ1BLWlltQkFZcmMwK1VId09KR3oyZDFxZGJ4c0toMzFGNkFWN3BI?=
 =?utf-8?B?S3pOcFRsK3B3Ujl3K0tRYWxaeVRidUNrRjNlV01zNmpsenJoQUFHT2Nhb3V1?=
 =?utf-8?B?emZrb1FhNXJpNHowQ1RHSy81NFlzMGRiWVl4bXErOGUwSTllRkNKMXRWd3g4?=
 =?utf-8?B?cU1RZ2VERXhUeW9PVFd6WDB5eElkV25uRDM4c0IweTZIL0pDMnBoRzlMV1dQ?=
 =?utf-8?B?UU8wQnAvNnhjOFdja29UYWl3dFlZWG0yVVVZN0QvOS9IL21vWVJRZG4rZjZX?=
 =?utf-8?B?U0k4U29CK01lWE5XazRWd1plTVRoT1RzUVFjT3JadDhTNVdmVmFrZzJsK0JY?=
 =?utf-8?B?SmlJOFJwdHV0Rk9UMG5jaGhKU0dwcjYvd3lMZ2VDbTkyMFBxNVp1aW9sSVU0?=
 =?utf-8?B?c2ZaRk9KQmZlb3lxNHNuUGtGbk00Q3dhNk4vcE1Lc0tuam5ZMFBqQXpBZmRS?=
 =?utf-8?B?ZjhjdHRCT0xiZGYzTUIyeTJTUEZ6dU9xRkEyWEtSeDJnTHhyTjFBcTVYL2Uy?=
 =?utf-8?B?Zk0zR3V1RWROL0pKTk5ibEppVitvbzVxVXI3d1V1Nks4blZsZ0s4VW1ZY3Ix?=
 =?utf-8?B?R2RXZUdoVWs1eVZpSzUzNXI3MDU0QnhSYlBsbkNrc1F2T01wQzNuYzArQ1dZ?=
 =?utf-8?B?NlIxZGlNNDBxcTd5RStTaUwvUXh2UTl4ZWR6cC9XdS8yYkdYUFB1MnVxaURM?=
 =?utf-8?B?RWwrNExLWUJTU3RTdExKWU1iRGo2cnZqR2VsZzdWa2NsUVIwbFQ1Vkt5Vmha?=
 =?utf-8?B?NG9qdlNNdWJaZHBhU0hDUFMxcGczaCttQVVTQXdSV1l2dFdtZUJjOWhRV3ZK?=
 =?utf-8?B?WjlqcUNMbjFPSVRwNWlFU0J1Mk1QN1lzUEVmWVJpaU9lT3FsTVNkb1dNb21J?=
 =?utf-8?B?bWc1WWxxelRxaDRtTGIvY1BsazlvclRjcHhoK3hETzFJcEFOa0xnaDlnV1M5?=
 =?utf-8?B?a3h2cGhqem51amJIZ0FWTEdIaWxreFBSbUpHMWgvc0x0ZkVHLzlKNlRNMlVB?=
 =?utf-8?B?QVhhOVQ5RDdEZSt0Q2NnbkpOYWU5TE9YbXY1SFpXUmZpUHQ5QTZzTUY5ZS9t?=
 =?utf-8?B?NkcxNlZmN0lqSy9PUVFTUVdaVzc3ZFQrMTd1eGhxakNCUzVrTkl4VU03bHBH?=
 =?utf-8?B?QUZQNjBsL1BLR3VyUnpTTFdZckcwTmxYaDhrTmJ5QUJLS0NaRzhvdkM5QWVQ?=
 =?utf-8?B?NTJIWVJMVElqSWQwbVprSDg0WG9xaWtJOWFPN3AwbWRSVU5IUFl2dnBzNUJY?=
 =?utf-8?B?ZHN5Y3cxbXZJUWR0Mk1PcnZ6VDVrVEZFa3pRY2psKzhyTnBFVklpT1d6WGRG?=
 =?utf-8?B?REpHQkdKSFBZdzVVbmxuL1BRME8wMU82VE1KNGpVek9oc0htaHAzcXpPdWRm?=
 =?utf-8?B?dEgzV0VvYk8xM01hOFV0WVFiV3Q2MHF3YUZTM2NXRXhKZHFuN0U2Q1ZMWEhK?=
 =?utf-8?B?YzNNT2hKRTJMUkxjUFlubTJqcjhvWFJLR0NGMlN6aWQrVUJuUml6c3A1d1pj?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b4ba42-bdb3-4904-e1ee-08dcdc78fd62
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 09:12:18.6779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8zYANJhP1hAQ0pQg99bWVjCIWefNwckc0VlNkRvJUvfPpsSjOXWYraoYJQaGbAJJETZZEA/j9wCRNpbGN8PFNFqy6mFNXX9awxA7lQvT4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5107
X-OriginatorOrg: intel.com

On 9/24/24 08:58, Jiawei Ye wrote:
> In the `mac802154_scan_worker` function, the `scan_req->type` field was
> accessed after the RCU read-side critical section was unlocked. According
> to RCU usage rules, this is illegal and can lead to unpredictable
> behavior, such as accessing memory that has been updated or causing
> use-after-free issues.
> 
> This possible bug was identified using a static analysis tool developed
> by myself, specifically designed to detect RCU-related issues.
> 
> To address this, the `scan_req->type` value is now stored in a local
> variable `scan_req_type` while still within the RCU read-side critical
> section. The `scan_req_type` is then used after the RCU lock is released,
> ensuring that the type value is safely accessed without violating RCU
> rules.
> 
> Fixes: e2c3e6f53a7a ("mac802154: Handle active scanning")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
