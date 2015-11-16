Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:55907 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752867AbbKPOrD (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 16 Nov 2015 09:47:03 -0500
Subject: Re: LL address and IPv6 address
References: <CAPpUg6NwiRzUMEPGpZa3=Ppg3LF3N7u1=o_sA0+rp5aHt0CC9g@mail.gmail.com>
 <CAF4BF-TStucwTg5Kp+YAN735RNQUA+aLf1fEPRKW7uSNZXSKYw@mail.gmail.com>
 <CAPpUg6Pi3Z3fPsDX3EBYhfn96ZLgXxQ5TAYAr7Rk3MKHcoZqxA@mail.gmail.com>
 <CAPpUg6O65Uyy+rhOdqh-cKK_w-4SqPvi9Ho6AGBFD7xUq4hukw@mail.gmail.com>
 <20151112085333.GA3045@omega>
 <CAPpUg6P259rf9NXGpDXqNq2Qragc5Ht9ZvQCSaDGSG1vSWcbZg@mail.gmail.com>
 <25991.1447437856@sandelman.ca> <20151114103526.GB1652@omega>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <5649EC63.5000508@osg.samsung.com>
Date: Mon, 16 Nov 2015 15:46:59 +0100
MIME-Version: 1.0
In-Reply-To: <20151114103526.GB1652@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Michael Richardson <mcr@sandelman.ca>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hello.

Alex already gave all the answers so I will only poke in here and there.

On 14/11/15 11:35, Alexander Aring wrote:
> On Fri, Nov 13, 2015 at 01:04:16PM -0500, Michael Richardson wrote:
>> I hadn't realized until I was trying to communicate LL (fe80::) addresses to
>> a plugfest peer that the LL addresses and layer-2 addresses are not stable.
>> (no eeprom in at86af23x, most of the OpenMote/Redwire devices that Contiki
>> runs on have same issue)

Yeah, sadly this is a very common issue on embedded hardware as the 
manufactures love to save the 2 cent for an EEPROM holding this kind of 
information. :(

>> Yes, we can set them from /etc/network/interfaces using iwpan, but I'm a bit
>> not keen about this as a general solution.
>>
>> Now, I have some ideas about deploying (802.1AR) certificates that permit a
>> node to prove it owns a particular L2 address.  Given that certificate, I
>> might as well configure the l2 and short address, etc. directly from the info
>> in the certificate.  This solution will suit my needs well, but probably not
>> others.
>>
>> We do not have a kernel command line option to set the LL address, we should,
>> but in the specific case of the RPI, that won't help that much, because the
>> RPI doesn't use GRUB (nor uboot by default), so the cmdline is hard to
>> update.  Does this matter that much; I'm not sure.  Still, I think we should
>> have a non-programmatic way to do this, maybe some kind file in /etc,
>> or maybe a sensible recommendation for having udev do it.
>>
> Maybe you want a solution like this [0], it's not mainline because I am
> not sure if this is the right way to do it. Exactly because the reason
> that network-managers/"/etc/network/interfaces" can do that for you.
>
> The extended address is then bounded to the devicetree, if the driver
> supports it. It will first looking at devicetree for an
> extended-address. If there isn't any address node, then a random one is
> used.
>
> Such devicetree entry should be part of the devicetree API of 802.15.4
> transceivers then.
>
> The pro is currently what I see:
>
> Ethernet does the same way and this is maybe also a contra, because all
> bootloaders hacking "manipulating devicetree entry with my in EEPROM
> saved mac-address of bootloader configuration", some people are not
> happy about this solution currently and say it will be still supported
> because backwards compatibility.
>
> Well, I would give that a try. But maybe the devicetree maintainers will
> be a different meaning and will not accepting such solutions anymore.
> (I really don't know that, we should discuss this with the devicetree
> people).
>
> So far you this is the solution which you are looking for.
>

My personal feelings about this are that the device address, as a unique 
identifier, should be setup and done when the kernel is up. One could 
always do it during the system bringup with udev or in network 
interfaces, etc. But imho this is all to late.

When the best option (address in EEPROM) is not available going with 
device tree or a kernel commandline option is a good way imho.

>> I also noted that if I tried to change some things, such as panid and l2
>> address that it wouldn't work until I rebooted.  Probably there was another
>> sequence I could have used, but I didn't figure it out at the time.
>>
> Address parameters can changed if the interface is down only, or do you
> mean to have another default panid? The panid default is that what
> 802.15.4 describes and is not "implementation specific" like the
> extended-address. But I think you hit the issue that you can't change
> the link address while interface is up.
>

As Alex said, there should be nothing which would require a reboot. Most 
likely you would have needed to bring down the device for configure and 
back up afterwards.
>> Also, as far as I know, we can't operate on more than one panid at the same
>> time.  I could imagine that maybe one could create multiple lowpan on top of
>> the same wpanX interface, but the panid is actually at the lower level.
>>
> I think I need to know about more the use-case of "on more than one
> panid", what do you want to do exactly.
>
>   - Different source pan only
>
>   - Different destination pan only
>
>   - Different destination and source pan

Jup, use cases is really what we are looking for here. If you have good 
ones we can see what needs to be done on our side.

> We dropped the multiple lowpan interface support from a while, because
> no use-case was there, maybe this will be changed now. :-)
> Anyway with multiple lowpan interfaces support it would not support any
> multiple pan handling.
>
> I think I can talk more about that when I know the exactly use-case
> above and the "granularity" where do you want a multiple pan support.
>
>   - per ipv6 socket
>
>   - per namespace
>
>   - per lowpan dev
>
> -----
>
> I always supposed 802.15.4 6LoWPAN connection is intra-pan connection
> only. Please correct me if I am wrong. I need to be honest, I can
> argument only how "multicast ipv6 address" is mapped to LL addressing,
> see [1].
>
> "1.  A destination PAN identifier is included in the frame, and it
>   MUST match the PAN ID of the link in question."
>
> So ipv6 multicast address should map in broadcast intra-pan
> communication. "To get the same nodes in unicast, it's also intr-pan." <-
> Don't know if this is correct.
>
>
> The easiest use-case for running multiple pan's which you might to have
> is (I do some ascii art here):
>
> 	802.15.4 PHY
> 	    /\
> 	   /  \
> 	  /    \
> 	 /      \
>       wpan0     wpan1
>       -----     -----
>       panid     panid
>       0xbeef    0xabcd
>         |         |
>         |         |
>      lowpan0    lowpan1
>   (intra-pan)   (intra-pan)
>
> hopefully this is understanding what I mean there.
>
> So lowpan0 and lowpan1 does intra-pan communication only, but on two
> different pans (link-layer) on one phy.
>
> This currently not possible with the at86rf23x transceivers because the
> address-filtering. Otherwise the mac802154 stack allows such behaviour
> to add more than one wpan interface at one time for one phy.
>
> The solution would be maybe to add a new devicetree entry inside the
> at86rf23x transceiver driver, which turns the transceiver into a "raw"
> mode. I call it now raw mode, because it's not easy to turn off address
> filtering inside the at86af23x transceiver, it will be something about
> promiscuous mode and then doing all filtering of address inside the
> mac802154 stack (linux side).
>
> Such feature would be possible, but then you need to know what you doing
> because you disable the address filter which occurs more workload on
> linux side.
>
> btw: you can also get the same transceiver when using two phy's, it
> should be looking then like this:
>
>     802154 PHY  802154 PHY
>         |         |
>       wpan0     wpan1
>       -----     -----
>       panid     panid
>       0xbeef    0xabcd
>         |         |
>         |         |
>      lowpan0    lowpan1
>   (intra-pan)   (intra-pan)
>
> Okay, maybe you don't want to have two phy's connected. I can also think
> about the above solution, to disable MAC filtering on transceiver side,
> then doing filtering on linux side, which allows then multiple wpan
> interfaces at the same time. This is all, because the address filtering
> only accepts one source address for the registers. :-)
>
> The solution with two phy's would reduce cpu overhead, because address
> filtering on phy side.

There is at least one 802.15.4 IP block out there that markets the 
support for dual PAN ID.

http://www.freescale.com/products/arm-processors/kinetis-cortex-m/w-series/kinetis-kw2x-2.4-ghz-rf-analog-mixed-signal-ieee-802.15.4-low-power-microcontrollers-mcus:KW2x

So far this is only inside a wireless mcu combination and thus unrealted 
to us but maybe the IP block will be used in some other hardware later.

What I don't know is how this functionality is exposed by the hardware. 
Would it only have a few extra regs needed for the dual PAN setup or two 
full register sets? Would it have different regs for the two sets of 
address filters? Allowing to have the two PANs on different channels or 
only on one?

I could image various solutions in our stack to support things but we 
would need to see what hardware is out there to support it. I'm not 
really a big fan of designing everything in without having real users 
for it. We can always incrementally improve on what we are missing.

regards
Stefan Schmidt
