Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA3137923;
	Sat,  5 Jul 2025 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751697539; cv=none; b=OJrWDyTtN68gvaMykNhoS3tGXYWn1TF7gavIuxxkWloJdNjrx8VtQi+mWjBqlaT48mDbzdJ63/mKmHRBpBP7/ICcDsxVbn5lcdN7z6TxoTMXeYAw2I/+g9oDF0xLbSV3zY8prQ5hqB4bPeDfV/PJ0mP1C6Cq/OwO6eV2Hx3Ea7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751697539; c=relaxed/simple;
	bh=nldGJdJUtnq8zZVfWkqgAD0qbHwLLlodoshdEQDCkAo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=dHONXQdycZzrlN5r3kQTsjd5K4ICrnjjJoIkXtePItGYDGuQro096Wa3uN7GpEcoMO4sSylvzqVxocHgzTk+QrWgKefh6Uz3aYjSz1PEXUM/TKr2ZUecJ2q2Aj1E9kyQtuLFCaUD4o/UwLedk3SP58VQt6ugO9os8OfhVDCdfNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bZ14m6plnz2BdTs;
	Sat,  5 Jul 2025 14:36:56 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C1851A016C;
	Sat,  5 Jul 2025 14:38:46 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 5 Jul 2025 14:38:45 +0800
Message-ID: <3707d653-2796-493b-b3e1-ad876800de26@huawei.com>
Date: Sat, 5 Jul 2025 14:38:44 +0800
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: replace ND_PRINTK with dynamic debug
From: Wang Liang <wangliang74@huawei.com>
To: Ido Schimmel <idosch@idosch.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <alex.aring@gmail.com>,
	<dsahern@kernel.org>, <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-bluetooth@vger.kernel.org>, <linux-wpan@vger.kernel.org>
References: <20250701081114.1378895-1-wangliang74@huawei.com>
 <aGf8_dnXpnzCutA7@shredder> <a45fdc35-aa94-4887-94f5-6654987f5ed1@huawei.com>
In-Reply-To: <a45fdc35-aa94-4887-94f5-6654987f5ed1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/7/5 9:38, Wang Liang 写道:
>
> 在 2025/7/5 0:10, Ido Schimmel 写道:
>> On Tue, Jul 01, 2025 at 04:11:14PM +0800, Wang Liang wrote:
>>> ND_PRINTK with val > 1 only works when the ND_DEBUG was set in 
>>> compilation
>>> phase. Replace it with dynamic debug. Convert ND_PRINTK with val <= 
>>> 1 to
>>> net_{err,warn}_ratelimited, and convert the rest to 
>>> net_dbg_ratelimited.
>> One small comment below
>>
>> [...]
>>
>>> @@ -751,9 +747,8 @@ static void ndisc_solicit(struct neighbour 
>>> *neigh, struct sk_buff *skb)
>>>       probes -= NEIGH_VAR(neigh->parms, UCAST_PROBES);
>>>       if (probes < 0) {
>>>           if (!(READ_ONCE(neigh->nud_state) & NUD_VALID)) {
>>> -            ND_PRINTK(1, dbg,
>>> -                  "%s: trying to ucast probe in NUD_INVALID: %pI6\n",
>>> -                  __func__, target);
>>> +            net_warn_ratelimited("%s: trying to ucast probe in 
>>> NUD_INVALID: %pI6\n",
>>> +                         __func__, target);
>> Without getting into a philosophical discussion about the appropriate
>> log level for this message, the purpose of this patch is to move
>> ND_PRINTK(val > 1, ...) to net_dbg_ratelimited(), but for some reason
>> this hunk promotes an existing net_dbg_ratelimited() to
>> net_warn_ratelimited(). Why not keep it as net_dbg_ratelimited()?
>
>
> Thanks!
>
> But this ND_PRINTK is some special. The val is 1, but the level is 'dbg'.
>
> To keep the consistency in printing behavior, I convert ND_PRINTK with
> val <= 1 to net_{err,warn}_ratelimited. So I use 
> net_warn_ratelimited() to
> place ND_PRINTK here.
Oh, sorry! I am wrong!!!

You are right, net_dbg_ratelimited() should be used here.
>
>>>           }
>>>           ndisc_send_ns(dev, target, target, saddr, 0);
>>>       } else if ((probes -= NEIGH_VAR(neigh->parms, APP_PROBES)) < 0) {
>
>
