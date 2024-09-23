Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444FB194A59;
	Mon, 23 Sep 2024 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727095256; cv=none; b=GXVwxqvnUVCxxg1a2eqfN4dtB8++QQ9C/PHS1ai6LCQZAe8283npWA2749F5pK+wsDLxLiZfbVZaFMhE2bPM3NwmNf7fwUx1hxSTl0Awt4r1AeLnlv4vS+H/lzEQZfew6NPyBiFwhv/F8TCVjgauKZpudSMpL20D/5vwB9vNReg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727095256; c=relaxed/simple;
	bh=C38EdgS5FfaIoRYAzrkN+RfOaUBK10h5QOR+3+O/S5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZr2xq4RrpMDnkLC+LCr6DPHWnn5/Y2tMRgpL3xsQyt9mXE8RjicZxQmHYh2bfUuemxM7bKH+ffX6sGYY2E/A5+8GPRtj/eNX/VD3qmxVCA3HfYhNFR7HmBbS9GX2/3ZddpxUaxsDfQ11lwmXs8iiWP6Kg2SWwkCLYk5UidyLEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=kmQrLcbQ; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="kmQrLcbQ"
Received: from [192.168.2.107] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id A5366C06E3;
	Mon, 23 Sep 2024 14:40:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1727095242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2hbtl8bLLosWHhpcR1poBLxifvf9pp8+pX0ugzSRGw=;
	b=kmQrLcbQHGfZgqA95kFgorpWPIpO8Li0WtqPwXT8NQVl8IeU2QPkTo/Zcb6aavZyILDI/u
	koNVJk/1jX52DWPnfJZ/Su03j2VRGkP8C7wtJNoNkdeNORWruETcyT8MlkU4YsJKE2Z8Vq
	iVFXYbO4DtMn9kH/X9PKIc7QJNHRki2C/QyMcMuQt8OkNPuJiE5nZ6YPDdNuM0QbubBbBS
	WKjbIYr9KKLVEUepli9Wk3aTN3RRBgB8rOZRHsU+fAnuXcCsFbadtQLlXz2zwgvIaikqxW
	bH6jCJaJxr5QL8rUR7hxpANNRpQQAVUiuI1u2oc9HDGUKJBysz8JS1OUmYjyeA==
Message-ID: <0b1e94ce-f4c1-44d4-afbe-fe2dfca51de5@datenfreihafen.org>
Date: Mon, 23 Sep 2024 14:40:40 +0200
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mac802154: Fix potential RCU dereference issue in
 mac802154_scan_worker
To: Jiawei Ye <jiawei.ye@foxmail.com>, miquel.raynal@bootlin.com
Cc: alex.aring@gmail.com, davem@davemloft.net, david.girault@qorvo.com,
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com
References: <20240920132131.466e5636@xps-13>
 <tencent_51492FE7A9204AE5B3DC49FA4F144D310F08@qq.com>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <tencent_51492FE7A9204AE5B3DC49FA4F144D310F08@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello.

On 9/21/24 07:22, Jiawei Ye wrote:
> Hi Miquèl,
> 
> I'm sorry for the accidental email sent while testing my email setup. Please disregard the previous message.
> 
> On 9/20/24 19:21, Miquel Raynal wrote:
>> Hi Jiawei,
>>
>> jiawei.ye@foxmail.com wrote on Fri, 20 Sep 2024 04:03:32 +0000:
>>
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
>>
>> I think net maintainers now expect the Cc: stable tag to be put here
>> when there is a reason to backport, which I believe is the case here.
>> So please add this line here.
>>
> 
> Does this mean I should use Cc: stable@vger.kernel.org? I am not familiar with this procedure.

Yes.

>>>
>>
>> Please delete this blank line as well.
>>
>> And with that you can add my:
>>
>> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>
>>> ---
>>
>> Thanks,
>> Miquèl
> 
> Do I need to resend patch v2 with the "Resend" label?

Please make it a v3 right away, the resend with changes is to confusing 
for maintainers to keep up what to apply.

In your case remove the blank line, add the stable cc and I am happy to 
apply this.

regards
Stefan Schmidt
