Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F1837F739;
	Tue, 26 May 2026 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812033; cv=fail; b=gfad6qkPDs+R9J2jTnr8z4cMJhoLPy+WrDCLWyhZxq8+uEaWmHIDmzO+xXF+x1RjhnBpbMNDeX9R7jSxzmnZKJznDcNai5qWaEJY6Oupwj50n6wwG5A1nW4yAK3SBXwmaEfxBdLo3Bi03SRsV+KgQettTRzqC09uxkn6XzlMZzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812033; c=relaxed/simple;
	bh=133CtybARFZhuydgUo/i/QmU00Fn1C1jU1+RlEl90H0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F38LoN9mxv8I2phgCenrDEF4W6LqZIhwF956AgeKcA6psuCwooUJ2T0fl+Lj4x2QKlRbseRCGFrrP1tgZ79GTtRDEVKwp+U5N38mWyouiVb5kwKsRMAPLbl5rm5Cro+euS5VL5CSsNvdbdgzuq5QPkfp3HrCy/JyDOCLx/lrAHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJt0uat0; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJt0uat0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779812031; x=1811348031;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=133CtybARFZhuydgUo/i/QmU00Fn1C1jU1+RlEl90H0=;
  b=GJt0uat0KhvDCjG4P+9ESMuP7cgNzyII8dNI9w5sEKzklQYUDljEZW09
   pMbK+URg0d0Z8crZkN7FVFlfNX9SfF5hBpK5O9GeWdQOtCzew9S6X8Hz2
   42B58I/WxJhlfQ8xdETyKqwuoHIuK2DOGRYGCAQHZ2+FEOxGcI1zJL9eX
   qTmQ6Do8ricJSVFci166fPAlZ4epPqpaIfpXaslHhWcvJWGgTuGr1Cd4n
   hRXQT6JiJy+0n7fQVfWCdibVvNlQneCrbugQIw54Yzinv7sgpjw9GI7AL
   u7XQDxjhAOMIE6cU2PODbAuhqODc/Rro9KiP1n4Bs/sI5Di6DCgNLFFtl
   g==;
X-CSE-ConnectionGUID: +PO9sLE/QEeKCmkboaHxDg==
X-CSE-MsgGUID: UnFI6FQOTN617Dc0ZFQCPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="68153668"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="68153668"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 09:13:50 -0700
X-CSE-ConnectionGUID: cqzTjLnRTZ6NKTdughKzPw==
X-CSE-MsgGUID: JV3IKk75SbunTnAyyhdV+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="247046904"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 09:13:50 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 09:13:49 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 09:13:49 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 09:13:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOvZBpHT5nI/HD+F+Ys06L3O2OOj/ZneTVDj349ZeN5XIbZ34qwZ8DSrGUN/WMlJEpD5JbC4pHuoN8QySgSJGGxPayEbS7rowJsw/Xc+LD8hKfwiELmemjYKXSnFuMWdyv6m6s3BZKBwCzajPQfVOeBKboefIDKrMyP7XEwuyhsp1M4qRbMHBtpXQDkAY1/w6apCgaQGFpAylnk2528YmYM8vDuNoUl7UTOgV0zsWSRv5NaPRMA6BEe0KUGXHIY+r205Xy2BnfTwNoWIs1ipw3wF0PWFpRAH95WhFwkRBwFPQ1Xm6ReuL+dem/J3qPL5jnoGsTHRxgVb7w9AMldefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X14pi8QK11VEB++slEscBPVJtvLYtEH8NO8yjwxMb0=;
 b=I+l590/YU4JUJBpb7I9/N/M29hbk6rshZTtisp6ULh58doHc4pa4SXlIGZw9dDczjb6yGZwOEfS+Ifu0nxaoFGTxC/tVB6kF53DoheMsqRKtfb+yY/j7smA9K/CdLqFsHpFKf5uxolJCyccgIoGBNmat6ZvDehKcwteVDo5VZ11WlQC7Pg4sAv1H2EuUN/XVrrM/k734GaeB/WQjMKKModNI+lqu47VV1UvpF0AoSnOXAPPKFBGLKt93RcNUyE4R/YsKFmkOnluaByLEFyrGtw8MLUDa4djO7OGFjsAaJnX/obvJ/GzxszE5CpFKcypwKE8+hCXdkH+qDbhAepni4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB5053.namprd11.prod.outlook.com (2603:10b6:a03:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 16:13:47 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 16:13:47 +0000
Message-ID: <7145a02d-88c4-4065-b436-90a8159ec868@intel.com>
Date: Tue, 26 May 2026 18:13:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mac802154: llsec: add skb_cow_data() before in-place
 crypto
To: Doruk Tan Ozturk <doruk@0sec.ai>
CC: <alex.aring@gmail.com>, <stefan@datenfreihafen.org>,
	<miquel.raynal@bootlin.com>, <linux-wpan@vger.kernel.org>,
	<security@kernel.org>, <netdev@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260525161806.96158-1-doruk@0sec.ai>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260525161806.96158-1-doruk@0sec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0120.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::49) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB5053:EE_
X-MS-Office365-Filtering-Correlation-Id: b1503c9c-0456-4c33-9e41-08debb41c3df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|11063799006|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: oXLybI7Nqii+H0395UH/csp+6zmPxS/FHxMk6QnStDv8v7mToScjDMvbB+jlmutfhBFpIIczDl11y1cIER2DyOleDCUCO6jXswqbmOaszsafcg/ZHw5zUmdUyu3yzylYhsfc3Px1u50bF9gT1YfQfdl1ZngKAumh2sW105u5f+BCympJxP/edGJCrZDtTQeni2tCmuVDUmQsViui+gL2PicTtneltM6vG+XlSIKAdW3G/hpk+GqoFAG41ckHcie2WYHuNoO+IbYXScY9Mny1zzgiOPAbX3+Qy7ikaRbqVZe858ELmd++9CkBRjN/Cpz+3vm3/XIbAj/+3LoG8HjVQndfnpNEYSxoYWv4rKQJYagPuu5lAihQk/2+lt9FchoFeEOEINlgjTqhRwZNpxG3PoacfsW2AO9zpPCKN6xl3MjSACBsVKNCjme/VI26ZwgJhwI6NHpAJuzziOBNy81X2mfAQE4JPnWRWtc/qeAsIyUIUqGmSd9oTCqBvsX9n8XxgCam1aUC/b9XhLik4zxNfkvpAJHqENbDFEXhXO1fzDByezQepD3+1dMgpfbjIAzeAMRvJXINHyc1Vod76NYWgx5Zaa9a1NU/Ru+F+5O3wiiOjF90UGjTqT+y3yQErjq0NSGmf2xZwAd8DKONZpdfOll4OcaxJzC1BcoZlt1/YxL7Nb+5nNEGAJEaxbtNo3gFnMXGiBuAHopDk7ldPUw2ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(3023799007)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTkvZ2U5dFZEMGZyR0k3Rzh5am5tSnJOc3d2VWM3dzNjV1ByM0F0emN6VDRG?=
 =?utf-8?B?WG1TQjYybDZKT3R3ZHUwV1hIZnQ3MFZRNXVQbHdaRTM2TFhoOTdvMGMzdTZq?=
 =?utf-8?B?akJnK2xobGZIQ1NhK0d5K2FQRmh2bzRVTmozT3hTdW5sK3pWSUlPUlVxRWQ2?=
 =?utf-8?B?TDIxR0dzQlN0bnQxc3FNOXZSQW9UWkRmZHdIb0NJSmJ2cGtmaW05TmlhZUgx?=
 =?utf-8?B?RStSaHBVaTcwc2xtTFNTMTEyWkI1a1Y0NjBlMWx4aTBrcGMxMWRiN2pCN3pZ?=
 =?utf-8?B?elZ3MFU4UGxyOCs1M2toLzExVkUrRVhEc05XR1U3UU9uWHc0eDNYTWduTzR4?=
 =?utf-8?B?REVFMmdnb3IrOUVmcXAzdjQ4YURrNFhmbkFBZlNidkZ1a0dmbWF1Q2E4c3ZG?=
 =?utf-8?B?dnQ5U0pQS1NXVFRkUVY1L0l5RWhrRjBFRkFLek8wRWRER09nelZkR3ovZFdt?=
 =?utf-8?B?RDhhdzlYV2lrUzg3UExWT1JRMVFZeGNnelRqa1NNSmtQR05RSjNCUERTem9J?=
 =?utf-8?B?RWZiT1NGT2dsOExmekpHNXhPVTFBM3Q3VXVqU0NCS2pTTmR3bVBFRGxncW1Z?=
 =?utf-8?B?ZnZnMlJSdkhSTVRraFM3THNzRXRBRG84NTBaNUl3aGtDaitVUDQra2lpRUls?=
 =?utf-8?B?Rkw2MzZudUNMeGJpSmt6bllyTGN6RUFCZDU2NFNESkJKYlNkVVhhMjRDbnk0?=
 =?utf-8?B?WXp1VHA5a0FDbDhBUmpPV3g0WXRXbjVKN1RiUnE1MFpSWUx0Mml1Y2t4L1VE?=
 =?utf-8?B?Y0h1SWRmUzFJZWgxeTI4bkc1NG1mQ1JFZUt3eUM3OWNpQjA0Um5mbGdRQVdk?=
 =?utf-8?B?RlJUMGVQVkxQb3VvbHpWUzliQmNuMFJJZzVJMUVHTnNXeHFYY0QyQjd0Rkt1?=
 =?utf-8?B?UExNUm1VeFo0WXZ6Y1huN2FNUDRYaGdhTzk0MU9IZG0rdlZFVVBxd2JjTHJ0?=
 =?utf-8?B?L05kUjlSRE9iSVgzN3ZPWk5yNklBcTJHVEJPbGNqcG1nekZHRGYxOGVzOEFz?=
 =?utf-8?B?czh3U290QzgxUmVQN2oxSk9SSjM0TWN5ZnE2dllpN2xZa1lLS2hCNkNCVndz?=
 =?utf-8?B?VkFpemJGWmpJN2s4MmRYbzJqUXJmTlMxV1hQV1pzQkRqQmUxVnpxc1ppZkR6?=
 =?utf-8?B?c0lQejdaUmNzZDZWbWlZMFY3b0JydEhWcHdzWWF5eHNOSG85S2tJV01BaXlE?=
 =?utf-8?B?dFF2VGd4ZFdSM0U1aU10RXVHT213RjFCMzNqb2NMeFp0cFBQMkdXQmRISjVS?=
 =?utf-8?B?cHIvZ1lIQmlCa2FZSUlnSDAzVHNkSkZtUzBEeW4rNmU3WFNDY0FlcDM1bU15?=
 =?utf-8?B?YkFianJScFpoMHdGdDJhSmVvTjIzSDRwdjZHY3I5NnRJSmpubnl4TE5Lbkhi?=
 =?utf-8?B?djZHWFBPU0sxTjFKN05mYUhVWlM0ZThpRVdpeDFFRmEveWt2c0VYVStPb3VB?=
 =?utf-8?B?WXhraXNWajJxUTdHVjdIdVhBWnZpazY2K0RLR05BVUljL3ZNNU1VT1hCRXlD?=
 =?utf-8?B?WHZFcWIrZGxOTlhyQTRhYnlUTXVCK28zMkhJOGxsdGNpaVNyQXNVNDZFM2J4?=
 =?utf-8?B?L2NRcGlMTnZ2eDRlYjVRR2lqWmNaZlF0UmxrQkI4aDhnaFlhdEppZ1RxcFYz?=
 =?utf-8?B?dGZ1WFVNa05TQy9waU5INzgxem5pbGhlK0xNdFBKMzkxWDlYNWllSTlDOHpT?=
 =?utf-8?B?YVAzTXJhYWlwWW5MQWNzcHlwQ3lWcWZ0YmJwS05GeTArbU1TNEtjRjJvSEtW?=
 =?utf-8?B?Q0EzZ1lKa0QzS2ZMMEU3Y0Z1ZWRJMTZJRDd2WVlvdU1rL0xTS29CenlxUzU1?=
 =?utf-8?B?am1CSWpxb3BwWkZtT3ozL1pkdFN5VC8vYkZlVnJCdkhQOWhBbHNRVXIyekY5?=
 =?utf-8?B?dHlkSnMxMXdiTkxwUEhmcVZsTmxPcVJVWHpMVlV1V0RWZS9Xb1JRWTAxUWRH?=
 =?utf-8?B?M3QzblF6VWVvQ1d6Mkl3cS9DcWdXb090NTBVblZhTlZtZ09DcWtQOWFvVksy?=
 =?utf-8?B?QUMzemV1ZEZRc0dTOFhQSE1CODRxU3J5L1pTNHRrYVJZTGloekxsclg5SFBB?=
 =?utf-8?B?ajgyYitjLzdCak9YTDZpbkduZ2ZEb3U5eFFUM1ZmazVlTjhmdEczZ2toQnpZ?=
 =?utf-8?B?dE9RQS9YWnVZeFQwUUdxTkl2T3RSTGtNL1NMQnd1QWNreFcyQUpPUitIRFUx?=
 =?utf-8?B?UG05Q2U0ejdBYWdiNktRTEFScHpEVWk1YWFSR3V2VlpnSnMrc3BhTFdqRjND?=
 =?utf-8?B?ci9mSkdGZ3QzeE03RUdJZTBNdkFMZEdjQmFTcEx2Ylc5a3B5cWZkU3h1ckoy?=
 =?utf-8?B?U3FEZHhOK2pSbGhlQ2NBbWNWblJaRUdBSW9TM3BuWGdsTlJPOWNwbE9ITVk5?=
 =?utf-8?Q?LpMKvrvjldZIpP/4=3D?=
X-Exchange-RoutingPolicyChecked: pKg3VzKgrxfRHNOhMTLmMILaj2PfHuDxlorwQ6RcjOp6Q9jAywVxV/Z+pqFkJmVk+80NpAPH0xkSxNX9+b4jyFAeaKcCRHXl5n8mNbdrD65egXR6g/ytRgFfPeMRPCSgOhnASNOPUZdIulDt65jDTg8KmDKPZDdlWoTQRa+QPADgcI3twwsGYy8bsHboMfMa9TPExjoSBFtu//iQVD06FPuWPnwUq1tLQjxKR4rK3UqDm2+CvzeHc9/ad+/c8s3hxlKRtdNAsAYP+Xx3eFEG9fmrA76Q9C+Co3P87dWgXPYQfGvB3dMTVtTFisSKcrs3fpgGG8HizFGkZk8gdsu3NA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b1503c9c-0456-4c33-9e41-08debb41c3df
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 16:13:46.9509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oe2j6re/ZRtPipQrio0RV7QfAbnCALt9vzONaXKMGwhnuNndhx5T3AOAvP42ux4XdqZN9dUXN5CR8Hum4/hneTVdxpVVNYIqjR5HP0WcEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5053
X-OriginatorOrg: intel.com

From: Doruk Tan Ozturk <doruk@0sec.ai>
Date: Mon, 25 May 2026 18:18:06 +0200

> [PATCH] mac802154: llsec: add skb_cow_data() before in-place crypto

Pls mark as "PATCH net".

> llsec_do_encrypt_unauth(), llsec_do_encrypt_auth(),
> llsec_do_decrypt_unauth(), and llsec_do_decrypt_auth() all perform
> in-place cryptographic transformations on skb data.  They build a
> scatterlist with sg_init_one() pointing into the skb's linear data area
> and then pass the same scatterlist as both src and dst to the crypto API
> (e.g. crypto_skcipher_encrypt/decrypt, crypto_aead_encrypt/decrypt).
> 
> On the RX path, __ieee802154_rx_handle_packet() clones the received skb
> before handing it to each subscriber via ieee802154_subif_frame().  The
> cloned skb shares the same underlying data buffer via reference
> counting.  When llsec_do_decrypt() subsequently modifies this shared
> buffer in place, it corrupts data that other clones -- potentially
> belonging to other sockets or subsystems -- still reference.
> 
> On the TX path, similar data sharing can occur when an skb's head has
> been cloned (skb_cloned() returns true).
> 
> The fix is to call skb_cow_data() before performing any in-place crypto
> operation.  skb_cow_data() ensures that the skb's data area is not
> shared: if the skb head is cloned or the data spans multiple fragments,
> it copies the data into a private buffer that can be safely modified in
> place.  This is the same pattern used by:
> 
>   - ESP (net/ipv4/esp4.c, net/ipv6/esp6.c)
>   - MACsec (drivers/net/macsec.c)
>   - WireGuard (drivers/net/wireguard/receive.c)
>   - TIPC (net/tipc/crypto.c)
> 
> Without this guard, in-place crypto on shared skb data leads to:
>   - Silent data corruption of other skb clones
>   - Use-after-free when the crypto API scatterwalk writes through a
>     page that has already been freed by another clone's kfree_skb()
>   - Kernel crashes under concurrent 802.15.4 traffic with security
>     enabled (KASAN/KMSAN reports slab-use-after-free)
> 
> This vulnerability was identified using 0sec.ai, an open-source
> automated security auditing platform (https://github.com/0sec-labs).
> 
> Fixes: 4c14a2fb5d14 ("mac802154: add llsec decryption method")
> Fixes: 03556e4d0dbb ("mac802154: add llsec encryption method")
> Cc: stable@vger.kernel.org
> Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>

Did you report this on LKML? If so, you should add

Closes: <link to your mail on lore>

right after the Reported-by.

> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
Other than that,

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek
