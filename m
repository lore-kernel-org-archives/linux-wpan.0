Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33236 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbbEDJVp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 4 May 2015 05:21:45 -0400
Received: by wief7 with SMTP id f7so73092534wie.0
        for <linux-wpan@vger.kernel.org>; Mon, 04 May 2015 02:21:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150504084432.GA2385@omega.Speedport_W_921V_1_37_000>
References: <CAG9Fz+sU3k2U03szspUF3oKnZOSrJrs=aG1Tgs=dnxxJ74=-3Q@mail.gmail.com>
	<20150504084432.GA2385@omega.Speedport_W_921V_1_37_000>
Date: Mon, 4 May 2015 11:21:43 +0200
Message-ID: <CAG9Fz+uGthm9-dRXgoC+hPXFPSW4krwUYkBEohY4f7GM_6qWtg@mail.gmail.com>
Subject: Re: Open task "missing enums", latest standard and where to put enums?
From: Christoffer Holmstedt <christoffer.holmstedt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>

Thank you Alexander for that comprehensive answer, I will look in to it.
--
Christoffer Holmstedt


2015-05-04 10:44 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> Hi,
>
> On Mon, May 04, 2015 at 08:08:38AM +0200, Christoffer Holmstedt wrote:
>> Hi
>> I'm looking in to the first open task about missing enums.
>>
>> ### Is the latest standard from 2011?
>> Is the IEEE Std 802.15.4-2011 [1] the latest one to use?
>>
>
> yes.
>
>> How much attention should I pay to the more specific ones such as
>> 802.15.4(g) for smart metering utility networks or (p) for Rail
>> communication and control? (I assume these are more about "policy" and
>> perhaps not so much about the "mechanism" to be implemented in the
>> linux kernel but I could be wrong here).
>>
>
> I would say "yes" here too, but I asked this myself some time ago. maybe
> some other people can answer your question here.
>
> What I know is in case of at86rf2xx transceivers:
>
> at86rf230 is -2003
> at86rf231 is -2006
> at86rf233 is -2011
>
> but you should follow the actual standard 2011, they have also some
> notes like:
>
> 5.2.1.1.7 Frame Version field
>
> "This field shall be set to 0x00 to indicate a frame compatible with
>  802.15.4-2003".
>
> Which we should lookup then in 2003 what's the different handling of this.
>
>
> For all others transceivers in the datasheet stands 2003, 2006 or 2011
> standard. I never saw a transceiver which have some additional character
> which follows a 802.15.4(g) standard, but maybe they don't exists yet.
> ;-) And also we don't handle the 2003 standard right at the moment, e.g.
> check/create on frame version field. We also don't support the at86rf230
> at the moment and this is maybe one reason, all others transceivers are
> hopefully -2006 or -2011.
>
> I also never tried to speak to a -2003 transceiver and I am not sure if
> this works correctly.
>
>> ### Where to put enums? It all depends I assume...
>> "include/linux/[ieee802154.h|nl802154.h]" seems to include specific
>> IEEE802.15.4 defines/enums, anywhere else to look?
>>
>
> What I meant with the opentask of missing enums definition to some
> strings is a very simple task which I was too lazy to implement and is
> related to wpan-tools only.
>
> Something like [0], the function "iftype_name".
>
> We need such function also for printing the frequency (in MHz, whatever)
> additional for page and channel. You can lookup the frequency in
> 802.15.4-2011, there are forumlars to calucalte the frequency according
> to page and channel. See "8.1.2 Channel assignments" for formulars like
>
> F_c = 2405 + 5 (k - 11) in megahertz, for k = 11, 12, ... 26 (example
> for channel page zero and channel 11 - 26 which is 2.4 GHz O-QPSK band.
>
> The same is for CCA modes, which we have in the userspace nl802154
> header. Currently I see this on iwpan list:
>
> cca_mode: 1
>
> but what the hell is cca mode "1"? This can be lookuped in 802.15.4-2011
> "8.2.7 Clear channel assessment (CCA)".
>
> Simple making a short function which have [1] as parameter (also
> included the cca opt string for special case in cca mode 3 -> the or 'xor'
> and logical operation).
>
>
> So that was the userspace <-> kernelside. Doing communication between these layes
> are only handled by enums. Special case if the standard definition is a number
> itself, like channel or page. We could introduce some:
>
> enum nl802154_pages {
>         nl802154_PAGE0,
>         nl802154_PAGE1,
>         ...
> };
>
> but I don't see the benifits of this enums, for cca modes it makes sense
> to do that. 802.15.4 describes a mapping to some "string explained cca
> mode" to "number".
>
> This is the userspace side which has only the userspace header nl802154,
> this is what I meant in the opentasks section. We have also one other
> userspace header which is for the 802.15.4 address family, but I didn't
> looked into that deeper.
>
>
> For kernelside there are also some missing enums which can be replaced
> by magic numbers, simple go ahead and send patches then I can look into
> that for reviewing.
>
> General about the huge numbers of related kernel headers:
>
> include/net/6lowan.h - header for net/6lowpan branch only. But this is
>                        currently not through and should a new open task
>                        because this header also includes only defines
>                        which are 802.15.4 specifc. e.g. dispatch values
>                        for fragmentation.
>
> net/ieee802154/6lowpan_i.h - doesn't exist right now but should only
>                              contains 802.15.4 6lowpan defines. e.g.
>                              dispatch values for fragmentation.
>
> You see, you only need to move some defines from global to an internal
> header. I already did that in the rework branch (I supposed) but have
> other priorities. Go ahead and send patches I and the generic 6LoWPAN
> community will review that.
>
> other headers:
>
> include/linux/ieee802154.h - contains 802.15.4 defines like BROADADDRESS
>                              and such things. These things coming from
>                              standard. If things are coming from
>                              standard but you need it for userspace
>                              defines then include/net/nl802154.h is the
>                              right one, e.g. cca modes enum.
>
>                              It's also plan to put (like wireless it does),
>                              many helpers script to parsing the header.
>                              See the rework branch [2]. I didn't send it
>                              mainline because it's difficult to replace
>                              the header parsing, because it's used everywhere
>                              and the crypto layer isn't configurable by a common
>                              userspace tool.
>
> include/net/mac802154.h - for the SoftMAC Layer part which should be
>                           globally because contains defines which
>                           can be used by driver layer.
>
> include/net/cfg802154.h - things which belongs to the connection between
>                           net/mac802154 and net/ieee802154. That's what
>                           cfg802154 does. In future you could also
>                           replace the net/mac802154 by a HardMAC driver.
>
> include/linux/nl802154.h - old userspace header should be removed.
>
> include/net/nl802154.h - userspace header which contains enums or defines only.
>                          I mentioned the enums and defines here because
>                          that was completely wrong in the old userspace
>                          header include/linux/nl802154.h which contains
>                          a prototype "extern const struct nla_policy
>                          ieee802154_policy[];". We do that now like wireless.
>                          You can lookup the wireless userspace header in
>                          "include/uapi/linux/nl80211.h". Our header is
>                          currently not part of include/uapi because if
>                          you have headers there and you will change it
>                          (maybe some enum name), then everybody in the
>                          linux world will be angry, because their
>                          software will not compile anymore. So that we
>                          are don't part of uapi right now is okay... but
>                          changing the interface is always not a good
>                          idea, nevertheless the interface is still in
>                          development. At the moment you need to grab
>                          everytime this header for your wpan userspace
>                          tool and should be the same like the running kernel.
>
> include/net/af_ieee802154.h - normally also an uapi header for the
>                               802.15.4 socket family which I don't trust
>                               right now that this is working correctly.
>
> include/net/ieee802154_netdev.h - this header should be removed, it
>                                   various things which should be moved
>                                   to the other headers.
>
> If you see some magic values, try to find the right header (please not
> the include/net/ieee802154_netdev.h).
>
> - Alex
>
> [0] https://github.com/linux-wpan/wpan-tools/blob/master/src/interface.c#L21
> [1] http://lxr.free-electrons.com/source/include/net/nl802154.h#L136
> [2] https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/include/net/ieee802154.h#L178
