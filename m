Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011018.outbound.protection.outlook.com [40.93.194.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DD838736E;
	Wed, 16 Sep 2026 12:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560155; cv=fail; b=VdUsPXp6BnnZys9RGM0TchkaOnRvDwKOmG7Tg2B45yoEujd+uG9AkTl+vXEvkZy/Zl2RFaDDTX7Ej+aHqvxM1b+FMGLRQMbuNbV63nQtmJbUBXbEh6Gbp+Qn3u2b919PCDVkDaP/H31kVJKi4dbBav7r5GU1ljd5P7rDLIbl/oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560155; c=relaxed/simple;
	bh=tFq45s2pqkEZ2QWBEZAHkj2pvAhUrOl7ogAh2fwASOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q8oy3P4kWRmHHSk04XtiZgR8J6pD+yuIK+SOZKQYyXoxFHF519hq9i6gyyBkKs2ccPwIAjYDwpxrZfHVdgsMn0ZnWdQJV45dBzjPbnRLaacsBgxIT8lT6YbMFCJe31WuHCr60zJYU0QGUZqPBnRendG8t+522DAPpFGDIuJc1Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UK0z+DL/; arc=fail smtp.client-ip=40.93.194.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UK0z+DL/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qq/LUjrPEMWFFM/TWzPM3UPUg8nSic+G/7tGYm03TgNdbJwJmGKsRHiUSgijfXPGxokHu508hV12FJUHXsyyb8YhOKpFgAL5lreHv5bEEaw3yQn3fmjHxB/RHkfftd3ojiFIFNpm/2C2zr9KTgMrqHtQzHl03S/7o1o69zqmugNggaG45E4NIDe3nacXfE2zkdFkL15ZfPM0xYKiU3wKCCFwfl7LTiA26s5VcJ0/4NRietYb5oPrLCePGjWJ6DRNi7W1FaMTFQjDCBkDKlBZLhITk5AvASKV2WMSpddT+de21Oa50xusX2SYwRSGsfslXzahhpPDC2FOcJNQVsfLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMnc51Gi2Ah0SFZ08K5cv6gy07eMRMuYgDacZxzu75E=;
 b=dzo4D5fC2vVVjDaVXg99SxTk5oyX9YLgaM9joH1ExIJUJU9eN/oMWkhuRRZWruGDqNVumaIrfZSho3buLjhsLrVk1Oq2/xiO1eYlmtCf9ueFH9OBTiDN6FOsA90phtobAQd8qizwKg9nG0TEgEXj8sHLV1VPcNwbYMOBsc5pF5tOJRdzUqseaaWQu9sT+bAzpraC5l0xCcyryvxQ9zb1FVByZ6Su6gOT5Na0QaWVdCxZXNrnZnmAhrpnXU/6gtDkmYl1IHPpK9pIAetgoELvnJdbSA93kNX3nL+5Y4P346Of76xei8C/wxYOZ8anCx9N1LN59hzL8cLJ6OSbhXKvAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMnc51Gi2Ah0SFZ08K5cv6gy07eMRMuYgDacZxzu75E=;
 b=UK0z+DL/UM92ljqbXpXlnoSRQ1gCCUbNMYvjOuyicWgUD59tGKhGPwAcx5mJlKdtx8rvj5eeQr5y9SDKTh9h8bTV12xlUQeV1AGrG/aoQUszS/k+RwOPVupziZCF1Nvf4iVauQoaIOQIRM/PKbcTC95S54QEB39wGO4S1mfe1hKwkcDiYXcpJOwe2Ebov4AY2V1vijRyEHAfYVsI3mouq2vn1yPeN7UVhmX43UgIglZQ/DzXejjgNKyqaEQnbIzNSKOGLlNVFAI2spOK0HyiuTbVtrkTkBNZ0aHQatIDiV99XBRwsnUtkrIlED8syOAtrJffRUWD4dE0QzDPBDbvNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Wed, 16 Sep
 2026 12:02:12 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 12:02:12 +0000
Date: Wed, 16 Sep 2026 15:02:02 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Lawrence Lee <lfqlee314@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
	Arun Ajith S <aajith@arista.com>, Roopa Prabhu <roopa@nvidia.com>,
	Jaehee Park <jhpark1013@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] ipv6: update NUD_FAILED neighbors from
 NA messages
Message-ID: <20260916120202.GA935660@shredder>
References: <cover.1789448374.git.lfqlee314@gmail.com>
 <6596966f734f3d416bfa83722f7a595149bcc3f8.1789448374.git.lfqlee314@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6596966f734f3d416bfa83722f7a595149bcc3f8.1789448374.git.lfqlee314@gmail.com>
X-ClientProxiedBy: TL0P290CA0007.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::11) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MN2PR12MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: b331edf7-546e-4b75-f76a-08df13ea577d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|11063799006|5023799004|56012099006|10067099003|4143699003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	62RYPA3nvhjBtfD1PC6H6d/JxSqHQW5BTPp6j9WhrFdDB53S8pt7rLI1HAmSbKFgLE/Cr+eFfRtO2YL3yG8M1JP4cGXK6qSdw6PCs9SGS7BRDG10M3m1Ho1SfnL+Ic7xUR4Au1eYe2eFsRSR40ypP2syYvczThKw+I6Zvsv7IP1PzrVzqsGtQ5YU9tJNiV53MH0Maa2tdEJ+bS50OVNElH5+ZP8PwL6aCYZS5QQ42WKLzS/7tmtDXK6nBTzmVYbUKNXLGpPZObdIU7Nw4LTkBl3jNQ6PvmXRRs2FkITvdLuJoxsyKiS96pLWWBnqdbPokBy/rjndK0y78U7du+tLCFjw/seOhPY4oAGOjtX+xkUNHf2OhBnuEvFuZ1QOSEJ8Rn7j4f3wpILNaw4FH9n/4ft71RMFxhaPCWcnyNq6M0HFrNFobH9XzbLfnCnxtTMS6LLfMAmTJeIp4kSx2PDUJQ3Mwhxln8V9AC4x7QFXC/PwPqmMYfJCx5+pZkibULYoX6ggrpXVuz/8X6y9CgPlL4ZQIj0dL8Rprr+qbisXg27EdYm7T+NBv0yiOvKH2skLzKtLKI6wOm8AuokCRRIObtRbit4itcLvIbGid2lmBKr4ojGvbzC9Djl/Mw9yIeqltyqK6Dojai95d6ofuU7OpJxhVsHHiHqUtE6iL/5Yklg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(11063799006)(5023799004)(56012099006)(10067099003)(4143699003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JDJh1QXvP5RBa2jf76dKhxPyYq2FtFkLZGFR9g11JttMHONTHKaj8i1CqxcG?=
 =?us-ascii?Q?BywIZy8VvXR5611aaUzl4SNHrlyDRVg3YcrCoLnyL0V/1jVglDwO5Scc/tNK?=
 =?us-ascii?Q?nmgp18oC9Xs/m4bPFTBxKFGPnX8ZLiA+OZUwVdOZVhbQjlzgpQNBZ0cLcL3k?=
 =?us-ascii?Q?DzC5AcmsTW6aeK4sLmWpwkzE0VnHG4lRhO+wbNQ7wVJommORIJoRmvzW1C6E?=
 =?us-ascii?Q?PCLLF4gM1GlkqK/3EWjhdcvGqMLMXTOJ56mdgFAxH+xUsiO/yIqo15gs59Ze?=
 =?us-ascii?Q?FeTcnC08aoD6eR6qrSLfdVAgFZTOYpKRmUWW5wGwZvkt9G2WJqXXEFODs7ev?=
 =?us-ascii?Q?v24Aup/czOT2dfdcyUXuGrTeOPd5vyNK78ChYXpRkynAQwG1vdbmEusl6tQZ?=
 =?us-ascii?Q?u2v8j+GhDBp+DgT2ipaeAZmxRXbH9l7HRffgs2EjiZKSTnOISJO5t8eZc8bC?=
 =?us-ascii?Q?8ZwL4p//rbipfPPh05rOsSvTVqtjpeThsVUBEALf0QuFHslPauxm5KlCyDaI?=
 =?us-ascii?Q?gMby35atniVzC/M9reICnpEr6bMu1DWy/Wg9tNxuOpjLjW7fmfQHnZa/kihY?=
 =?us-ascii?Q?SRiXA6up0VgLbOUQj/FAKvRZmjKxqVh9IEoETPCAt/8CY0qdNRVP/ait8bO1?=
 =?us-ascii?Q?qXNnqQ2Nm5qQTV+UrPKdAPrQCkDC3YDKOi/9YSipN0ql6d1nhB3C8juJNaVP?=
 =?us-ascii?Q?xcxjIKm7kywAiNFow5gYJHqTpW1CxvStTOK0fnMtDF7nrz/JWKYagFRHw5QU?=
 =?us-ascii?Q?XedmtS2CiDnnGVQXoL02/s2FQ/TsvyBRXb+0mqkYeaPhBnbrDT9coVtf2NBC?=
 =?us-ascii?Q?GTpBRNczUaiJGG1MUgopByMJcz8bMqvqPfaJYjyRLgISpJEABZz0hpOLAdwt?=
 =?us-ascii?Q?ziSSDgW4HW0NwhuD7WrVAOhapy6FcPjjFgL/knz2J9SKT1zzmupdFVZZpzfY?=
 =?us-ascii?Q?vw8u0tAkRxWH71SKz16XsPYaVzP1LlSYCG1KLAT9BEhYYzBPEctFCcjlVJ1w?=
 =?us-ascii?Q?B/rfrPBSsvcXwSBAEsW5jyGeoQJGAq5vUaxkeOQByZdYeztTdq5kaEaXsPHx?=
 =?us-ascii?Q?2++OcR3233d6YBlp3jKiWb2+r1+q4ibm60IhKoToW0rTG5vqdjvCbqaBvagS?=
 =?us-ascii?Q?hEtIq3gBCCE10W6b8SZ90MNWcd1HR+knCV0ChA979iKi1p85sJvjOMbUYzJP?=
 =?us-ascii?Q?+atXTqNLSzLOBcJHjiGOHwSQVdLgiyI2W5JOrBJ2y45jocJ6K5C+gZD2tt8q?=
 =?us-ascii?Q?q7CjMfFIVzOd4wBDWYXEZGPHgMmlhvV8e1FJHRf8OyEeiZSGr5ZU3BLpqJlU?=
 =?us-ascii?Q?g7okMmQPNzEia49/q3yRIdy5tH3At4qJHxnlE+d21hIyoyGKZ9tw2DtJSTUn?=
 =?us-ascii?Q?pYz3gztIDW0df32YzDSRDgZqJVk4wAp9ZOEqZWOdRuaXLKKCmaG0OPzAP8/P?=
 =?us-ascii?Q?hQsniHFdCfTcSp31hAR9k7Ju4qwLc0nV9xzFGrRROM+vXwFY7fl6ZdfCfw29?=
 =?us-ascii?Q?8JEkN1OzrLW9Nn6t82rqqutmSnxMNbTPMcI81Pr8YQDmEyhQ0kFvJcXTiLAG?=
 =?us-ascii?Q?qOD19D+V0RSBeimQiHKhh5ywf4uGpJy8XM+DrFesc5gZkgSEpSQ7Nv4LKYfk?=
 =?us-ascii?Q?NR0g/8TZ/ZK2QCQbUDpOuShsmbo24zYemJ/hikf1RFqhsB56j2OvEEFyqsYH?=
 =?us-ascii?Q?Ns3DIBo7FYZ3ecpwGiSsJKyh2R5lOWYmXVJKRCSsUmxFIDp9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b331edf7-546e-4b75-f76a-08df13ea577d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 12:02:12.3304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifUOIokzHPyqD3BMlIC3u8HHmvF4KQyeSQK6MIaEsX33SFA0flH4npAreb/aNs/EHJi/rkRLKflAk3McsWo44A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376

On Tue, Sep 15, 2026 at 05:01:31AM +0000, Lawrence Lee wrote:
> Transition a FAILED neighbor entry to STALE upon receipt of an NA
> message on routers when accept_untracked_na is enabled. This extends the
> RFC 9131 accept_untracked_na behavior so that FAILED entries are treated
> the same as non-existent entries. In the context of RFC 4861 which
> introduced NDP, both non-existent and FAILED entries are considered
> untracked since they do not have a valid neighbor cache entry.

RFC 4861 didn't introduce NDP (RFC 1970 did), so please omit this bit.
But if you're going to mention RFC 4861, then cite 7.3.3 which says that
"If address resolution fails, the entry SHOULD be deleted". The fact
that Linux keeps it as FAILED is an implementation detail and treating
it as untracked is correct from RFC perspective.

> 
> Trying to resolve FAILED neighbors via periodic probing (e.g. using
> NTF_EXT_MANAGED) is more work compared to this approach which uses
> information in NAs that the kernel may already be receiving. Note that
> because this behavior in IPv6 is dependent on the accept_untracked_na
> sysctl setting, this approach is more conservative than IPv4 which
> transitions FAILED neighbors to STALE by default upon receiving GARPs.
> 
> Link: https://lore.kernel.org/r/20260813233344.445265-1-lfqlee314@gmail.com
> Assisted-by: LLM Sashiko sparse
> Signed-off-by: Lawrence Lee <lfqlee314@gmail.com>
> ---
>  Documentation/networking/ip-sysctl.rst | 28 ++++----
>  include/net/ndisc.h                    | 15 ++--
>  net/6lowpan/ndisc.c                    | 15 ++--
>  net/ipv6/ndisc.c                       | 94 +++++++++++++++++---------
>  4 files changed, 96 insertions(+), 56 deletions(-)

The RFC was:

1 file changed, 11 insertions(+), 2 deletions(-)

I'm not sure how this ballooned to this size...

> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 208f46967ee5..4cc57a6be99b 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -3223,18 +3223,19 @@ drop_unsolicited_na - BOOLEAN
>  	Default: 0 (disabled).
>  
>  accept_untracked_na - INTEGER
> -	Define behavior for accepting neighbor advertisements from devices that
> -	are absent in the neighbor cache:
> +	Define behavior for accepting neighbor advertisements for IPv6 addresses
> +	that are absent from the neighbor cache or whose entries are in FAILED
> +	state:
>  
> -	- 0 - (default) Do not accept unsolicited and untracked neighbor
> -	  advertisements.
> +	- 0 - (default) Do not create new neighbor cache entries or update
> +	  FAILED entries from neighbor advertisements.
>  
> -	- 1 - Add a new neighbor cache entry in STALE state for routers on
> -	  receiving a neighbor advertisement (either solicited or unsolicited)
> -	  with target link-layer address option specified if no neighbor entry
> -	  is already present for the advertised IPv6 address. Without this knob,
> -	  NAs received for untracked addresses (absent in neighbor cache) are
> -	  silently ignored.
> +	- 1 - For routers, add a new neighbor cache entry or update an existing
> +	  FAILED entry to STALE upon receiving a neighbor advertisement (either
> +	  solicited or unsolicited) with the target link-layer address option
> +	  specified. Without this knob, NAs received for untracked addresses
> +	  (absent from the neighbor cache or in FAILED state) are silently
> +	  ignored.
>  
>  	  This is as per router-side behavior documented in RFC9131.
>  
> @@ -3249,9 +3250,10 @@ accept_untracked_na - INTEGER
>  	  used in conjunction with the ndisc_notify setting on the host to
>  	  satisfy this prerequisite.
>  
> -	- 2 - Extend option (1) to add a new neighbor cache entry only if the
> -	  source IP address is in the same subnet as an address configured on
> -	  the interface that received the neighbor advertisement.
> +	- 2 - Extend option (1) to add a new neighbor cache entry or update a
> +	  FAILED entry only if the source IP address is in the same subnet as
> +	  an address configured on the interface that received the neighbor
> +	  advertisement.
>  
>  enhanced_dad - BOOLEAN
>  	Include a nonce option in the IPv6 neighbor solicitation messages used for

The doc update looks OK.

> diff --git a/include/net/ndisc.h b/include/net/ndisc.h
> index 96e3bb6e83af..7fb3f10eca6c 100644
> --- a/include/net/ndisc.h
> +++ b/include/net/ndisc.h
> @@ -154,11 +154,13 @@ void __ndisc_fill_addr_option(struct sk_buff *skb, int type, const void *data,
>   *     option parser will take care about that option.
>   *
>   * void (*update)(const struct net_device *dev, struct neighbour *n,
> - *		  u32 flags, u8 icmp6_type,
> + *		  u32 flags, bool failed_recovery, u8 icmp6_type,
>   *		  const struct ndisc_options *ndopts):
>   *     This function is called when IPv6 ndisc updates the neighbour cache
>   *     entry. Additional options which can be updated may be previously
>   *     parsed by parse_opts callback and accessible over ndopts parameter.
> + *     failed_recovery indicates that ndisc accepted the packet to recover
> + *     an entry observed in NUD_FAILED.
>   *
>   * int (*opt_addr_space)(const struct net_device *dev, u8 icmp6_type,
>   *			 struct neighbour *neigh, u8 *ha_buf,
> @@ -197,7 +199,7 @@ struct ndisc_ops {
>  				 struct nd_opt_hdr *nd_opt,
>  				 struct ndisc_options *ndopts);
>  	void	(*update)(const struct net_device *dev, struct neighbour *n,
> -			  u32 flags, u8 icmp6_type,
> +			  u32 flags, bool failed_recovery, u8 icmp6_type,
>  			  const struct ndisc_options *ndopts);
>  	int	(*opt_addr_space)(const struct net_device *dev, u8 icmp6_type,
>  				  struct neighbour *neigh, u8 *ha_buf,
> @@ -227,12 +229,13 @@ static inline int ndisc_ops_parse_options(const struct net_device *dev,
>  }
>  
>  static inline void ndisc_ops_update(const struct net_device *dev,
> -					  struct neighbour *n, u32 flags,
> -					  u8 icmp6_type,
> -					  const struct ndisc_options *ndopts)
> +				    struct neighbour *n, u32 flags,
> +				    bool failed_recovery, u8 icmp6_type,
> +				    const struct ndisc_options *ndopts)
>  {
>  	if (dev->ndisc_ops && dev->ndisc_ops->update)
> -		dev->ndisc_ops->update(dev, n, flags, icmp6_type, ndopts);
> +		dev->ndisc_ops->update(dev, n, flags, failed_recovery,
> +				       icmp6_type, ndopts);
>  }

All the changes in this file can be dropped. See below.

>  
>  static inline int ndisc_ops_opt_addr_space(const struct net_device *dev,
> diff --git a/net/6lowpan/ndisc.c b/net/6lowpan/ndisc.c
> index 868d28583c0a..8fedfef93740 100644
> --- a/net/6lowpan/ndisc.c
> +++ b/net/6lowpan/ndisc.c
> @@ -47,7 +47,8 @@ static int lowpan_ndisc_parse_options(const struct net_device *dev,
>  	}
>  }
>  
> -static void lowpan_ndisc_802154_update(struct neighbour *n, u32 flags,
> +static void lowpan_ndisc_802154_update(struct neighbour *n,
> +				       bool failed_recovery,
>  				       u8 icmp6_type,
>  				       const struct ndisc_options *ndopts)
>  {
> @@ -87,20 +88,24 @@ static void lowpan_ndisc_802154_update(struct neighbour *n, u32 flags,
>  		ieee802154_be16_to_le16(&neigh->short_addr, lladdr_short);
>  		if (!lowpan_802154_is_valid_src_short_addr(neigh->short_addr))
>  			neigh->short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
> +	} else if (failed_recovery) {
> +		neigh->short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
>  	}
>  	write_unlock_bh(&n->lock);
>  }
>  
>  static void lowpan_ndisc_update(const struct net_device *dev,
> -				struct neighbour *n, u32 flags, u8 icmp6_type,
> +				struct neighbour *n, u32 flags,
> +				bool failed_recovery, u8 icmp6_type,
>  				const struct ndisc_options *ndopts)
>  {
>  	if (!lowpan_is_ll(dev, LOWPAN_LLTYPE_IEEE802154))
>  		return;
>  
> -	/* react on overrides only. TODO check if this is really right. */
> -	if (flags & NEIGH_UPDATE_F_OVERRIDE)
> -		lowpan_ndisc_802154_update(n, flags, icmp6_type, ndopts);
> +	/* React to overrides or accepted FAILED-entry recovery. */
> +	if ((flags & NEIGH_UPDATE_F_OVERRIDE) || failed_recovery)
> +		lowpan_ndisc_802154_update(n, failed_recovery, icmp6_type,
> +					   ndopts);
>  }
>  
>  static int lowpan_ndisc_opt_addr_space(const struct net_device *dev,

I'm not sure why you added these lowpan changes to the patch. They are
not described in the commit message. Given that lowpan_ndisc_update()
already has a TODO comment about only handling overrides, I suggest to
ignore it. If needed, it can be modified in the future by someone who
can explain the use case and test the change.

> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index 90cd5d852569..84d70c09205a 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -778,13 +778,23 @@ static int pndisc_is_router(const void *pkey,
>  	return ret;
>  }
>  
> +static void __ndisc_update(const struct net_device *dev,
> +			   struct neighbour *neigh, const u8 *lladdr, u8 new,
> +			   u32 flags, bool failed_recovery, u8 icmp6_type,
> +			   struct ndisc_options *ndopts)
> +{
> +	neigh_update(neigh, lladdr, new, flags, 0);
> +	/* report ndisc ops about neighbour update */
> +	ndisc_ops_update(dev, neigh, flags, failed_recovery, icmp6_type,
> +			 ndopts);
> +}
> +
>  void ndisc_update(const struct net_device *dev, struct neighbour *neigh,
>  		  const u8 *lladdr, u8 new, u32 flags, u8 icmp6_type,
>  		  struct ndisc_options *ndopts)
>  {
> -	neigh_update(neigh, lladdr, new, flags, 0);
> -	/* report ndisc ops about neighbour update */
> -	ndisc_ops_update(dev, neigh, flags, icmp6_type, ndopts);
> +	__ndisc_update(dev, neigh, lladdr, new, flags, false, icmp6_type,
> +		       ndopts);
>  }

This hunk can be dropped.

>  
>  static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
> @@ -972,14 +982,18 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
>  
>  static int accept_untracked_na(struct inet6_dev *idev, struct in6_addr *saddr)
>  {
> +    /* For any given neighbor IP address, consider it an untracked neighbor if
> +     * it is absent from the neighbor cache or if it has a NUD_FAILED entry in
> +     * the neighbor cache
> +     */

Redundant given the comments in the caller and the sysctl documentation.
Simply modify the existing comments below to mention FAILED case.

>  	switch (READ_ONCE(idev->cnf.accept_untracked_na)) {
> -	case 0: /* Don't accept untracked na (absent in neighbor cache) */
> +	case 0: /* Reject NAs for untracked neighbours */
>  		return 0;
> -	case 1: /* Create new entries from na if currently untracked */
> +	case 1: /* Accept NAs for untracked neighbours */
>  		return 1;
> -	case 2: /* Create new entries from untracked na only if saddr is in the
> +	case 2: /* Accept NAs for untracked neighbours only if saddr is in the
>  		 * same subnet as an address configured on the interface that
> -		 * received the na
> +		 * received the NA
>  		 */
>  		return !!ipv6_chk_prefix(saddr, idev->dev);
>  	default:
> @@ -1001,6 +1015,9 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
>  	struct neigh_table *tbl;
>  	struct neighbour *neigh;
>  	struct inet6_dev *idev;
> +	bool neigh_failed = false;
> +	bool neigh_untracked = false;
> +	bool accept_untracked = false;

Try to maintain reverse xmas tree:

https://docs.kernel.org/next/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

>  	u8 *lladdr = NULL;
>  	SKB_DR(reason);
>  	u8 new_state;
> @@ -1067,32 +1084,41 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
>  	neigh = neigh_lookup(tbl, &msg->target, dev);
>  
>  	/* RFC 9131 updates original Neighbour Discovery RFC 4861.
> -	 * NAs with Target LL Address option without a corresponding
> -	 * entry in the neighbour cache can now create a STALE neighbour
> -	 * cache entry on routers.
> +	 * NAs with Target LL Address option can now create a STALE neighbor
> +	 * cache entry on routers if the NA does not have a corresponding entry
> +	 * in the neighbour cache or has a corresponding FAILED entry.
>  	 *
> -	 *   entry accept  fwding  solicited        behaviour
> -	 * ------- ------  ------  ---------    ----------------------
> -	 * present      X       X         0     Set state to STALE
> -	 * present      X       X         1     Set state to REACHABLE
> -	 *  absent      0       X         X     Do nothing
> -	 *  absent      1       0         X     Do nothing
> -	 *  absent      1       1         X     Add a new STALE entry
> +	 *       entry accept  fwding  solicited        behaviour
> +	 * ----------- ------  ------  ---------    ----------------------
> +	 *  non-FAILED      X       X         0     Set state to STALE
> +	 *  non-FAILED      X       X         1     Set state to REACHABLE
> +	 *      FAILED      0       X         X     Do nothing
> +	 *      FAILED      1       0         X     Do nothing
> +	 *      FAILED      1       1         X     Set state to STALE
> +	 *      absent      0       X         X     Do nothing
> +	 *      absent      1       0         X     Do nothing
> +	 *      absent      1       1         X     Add a new STALE entry
>  	 *
>  	 * Note that we don't do a (daddr == all-routers-mcast) check.
>  	 */

The comment looks OK.

>  	new_state = msg->icmph.icmp6_solicited ? NUD_REACHABLE : NUD_STALE;
> -	if (!neigh && lladdr && idev && READ_ONCE(idev->cnf.forwarding)) {
> -		if (accept_untracked_na(idev, saddr)) {
> -			neigh = neigh_create(tbl, &msg->target, dev);
> -			new_state = NUD_STALE;
> -		}
> -	}
> +	neigh_failed = neigh &&
> +		       (READ_ONCE(neigh->nud_state) & NUD_FAILED);
> +	neigh_untracked = !neigh || neigh_failed;
> +	if (neigh_untracked) {
> +		accept_untracked = lladdr && idev &&
> +				   READ_ONCE(idev->cnf.forwarding) &&
> +				   accept_untracked_na(idev, saddr);
> +		new_state = NUD_STALE;
> +	}
> +	if (!neigh && accept_untracked)
> +		neigh = neigh_create(tbl, &msg->target, dev);
>  
>  	if (neigh && !IS_ERR(neigh)) {
> +		u32 update_flags;
>  		u8 old_flags = neigh->flags;
>  
> -		if (READ_ONCE(neigh->nud_state) & NUD_FAILED)
> +		if (neigh_untracked && !accept_untracked)
>  			goto out;
>  
>  		/*

This can be simplified to:

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 90cd5d852569..7d114bdb263e 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1082,19 +1082,21 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 	 * Note that we don't do a (daddr == all-routers-mcast) check.
 	 */
 	new_state = msg->icmph.icmp6_solicited ? NUD_REACHABLE : NUD_STALE;
-	if (!neigh && lladdr && idev && READ_ONCE(idev->cnf.forwarding)) {
-		if (accept_untracked_na(idev, saddr)) {
-			neigh = neigh_create(tbl, &msg->target, dev);
-			new_state = NUD_STALE;
+	if (!neigh || (READ_ONCE(neigh->nud_state) & NUD_FAILED)) {
+		if (!lladdr || !idev || !READ_ONCE(idev->cnf.forwarding) ||
+		    !accept_untracked_na(idev, saddr)) {
+			if (neigh)
+				neigh_release(neigh);
+			return reason;
 		}
+		if (!neigh)
+			neigh = neigh_create(tbl, &msg->target, dev);
+		new_state = NUD_STALE;
 	}
 
 	if (neigh && !IS_ERR(neigh)) {
 		u8 old_flags = neigh->flags;
 
-		if (READ_ONCE(neigh->nud_state) & NUD_FAILED)
-			goto out;
-
 		/*
 		 * Don't update the neighbor cache entry on a proxy NA from
 		 * ourselves because either the proxied node is off link or it

> @@ -1108,19 +1134,23 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
>  			goto out;
>  		}
>  
> -		ndisc_update(dev, neigh, lladdr,
> -			     new_state,
> -			     NEIGH_UPDATE_F_WEAK_OVERRIDE|
> -			     (msg->icmph.icmp6_override ? NEIGH_UPDATE_F_OVERRIDE : 0)|
> -			     NEIGH_UPDATE_F_OVERRIDE_ISROUTER|
> -			     (msg->icmph.icmp6_router ? NEIGH_UPDATE_F_ISROUTER : 0),
> -			     NDISC_NEIGHBOUR_ADVERTISEMENT, &ndopts);
> +		update_flags = NEIGH_UPDATE_F_WEAK_OVERRIDE |
> +			       (msg->icmph.icmp6_override ?
> +				NEIGH_UPDATE_F_OVERRIDE : 0) |
> +			       NEIGH_UPDATE_F_OVERRIDE_ISROUTER |
> +			       (msg->icmph.icmp6_router ?
> +				NEIGH_UPDATE_F_ISROUTER : 0);
> +
> +		__ndisc_update(dev, neigh, lladdr,
> +			       new_state, update_flags, neigh_failed,
> +			       NDISC_NEIGHBOUR_ADVERTISEMENT, &ndopts);

Please drop this hunk. It's only needed because of the unnecessary
lowpan change.

>  
>  		if ((old_flags & ~neigh->flags) & NTF_ROUTER) {
>  			/*
>  			 * Change: router to host
>  			 */
> -			rt6_clean_tohost(dev_net(dev),  saddr);
> +			rt6_clean_tohost(net,
> +					 neigh_failed ? &msg->target : saddr);
>  		}

What is the reason for this change? It's also not explained in the
commit message and I suspect it's not needed.

>  		reason = SKB_CONSUMED;
>  out:
> -- 
> 2.43.0
