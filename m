Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D401465A0
	for <linux-wpan@vger.kernel.org>; Fri, 13 Sep 2024 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726257220; cv=none; b=rJuwlVUo1cvYdvM45gGipbNh4bNZ66SmMcKDfW197IAF99E16PAKmL2mFYFhTbP7zStgI4yC08yRl9ZCFP7NK9XdeX0r9/uh0zV08UNcjKEtXy8bT7oxJBiqfe5VgBpvvUoGW2SBf05vjSDotH13/O+oQdAYtXafBt4knwuHvAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726257220; c=relaxed/simple;
	bh=WjfKP7JhQEBvrfElRs+ybyQ/X2XIoB8A56mCv2deSxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLWK/55W2TsX3opLG2AgsU0J7yNpwDo6eGwyrdR++C3C5HSX19bnz7MIte4TtLX8LNtKDIU71tmcC+1nxOZi/qsYKiXVKkCiettj7GVNgmT3k4/52WTXYR2/kYAWjwMsu/W02NPzjJs116AjbRKYfVpFLvKZujltpFaeQZKPNxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=utmbzd0I; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="utmbzd0I"
Received: from [192.168.2.107] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 3BD94C0209;
	Fri, 13 Sep 2024 21:53:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1726257210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6tB8WWh9k2G+OeWEgWQ2jWKgmJ6JWLSUu1RSg2Wihzo=;
	b=utmbzd0If9uAAeO7dGYCCnTnADMceeOnBGFAJIDO0YMLBSi2o36j57B4tN9MvtofPA2An9
	VFI2I9nxxNlR+TSsZ4lsuJPbC8EbQ8B0pY7nY9fOkEtLRTmsJHLMBGUayRfnhcFkxQ3Ol+
	DUCcsSZP4VCguon0+Z7O2C0anzR148Y3YsN/F40w6FINx0MhXdF5AZF4abdCtAVNf+dm89
	v+aX0Oxs8OC07PKgSSnsm8T/5hx+ZhKfuGI+T70pgcFygXWV1v+TYtHTVIV0HGtdze7ZiY
	VRFnyghe6pAXVIctWDDUBZxpoucHOAF0yxKdatY1oTlSp4nwl3AVWQtocB8TyQ==
Message-ID: <96117fb8-0f2c-4bd4-ae0e-6e4b3034a7c9@datenfreihafen.org>
Date: Fri, 13 Sep 2024 21:53:29 +0200
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 802.15.4-2020 PHR field changes
To: Alexander Aring <aahringo@redhat.com>, James Hanley <jhanley@dgtlrift.com>
Cc: linux-wpan@vger.kernel.org
References: <A99422D6-46AE-42D1-852D-85D3EC3AFD53@dgtlrift.com>
 <CAK-6q+jqJ=xaLH_G08hU0qNVXqoeqaA+_u20s4H+aiqt_70sFg@mail.gmail.com>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <CAK-6q+jqJ=xaLH_G08hU0qNVXqoeqaA+_u20s4H+aiqt_70sFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 9/13/24 12:59 AM, Alexander Aring wrote:
> Hi,
> 
> On Mon, Sep 9, 2024 at 8:19 PM James Hanley <jhanley@dgtlrift.com> wrote:
>>
>> Has there been any effort to understand the changes needed to include/net/ieee802154.h and associated files within drivers/net/ieee802154 to support the ratification of 15.4-2020?  One prime example is the "Extended PHR" bit which was previously reserved to now allow extend the PHR of 2 more octets giving bits 8-11 to be used for "Frame Length MSB" and bits 12-15 marked as "Reserved" - this in combination of the legacy PHR bits 0-6 labeled as "Frame Length LSB" now allows for a frame MTU of 2048 octets.
>>
>> The 802.15.4-2020 is available individually free of charge through the IEEE website through the IEEE Get Program. https://ieeexplore.ieee.org/document/9144691
>>
>> Is there a way to prototype these new changes to the spec with the mac802154_hwsim driver?
>>
> 
> mac802154_hwsim driver uses mac802154 the SoftMAC implementation.
> There are quite more changes necessary as the whole mac802154 stack
> deals with static 127 bytes MTU defines, etc. Unfortunately, it isn't
> just a driver change.

I understand it the way that James actually wanted to try prototyping 
stack changes and verify with hwsim. James, could you clarify?

To answer your question, we currently have no support for any of the 
newer 802154 specs. :/ Bigger MTU was brought up before (IIRC in the 
subGHz context) but nobody started to actually work on it.

We are happy to take changes in, but currently we have no plans on our 
side to get this going.

regards
Stefan Schmidt
