Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:58973 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930AbbKZLLM (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 26 Nov 2015 06:11:12 -0500
Subject: Re: [RFCv2 bluetooth-next 2/3] ipv6: add ipv6_addr_prefix_cpy
References: <1447799594-6050-1-git-send-email-alex.aring@gmail.com>
 <1447799594-6050-3-git-send-email-alex.aring@gmail.com>
 <5655E50C.5090906@osg.samsung.com> <20151125181713.GC4652@omega>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <5656E8CB.5050903@osg.samsung.com>
Date: Thu, 26 Nov 2015 12:11:07 +0100
MIME-Version: 1.0
In-Reply-To: <20151125181713.GC4652@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, kernel@pengutronix.de, mcr@sandelman.ca, lukasz.duda@nordicsemi.no, martin.gergeleit@hs-rm.de, "David S . Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, James Morris <jmorris@namei.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Patrick McHardy <kaber@trash.net>

Hello.

On 25/11/15 19:17, Alexander Aring wrote:
> On Wed, Nov 25, 2015 at 05:42:52PM +0100, Stefan Schmidt wrote:
>> Hello.
>>
>> On 17/11/15 23:33, Alexander Aring wrote:
>>> This patch adds a static inline function ipv6_addr_prefix_cpy which
>>> copies a ipv6 address prefix(argument pfx) into the ipv6 address prefix.
>>> The prefix len is given by plen as bits. This function mainly based on
>>> ipv6_addr_prefix which copies one address prefix from address into a new
>>> ipv6 address destination and zero all other address bits.
>>>
>>> The difference is that ipv6_addr_prefix_cpy don't get a prefix from an
>>> ipv6 address, it sets a prefix to an ipv6 address with keeping other
>>> address bits. The use case is for context based address compression
>>> inside 6LoWPAN IPHC header which keeping ipv6 prefixes inside a context
>>> table to lookup address-bits without sending them.
>>>
>>> Cc: David S. Miller<davem@davemloft.net>
>>> Cc: Alexey Kuznetsov<kuznet@ms2.inr.ac.ru>
>>> Cc: James Morris<jmorris@namei.org>
>>> Cc: Hideaki YOSHIFUJI<yoshfuji@linux-ipv6.org>
>>> Cc: Patrick McHardy<kaber@trash.net>
>>> Signed-off-by: Alexander Aring<alex.aring@gmail.com>
>>> ---
>>>   include/net/ipv6.h | 15 +++++++++++++++
>>>   1 file changed, 15 insertions(+)
>>>
>>> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
>>> index e1a10b0..9d38fc2 100644
>>> --- a/include/net/ipv6.h
>>> +++ b/include/net/ipv6.h
>>> @@ -382,6 +382,21 @@ static inline void ipv6_addr_prefix(struct in6_addr *pfx,
>>>   		pfx->s6_addr[o] = addr->s6_addr[o] & (0xff00 >> b);
>>>   }
>>> +static inline void ipv6_addr_prefix_cpy(struct in6_addr *addr,
>>> +					const struct in6_addr *pfx,
>>> +					int plen)
>>> +{
>> Naming it ipv6_addr_prefix_cop, as Sergei suggested, would be easier to
>> read.
> ok.
>
>>> +	/* caller must guarantee 0 <= plen <= 128 */
>>> +	int o = plen >> 3,
>>> +	    b = plen & 0x7;
>>> +
>> Any reason you are not doing the memset here before memcpy like it is done
>> in ipv6_addr_prefi()?
> ipv6_addr_prefix is more a "getter" for a prefix from an address. The
> destination address (which should be the result) will memset the whole
> address before copy the prefix from address to it.

Ah, right. Missed that part.

> THe ipv6_addr_prefix_copy will set a prefix given by second parameter
> pfx and set the prefix to the address (given by first parameter).
>
> Maybe the ipv6_addr_prefix could call:
>
> 1. memset(pfx, sizeof...)
> 2. ipv6_addr_prefix_copy(pfx, addr, plen);
>
> but ipv6_addr_prefix_copy need to care about other bits which are set at
> destination address, if (plen/8 != 0). I don't want to touch
> ipv6_addr_prefix function and slow-down some mechanism.

No need to change this from my side. I just missed the memset being 
handled in the destination address.

With the name change to _copy you can add my

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
