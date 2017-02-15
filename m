Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36130 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751421AbdBOKyX (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 15 Feb 2017 05:54:23 -0500
MIME-Version: 1.0
In-Reply-To: <1d730de9-7665-e231-cbe5-d5b376499e7c@pengutronix.de>
References: <20170209145551.12747-1-luiz.dentz@gmail.com> <20170209145551.12747-6-luiz.dentz@gmail.com>
 <7f9a9a39-fbe4-c577-3b8b-e8350634ddcb@pengutronix.de> <CABBYNZLdpFyVZri8MDFYpkVFk+krRNfaW6wQp5MWX--gdCqMew@mail.gmail.com>
 <CABBYNZK6Zy7VZmKhZfodiOkj52w=OQ5vEOVf00co1HDfJpqXKQ@mail.gmail.com> <1d730de9-7665-e231-cbe5-d5b376499e7c@pengutronix.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 15 Feb 2017 12:54:20 +0200
Message-ID: <CABBYNZ+_-w2OXhAPRFaiWCd9JeZdBHMLurvbiOwLA5q+JDeyTw@mail.gmail.com>
Subject: Re: [PATCH 5/5] 6lowpan: Use netdev addr_len to determine lladdr len
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Patrik Flykt <patrik.flykt@linux.intel.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hi Alex,

On Wed, Feb 15, 2017 at 12:28 PM, Alexander Aring <aar@pengutronix.de> wrote:
> Hi,
>
> On 02/15/2017 11:16 AM, Luiz Augusto von Dentz wrote:
>> Hi Alex,
>>
>> On Wed, Feb 15, 2017 at 10:24 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Alex,
>>>
>>> On Wed, Feb 15, 2017 at 9:44 AM, Alexander Aring <aar@pengutronix.de> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 02/09/2017 03:55 PM, Luiz Augusto von Dentz wrote:
>>>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>>>
>>>>> This allow technologies such as Bluetooth to use its native lladdr which
>>>>> is eui48 instead of eui64 which was expected by functions like
>>>>> lowpan_header_decompress and lowpan_header_compress.
>>>>>
>>>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>>> ---
>>>>>  net/6lowpan/iphc.c      | 17 +++++++++++++++--
>>>>>  net/bluetooth/6lowpan.c | 43 ++++++++++---------------------------------
>>>>>  2 files changed, 25 insertions(+), 35 deletions(-)
>>>>>
>>>>> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
>>>>> index fb5f6fa..ee88feb 100644
>>>>> --- a/net/6lowpan/iphc.c
>>>>> +++ b/net/6lowpan/iphc.c
>>>>> @@ -827,8 +827,21 @@ static u8 lowpan_compress_ctx_addr(u8 **hc_ptr, const struct net_device *dev,
>>>>>               }
>>>>>               break;
>>>>>       default:
>>>>> -             /* check for SAM/DAM = 11 */
>>>>> -             memcpy(&tmp.s6_addr[8], lladdr, EUI64_ADDR_LEN);
>>>>> +             switch (dev->addr_len) {
>>>>> +             case ETH_ALEN:
>>>>> +                     memcpy(&tmp.s6_addr[8], lladdr, 3);
>>>>> +                     tmp.s6_addr[11] = 0xFF;
>>>>> +                     tmp.s6_addr[12] = 0xFE;
>>>>> +                     memcpy(&tmp.s6_addr[13], lladdr + 3, 3);
>>>>> +                     break;
>>>>> +             case EUI64_ADDR_LEN:
>>>>> +                     memcpy(&tmp.s6_addr[8], lladdr, EUI64_ADDR_LEN);
>>>>> +                     break;
>>>>> +             default:
>>>>> +                     dam = LOWPAN_IPHC_DAM_11;
>>>>> +                     goto out;
>>>>> +             }
>>>>> +
>>>>>               /* second bit-flip (Universe/Local) is done according RFC2464 */
>>>>>               tmp.s6_addr[8] ^= 0x02;
>>>>
>>>> move this handling in per link-layer layer decision, see below.
>>>>
>>>>>               /* context information are always used */
>>>>
>>>> PLEASE... and this is one of my rant!
>>>>
>>>> PLEASE LOOK WHAT I HAVE DONE IN THIS FILE IN MY RFC PATCH SERIES YOU
>>>> NEED TO FIX MORE THAN JUST CONTEXT BASED COMPRESSION.
>>>>
>>>> e.g. stateless un/compression
>>>
>>> I haven't changed that and probably it needs a separate patch in that
>>> case since Im only, and I really mean only, fixing the address length
>>> and because your patches end up changing a lot more things it is
>>> pretty hard to extract the exact parts that fixes this.
>>
>> Btw I just checked your patch and there doesn't seem to have fix what
>> you saying, in fact it is exact the same code as above:
>>
>> http://www.spinics.net/lists/linux-bluetooth/msg67937.html
>>
>
> Just to be sure we talking about the both thing:
>
> For example:
>   lowpan_iphc_uncompress_addr
>
>
> You didn't changed that function which still use 8 byte lladdr and FF:FE
> pattern. It will still be broken.

And what make you believe it was broken in the first place, ndisc was
broken because of address length was wrong but in case of 6lowpan it
is still correct to use FF:FE in the IID following which is what is
state here:

https://wiki.tools.ietf.org/html/rfc7668#section-3.2.2

> My idea: Make a callback with prefix and lladdr as parameter to generate
> such address. Then on stateless you can call it with L2 saddr/daddr and
> ff80::/64 prefix. For stateful the same but with prefix from context
> table.

These address never changes in case of Bluetooth, besides I don't
think we want to risk the callback calling something else in a
re-entrant fashion, so I think what we should give the IID or the
link-local ipv6 address directly and stop generating the address on
every compress/uncompress.


-- 
Luiz Augusto von Dentz
