Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E6247ECF2;
	Wed,  2 Sep 2026 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352533; cv=none; b=Dkw9+xEQKU/2fA7p1VCaQ+PFGqdDv0zrS+doRnqiKj45VZdF90690ewthLYAsadOFOF+nepHQV397D4gwzQpC3USX/5iI8WZoVo+WOxxfApkemwpWk9cmvnsgQ049ZJEDMAxRCtT8UT8Wy849xFZj/3jS6MUdl7z67TfzUHAaG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352533; c=relaxed/simple;
	bh=/mJqXti8QBJSd6BhhOZy12f+td/MAipAzf1teO2oGCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjI7uw5CUJNPui4xdzoYCRfjRzuZbvj4STw+NIHWa+9y0zm14zN7zOkHfL6xl/VF/jluZXjXj6RKb2ZL7uM6jEl/Yb92X5dfOIKqNXBxXH/ivMR94ib6aMNZ+4gpDlOZx8WDuQxJPUXWZnJIHk0HWRGPhH/6lFk/eD8q43AR2d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=qJAcqk5Q; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="qJAcqk5Q"
Received: from [192.168.2.30] (unknown [46.253.254.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 15BF4C05C4;
	Wed,  2 Sep 2026 14:35:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1788352525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAzGcaQ3QymzfPM8l8G2UeopGjsr8CDlo4Gd16dLAFU=;
	b=qJAcqk5QpmT7T+XDtcYo3OEea2cTt1y5c+6p2RbLdTOZVb7DKeC3vyPI7T6+Pd3RpIpv7r
	Ex0nQGhWx+MesJNuqyaxX1/T90G1fZlZMbgiXyiL1R+fogdwGw00jV54ACKHjvui0wKN3o
	344C0J6OgGOoKFjTC8TcQRJ1HLHDzXf9DpmjLyNqDrq9DSMbo83XF9dGtrQg9xTnVsnnuh
	3e4YEiOgtr08TWDJDqSfHCFLYzA3MWGb79Mim+WUimlUij7TO5RKx3adVj7MFMNc4aqOMb
	ypU+3KFnzzDzI0vzxm/vAmSYE9hAL8YWKzidgLj/ySDkcITe5QTq6StkL1veGQ==
Message-ID: <ceb38e6c-832e-4345-bbc3-52721aa4b6c6@datenfreihafen.org>
Date: Wed, 2 Sep 2026 14:35:23 +0200
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] mac802154: fix netdev use-after-free in beacon
 worker
To: zihan xi <zihanx@nebusec.ai>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, alex.aring@gmail.com,
 miquel.raynal@bootlin.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, david.girault@qorvo.com, vega@nebusec.ai
References: <cover.1785596603.git.zihanx@nebusec.ai>
 <e9a3909c7a6281967961773ca841e860b8ecf40e.1785596603.git.zihanx@nebusec.ai>
 <6326f119-048e-4d46-ab2f-debb20420297@datenfreihafen.org>
 <CAANe3eSyr9sSS1q1LfFXztXaZGXMR0HAiYmT4=eBhf0M5asrXQ@mail.gmail.com>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <CAANe3eSyr9sSS1q1LfFXztXaZGXMR0HAiYmT4=eBhf0M5asrXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Zihan,

On 9/2/26 12:16, zihan xi wrote:
> On Wed, Sep 2, 2026 at 4:15 PM Stefan Schmidt <stefan@datenfreihafen.org> wrote:
>>
>> Hello Zihan,
>>
>> On 8/2/26 11:23, Zihan Xi wrote:
>>> mac802154_beacon_worker() reads local->beacon_req under RCU and derives
>>> the sub-interface from the request, but then drops the RCU read lock and
>>> continues to use both sdata and the embedded wpan_dev.
>>>
>>> mac802154_stop_beacons_locked() cancels only pending beacon work, clears
>>> local->beacon_req and frees the request.  A beacon worker that is already
>>> running can therefore continue after interface teardown and dereference
>>> the freed netdev private area.
>>>
>>> The scan worker already pins the netdev before leaving RCU.  Apply the
>>> same lifetime rule to the beacon worker: take a netdev reference while
>>> the request is still protected by RCU, and release it on all paths that
>>> continue after the reference is acquired.
>>>
>>> Fixes: 3accf4762734 ("mac802154: Handle basic beaconing")
>>> Cc: stable@vger.kernel.org
>>> Reported-by: Vega <vega@nebusec.ai>
>>> Assisted-by: Codex:gpt-5.4
>>> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
>>> ---
>>>    net/mac802154/scan.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
>>> index 65089826f..ebd092d40 100644
>>> --- a/net/mac802154/scan.c
>>> +++ b/net/mac802154/scan.c
>>> @@ -416,6 +416,7 @@ void mac802154_beacon_worker(struct work_struct *work)
>>>        struct cfg802154_beacon_request *beacon_req;
>>>        struct ieee802154_sub_if_data *sdata;
>>>        struct wpan_dev *wpan_dev;
>>> +     netdevice_tracker dev_tracker;
>>>        u8 interval;
>>>        int ret;
>>>
>>> @@ -427,12 +428,14 @@ void mac802154_beacon_worker(struct work_struct *work)
>>>        }
>>>
>>>        sdata = IEEE802154_WPAN_DEV_TO_SUB_IF(beacon_req->wpan_dev);
>>> +     netdev_hold(sdata->dev, &dev_tracker, GFP_ATOMIC);
>>>
>>>        /* Wait an arbitrary amount of time in case we cannot use the device */
>>>        if (local->suspended || !ieee802154_sdata_running(sdata)) {
>>>                rcu_read_unlock();
>>>                queue_delayed_work(local->mac_wq, &local->beacon_work,
>>>                                   msecs_to_jiffies(1000));
>>> +             netdev_put(sdata->dev, &dev_tracker);
>>>                return;
>>>        }
>>>
>>> @@ -450,6 +453,7 @@ void mac802154_beacon_worker(struct work_struct *work)
>>>        if (interval < IEEE802154_ACTIVE_SCAN_DURATION)
>>>                queue_delayed_work(local->mac_wq, &local->beacon_work,
>>>                                   local->beacon_interval);
>>> +     netdev_put(sdata->dev, &dev_tracker);
>>>    }
>>>
>>>    int mac802154_stop_beacons_locked(struct ieee802154_local *local,
>>
>>
>> This patch does no longer apply. Please rebase and re-send.
>>
>> regards
>> Stefan Schmidt
> 
> Hi Stefan,
> 
> thanks for taking a look.
> 
> This change already landed in net.git as 5f26a690e8ef
> ("mac802154: fix netdev use-after-free in beacon worker"),
> applied by Jakub with Miquel's Reviewed-by.

Ah, I missed that Jakub took it already. Thanks.

> If wpan.git still needs a rebased copy, I can send that. Otherwise
> I will leave it as is to avoid a duplicate.

No need. Its fine as is now.

regards
Stefan Schmidt

