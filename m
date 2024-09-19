Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB35C19E7D1;
	Thu, 19 Sep 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726751141; cv=none; b=N4xmuM/CW6kxzd1dMUiXtdzon5KQU95z2eNktFh0B4LK7AWNGUMcOUNvRE+W/NwJtts49URN7PebRD118W9mUCX6J2sRTRkq5Mk64i/MW5h8H9SpEKf7fgPW16u4gm1iMldL421KZFOAfCxUvZGJbdLdask54OKQM6DhCBGcSHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726751141; c=relaxed/simple;
	bh=FiGre3xQQE6hhmjM+oLWLYutnnKrJlKisaObM0PtP1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=in0TLhMLyRTruLHgyWV0cPDf5e7zXbGYzf7r8y5tTOsWKAbjnWXVqmouf4JRY+DBq31KJQs9zH/NLfckoFWcrYgDpSKUyBDF+ydaUo03SapCwwss0H2ocx0v4r0wNur0v3+yHhFcptDG0lQ318TWefEIIa8veFT7lzwS3iP0ZZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=thVROKO8; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="thVROKO8"
Received: from [10.136.2.92] (unknown [83.68.141.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 22EF4C00E0;
	Thu, 19 Sep 2024 15:05:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1726751127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Y57BPJyLA/lM4BrWgu/heI5PAlRBELA1lH/W+055F4=;
	b=thVROKO8bl3415p4kWDD4FfRfBV8q2SfH3d2AeaHinRNwf3p/LaOfWuoQoH1YmkPuFTv4p
	66Uwz2KutqGzYr31lUdxqbv8BtWwI4ADGzqmHRrL5xM+z6EhZtt9QRkA2CopjjPton0LOZ
	L/1NgQ3vGWKfyl4OWyoVgiL4kwJSfNzYq9JMVK0E3kLL396aX5773kat/SXASLV8HXEyfh
	52CqEprWVKQGenlKPs899uQ4Oe6sgpgY9fhj0uM4g7bnDiYPTZsKygbMcJZVWZ0ViAL3RE
	bW6JUzSBuRLX+QHZNI515/jkWPy2hpWNWL1nRaOd6SqfuL63bDH8y/a9ImdHNg==
Message-ID: <11239363-1608-44a4-bfab-d188f6e0934e@datenfreihafen.org>
Date: Thu, 19 Sep 2024 15:05:26 +0200
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix the RCU usage in mac802154_scan_worker
To: Jiawei Ye <jiawei.ye@foxmail.com>, przemyslaw.kitszel@intel.com
Cc: alex.aring@gmail.com, davem@davemloft.net, david.girault@qorvo.com,
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <f3c26426-7ebb-4b8b-9443-f604292a53a9@intel.com>
 <tencent_8C653C3534893CF0BC88A43A2831CDA2260A@qq.com>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <tencent_8C653C3534893CF0BC88A43A2831CDA2260A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jiawei,

On 9/19/24 14:26, Jiawei Ye wrote:
> On 9/19/24 17:01, Przemek Kitszel wrote:
>>> In the `mac802154_scan_worker` function, the `scan_req->type` field was
>>> accessed after the RCU read-side critical section was unlocked. According
>>> to RCU usage rules, this is illegal and can lead to unpredictable
>>> behavior, such as accessing memory that has been updated or causing
>>> use-after-free issues.
>>>
>>> This possible bug was identified using a static analysis tool developed
>>> by myself, specifically designed to detect RCU-related issues.
>>>
>>> To address this, the `scan_req->type` value is now stored in a local
>>> variable `scan_req_type` while still within the RCU read-side critical
>>> section. The `scan_req_type` is then used after the RCU lock is released,
>>> ensuring that the type value is safely accessed without violating RCU
>>> rules.
>>>
>>> Fixes: e2c3e6f53a7a ("mac802154: Handle active scanning")
>>> Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
>>> ---
>>>    net/mac802154/scan.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
>>> index 1c0eeaa76560..29cd84c9f69c 100644
>>> --- a/net/mac802154/scan.c
>>> +++ b/net/mac802154/scan.c
>>> @@ -180,6 +180,7 @@ void mac802154_scan_worker(struct work_struct *work)
>>>    	unsigned int scan_duration = 0;
>>>    	struct wpan_phy *wpan_phy;
>>>    	u8 scan_req_duration;
>>> +	enum nl802154_scan_types scan_req_type;
>>
>> this line violates the reverse X-mass tree rule of code formatting
> 
> Thank you for pointing out the concern regarding the violation of the
> reverse Christmas tree rule. I will adjust the placement of
> `enum nl802154_scan_types scan_req_type` to be between
> `struct cfg802154_scan_request *scan_req` and
> `struct ieee802154_sub_if_data *sdata`. If this change is suitable,
> should I resend the patch as a v2 patch?

Yes, please always increase the version whenever you change something 
and re-send. Also a ChangeLog of the changes makes it a lot easier for 
the reviewer.

regards
Stefan Schmidt
