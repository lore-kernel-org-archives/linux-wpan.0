Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFDF198E6C;
	Thu, 19 Sep 2024 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736489; cv=fail; b=jjOdXGwwjgtiVrtz8qcsDHQVhBRzDAmwu7+OPJ/KQQn5h+WejlqUvzeojidNdvmMC6C6D07sXwIm49WtQ9jWGRiUNjmxbTGi138Fj6/Ao+JN18i7Uqad5hXvJeuM2zkH4qLlvGEjWeBv8k2iWACiVNRWlaw8X27KcC1R+FYoY+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736489; c=relaxed/simple;
	bh=8UbXtlTU+RGe8C34pn/0QTsH4hC5IIxlAVNdSmv+9nk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sQcbzQPRW7emCovCVnInSrW1LUfHpK+CRr/+AtjW+Vhcw7zKATksBNT/SAr/spD56vaRn+e8NWvjfYU2SDqUXjVFPvHGalsPHPw0RIP4saqZioE3wZts3jD30XH21G0sOcLqiBI7caG8FdC0rwg79aUFm08ssgPXjTG1UqmKU90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFuDr1gJ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFuDr1gJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726736488; x=1758272488;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8UbXtlTU+RGe8C34pn/0QTsH4hC5IIxlAVNdSmv+9nk=;
  b=SFuDr1gJFOORZDqwy3r8dPBetuouwg8WTvX3bb5wEsVEA9Km+m+3fysu
   0gMKYoE18dVYVKWxudRAkXp+IRcAIzgLg1OxZQx4bUF26bhEYCg/dHNJ+
   9wiYbaSnZNvc1ivU0cW2mKdmrwWnIR7VVisR0aEH+eExyfSiDKbeNdhFq
   Rkie6U8gF0ON+vB8btZpUxUz1jCTyTm/PJMbymCxqMSyue95OaQXsj5as
   YyqZ5UPptII7YwlQ2J6rkcHNBmgBCgWqXmofN/aGNrQTAt4CrqmG4zT2R
   hMNajJtHaAZUEUhsOfLcwuc86AUnLQs1SmyUdsTTU3MLApZ9ATRFdsElX
   Q==;
X-CSE-ConnectionGUID: wQHXFOGLRY2qg9n1Prx6Gw==
X-CSE-MsgGUID: bZLFYr4NQ/ij7gq3GVc2XA==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25782330"
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="25782330"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 02:01:17 -0700
X-CSE-ConnectionGUID: hlDiv/JdQwOCQWkRx6SKhw==
X-CSE-MsgGUID: FNjDwWu7TlO0ITrLwxs+dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="74652881"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 02:01:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 02:01:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 02:01:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 02:01:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 02:01:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFmwqAEKPEah/nf3vyOhPb0qga22Oy9zwtsnryWTeJNrqz14VccMmjtHzcsuMvEfF5RrQmF00gAx6sGVDURRVACeZ2t2gyXloB7EHE6ytO6uhdMqmsRYrCh6dxVPtgpJvtznqrjwblQc9XZys0q1yqQmSF0Eq97Vtd7b7jdtVIwibKtsiYA3guZWaFkWQmUl/TNarPOGzExpNgpOO3vgYSOCSCAHtTWtFvDMpDnRyK5XeruXFaGRP8hUklr00hHUPfrZ4Q2lojJdceolP6EcmKXjVPTIcMXy1c4ApWr/MJCZ+ewh2Pu9NKiqT3fOss2IXsKgSEA4VNfWSN5kRgmghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YexTxQ7fv8uHT5E4uvgU/I+JwwjwjqrpykaZT/cZl+I=;
 b=XOM9exuxgsOrPx8a15yS0rRSyRDMEq6vPFAqgei3zHd/WNZyUjrzl2rQVmejy9o55I10S7ddabNhlXuBhY/3Kg5nroGNLqaFB20WhALuZfoCqsFFHrtjBvl9PyaUkEzr3AjPFcgU0eIi9niPx3ZPnWLpCoBcVEhGZIxgptpK9GoiAhwPKbzqK8otSEnGw8bpU/31zdCGKwc/OnQqOZiOE6c9AxfCT9yWXJz8OYZ13Uv6Jxt0zAnYr9rC9kqQF7Dl0zkMyp/zuqTSLDHIxS8OYH5vyZmKQ7ZfK2LjvSyhIgkgOFef/ct4JC4aHF3jizZSXNEKFfrpWRETHlaLDIHC/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MN6PR11MB8103.namprd11.prod.outlook.com (2603:10b6:208:473::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25; Thu, 19 Sep
 2024 09:01:13 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7962.022; Thu, 19 Sep 2024
 09:01:13 +0000
Message-ID: <f3c26426-7ebb-4b8b-9443-f604292a53a9@intel.com>
Date: Thu, 19 Sep 2024 11:01:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mac802154: Fix potential RCU dereference issue in
 mac802154_scan_worker
To: Jiawei Ye <jiawei.ye@foxmail.com>, <miquel.raynal@bootlin.com>
CC: <linux-wpan@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alex.aring@gmail.com>,
	<stefan@datenfreihafen.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <david.girault@qorvo.com>
References: <tencent_24586A9E52F56C5C12E9535AD3F243C98B06@qq.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <tencent_24586A9E52F56C5C12E9535AD3F243C98B06@qq.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0021.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::17) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MN6PR11MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 68eeaa4f-9c5e-4c3f-2a12-08dcd8899cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmlISVhLbXg4S3JLZGVzSTJxeXE3eUZnZEdyM0l3bTBVazJvSE1FUkNaYm9N?=
 =?utf-8?B?ZnhFL0p4ZWhOMUhjOFhYVE5PSW1SZFZ1aDRRT0RhQ3J5T2ZQcW5PcktQcUYy?=
 =?utf-8?B?cXhXcUFQd2JIa2dTc21vMG5TWTZPYTZ5WkNQMVpRelo3Z0tXaGU4Z2s5SUFz?=
 =?utf-8?B?N1NzSlM3bVVyb2xpeGNsWDl4N3h5NTZPRzMxeDZNTE81eWlCY2lVWGwwSDQ4?=
 =?utf-8?B?aU5yQ3RZTFRXT29kWFNTVDRJTlZ3Q3U3ZjN0a25IdFgrUVljL04ybUhMRW9k?=
 =?utf-8?B?M1BxSndEUVFJNlRPTFFuSzByNTk1SXBXNFpoQzJtWXNaMmFELy9qck9JNWE4?=
 =?utf-8?B?WFIyRlQrekhjQ3ZBSHFtb2RVN2hCUVladzQ2RUg5OERlUXpmbk8zZkFwMEU0?=
 =?utf-8?B?bDh5WVpSMmpkRVZ0b3paajE1VVRoOUMrb0ZDSjJpdlF1Q1ZPUXJDTkpTZm5D?=
 =?utf-8?B?Z3I0UFh3N3NuNFBPdkFCbEZzeW52cGgrQThQSmtOWUUvTkFWVC9mM0xmSjE0?=
 =?utf-8?B?ajdiR3lpWjRYdzNHdmtYd0tsZDFhLzd2dFVEZVFJVHhmbjBveG0vTzJjT29M?=
 =?utf-8?B?azJ2OGNTY2kwV2duYUpnZEVjbnZmTmVrMW1TV05CelpsQmhkTmxNYkdjdWFr?=
 =?utf-8?B?cjlCR2plQlFYMm5YRDM2NzFvQWl3SzdNRU1qTFhFUUQ5OGdPWm5kU21XR3Ew?=
 =?utf-8?B?V0luZ1dnenRPcGUveWM2LzlWUXB0R3BsN0U1SzB4dXBLRlpmU24vYWxQNFcw?=
 =?utf-8?B?KzRYOU4xMWtwdndNa1JLL0NzOGRKNHVCUTVKUHVEUTNnZFpNOTVvNlpqT2ZN?=
 =?utf-8?B?emJBT3gwbzMwb3JvTFQwR0tEMVA3WnhjTmlQd1U2WGhjWlBXM2R1c3JDTUpR?=
 =?utf-8?B?TldhY21PTzcxL2o2M0tNY2duS2pBNGhoWDY5amtOM254MklYWTUxZ3l4Z2JQ?=
 =?utf-8?B?Si9JMXNPSzNjQnQxSjdEVEZRQXRPZFFmR0hGc2RPcE1XUW53YXAvSlFRM1Z1?=
 =?utf-8?B?SEdNRVlKR2xFNjhJY3VMZVNXVDJEYXJRVFQ0ayt0WVZ2anE0elQ5eHU1Q0Ry?=
 =?utf-8?B?YjFkUWRLSHpoZWU2aUZPVkVLQzJQc29tY1M2SVdTK1BhUHRmaklsZzFlOU85?=
 =?utf-8?B?RTMwVjc1SEZta2RUM09BOStja1lJZHViR2UwZTBDeUdTTXpQTVdDaGM1YUUx?=
 =?utf-8?B?WS8yaWRtdCs1QUUrUUVvWjJvNFRiUlNMYUlaK0ZPOWpQaFVVYnNjOGl1aFlQ?=
 =?utf-8?B?OFlPUGNLMDdXeXVxbEZHdGlaZlI3Yy8zY0xNNmgxd1RhdWMvV0lhbWtJVmJZ?=
 =?utf-8?B?a3ZySGxRQ1hmaGJ3R25VRnE4aTltU3dRQ3BVYTdhVlc0eUM4cURnVTdGVG11?=
 =?utf-8?B?YXFlbEM0N0U2V2pKaHlpVVVoWXRtaXZneVJTbm5BWUlUWjdzWkUzRW1HTC9m?=
 =?utf-8?B?LzRjajVPd1ZRbDlPdWJDRFZGSDZrZEdzYTNhMG43SDZ3cldGSXJ0ZzRCZ01E?=
 =?utf-8?B?aW5ibXE3NGp5QXhTbHlMVko2STFYaWRPUDh6eThaOXZRMTMwYzBWV0EvVWZl?=
 =?utf-8?B?VWRSWVdhOUJQdEs3UVFDYis0NTR2ZVBrVDk4M01HaUxDMzJaRzJZT1VyRGZU?=
 =?utf-8?B?N0tNNHl6OEsrQndyUVU0aTRFYXBrWEU2QWJvMkQ2Qk80OE1saGpWMHgzSTIr?=
 =?utf-8?B?R2dPTThZeGJBNGhJZStLUUMxcFUwRFMrUzY1NDBZL0gwUVN6cHl4VmVtUEtX?=
 =?utf-8?B?d1dlUDB6cENYRy9iTEdTR25xMmVwb0RYdEpVQjRudUFKQkpKczc4OVZNWXo1?=
 =?utf-8?B?VnJxWHJ3aTlFMU4wZE9DUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3FUTDd3RllJdE93aFJhQTNGdE85UkVWa05HMWVWM3p3QS80aCtRZkxpckw5?=
 =?utf-8?B?UHhzaW1tR0xoenFrUEJINENNdlNlb3R6ZUFqOUNvZDhDMWQweC8yL3JiWmw5?=
 =?utf-8?B?T0Z5WlAyS3JYTVdHTU9VUnp1bnlTMnFNcUFyK0hZSWZ3c1IrUUhQV2hqN2xy?=
 =?utf-8?B?SmUrNXQ5YVBqRzlaTm1aUnRYaGREUWlVNTgwdkFuWHgwdTVNWVJlSzF0Y2lk?=
 =?utf-8?B?eVVudDBBRVhoWTBvaHhjYVFGeXlxWHF3ZGt4QzlWMkFWeDc4RW15endMMU5z?=
 =?utf-8?B?TlcxL1ZwS1FGcW1TNmNzWllVY2lLdmZpZGRaUEh0Z2Ivc012cXQxYlY3bTAz?=
 =?utf-8?B?dG4zOEJVVTU0dXFVOUNjNEpta3pTMlM3bFU1MjN0aXdrVFhxQkI5MGdvZjIr?=
 =?utf-8?B?SXdLY21ocWNvQ0ZOdEo4VXd4SThtVUhhd0pNekpKSUhzT2N0KzBGWWFleHE1?=
 =?utf-8?B?UHFsNWM1WjA4dHNmNlE0UmtDTXA2Q2Vab0RwZ2k1Z1BCMGNPeGorRlNFOEN3?=
 =?utf-8?B?TnlEQ0FqSFhvRGxUNk9JYmp1RTh4eXN2ZVk1QW16VFkrcTFTWldSSElOKzJY?=
 =?utf-8?B?Ym1vZ1ZTZHpGL29EZUJJV3pqYm1kQ2tyWjE1b3ljV0RPWkhOZmNWN0l1VUZI?=
 =?utf-8?B?YlNaNHc3WVRlMTRBNTduWitlbU1KTVhZMExIajIzNDBUSll6Ny9id0lPTmly?=
 =?utf-8?B?Yk8reERCTDluTjFoZm9CT2dLL2dMRExTdHk0VS93TkNGOUdiVXlQM0lONDRI?=
 =?utf-8?B?V2Y3UytaNWlDOUFieGxOK3JPQmYxRjVkNDJoWUIzN2laeHZVRjFDaVRvSHlI?=
 =?utf-8?B?MldseUU4SlA1MTlnaFhJbyt4K0lTbDJvNDQ1UU1vNGwxWDlXOGlTSnRORzFy?=
 =?utf-8?B?dU9YNmFTaDFSLzJpVkZLa0RSYitTUHpNc3ozVHN4QlBrd0IyRWJVaTFZOTk4?=
 =?utf-8?B?Wm1TL3NlUGRUSmlOc0Z1Z1NxVzJxSTVpREFHaFhGbDIwQWRuWVE5VmhCYVZj?=
 =?utf-8?B?ejBMOTkwRzc3MVhLUUhSdHA3UnI2U2pRQ05tWEt0ZEpiNmkyeWNOT0NyeFNh?=
 =?utf-8?B?RjVOSDJ6blU0R2hmamF1dFhnWWx5QTFLQlVsbHh6Uk5GRjJqNnk5Y3VFWEEy?=
 =?utf-8?B?K1kwTXIvTG5FQkRpVmdnVWZmWHhsYk54anl6QkpMRXAxOHBQUWE5Z1dHOXJy?=
 =?utf-8?B?SWEweW8yVXNFc1dQNTNablZKa0JwOHFOa1UxQWxwQTFuWTNyUHRnNWUzZ0Rt?=
 =?utf-8?B?c1k3QzZPQm9qWGNsbU9CV3BrQnFuQi83ZTM0RW5DeDQxVTV4ek91M2NWOWhV?=
 =?utf-8?B?Y0NqNnFMbEkyL2dDYVEzQmgrS29lb2pBaDE1b0ZhZ2l2M2tJWWlhZGYvRStU?=
 =?utf-8?B?NXEzaUkzQWJ4OFVkNk5KVVQwdXduTWNTbk9LL2tQcHYvYUxhditORHpHb2xF?=
 =?utf-8?B?WkRwY29SeTJuZGNZR3lZM3pMc0FnNjVLRU53bHk1azE5Vm1GSG0wWDFmTVV5?=
 =?utf-8?B?UTVwcGwrdVNSa1FROUJTR0I0OFBHeEZ3czAxUTVGaURFdmJmRFJWMVZ0UVlp?=
 =?utf-8?B?aXdmd09keEc3UWo3NDBEQ09GV0k1OGxFWlhwcWZkUCttR2x0Zyt2QlNmZkRO?=
 =?utf-8?B?bGpGZ29UVmxPZllwaWV0ZFB2ODJvMEEwczgwVHpSNnlndjRGek9XVXZTTm1Z?=
 =?utf-8?B?WktYWGpGMUZvR0FYcjFjU1pIQVZGQmgzTk4wOUJXbjd5eEZQZ2NLWmhhdjZu?=
 =?utf-8?B?dmw0ZFFsK3JoTHEwSTlCejVPcHQyd2F6anU1ZU03OTFRZEx1Ly9MRUJOaXlD?=
 =?utf-8?B?MGJ4VzVaUlBDQWZlNlRIRDQ3OG5ESk1LaWNDWHdRdklhd2RkVWR4U2FxbTZF?=
 =?utf-8?B?M0NGM08ycWdCRU4rM2lJQ1NNMHNoQXEydEhLWDJTanFlVTd1UVFZcUNsOXlu?=
 =?utf-8?B?MVV0MmRUTVE0anZhSnFycXBTN1Y5and4R1V1NW5CTHhUT1krUXI0bmpzZzk3?=
 =?utf-8?B?K2RkcW42OFVyRDlqcHkrZER1SjAxcnB1eDhlU3lVQ2NMZWVTTFAySUpKd1F4?=
 =?utf-8?B?TmU0SlU2MFJXWFNYSEJ5NWR2TWFjNktaKy9iSHgrcTB0MzFmMTE4bk1ia3lt?=
 =?utf-8?B?cWZIT0NkZStreWV3YTdaUVBOUlI1NzIrMXk3NXVyanVoR1QwUGd0S2k4WlR2?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68eeaa4f-9c5e-4c3f-2a12-08dcd8899cc3
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 09:01:13.2845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXauKsQP8xDt6tXXBn8Uol8gVLQ2aMfD435YnhPf61szJa3GNKWYbFHN/cmI7mOSN9lIggwMMYvzQqg0j2JDjTa0iDrTqMHK7wLElezt+wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8103
X-OriginatorOrg: intel.com

On 9/19/24 09:16, Jiawei Ye wrote:
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
> Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
> ---
>   net/mac802154/scan.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
> index 1c0eeaa76560..29cd84c9f69c 100644
> --- a/net/mac802154/scan.c
> +++ b/net/mac802154/scan.c
> @@ -180,6 +180,7 @@ void mac802154_scan_worker(struct work_struct *work)
>   	unsigned int scan_duration = 0;
>   	struct wpan_phy *wpan_phy;
>   	u8 scan_req_duration;
> +	enum nl802154_scan_types scan_req_type;

this line violates the reverse X-mass tree rule of code formatting

>   	u8 page, channel;
>   	int ret;
>   
> @@ -210,6 +211,7 @@ void mac802154_scan_worker(struct work_struct *work)
>   
>   	wpan_phy = scan_req->wpan_phy;

this line (not yours) just saves the first level of pointer, but then
accesses wpan_phy->... outside of the rcu_read_lock() section, for me
it's very similar case to what you are fixing here

>   	scan_req_duration = scan_req->duration;
> +	scan_req_type = scan_req->type;
>   
>   	/* Look for the next valid chan */
>   	page = local->scan_page;
> @@ -246,7 +248,7 @@ void mac802154_scan_worker(struct work_struct *work)
>   		goto end_scan;
>   	}
>   
> -	if (scan_req->type == NL802154_SCAN_ACTIVE) {
> +	if (scan_req_type == NL802154_SCAN_ACTIVE) {
>   		ret = mac802154_transmit_beacon_req(local, sdata);
>   		if (ret)
>   			dev_err(&sdata->dev->dev,

