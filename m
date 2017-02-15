Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53017 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751443AbdBOL6J (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 15 Feb 2017 06:58:09 -0500
Subject: Re: [PATCH 5/5] 6lowpan: Use netdev addr_len to determine lladdr len
References: <20170209145551.12747-1-luiz.dentz@gmail.com>
 <20170209145551.12747-6-luiz.dentz@gmail.com>
 <7f9a9a39-fbe4-c577-3b8b-e8350634ddcb@pengutronix.de>
 <CABBYNZLdpFyVZri8MDFYpkVFk+krRNfaW6wQp5MWX--gdCqMew@mail.gmail.com>
 <39a225d6-ae53-6b5c-1ede-6f541b3585d1@pengutronix.de>
 <CABBYNZKFDejmop7Y7V-pn6Q_BjNtzm-tO+gd2YVd3-TO23mdKg@mail.gmail.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <4e00a4e3-35c4-156f-a8c0-8455b300e097@pengutronix.de>
Date: Wed, 15 Feb 2017 12:58:07 +0100
MIME-Version: 1.0
In-Reply-To: <CABBYNZKFDejmop7Y7V-pn6Q_BjNtzm-tO+gd2YVd3-TO23mdKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Patrik Flykt <patrik.flykt@linux.intel.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>


Hi,

On 02/15/2017 11:49 AM, Luiz Augusto von Dentz wrote:
> Hi Alex,
> 
> On Wed, Feb 15, 2017 at 12:21 PM, Alexander Aring <aar@pengutronix.de> wrote:
>>
>> Hi,
>>
>> On 02/15/2017 09:24 AM, Luiz Augusto von Dentz wrote:
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
>>>
>>
>> Yes, then please check everything which makes use of L3 address handling in
>> combination with the L2 address. This will be simple broken if you
>> remove the FF:FE pattern which was wrong before.
> 
> Nope, FF:FE is the correct filler bytes for the interface identifier
> in case you haven't read:
> https://wiki.tools.ietf.org/html/rfc7668#section-3.2.2
> 

Yes, but YOU fixing the L2 address handling to not use FF:FE bit pattern
anymore. You didn't touch all of compression/uncompression code which
still use "just copying 8 bytes from given lladdr to generate the IID".

>> In my patch-series I suppose I hit all parts and also testing it.
> 
> Im pretty sure it was only possible to test with Linux to Linux in
> terms of Ble 6lowpan since there did not existed anything else, now we
> have zephyr to interoperate which is what Im testing with.
> 

hmpf, what shall I say now... the BTLE 6LoWPAN code is still broken. At
my view of handling link-layer address.

>>>> Now I for this, I want to see a link-layer evaluation not address length based.
>>>> Please do so also for the other patch which fixing some behaviour in ipv6.
>>>> The reason is here that uncompress/compress addresses are defined by RFC
>>>> 6LoWPAN adapation.
>>>>
>>>> There is already a link-layer case, so please add BTLE LLTYPE there! Not
>>>> move your handling in default, add some WARN_ONCE there...
>>>
>>> Here I have to pretty blunt, it is a mistake to put link layer logic
>>> inside the 6lowpan module, first it creates a dependencies of these
>>> technologies and second it slow down the development because we end up
>>> with multiple trees having to synchronize which each other.
>>>
>>
>> This is only because the bluetooth 6LoWPAN implementation was wrong at
>> the initial commit.
>>
>> Synchronize each other? No, your changes doesn't require any 802.15.4
>> changes. You just need to fix it right and doing it not more broken than
>> before... which this patch does by fixing only the half of un/compress
>> addresses. Then some cases simple doesn't work. It's even worse, you
>> will grab 8 bytes from a pointer which is 6 bytes now.
> 
> Don't I have to update the parts under net/6lowpan, doesn't that get
> handled in linux-wpan tree? Doesn't linux-bluetooth needs to
> synchronize with linux-wpan in case any of these functions get
> changed? For example if we do introduce a callback...
> 

If you evaluate the LLTYPE before you can do what you want. But you need
to fix ALL handling of link-layer address compression/uncompression. You
changed only compress of stateful handling -> which is only 1/4 part of
what you need.

Sorry.

>> So now, to you link-layer logic... This is how 6LoWPAN works,
>> compression/uncompression will reconstruct L3 addresses from information
>> from L2 header...
>>
>> What we could do is to provide one callback to make a SLAAC address to a
>> given prefix, then call it in SLAAC generation (ipv6) or here in IPHC.
>> I think this is one of my 1001 cleanups for 6LoWPAN which I have in my
>> mind. Remove the switch-case stuff and make callback to provide this
>> handling which depends on L2 6LOWPAN implementation.
> 
> And who said that SLAAC needs to be generated by 6lowpan code? The
> fact that 6lowpan used SLAAC does not mean it has to be generated
> there, actually this is the very reason there so much duplicated code
> trying to generate the same ipv6 based on the MAC address when in fact
> it never changes.
> 

For stateless and source mac address -> the address will never changed.
I agree: for destination -> people can add different lladdr in ndisc.
Don't know the bluetooth policy there, maybe drop it... it should not
happen.

In case of stateful you don't know the L3 reconstruct address.

>> So we have no link-layer handling there anymore, but it's moved to a
>> callback which contains the 6LoWPAN BTLE module.
> 
> We can do this upfront, we just need to settle in a common format,
> e.g.: interface identifier and that it.
> 
>>> Also I have not seen a single mention of link local IP that is not
>>> using 6 or 8 bytes link layer format, and in fact if there exist one
>>> then we should probably have the caller handle the link local ip
>>> format, but then again I haven't seen any indication that these needs
>>> changing in fact for 15.4 16 bit address you can generate a valid 8
>>> bytes address before calling 6lowpan API, which is probably what we
>>> should do to avoid depending on 15.4 code inside 6lowpan.
>>>
>>
>> yes there is _currently_ not other 6LoWPAN implementation which has 8 or
>> 6 bytes.
>>
>> What do you think about a callback? Then these 2 byte 802.15.4 address
>> magic will be handled by net/ieee802154/6lowpan/core.c and we also can
>> call the callback in IPv6 code to make SLAAC address.
> 
> The IID should be enough.
> 

I don't know what I should say here. I need to work on my exam now. I am
busy with other things... send new patches and I will review it.

Do you see that you need to fix more of these stateless/stateful
compression functions?

- Alex
