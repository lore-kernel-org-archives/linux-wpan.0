Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4875D156F26;
	Wed,  5 Jun 2024 20:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617758; cv=none; b=nbGhG/yCTI9NKyUBNZuC+YD8ODAnQ51ffVzLQww2sW8wlqCxYFrvtHt2h95tRyF4qYztT6EJI0zM1dYihcPA7ADPboikwrf9yUYxFA+9P43aFzGpR3MPlvgQID9qmLISslQYTzE3cztIU3/l5lEnUcY+UUTwTOCactuIZpBYSeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617758; c=relaxed/simple;
	bh=YeRz+r/JijIpAJ9ruGEWph6mEWllUl61ky5cVumLtiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cm0Pu9YxzK49A+2NDjKc0dse2zsClnBvKbWrgT10kZK05PtupMMKplHv40oNAdc/iNT1NrQgx0I82eeNelJFSeGBAI7ygCHbk+sEy+K5w/ukPvBTUEB9NKfZ3vIdhtPr/ZdnUhf52Gf0Sw9jP3AtxpjbMmgnJwDPBUk2LBNxTdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=MW3QTbSw; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="MW3QTbSw"
Received: from [192.168.2.51] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 9275AC01B9;
	Wed,  5 Jun 2024 22:02:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1717617744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/hTIr21CahD0Nu7VkQW1QMjCpyJixUIEnztFvdZHlg=;
	b=MW3QTbSw5RFmQk0yUd1gvedDSjOrE+GXsBFHmpd81TdF7fqhTyGKK9djxwi3Lw0ZDQOmXD
	nS8T+ea3/rTqJbXbjJp5RgMJegtAK2CzBUWCRtDidVpJKO1GtFYslXjx4gM4GrMeJSWOxq
	kCpmfCDWiwLxuR3Z/BD65l/1B07HHQuo7bWnhfdC+E+HTnjoNQr1SlAcwz9uhxo4uBZ2lD
	TQyAawcChPXxzj6exXDWixa+TCQb3j0X9gberzwNpbggtfZ3uiPgFv1N+PpAimxhY+ecwB
	q0pUdRVtmnIEDPIbxFuQZVArPpysBnu6GsfkkJZw2Q8mGAocthAXJy9dmIQxbw==
Message-ID: <cb91e5d3-7596-4564-9e0b-4819e437a692@datenfreihafen.org>
Date: Wed, 5 Jun 2024 22:02:24 +0200
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mac802154: Fix racy device stats updates by
 DEV_STATS_INC() and DEV_STATS_ADD()
To: Alexander Aring <aahringo@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Yunshui Jiang <jiangyunshui@kylinos.cn>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-wpan@vger.kernel.org, alex.aring@gmail.com,
 miquel.raynal@bootlin.com, davem@davemloft.net
References: <20240531080739.2608969-1-jiangyunshui@kylinos.cn>
 <41e4b0e3-ecc0-43ca-a6cd-4a6beb0ceb8f@datenfreihafen.org>
 <20240603165543.46c7d3b4@kernel.org>
 <CAK-6q+j7vBbeB5ZPdT6szgUzYhDiPyVuadLooOywOU7M0fpfzQ@mail.gmail.com>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <CAK-6q+j7vBbeB5ZPdT6szgUzYhDiPyVuadLooOywOU7M0fpfzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Jakub, Alex,

On 04.06.24 15:52, Alexander Aring wrote:
> Hi,
> 
> On Mon, Jun 3, 2024 at 7:56 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Mon, 3 Jun 2024 11:33:28 +0200 Stefan Schmidt wrote:
>>> Hello.
>>>
>>> On 31.05.24 10:07, Yunshui Jiang wrote:
>>>> mac802154 devices update their dev->stats fields locklessly. Therefore
>>>> these counters should be updated atomically. Adopt SMP safe DEV_STATS_INC()
>>>> and DEV_STATS_ADD() to achieve this.
>>>>
>>>> Signed-off-by: Yunshui Jiang <jiangyunshui@kylinos.cn>
>>>> ---
>>>>    net/mac802154/tx.c | 8 ++++----
>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
>>>> index 2a6f1ed763c9..6fbed5bb5c3e 100644
>>>> --- a/net/mac802154/tx.c
>>>> +++ b/net/mac802154/tx.c
>>>> @@ -34,8 +34,8 @@ void ieee802154_xmit_sync_worker(struct work_struct *work)
>>>>      if (res)
>>>>              goto err_tx;
>>>>
>>>> -   dev->stats.tx_packets++;
>>>> -   dev->stats.tx_bytes += skb->len;
>>>> +   DEV_STATS_INC(dev, tx_packets);
>>>> +   DEV_STATS_ADD(dev, tx_bytes, skb->len);
>>>>
>>>>      ieee802154_xmit_complete(&local->hw, skb, false);
>>>>
>>>> @@ -90,8 +90,8 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
>>>>              if (ret)
>>>>                      goto err_wake_netif_queue;
>>>>
>>>> -           dev->stats.tx_packets++;
>>>> -           dev->stats.tx_bytes += len;
>>>> +           DEV_STATS_INC(dev, tx_packets);
>>>> +           DEV_STATS_ADD(dev, tx_bytes, len);
>>>>      } else {
>>>>              local->tx_skb = skb;
>>>>              queue_work(local->workqueue, &local->sync_tx_work);
>>>
>>> This patch has been applied to the wpan tree and will be
>>> part of the next pull request to net. Thanks!
>>
>> Hi! I haven't looked in detail, but FWIW
>>
>> $ git grep LLTX net/mac802154/
>> $
>>
>> and similar patch from this author has been rejected:
>>
>> https://lore.kernel.org/all/CANn89iLPYoOjMxNjBVHY7GwPFBGuxwRoM9gZZ-fWUUYFYjM1Uw@mail.gmail.com/
> 
> In the case of ieee802154_tx() yes the tx lock is held so it's like
> what the mentioned link says. The workqueue is an ordered workqueue
> and you either have the driver async xmit option (the preferred
> option) or the driver sync xmit callback on a per driver (implies per
> interface) basis.

When I reviewed and applied this I did indeed not realize the ordered 
workqueue making this unnecessary.

> I also don't see why there is currently a problem with the current
> non-atomic way.

For me this looks more like a wrapper that could avoid future problems 
for no cost. I would not mind if the patch stays. But you are right, its 
not strictly needed. Want me to back it out again?

regards
Stefan Schmidt
