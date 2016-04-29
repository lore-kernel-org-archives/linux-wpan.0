Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:24559 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802AbcD2O6L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 Apr 2016 10:58:11 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [riot-devel] RIOT+ULAs: no router entry
From: smlng <s@mlng.net>
In-Reply-To: <20160424203128.GA27936@omega>
Date: Fri, 29 Apr 2016 16:58:04 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <3CFBDFC0-3AB2-4931-8BCB-B034EBDC0B9C@mlng.net>
References: <B354489C-54BF-4CAF-8B41-04A946D83478@mlng.net> <20160422102833.GA5671@omega> <7BCB9BD8-C255-458C-83F6-0F7FE69F5C7F@mlng.net> <20160422122816.GA6364@omega> <20160424200528.GA27492@omega> <20160424203128.GA27936@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: RIOT OS kernel developers <devel@riot-os.org>

Hi Alex,
hi all,

over the last days I did some more extensive tests and enabled/added some debug output in RIOT, and I got close to the root cause of the problem. 

TL;DR: 
- Linux does not set the router flag in its NAs
- but it should when `radvd` is running (or `radvd` should enable it). 
- RIOT behaves correctly, according to RFC-4861 7.2.4.

----

Now the slightly longer version; I quickly recap my setup:

- a RasPi with OpenLabs transceiver, and `radvd` (linux-wpan version from github)
- Atmel samr21-xpro running RIOT with `gnrc_networking` example (2016.04-branch)
- `radvd` announces a ULA-prefix (though ULA doesn't matter, could global as well)

I observed the following behavior:

- RIOT send RS on boot, `radvd` on RasPi replies with RA (incl. PIO, ABRO, SLLAO)
- RIOT parse RA, generates IP from prefix, adds NCE for router with router flag set
- RIOT send NS for RasPi/routers link-local address -> RasPi replies with NA
- RIOT parses NA, but router flag not set -> unset router flag in NCE of router
- hence no more router in cache -> no ping or data transfer via non-link-local (e.g. ULA) IPs 

so my question @alex and @linux-wpan: can I manually set/enable the routers flag for NAs in Linux Kernel? Or somehow _convince_ `radvd` to do so on startup?
I'm running latest Raspbian with Kernel 'Linux raspberrypi 4.1.19+' and wpan-tools from github on the RasPi.

Best,
  Sebastian

> Am 24.04.2016 um 22:31 schrieb Alexander Aring <alex.aring@gmail.com>:
> 
> Hi,
> 
> On Sun, Apr 24, 2016 at 10:05:28PM +0200, Alexander Aring wrote:
>> Hi,
>> 
>> On Fri, Apr 22, 2016 at 02:28:16PM +0200, Alexander Aring wrote:
>>> On Fri, Apr 22, 2016 at 01:13:29PM +0200, smlng wrote:
>> ...
>>>> 
>>>> @Alex as you joined the discussion: I also have a question regarding the Linux side. I currently use Raspbian with shipped Linux-Kernel 4.1.19. I observed that Linux still does NS for link-local address via the nodes scoped multicast address, instead of using 6lo 'shortcut' by extracting LL/MAC-address from the link-local IP. Is this fixed in some recent version?
>>>> 
>>> 
>>> There are currently pending patches for introducing neigh_ops, which is
>>> a callback strucuture for send/recv NS/NA. After this is mainline it
>>> should be easily to change this behaviour, or? What do you think?
>>> See [3] - function "lowpan_ndisc_send_ns".
>>> 
>> 
>> I think, I know what you mean. There is some NS with src as unspecified
>> addr "::" and dest is some "multicast node scope".
>> 
>> RFC 6775 says [0]:
>> 
>> An unspecified source address MUST NOT be used in NS messages.
>> 
>> Additional to the pending patches I added:
>> 
>> diff --git a/net/6lowpan/ndisc.c b/net/6lowpan/ndisc.c
>> index d088295..c6207cd 100644
>> --- a/net/6lowpan/ndisc.c
>> +++ b/net/6lowpan/ndisc.c
>> @@ -386,8 +386,11 @@ static void lowpan_ndisc_send_ns(struct net_device *dev,
>>                saddr = &addr_buf;
>>        }
>> 
>> +       /* RFC6775:
>> +        * An unspecified source address MUST NOT be used in NS messages.
>> +        */
>>        if (ipv6_addr_any(saddr))
>> -               inc_opt = false;
>> +               return;
> 
> Question would here also, if we really wants to drop it or use ?link-local?
> saddr then.
> 
>>        if (inc_opt) {
>>                optlen += ndisc_opt_addr_space(dev, dev->addr_len);
>>                optlen += lowpan_ndisc_802154_short_addr_space(dev);
>> 
>> 
>> This will not sending NS with "::" addresses as source address.
>> 
>> However, it's a little bit ugly we should prevent to calling this
>> callback when source address is "::".
>> 
>> This patch should be fine at first but can maybe optimized in future.
>> 
> 
> I think what you ask is the complete ARO stuff support and I can't
> follow the:
> 
> "by extracting LL/MAC-address from the link-local IP." in case of
> destination address and sending NS. What I found is the "Sending NS"
> section of rfc6775 [0], which doesn't say anything about different
> destination address.
> 
> Also I found a bootstrapping example in case of 6LN -> 6LR, [1]. But they
> meant there the GP64 and link-local is defined as LL64.
> 
> ...
> 
> I think I need to look deeper into that to say something related to
> 6LoWPAN-ND. :-)
> 
> - Alex
> 
> [0] https://tools.ietf.org/html/rfc6775#section-5.5.1
> [1] https://tools.ietf.org/html/rfc6775#section-10.2.1
> _______________________________________________
> devel mailing list
> devel@riot-os.org
> https://lists.riot-os.org/mailman/listinfo/devel

