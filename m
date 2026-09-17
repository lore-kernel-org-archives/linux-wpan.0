Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676B58B6D4;
	Thu, 17 Sep 2026 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655898; cv=fail; b=GJMhGitqnD9UvG/EoLm8qdUZavB+eCNbHRGEEHWC3EjbrgrknmJoyimZ85KdRuoQkb1x7inOXm2xilJEQBXc5ofT0GVMTQfDmTfBPURvp60XT2CPnU3O6ahJqE6ggsJzKdMkLTBarrFsqekI73lPT4NbzJrnu8WNioJdinx4gHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655898; c=relaxed/simple;
	bh=FJ9XOneYo79iOhTUkDm8mrdM6q5oC2CiIq9Zln7dcyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nso5MKKa7lZ+qMUuc0Y2fu0i+dw+oiM25nP0FqmTdtwMGUo649fky2KSSajXrmpQg8N3tgsY1Qt8S2A6UodPbmczb1xJYiJwNcshIbsNWYJQ3Acq1BQbVxMpOcbAB40mNv/fGq34FwJXUX+GboxCLvyuFAHjcC1FZOZWhrlQYlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YPq9N7eb; arc=fail smtp.client-ip=52.101.61.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YPq9N7eb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kg5ir/hQhPm+EEYekfdo6BAwwK3+bqgwE3Tdm766nkQ2Se7/RkokR3wlcBnwMJnMB0pbYGRLR9cXnBvaEU6yuHRZj+UwHMFsgemWMt3VJjoo2urUz2VNx7swLUxlqBkVZYUGVis6jVSc1ZzEaBG7ISldBuBzfv0XGeSR9thK+QXmnL1BwmGNdh0Ji/FvE0DolpJPHc5xakSuvlNNq3kuwlKmbtxYM4iq3ssK9Dh7F9Ex7M7n75YSI4ECobYiDVUFNmHvNxwdIyNAD/gm5f1jj/dv7UVcII90YXL+dJt23oiNpUtvhyWm8Npjpwn3RZLbXykIg8i0snJTXVvp+2GnOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXIHh5ikDaVKJpxcyBVctni+xEVlqT8iXebqgcVc8XA=;
 b=raiOE0JxBicFvtt3og6ctL+chNtqkmj4y8HvhejSCpIWuiVlOacsW0hKxG1JZrH/kApskdgijhoYcA2jxvhbe4FRcdLEkKrDGcO6InrKqqx36Tkyni18+QR+0qENIOAKt9I8vb+SFnxabg5GYCFfXHy+4KJnN9sojyqIxUE2J34DkLAlLmgBEdI1+d4IdA0ig456hnnouCL1vVD8Kul6VwOOJgg67ltS6Wh3uZq6I2c0xfRX+yaugcMJNhRaksXM/G00z+Or5R08nooJn7w4R2kYJRCn4oInXgPGIRpqOWipKNYOqvv1xLnxiBX8jJwg6m214GfEJwjxbYjsVNxFzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXIHh5ikDaVKJpxcyBVctni+xEVlqT8iXebqgcVc8XA=;
 b=YPq9N7eb9IVzz9fvvUBHOpAmbLAJxZjdPcXTSxoCzaiE51KLctz7Io6Znx66fZYfvx6FarELpObyEcn/UkIkitzhaZZdPHXRquKqoDbs9iA0vftMih19uY93TVtl0XdLtUL+tlwhXXaUUNszTxhpowBAl6JqJIgNYWQWfKQIZ42hWk+E4YoMZRdXhX/fTHDHCD1THHAEOsm7GN76UY8MXp28bpynOJzrC+MhYmTZBTIKdzU7QAn013WZ3uS7i4pOMRfXppcgO7Fn9u3WQCCv0RblOdNEIsW1YDsSQ9KZ3NZ0U6dMY637mIZFf8ZF6GHA95qkz9BJP01TkeiX7qcg3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 14:38:02 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 14:38:00 +0000
Date: Thu, 17 Sep 2026 17:37:50 +0300
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
Message-ID: <20260917143750.GA1332286@shredder>
References: <cover.1789448374.git.lfqlee314@gmail.com>
 <6596966f734f3d416bfa83722f7a595149bcc3f8.1789448374.git.lfqlee314@gmail.com>
 <20260916120202.GA935660@shredder>
 <DLGXDIB879EO.IDZNAIRY0VFJ@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLGXDIB879EO.IDZNAIRY0VFJ@gmail.com>
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DM4PR12MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: a8546720-02b6-403d-4fe1-08df14c9459d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|4143699003|56012099006|11063799006|3023799007|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	m28/VMMcv+bTrDd2pVjTQHfO2z79s0oDih4Jy6Z1+EgwXbQCqxP2RFNR0a6hacGNLCi5MiZGfSkVGbYI6ghGwYhqhKVIGN/G3hFXzhrPR4lILxNqGlKVlSV7cavTYfj8D7+v6HQEUSDxwpwww/as60jjrEk7fd0ihNG2QO89wMGen4LredzHxRRg+4B9I/bvL6RlQKkBQ6y89XI0zh150/FJ9ble2VayAv7ATj6XIMaXXJJ1uzTAsfky/l9Jd4+TGvix/kcyIPUiWbjU6TFc6ECaPS5xP2Ghlh96AsVEDKEE2AeEyxXkQ2JZ97oQqWCv3V9REweev0iotum1nZilK6eWu8mRMbNOeJtepSXUERQeTCwd+uFb8EpN2BkIwI5/0XAb3xN+SMU3juI4EwGEwTaG8z+a+WLFWOyiqAvX7rXeop5ovp+hTW2II80y2WZwai3nuNyC9/yIAoig7qaOLtcP3KWyMjy6HWi+w9h8/OBlx73RlMHeBVUl0y+tlmTsgGl6RuwMy98HUSfbKUk1u0Td+Ougz7OWTsP2Y//TYLspBhz1Nv0IgP41LtIT3R10UznQnz9kxduWfP+1Utxge/O2QqrF6NJfRkEDERxoYcDfMWLgwbiKyKSxwgzU0OrWUqWYrNOjKofN+6erqIA3miCPWQ4EICNcbN2izZck1bA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(4143699003)(56012099006)(11063799006)(3023799007)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hKwqmsTgycgbbnKlWq/UdNgTOObHILGz41v5+Vw3V8zgY3NisK7gHAWO94Gk?=
 =?us-ascii?Q?WYDBFQMoZl68SW8bGyffceosSAXGGvjqTFzrhc6TNtOAB/dfokJa5tCXshgv?=
 =?us-ascii?Q?4TqPIqSGC1YIkavowO3abBHZ8n24/45yhitQZh8ADTi6U07Kncs8IzhYko5j?=
 =?us-ascii?Q?XIGT4KxJO26YI+ZEehMBke3QxwO60095k7uXy3/+kbbZLTVA53PFheGj1jkP?=
 =?us-ascii?Q?cLBpqvcdmQRe6kt7R3ZlzokNkSj8m2GvQluhTtBvlLr7WcaLG/iF6CKrrmqJ?=
 =?us-ascii?Q?/8zqWOUUeV3e6DIACybQjHv0Bt77xop+mVQUoAoYDJ5fOEqpPxQtkS0ISfLr?=
 =?us-ascii?Q?XlI5L9wTMDu7U6oudB9PcwXt62b6cevLJNoR6sIZPfmNXdOcMrA/R8c5Chvw?=
 =?us-ascii?Q?5JylQpS7Z3CjE0RmYtz92dpxGYoVOegd/voL3V/rlc1wKDx4hspaLqVrO7As?=
 =?us-ascii?Q?ubiNnHG/l44GDrBw6yG2IuEeHsebA4pCj5EwzVT9gVt+4DhCikw1zNolS8CM?=
 =?us-ascii?Q?57TcIVG1/XoqPzav1/Wcn4PJqYq7zEVaCHYAVsc/gqDN8Oc71o4N/YZ85dUN?=
 =?us-ascii?Q?HkZWWczTARpoj5xxwqTC7GuWLwz90vzuCIaFCjAcXTX0N12Bm2vzfMCBYLik?=
 =?us-ascii?Q?4DP/tDaREI6Zk+EOmmE8F7OyIve3W/9Lm+OV4Bhxp5ngAZN5FxBDv36e9Mve?=
 =?us-ascii?Q?GWGJvtEPOWq8gbN1293lHnANcfTIJQ+gGkWsSCKe4+9tPQxaqcmNbCMos2Az?=
 =?us-ascii?Q?fjilgRrIwl+Mh2g2p6eSyou978RdoOm2PTO9fswoRyOec4XhczUwXVsMJn8V?=
 =?us-ascii?Q?vKhbJ15wwcrhnuqjSxufbogvlBjtJOm+k7BPAVA8YyglafPVJXby1ovFQSvt?=
 =?us-ascii?Q?zi1vlbpOnN97DQNF2rSpUVjL1Fhiv+DsV6p+BGtEjPOlrhAiN6GtgDS7qapc?=
 =?us-ascii?Q?IMdmyWRkBz8HyRJAyukQKqSUc04VR/a4UFFakWQXGidAGHVLQuDk8AAzcymX?=
 =?us-ascii?Q?qTCC1sTLbPUWV6qdn72EtFaFrtIrfIfIuHP/50vdFq701mkMTWehfuMHlyEJ?=
 =?us-ascii?Q?LqDww6J3eERKzfnOGhENZU59d9/oLPdsLMAHc9f4a1z2m5UeZtN8PMU7LD8w?=
 =?us-ascii?Q?NP7k9zW1KloOaC+q++XOhKStuhzKVRk1D1e+fPDhMhOw0j7pcHWcsxLsg4xO?=
 =?us-ascii?Q?UX/CKFpWfh11kpTFOLpNe/Uc1P7KQVSk+M6a2E/QwK9tH7XGN6Y0iom5FC2A?=
 =?us-ascii?Q?c5s82J1m2/lUwE3Wi+kn72JKoIakawNxF8yxTVPz4h4q+oxP7x0uR1yUxYlA?=
 =?us-ascii?Q?i38pIC9SvgIHqIQXVVMpU7ybW27GSXKvFyCMSlppqJzGhMtNImV31FqSXWYK?=
 =?us-ascii?Q?famnoS+AMm258yF2qs/dfYUO2cYpMSQsEYqclF3FIO0W0IMPP67cZlW6DbLN?=
 =?us-ascii?Q?y/BfReqy0uOMWbk7qX1uGeDDaVCWIl3oKuYblJ8OTaSgPd8GaR2mWG5RrYUQ?=
 =?us-ascii?Q?dPYHyPZpPjkWnQCArbIkoAV8WLT+fclQk0Gi62MUSxb/M0nMCA5rMOS949Ni?=
 =?us-ascii?Q?bIPoORCLhrE9t0QOWZkjIrClzHzU91D7eEPBswDUYPn/57BW+lum98podmM6?=
 =?us-ascii?Q?SY19dQZjAB2cCawxe/K3jHJ3edGcbYMKcNNQb8neUsqzcTBCuJ3ok8TuZEpe?=
 =?us-ascii?Q?nVKJ49sSJv1s4WKbZ6kT0MBN65EemiFGnx43rwMFxPMMGo2tkoEHuDFaYyZm?=
 =?us-ascii?Q?MFmWijyTqQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8546720-02b6-403d-4fe1-08df14c9459d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 14:38:00.0412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTcF3Ie2dljARlvTy8ybc7EXM7QaCdfnNDM/jYZ33A9mWtTccI8nMfS2tqmwzJaHCIKc52NhbqrOLejpUESAxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742

On Wed, Sep 16, 2026 at 05:43:11PM +0000, Lawrence Lee wrote:
> On Wed Sep 16, 2026 at 12:02 PM UTC, Ido Schimmel wrote:
> > I'm not sure why you added these lowpan changes to the patch. They are
> > not described in the commit message. Given that lowpan_ndisc_update()
> > already has a TODO comment about only handling overrides, I suggest to
> > ignore it. If needed, it can be modified in the future by someone who
> > can explain the use case and test the change.
> >
> 
> I added the lowpan changes after my local Sashiko review run identified 
> an issue where a FAILED neighbor can retain an outdated private short 
> address if it's moved to STALE by a non-override NA. Happy to drop all 
> lowpan-related changes or update comments/commit message to reflect the 
> changes, please let me know your preference.

And if the entry is INCOMPLETE and we get a non-override NA?
lowpan_ndisc_update() will ignore it. It's a pre-existing issue and
there is a TODO comment about this:

"/* react on overrides only. TODO check if this is really right. */"

You can mention that it's a pre-existing issue under the '---'. That
way, hopefully, Sashiko will not flag it and it won't clutter the git
log.

[...]

> Was originally unsure if I should modify the existing logical structure.  
> Thanks for the suggestion, will implement this. Is it appropriate to 
> credit you with a commit tag?

No. I will add my R-b tag when appropriate.

[...]

> > What is the reason for this change? It's also not explained in the
> > commit message and I suspect it's not needed.
> 
> This was added in response to another Sashiko local review finding.  
> Let's say we have some FAILED neighbor T with NTF_ROUTER set. If we get 
> an NA from source address S with target address T and with the Router 
> bit clear, existing kernel code will cleanup routes with gateway S, but 
> IMO we should clean routes with gateway T instead since that is the 
> neighbor which was updated by the NA. I can either update 
> comments/commit message to reflect this or remove the change entirely, 
> please let me know your preference.

And if the neighbour was in a different state than FAILED? It seems like
another pre-existing issue. I guess that in practice, most of the time,
the source address of the NA is also the target address in the payload.
You can mention this under the '---'.
