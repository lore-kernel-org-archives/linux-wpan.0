Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E4D379C49;
	Wed,  2 Sep 2026 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336916; cv=none; b=t+8MAxbMfSMO6A+TvVOqWBlWJuwvKwN51I7ITfhtKN6V/ldof7iFtZR6r6IOymnNA3pDgD/BpxI1kPCYEOp9xVWe6kAd1zk9bQ8F/7eyZUB6oz9xTseGtywTiR9GX52yud2BZ+tkBV5ac/f8DL6ix67ZAB8G1skq1XF775TankY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336916; c=relaxed/simple;
	bh=Q0WhKxDSOpoFhpoIf/iwsTotUGooaR1OtjWFgYecLso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GB7gULAAX5GD5dOofszCqh4IjZ6qpc3q3sOaobthUw5aFFywpQSzZVLPWyzNGQuV3saD9r9KvXNqybGpDW6gHLkS2J1A9kCviocMb0M1b01+OTnfu5WU1YH4aLlUqGmRtpG+yNMYnGPKWn5DN+Plt8HKvnllW+d+Kj4QnYSqNpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=FuOMzhIC; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="FuOMzhIC"
Received: from [192.168.2.30] (unknown [46.253.254.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 6F528C05C4;
	Wed,  2 Sep 2026 10:15:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1788336912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9u6Ngpvb47EUV9DRWgnCGze3rAxUpePRE8M/w6FOU4=;
	b=FuOMzhICKr1P8ZWEMQHafzLhqqHkkanjI3671aCIbBZ4J9vRPzMEH7L34JvpIHp5m9ziry
	/vKZVAEU4eUGxHbWxJOY3O8cWgWcbaWpaYsfj9bvMSsOuZeSkVuBlVp13agDhPWs1jie9V
	jUzY/ZJl+8snF3SB+V0ZLRSKyXS5p1jStZDTrRZMi1ungO6iq5/prrRNTwce/2nZlNSoBZ
	cGchxiFXJAr00BViOP/Q//tLUiKO82Yi+S27ScUfil9VmscBeQlqS+utwHg3tWBMOQbdVH
	AAHWgClfP/imRxFDbH2OMjC2XvlS08ns/uHAC6+yNGEPDOCrKw2+lLypKgJH5Q==
Message-ID: <6326f119-048e-4d46-ab2f-debb20420297@datenfreihafen.org>
Date: Wed, 2 Sep 2026 10:15:10 +0200
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] mac802154: fix netdev use-after-free in beacon
 worker
To: Zihan Xi <zihanx@nebusec.ai>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org
Cc: alex.aring@gmail.com, miquel.raynal@bootlin.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 david.girault@qorvo.com, vega@nebusec.ai
References: <cover.1785596603.git.zihanx@nebusec.ai>
 <e9a3909c7a6281967961773ca841e860b8ecf40e.1785596603.git.zihanx@nebusec.ai>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <e9a3909c7a6281967961773ca841e860b8ecf40e.1785596603.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Zihan,

On 8/2/26 11:23, Zihan Xi wrote:
> mac802154_beacon_worker() reads local->beacon_req under RCU and derives
> the sub-interface from the request, but then drops the RCU read lock and
> continues to use both sdata and the embedded wpan_dev.
> 
> mac802154_stop_beacons_locked() cancels only pending beacon work, clears
> local->beacon_req and frees the request.  A beacon worker that is already
> running can therefore continue after interface teardown and dereference
> the freed netdev private area.
> 
> The scan worker already pins the netdev before leaving RCU.  Apply the
> same lifetime rule to the beacon worker: take a netdev reference while
> the request is still protected by RCU, and release it on all paths that
> continue after the reference is acquired.
> 
> Fixes: 3accf4762734 ("mac802154: Handle basic beaconing")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> ---
>   net/mac802154/scan.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
> index 65089826f..ebd092d40 100644
> --- a/net/mac802154/scan.c
> +++ b/net/mac802154/scan.c
> @@ -416,6 +416,7 @@ void mac802154_beacon_worker(struct work_struct *work)
>   	struct cfg802154_beacon_request *beacon_req;
>   	struct ieee802154_sub_if_data *sdata;
>   	struct wpan_dev *wpan_dev;
> +	netdevice_tracker dev_tracker;
>   	u8 interval;
>   	int ret;
>   
> @@ -427,12 +428,14 @@ void mac802154_beacon_worker(struct work_struct *work)
>   	}
>   
>   	sdata = IEEE802154_WPAN_DEV_TO_SUB_IF(beacon_req->wpan_dev);
> +	netdev_hold(sdata->dev, &dev_tracker, GFP_ATOMIC);
>   
>   	/* Wait an arbitrary amount of time in case we cannot use the device */
>   	if (local->suspended || !ieee802154_sdata_running(sdata)) {
>   		rcu_read_unlock();
>   		queue_delayed_work(local->mac_wq, &local->beacon_work,
>   				   msecs_to_jiffies(1000));
> +		netdev_put(sdata->dev, &dev_tracker);
>   		return;
>   	}
>   
> @@ -450,6 +453,7 @@ void mac802154_beacon_worker(struct work_struct *work)
>   	if (interval < IEEE802154_ACTIVE_SCAN_DURATION)
>   		queue_delayed_work(local->mac_wq, &local->beacon_work,
>   				   local->beacon_interval);
> +	netdev_put(sdata->dev, &dev_tracker);
>   }
>   
>   int mac802154_stop_beacons_locked(struct ieee802154_local *local,


This patch does no longer apply. Please rebase and re-send.

regards
Stefan Schmidt
