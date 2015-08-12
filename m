Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:57368 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbbHLNsO (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 12 Aug 2015 09:48:14 -0400
Subject: Re: [RFC 10/16] ieee802154: 6lowpan: add dispatch evalualtion helpers
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
 <1438583035-6287-11-git-send-email-alex.aring@gmail.com>
 <55CB413E.4020304@osg.samsung.com> <20150812132031.GA3962@omega>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55CB4E99.5050905@osg.samsung.com>
Date: Wed, 12 Aug 2015 15:48:09 +0200
MIME-Version: 1.0
In-Reply-To: <20150812132031.GA3962@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hello.

On 12/08/15 15:20, Alexander Aring wrote:
> On Wed, Aug 12, 2015 at 02:51:10PM +0200, Stefan Schmidt wrote:
>> Hello.
>>
>> typo in subject. s/evalualtion/evaluation/
>>
> ok.
>
>> On 03/08/15 08:23, Alexander Aring wrote:
>>> This patch introduce some static inline function for checking the right
>>> dispatch value. This also fixes an bug to detect the right fragmentation
>>> dispatch value, we currently use "0xe0" as masking the fragmentation
>>> dispatch. Correct is "0xf8" as mask.
>>>
>>> Signed-off-by: Alexander Aring<alex.aring@gmail.com>
>>> ---
>>>   include/net/6lowpan.h              | 18 +++++++++++++-----
>>>   net/ieee802154/6lowpan/6lowpan_i.h |  3 +++
>>>   net/ieee802154/6lowpan/rx.c        | 30 +++++++++++++++++++++++++-----
>>>   3 files changed, 41 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
>>> index e16763f..073c791 100644
>>> --- a/include/net/6lowpan.h
>>> +++ b/include/net/6lowpan.h
>>> @@ -126,11 +126,19 @@
>>>   	 (((a)[6]) == 0xFF) &&	\
>>>   	 (((a)[7]) == 0xFF))
>>> -#define LOWPAN_DISPATCH_IPV6	0x41 /* 01000001 = 65 */
>>> -#define LOWPAN_DISPATCH_HC1	0x42 /* 01000010 = 66 */
>>> -#define LOWPAN_DISPATCH_IPHC	0x60 /* 011xxxxx = ... */
>>> -#define LOWPAN_DISPATCH_FRAG1	0xc0 /* 11000xxx */
>>> -#define LOWPAN_DISPATCH_FRAGN	0xe0 /* 11100xxx */
>>> +#define LOWPAN_DISPATCH_IPV6		0x41 /* 01000001 = 65 */
>>> +#define LOWPAN_DISPATCH_IPHC		0x60 /* 011xxxxx = ... */
>>> +#define LOWPAN_DISPATCH_IPHC_MASK	0xe0
>>> +
>>> +static inline bool lowpan_is_ipv6(u8 dispatch)
>>> +{
>>> +	return dispatch == LOWPAN_DISPATCH_IPV6;
>>> +}
>>> +
>>> +static inline bool lowpan_is_iphc(u8 dispatch)
>>> +{
>>> +	return (dispatch & LOWPAN_DISPATCH_IPHC_MASK) == LOWPAN_DISPATCH_IPHC;
>>> +}
>>>   #define LOWPAN_DISPATCH_MASK	0xf8 /* 11111000 */
>>> diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
>>> index d62046e..e009a4a 100644
>>> --- a/net/ieee802154/6lowpan/6lowpan_i.h
>>> +++ b/net/ieee802154/6lowpan/6lowpan_i.h
>>> @@ -7,6 +7,9 @@
>>>   #include <net/inet_frag.h>
>>>   #include <net/6lowpan.h>
>>> +#define LOWPAN_DISPATCH_FRAG1		0xc0
>>> +#define LOWPAN_DISPATCH_FRAGN		0xe0
>>> +
>>>   struct lowpan_create_arg {
>>>   	u16 tag;
>>>   	u16 d_size;
>>> diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
>>> index c7afd4a..b0066b7 100644
>>> --- a/net/ieee802154/6lowpan/rx.c
>>> +++ b/net/ieee802154/6lowpan/rx.c
>>> @@ -21,6 +21,16 @@ typedef unsigned __bitwise__ lowpan_rx_result;
>>>   #define RX_DROP			((__force lowpan_rx_result) 2u)
>>>   #define RX_QUEUED		((__force lowpan_rx_result) 3u)
>>> +#define LOWPAN_DISPATCH_FIRST		0xc0
>>> +#define LOWPAN_DISPATCH_FRAG_MASK	0xf8
>>> +#define LOWPAN_DISPATCH_IPHC_MASK	0xe0
>>> +
>>> +#define LOWPAN_DISPATCH_NALP		0x00
>>> +#define LOWPAN_DISPATCH_HC1		0x42
>>> +#define LOWPAN_DISPATCH_BC0		0x50
>>> +#define LOWPAN_DISPATCH_ESC		0x7f
>>> +#define LOWPAN_DISPATCH_MESH		0x80
>>> +
>> Any specific reason you moved the *_HC1 define here (same for the *_FRAG
>> defines above)?
>>
>> I would think having them all in 6lowpan.h would make most sense. You might
>> need them only in this file for now but later one maybe in another file. It
>> could be personal taste but having them all in one place should be easier.
>> imho.
> There exists 6LoWPAN functionality which is shared between BTLE 6LoWPAN
> and IEEE 802.15.4 6LoWPAN, these are:
>
>   - IPHC
>   - IPV6
>
> they use both the same dispatch values.
>
> The file "include/net/6lowpan.h" is part of the generic 6LoWPAN branch,
> so functionality which belongs to "IPHC" and "IPv6" (IPv6 dispatch is
> the easiest dispatch, there is only maybe this one inline function).
>
>
> The other dispatches are not defined for BTLE, e.g. fragmentation is
> handled by MAC layer of BTLE so far I know. Also HC1 is not defined for
> BTLE 6LoWPAN.

Ah, now I understand why you keep them separate. Just keep it like you 
have in this case.

regards
Stefan Schmidt
